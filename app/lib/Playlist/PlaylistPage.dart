import 'package:app/Music/Music_Backend.dart';
import 'package:app/Playlist/Playlist_Backend.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Classes/Music.dart';
import '../Templates/Templates.dart';

class PlaylistPage extends StatefulWidget{
  final String title;

  PlaylistPage({required this.title});

  @override
  @override
  _PlaylistPageState createState() => _PlaylistPageState();

}

class _PlaylistPageState extends State<PlaylistPage>{

  List<Music> musicList = [];

  @override
  void initState() {
    super.initState();
    loadMusicList();
  }

  Future<void> loadMusicList() async {
    List<Music> loadedMusicList = [];
    List<int>? databasePlaylistMusics = await Playlist_Backend.getMusicsFromPlaylist(widget.title);

    if (databasePlaylistMusics != null) {
      for (int idMusic in databasePlaylistMusics) {
        Music? music = await Music_Backend.getMusicById(idMusic);
        if (music != null) {
          loadedMusicList.add(music);
        }
      }
      print(loadedMusicList);
    }

    setState(() {
      musicList = loadedMusicList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Templates.AppbarSpotivibes(),
      body:Column(
        children:[
          Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 80.0),
            child: Center(
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: musicList.length,
              separatorBuilder: (context, index) => const Divider(
                color: Colors.grey,
                thickness: 1.0,
              ),
              itemBuilder: (context, index) {
                Music music = musicList[index];
                return ListTile(
                  title: Text(music.getName()),
                  trailing: ElevatedButton(
                    onPressed: () {},
                    child: Text('See More'),
                  ),
                );
              },
            ),
          ),
        ] ,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Lógica do botão flutuante
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: Templates.Footer(context),
    );
  }

}