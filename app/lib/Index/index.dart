import 'package:app/HomePage/HomePage.dart';
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
      // Redirect to the homepage
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
    // Fetch the playlists from Firebase Realtime Database
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    playlistsStream = Playlist_Backend.getPlaylistsFromFirebase(uid);
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    bool isLoggedIn = currentUser != null;

    return Scaffold(
      appBar: AppBar(
        title: Text('Index Page'),
        automaticallyImplyLeading: false, // Remove the "Go Back" arrow
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
              onPressed: signout, // Call the signout function
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
      body: isLoggedIn
          ? StreamBuilder(
        stream: playlistsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Process and display the playlists data
            Map<dynamic, dynamic> playlistsData = snapshot.data!.snapshot.value;
            List<Widget> playlistWidgets = [];
            if (playlistsData != null) {
              playlistsData.forEach((key, value) {
                String playlistTitle = key;
                String playlistCreator = value['creator'] ?? 'Unknown Creator'; // Add null-checking
                // Create a widget for each playlist
                playlistWidgets.add(ListTile(
                  title: Text(playlistTitle),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlaylistPage(
                          title: playlistTitle,
                          creator: playlistCreator,
                        ),
                      ),
                    );
                  },
                ));
              });
            }
            return ListView(
              children: playlistWidgets,
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return CircularProgressIndicator();
          }
        },
      )
          : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You need to be logged in to check all funcionalities!'),
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
    );
  }


}
