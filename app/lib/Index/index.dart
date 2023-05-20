import 'package:app/HomePage/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:app/profile/profile.dart';
import 'package:app/settings/settings.dart';
import 'package:app/Playlist/Playlist_create_frontend.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:app/Playlist/Playlist_Backend.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Index Page'),
        actions: [
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
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: signout, // Call the signout function
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Playlist_Create()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: playlistsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Process and display the playlists data
            Map<dynamic, dynamic> playlistsData = snapshot.data!.snapshot.value;
            List<Widget> playlistWidgets = [];
            if (playlistsData != null) {
              playlistsData.forEach((key, value) {
                String playlistTitle = key;
                // Create a widget for each playlist
                playlistWidgets.add(ListTile(
                  title: Text(playlistTitle),
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
      ),
    );
  }
}
