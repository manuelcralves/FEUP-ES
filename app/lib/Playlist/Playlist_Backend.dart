
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

    await ref.child(getTitle()).set({
      "musics": "",
    });
  }

  static Stream<dynamic>? getPlaylistsFromFirebase(String ?uid) {
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
}