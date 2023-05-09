import 'Album.dart';
import 'Artist.dart';

class Music {
  late int _idMusic;
  late String _name;
  late Artist _artist;
  late Album _album;
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

  Artist getArtist() {
    return _artist;
  }

  void setArtist(Artist artist) {
    _artist = artist;
  }

  Album getAlbum() {
    return _album;
  }

  void setAlbum(Album album) {
    _album = album;
  }

  String getLyrics() {
    return _lyrics;
  }

  void setLyrics(String lyrics) {
    _lyrics = lyrics;
  }

  Music(int idMusic,String name, Artist artist, Album album, String lyrics) {
    _idMusic = idMusic;
    _name = name;
    _artist = artist;
    _album = album;
    _lyrics = lyrics;
  }
}