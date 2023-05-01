

import 'Music.dart';

class Playlist{
  late int _idOwner;
  late String _title;
  late List<Music> _musics;

  int getIdOwner() {
    return _idOwner;
  }

  void setIdOwner(int idOwner) {
    _idOwner = idOwner;
  }

  String getTitle() {
    return _title;
  }

  void setTitle(String title) {
    _title = title;
  }

  List<Music> getMusics() {
    return _musics;
  }

  void setMusics(List<Music> musics) {
    _musics = musics;
  }

  Playlist(int idOwner, String title, List<Music> musics) {
    _idOwner = idOwner;
    _title = title;
    _musics = musics;
  }
}