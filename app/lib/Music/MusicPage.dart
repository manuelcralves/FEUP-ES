

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Classes/Music.dart';
import '../Classes/Comment.dart';
import '../Templates/Templates.dart';
import 'Comment_Backend.dart';

class MusicPage extends StatefulWidget {
  final Music music;

  MusicPage({required this.music});

  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  bool _isCommentSectionExpanded = false;
  String? _myComment;
  late List<Comment> comments;

  @override
  void initState() {
    super.initState();
    loadComments();
  }

  Future<void> loadComments() async {
    List<Comment> loadedCommentList = await Comment_Backend.getCommentsFromMusic(widget.music.getIdMusic());

    if (loadedCommentList != null) {
      setState(() {
        comments = loadedCommentList;
        comments.reversed;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    bool isLoggedIn = currentUser != null;
    return Scaffold(
      appBar: Templates.AppbarSpotivibes(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.music.getName(),
                    style: TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lexenda Deca',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'Artist:',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.music.getArtist(),
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Album:',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.music.getAlbum().toString(),
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'Lyrics:',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  widget.music.getLyrics(),
                  style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 40),

                Align(
                  alignment: Alignment.center,
                  child:
                  Text(
                  "Comments",
                  style: TextStyle(
                    fontSize: 35,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ),
                SizedBox(height: 24),
                Column(
                  children: [
                    FutureBuilder<List<Comment>>(
                    future: loadComments().then((_) => comments),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final List<Comment> commentList = snapshot.data!;
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: commentList.length,
                          itemBuilder: (context, index) {
                            Comment comment = commentList[index];
                            return ListTile(
                              title: Text(comment.getEmail()),
                              subtitle: Text(comment.getComment()),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('Erro ao carregar músicas');
                      }

                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ],
                ),
            ],
          ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _isCommentSectionExpanded = !_isCommentSectionExpanded;
              });
            },
            child: Container(
              height: 50,
              color: Colors.grey[200],
              child: ListTile(
                title: Text('Comentários'),
                trailing: Icon(
                  _isCommentSectionExpanded
                      ? Icons.expand_more
                      : Icons.expand_less,
                ),
              ),
            ),
          ),
          if (_isCommentSectionExpanded)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.grey[300],
                child: isLoggedIn
                    ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: TextField(
                              onChanged: (value) {
                                _myComment = value;
                              },
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Comment that = Comment(currentUser.email!,_myComment!);
                              Comment_Backend.addCommentToMusic(widget.music.getIdMusic(), that);
                              Future.delayed(const Duration(seconds: 2));
                              setState(() {
                                _isCommentSectionExpanded = !_isCommentSectionExpanded;
                              });
                              comments.insert(0, that);
                            },
                            child: Text('Enviar'),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
                    : Container(
                      alignment: Alignment.center,
                      child: Text(
                    'You need to be logged in to see the comments',
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

