
import 'package:app/Classes/Playlist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../main.dart';

class Playlist_Backend extends Playlist{
  Playlist_Backend(super.title, super.musics);

  Future<void> addPlaylistToFirebase() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/$uid/Playlists");

    await ref.set({
      "title": getTitle(),
      "musics": getMusics(),
    });
  }

}