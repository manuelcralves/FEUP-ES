import 'package:firebase_database/firebase_database.dart';

import '../Classes/Music.dart';
import '../Playlist/Playlist_Backend.dart';

class Music_Backend extends Music {
  Music_Backend(super.idMusic, super.name, super.artist, super.album,
      super.lyrics);


  static Future<Music?> getMusicById(int idMusic) async {
    var ref = FirebaseDatabase.instance.ref().child("database/Musics");
    DatabaseEvent event = await ref.once();
    DataSnapshot snapshot = event.snapshot;
    if (snapshot.value != null) {
      dynamic musicData = snapshot.value;
      if(musicData is List<dynamic>) {
        for (var value in musicData) {
          if (value['_idMusic'] == idMusic) {
            return Music(value['_idMusic'], value['_name'], value['_artist'],
                value['_album'], value['_lyrics']);
          }
        };
      }
      return null;
    }
  }

  static Future<List<Music>> getAllMusicsFromDatabase() async {
    List<Music> musics = [];
    var ref = FirebaseDatabase.instance.ref().child("database/Musics");
    DatabaseEvent event = await ref.once();
    DataSnapshot snapshot = event.snapshot;
    if (snapshot.value != null) {
      dynamic musicData = snapshot.value;
      if(musicData is List<dynamic>) {
        for (var value in musicData) {
          Music music = Music(value['_idMusic'], value['_name'], value['_artist'],
              value['_album'], value['_lyrics']);
          musics.add(music);
        };
      }
    }
    return musics;
  }
  static Future<List<Music>> getAllMusicsNotInPlaylist(String playlistName) async {
    List<Music> allMusics = await getAllMusicsFromDatabase();
    List<int>? playlistMusics = await Playlist_Backend.getMusicsFromPlaylist(playlistName);

    if (playlistMusics != null) {
      // Filtrar as músicas que estão na playlist
      allMusics = allMusics.where((music) => !playlistMusics.contains(music.getIdMusic())).toList();
    }

    return allMusics;
  }
}