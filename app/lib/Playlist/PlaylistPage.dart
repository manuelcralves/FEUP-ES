import 'package:app/Music/Music_Backend.dart';
import 'package:app/Playlist/Playlist_Backend.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Classes/Music.dart';
import '../Search/Search_Frontend_Musics.dart';
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
          Templates.SubTitle(widget.title),
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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Playlist_Backend.removeMusicFromPlaylist(music.getIdMusic(), widget.title);
                          loadMusicList();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: Text('Remove'),
                      ),
                      SizedBox(width: 8.0), // Espaçamento entre os botões
                      ElevatedButton(
                        onPressed: () {
                          // Lógica para ver mais detalhes da música
                          // ...
                        },
                        child: Text('See More'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ] ,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Search_Frontend_Musics(playlist_name: widget.title),
            ),
          ).then((value){
              loadMusicList();
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

}