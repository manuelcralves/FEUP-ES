

import 'Music.dart';

class Playlist{
  late String _title;
  late List<int> _musics;

  String getTitle() {
    return _title;
  }

  void setTitle(String title) {
    _title = title;
  }

  List<int> getMusics() {
    return _musics;
  }

  void setMusics(List<int> musics) {
    _musics = musics;
  }

  Playlist(String title, List<int> musics) {
    _title = title;
    _musics = musics;
  }
}