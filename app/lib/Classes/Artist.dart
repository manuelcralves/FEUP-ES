import 'Album.dart';
import 'Music.dart';

class Artist {
  late String _name;
  late List<Music> _musics;
  late List<Album> _albums;

  String getName() {
    return _name;
  }

  void setName(String name) {
    _name = name;
  }

  List<Music> getMusics() {
    return _musics;
  }

  void setMusics(List<Music> musics) {
    _musics = musics;
  }

  List<Album> getAlbums() {
    return _albums;
  }

  void setAlbums(List<Album> albums) {
    _albums = albums;
  }

  Artist(String name, List<Music> musics, List<Album> albums) {
    _name = name;
    _musics = musics;
    _albums = albums;
  }
}