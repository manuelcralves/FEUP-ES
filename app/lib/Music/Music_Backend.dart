import 'package:firebase_database/firebase_database.dart';

import '../Classes/Music.dart';

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
}