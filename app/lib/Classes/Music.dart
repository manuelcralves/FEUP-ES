import 'Album.dart';
import 'Artist.dart';

class Music {
  late int _idMusic;
  late Artist _artist;
  late Album _album;

  int getIdMusic() {
    return _idMusic;
  }

  void setIdMusic(int idMusic) {
    _idMusic = idMusic;
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

  Music(int idMusic, Artist artist, Album album) {
    _idMusic = idMusic;
    _artist = artist;
    _album = album;
  }
}