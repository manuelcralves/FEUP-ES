import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Classes/Music.dart';
import '../../Music/MusicPage.dart';

class Search_General_Musics extends SearchDelegate<Music>{

  SharedPreferences? _prefs;

  Future<List<Music>> musics;

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Search_General_Musics({required this.musics});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: (){
      query = '';
    },
        icon: Icon(Icons.clear))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      close(context,Music(0, "", "", 0, ""));
      },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Music>>(
      future: musics,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<Music> musicList = snapshot.data!;
          final List<Music> filteredList = musicList
              .where((music) => music.getName().toLowerCase().contains(query.toLowerCase()))
              .toList();
          _prefs?.setString('recentQuery', query);
          return ListView.builder(
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              final Music music = filteredList[index];
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
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Music>>(
        future: musics,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Music> musicList = snapshot.data!;
            final List<Music> filteredList = musicList
                .where((music) =>
                music.getName().toLowerCase().contains(query.toLowerCase()))
                .toList();
            String? recentQuery = _prefs?.getString('recentQuery');
            return ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final Music music = filteredList[index];
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
        });
  }
}