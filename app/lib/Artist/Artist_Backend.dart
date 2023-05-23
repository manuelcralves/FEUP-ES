import 'package:firebase_database/firebase_database.dart';
import '../Classes/Artist.dart';
import '../Classes/Music.dart';
import '../Music/Music_Backend.dart';

class Artist_Backend {
  static Future<List<Artist>> getAllArtistsFromDatabase() async {
    List<Artist> artists = [];

    var ref = FirebaseDatabase.instance.ref().child('database/Artists');
    DatabaseEvent event = await ref.once();
    DataSnapshot snapshot = event.snapshot;

    if (snapshot.value != null) {
      dynamic artistData = snapshot.value;
      if(artistData is List<dynamic>) {
        for (var artistItem in artistData) {
          if (artistItem is Map<String, dynamic>) {
            List<dynamic> musics = artistItem["_musics"];
            List<int> parsedList = musics.map((value) => value as int).toList();
            Artist artist = Artist(
              artistItem['_name'],
              parsedList,
            );
            artists.add(artist);
          }
        }
      }
    }

    return artists;
  }

  static Future<List<Music>> getArtistMusics(List<int> musicIds) async {
    List<Music> musics = [];

    for (var musicId in musicIds) {
      Music? music = await Music_Backend.getMusicById(musicId);
      musics.add(music!);
    }

    return musics;
  }
}
