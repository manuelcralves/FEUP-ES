import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Classes/Artist.dart';
import '../Classes/Comment.dart';
import '../Classes/Music.dart';
import '../Artist/Artist_Backend.dart';
import '../Music/Comment_Backend.dart';
import '../Music/MusicPage.dart';

class ArtistPage extends StatefulWidget {
  final Artist artist;

  ArtistPage({required this.artist});

  @override
  _ArtistPageState createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  bool _isCommentSectionExpanded = false;
  String? _myComment;
  late List<Comment> comments;
  late Future<List<Music>> musics;
  late String? album_name;

  @override
  void initState() {
    super.initState();
    loadComments();
    musics = loadMusics();
  }

  Future<void> loadComments() async {
    List<Comment> loadedCommentList = await Comment_Backend.getCommentsFromArtist(widget.artist.getName());

    if (loadedCommentList != null) {
      setState(() {
        comments = loadedCommentList;
        comments.reversed;
      });
    }
  }

  Future<List<Music>> loadMusics() {
    Future<List<Music>> loadedMusicList= Artist_Backend.getArtistMusics(widget.artist.getMusics());
    return loadedMusicList;
  }




  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    bool isLoggedIn = currentUser != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.artist.getName()),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.artist.getName(),
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 50.0),
            const Align(
              alignment: Alignment.center,
              child:
              Text(
                "Musics by the artist",
                style: TextStyle(
                  fontSize: 35,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 40),
            FutureBuilder<List<Music>>(
              future: musics,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error loading musics');
                } else if (snapshot.hasData) {
                  final musics = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: musics.length,
                    itemBuilder: (context, index) {
                      final music = musics[index];
                      return ListTile(
                        title: Text(
                          music.getName(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(music.getAlbum().toString()),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MusicPage(music: music)),
                          );
                        },
                      );
                    },
                  );
                } else {
                  return Text('No musics found');
                }
              },
            ),
            const Align(
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
                      return Text('Erro ao carregar artistas');
                    }

                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ],
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
                                Comment_Backend.addCommentToArtist(widget.artist.getName(), that);
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
                      'You need to be logged in to make a comment',
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
