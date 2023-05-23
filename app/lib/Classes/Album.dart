import 'Artist.dart';
import 'Music.dart';

class Album {
  late int _idAlbum;
  late String _name;
  late String _artist;

  int getIdAlbum() {
    return _idAlbum;
  }

  void setIdAlbum(int idAlbum) {
    _idAlbum = idAlbum;
  }

  String getArtist() {
    return _artist;
  }

  void setArtist(String artist) {
    _artist = artist;
  }

  String getName(){
    return _name;
  }

  void setName(String name){
    _name = name;
  }


  Album (int idAlbum,String name, String artist) {
    _name = name;
    _idAlbum = idAlbum;
    _artist = artist;
  }
}