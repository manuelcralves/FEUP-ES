import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../Classes/Comment.dart';
import '../Classes/User.dart';


class Comment_Backend extends Comment{
  Comment_Backend(super.user, super.comment);

  static Future<List<Comment>> getCommentsFromMusic(int idMusic) async {
    List<Comment> comments = [];
    DatabaseReference ref = FirebaseDatabase.instance.ref("database/comments/$idMusic");

    DatabaseEvent event = await ref.once();
    DataSnapshot snapshot = event.snapshot;
    if(snapshot==null){
      print("NULL");
      return comments; //nao ha comentarios em relaçao a essa musica
    }
    else{
      dynamic commentData = snapshot.value;
      if(commentData is Map<String,dynamic>) {
        for (var entry in commentData.entries) {
          Comment comment = Comment(entry.value["_user"], entry.value['_comment']);
          comments.add(comment);
        }
        comments = comments.reversed.toList();
      }
    }
    return comments;
  }

  static Future<void> addCommentToMusic(int idMusic, Comment comment) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("database/comments/$idMusic");

    DatabaseEvent event = await ref.once();
    DataSnapshot snapshot = event.snapshot;
    if(snapshot==null) {
      Map<String, dynamic> contentComment = {
        '_user': comment.getEmail(),
        '_comment': comment.getComment(),
      };

      await ref.set(contentComment);
    }
    else {
      Map<String, dynamic> newChildData = {
        '_user': comment.getEmail(),
        '_comment': comment.getComment(),
      };

      DatabaseReference newChild = ref.push();
      await newChild.set(newChildData);
    }
  }

}