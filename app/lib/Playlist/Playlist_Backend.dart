
import 'package:app/Classes/Playlist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../Classes/Music.dart';
import '../main.dart';

class Playlist_Backend extends Playlist{

  Playlist_Backend(super.title, super.musics);

  Future<void> addPlaylistToFirebase() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/$uid/Playlists");

    await ref.child(getTitle()).set("");
  }

  static Stream<dynamic>? getPlaylistsFromFirebase() {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final playlistsRef = FirebaseDatabase.instance
          .ref()
          .child('users')
          .child(uid)
          .child('Playlists');

      final playlistsStream = playlistsRef.onValue;

      return playlistsStream;
    }
  }

  static Future<List<int>?> getMusicsFromPlaylist(String playlist_name) async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/$uid/Playlists/$playlist_name");

    DatabaseEvent event= await ref.once();
    DataSnapshot snapshot = event.snapshot;

    if (snapshot.value != null) {
      dynamic musicData = snapshot.value;
      if (musicData is List<dynamic>) {
        List<int> parsedList = musicData.map((value) => value as int).toList();
        return parsedList;
      } else if (musicData is Map<dynamic, dynamic>) {
        List<int> parsedList = musicData.values.map((value) => value as int).toList();
        return parsedList;
      }
    }

    return null;
  }
}