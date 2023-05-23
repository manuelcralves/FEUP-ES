import 'package:app/Playlist/Playlist_Backend.dart';
import 'package:app/Search/Search_Bar/Search_Musics_to_Add.dart';
import 'package:app/Templates/Templates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Classes/Music.dart';
import '../../Classes/Playlist.dart';
import '../../Music/Music_Backend.dart';

class Search_Frontend_Musics extends StatefulWidget{
  final String playlist_name;

  Search_Frontend_Musics({required this.playlist_name});

  @override
  _Search_Frontend_Music_State createState() => _Search_Frontend_Music_State();

}

class _Search_Frontend_Music_State extends State<Search_Frontend_Musics> {
  late Future<List<Music>> musics;

  @override
  void initState() {
    super.initState();
    fetchMusics();

  }

  Future<void> fetchMusics() async {
    Future<List<Music>> Allmusics= Music_Backend.getAllMusicsNotInPlaylist(widget.playlist_name);
    setState(() {
      musics = Allmusics;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Templates.AppbarSpotivibes(),
      body: Column(
        children: [
          Templates.SubTitle("Add Musics"),
          ElevatedButton.icon(
            icon: const Icon(Icons.search),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white38,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(60))),
              alignment: Alignment.centerLeft,
              fixedSize: const Size(313,17),
            ),
            label: const Text('Search'),
            onPressed: () {
              showSearch(context: context, delegate: Search_Musics_to_Add(musics:musics, playlist_name:widget.playlist_name)).then((value) {
                fetchMusics();
              });
            },
          ),
          Expanded(
            child: FutureBuilder<List<Music>>(
              future: musics,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<Music> musicList = snapshot.data!;
                  return ListView.builder(
                    itemCount: musicList.length,
                    itemBuilder: (context, index) {
                      Music music = musicList[index];
                      return ListTile(
                        title: Text(music.getName()),
                        onTap: () {
                          setState(() {
                            musicList.remove(music);
                          });
                          Playlist_Backend.addMusicToPlaylist(music.getIdMusic(), widget.playlist_name);
                        },
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Erro ao carregar músicas');
                }

                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
