import 'Artist.dart';
import 'Music.dart';

class Album {
  late int _idAlbum;
  late String _name;
  late Artist _artist;

  int getIdAlbum() {
    return _idAlbum;
  }

  void setIdAlbum(int idAlbum) {
    _idAlbum = idAlbum;
  }

  Artist getArtist() {
    return _artist;
  }

  void setArtist(Artist artist) {
    _artist = artist;
  }

  String getName(){
    return _name;
  }

  void setName(String name){
    _name = name;
  }


  Album(int idAlbum,String name, Artist artist) {
    _name = name;
    _idAlbum = idAlbum;
    _artist = artist;
  }
}