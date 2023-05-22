import 'package:firebase_database/firebase_database.dart';

import '../Classes/Comment.dart';

class Comment_Backend extends Comment{
  Comment_Backend(super.user, super.comment);

  static Future<List<Comment>> getCommentsFromMusic(int idMusic) async {
    List<Comment> comments = [];
    DatabaseReference ref = FirebaseDatabase.instance.ref("database/comments/$idMusic");

    DatabaseEvent event = await ref.once();
    DataSnapshot snapshot = event.snapshot;
    if(snapshot==null){
      return comments; //nao ha comentarios em relaçao a essa musica
    }
    else{
      dynamic commentData = snapshot.value;
      if(commentData is List<dynamic>) {
        for (var value in commentData) {
          Comment music = Comment(value['_user'], value['_comment']);
          comments.add(music);
        };
      }
    }
    return comments;
  }

  static addCommentToMusic(int _idMusic, Comment comment){

  }

}