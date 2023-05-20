


import 'package:app/HomePage/HomePage.dart';
import 'package:app/Playlist/Playlist_Backend.dart';
import 'package:app/Templates/Templates.dart';
import 'package:app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/Playlist/Playlist_Backend.dart';
import 'package:flutter/material.dart';


import '../Classes/Music.dart';
import '../Classes/Playlist.dart';
import '../Index/index.dart';
import '../login/login_frontend.dart';

class Playlist_Create extends StatefulWidget{
  Playlist_Create({super.key});

  @override
  State<Playlist_Create> createState() => _PlaylistCreate();
}

class _PlaylistCreate extends State<Playlist_Create>{

  late String playlist_name;

  void add_to_playlist() {
    List<int> musics = [];
    Playlist_Backend playlist = Playlist_Backend(playlist_name, musics);
    playlist.addPlaylistToFirebase().then((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Index()), // Navigate back to the index page
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Templates().AppbarSpotivibes(),
      body: Container(
        margin: EdgeInsets.all(40),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Playlist Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          playlist_name = value;
                        });
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: add_to_playlist,
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    child: Text("Add"),
                  ),
                ],
              ),
        ],
      ),
    ),
    );
  }

}