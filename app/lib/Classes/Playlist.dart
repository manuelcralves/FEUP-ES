

import 'Music.dart';

class Playlist{
  late String _title;
  late List<Music> _musics;

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

  Playlist(String title, List<Music> musics) {
    _title = title;
    _musics = musics;
  }
}