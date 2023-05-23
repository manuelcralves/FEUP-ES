import 'package:firebase_database/firebase_database.dart';

import '../Classes/Album.dart';

class Album_Backend extends Album{
  Album_Backend(super.idAlbum, super.name, super.artist);

  static Future<String?> getAlbumNameById(int idAlbum) async {
    var ref = FirebaseDatabase.instance.ref().child("database/Albums");
    DatabaseEvent event = await ref.once();
    DataSnapshot snapshot = event.snapshot;
    if (snapshot.value != null) {
      dynamic musicData = snapshot.value;
      if(musicData is List<dynamic>) {
        for (var value in musicData) {
          print(idAlbum);
          print(value['_idAlbum']);
          if (value['_idAlbum'] == idAlbum) {
            return value['_name'];
          }
        };
      }
      return null;
    }
  }
}