import 'Album.dart';
import 'Artist.dart';

class Music {
  late int _idMusic;
  late String _name;
  late String _artist;
  late int _album;
  late String _lyrics;

  int getIdMusic() {
    return _idMusic;
  }

  void setIdMusic(int idMusic) {
    _idMusic = idMusic;
  }

  String getName() {
    return _name;
  }

  void setName(String name) {
    _name = name;
  }

  String getArtist() {
    return _artist;
  }

  void setArtist(String artist) {
    _artist = artist;
  }

  int getAlbum() {
    return _album;
  }

  void setAlbum(int album) {
    _album = album;
  }

  String getLyrics() {
    return _lyrics;
  }

  void setLyrics(String lyrics) {
    _lyrics = lyrics;
  }

  Music(int idMusic,String name, String artist, int album, String lyrics) {
    _idMusic = idMusic;
    _name = name;
    _artist = artist;
    _album = album;
    _lyrics = lyrics;
  }
}