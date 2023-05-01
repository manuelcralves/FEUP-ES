import 'Artist.dart';
import 'Music.dart';

class Album {
  late int _idAlbum;
  late Artist _artist;
  late List<Music> _musics;

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

  List<Music> getMusics() {
    return _musics;
  }

  void setMusics(List<Music> musics) {
    _musics = musics;
  }

  Album(int idAlbum, Artist artist, List<Music> musics) {
    _idAlbum = idAlbum;
    _artist = artist;
    _musics = musics;
  }
}