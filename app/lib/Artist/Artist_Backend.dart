import 'package:firebase_database/firebase_database.dart';
import '../Classes/Artist.dart';
import '../Classes/Music.dart';

class Artist_Backend {
  static Future<List<Artist>> getAllArtistsFromDatabase() async {
    List<Artist> artists = [];

    var ref = FirebaseDatabase.instance.ref().child('database/Artists');
    DataSnapshot snapshot = (await ref.once()) as DataSnapshot;

    if (snapshot.value != null) {
      dynamic artistData = snapshot.value;
      artistData.forEach((key, value) async {
        List<int> musicIds = List<int>.from(value['_musics']);
        List<Music> artistMusics = await getArtistMusics(musicIds);

        Artist artist = Artist(
          value['_name'],
          artistMusics.cast<int>(),
        );
        artists.add(artist);
      });
    }

    return artists;
  }

  static Future<List<Music>> getArtistMusics(List<int> musicIds) async {
    List<Music> musics = [];

    for (var musicId in musicIds) {
      Music music = await fetchMusicFromDatabase(musicId);
      musics.add(music);
    }

    return musics;
  }

  static Future<Music> fetchMusicFromDatabase(int musicId) async {
    var ref = FirebaseDatabase.instance.ref().child('database/Musics/$musicId');
    DataSnapshot snapshot = (await ref.once()) as DataSnapshot;
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
