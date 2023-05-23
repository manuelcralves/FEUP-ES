import 'package:app/Music/Music_Backend.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Classes/Music.dart';
import '../../Music/MusicPage.dart';
import '../../Templates/Templates.dart';
import '../Search_Bar/Search_General_Musics.dart';

class Search_General_Musics_Frontend extends StatelessWidget{
  late Future<List<Music>> musics = Music_Backend.getAllMusicsFromDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Templates.AppbarSpotivibes(),
      body: Column(
        children: [
          Templates.Search_Options(context),
          Templates.SubTitle("Musics"),
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
              showSearch(context: context, delegate: Search_General_Musics(musics:musics));

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
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MusicPage(music: music)),
                          );
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
      bottomNavigationBar: Templates.Footer(context),
    );
  }


}