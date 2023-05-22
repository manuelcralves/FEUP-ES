import 'package:firebase_database/firebase_database.dart';
import '../Classes/Music.dart';

class Artist_Backend {
  static Future<List<Music>> getArtistMusics(List<int> musicIds) async {
    List<Music> musics = [];

    for (var musicId in musicIds) {
      Music music = await fetchMusicFromDatabase(musicId);
      musics.add(music);
    }

    return musics;
  }

  static Future<Music> fetchMusicFromDatabase(int musicId) async {
    var ref = FirebaseDatabase.instance.ref().child("database/Musics/$musicId");
    DatabaseEvent event = await ref.once();
    DataSnapshot snapshot = event.snapshot;
    dynamic musicData = snapshot.value;

    if (musicData != null) {
      return Music(
        musicData['_idMusic'],
        musicData['_name'],
        musicData['_artist'],
        musicData['_album'],
        musicData['_lyrics'],
      );
    }

    throw Exception('Failed to fetch music from database');
  }
}
