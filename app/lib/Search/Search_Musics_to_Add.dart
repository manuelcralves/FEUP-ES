import 'dart:core';

import 'package:app/Playlist/Playlist_Backend.dart';
import 'package:flutter/material.dart';

import '../Classes/Music.dart';
import '../Music/Music_Backend.dart';

class Search_Musics_to_Add extends SearchDelegate<Music>{
  Future<List<Music>> musics;
  final String playlist_name;

  Search_Musics_to_Add({required this.musics, required this.playlist_name});


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

          return ListView.builder(
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              final Music music = filteredList[index];
              return ListTile(
                title: Text(music.getName()),
                onTap: () {
                  Playlist_Backend.addMusicToPlaylist(music.getIdMusic(), playlist_name);
                  close(context, music);
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
              .where((music) => music.getName().toLowerCase().contains(query.toLowerCase()))
              .toList();

          return ListView.builder(
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              final Music music = filteredList[index];
              return ListTile(
                title: Text(music.getName()),
                onTap: () {
                  Playlist_Backend.addMusicToPlaylist(music.getIdMusic(), playlist_name);
                  close(context, music);
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
  }}