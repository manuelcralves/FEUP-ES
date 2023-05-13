
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

    await ref.push().set({
      "title": getTitle(),
      "musics": getMusics(),
    });
  }

  Future<List<Playlist>> getPlaylistsFromFirebase(String uid) async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child("users/$uid/Playlists").get();

    List<Playlist> playlists = [];

    Map<dynamic, dynamic>? playlistMap = snapshot.value as Map<dynamic, dynamic>?;
    if (playlistMap != null) {
      playlistMap.forEach((key, value) {
        String title = value["title"];
        List<int> musics = List<int>.from(value["musics"]);
        playlists.add(new Playlist(title, musics));
      });
    }

    return playlists;
  }
}