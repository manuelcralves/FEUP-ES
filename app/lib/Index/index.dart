import 'package:app/HomePage/HomePage.dart';
import 'package:app/Templates/Templates.dart';
import 'package:flutter/material.dart';
import 'package:app/profile/profile.dart';
import 'package:app/settings/settings.dart';
import 'package:app/Playlist/Playlist_create_frontend.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:app/Playlist/Playlist_Backend.dart';

import '../Playlist/PlaylistPage.dart';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  Future<void> signout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }

  Stream<dynamic>? playlistsStream;

  @override
  void initState() {
    super.initState();
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    playlistsStream = Playlist_Backend.getPlaylistsFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    bool isLoggedIn = currentUser != null;

    return Scaffold(
      appBar: AppBar(
        title: Text('Spotivibes'),
        automaticallyImplyLeading: false,
        actions: [
          if (isLoggedIn)
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              },
            ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Settings()),
              );
            },
          ),
          if (isLoggedIn)
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: signout,
            ),
          if (isLoggedIn)
            IconButton(
              icon: Icon(Icons.playlist_add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Playlist_Create()),
                );
              },
            ),
          if (!isLoggedIn)
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
        ],
      ),
      body: isLoggedIn ? Container(
        margin: EdgeInsets.only(left: 20),
        child: Container(
          child: Visibility(
            visible: FirebaseAuth.instance.currentUser?.uid != null,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 70)),
                Text(
                  "Playlists",
                  style: TextStyle(fontSize: 30, fontFamily: AutofillHints.givenName),
                ),
                Padding(padding: EdgeInsets.only(top: 70)),
                FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Playlist_Create()),
                    );
                  },
                  child: const Icon(Icons.add),
                ),
                SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: StreamBuilder(
                        stream: playlistsStream,
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData) {
                            Map<dynamic, dynamic>? playlists = snapshot.data?.snapshot.value;
                            if (playlists != null) {
                              List<Widget> buttons = [];
                              playlists.forEach((key, value) {
                                buttons.add(
                                  Column(
                                    children: [
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      FloatingActionButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => PlaylistPage(title: key)),
                                          );
                                        },
                                        child: Text(key),
                                        backgroundColor: Colors.blue,
                                      ),
                                    ],
                                  ),
                                );
                              });
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: buttons,
                              );
                            }
                          }
                          return Container();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ) : Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You need to be logged in to check all functionalities!'),
            IconButton(
             icon: Icon(Icons.exit_to_app),
              onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
           },
          ),
        ],
      ),
    ),
      bottomNavigationBar: Templates.Footer(context),
    );
  }
}