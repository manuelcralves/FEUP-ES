import 'Album.dart';
import 'Music.dart';

class Artist {
  late String _name;
  late List<int> _musics;

  String getName() {
    return _name;
  }

  void setName(String name) {
    _name = name;
  }

  List<int> getMusics() {
    return _musics;
  }

  void setMusics(List<int> musics) {
    _musics = musics;
  }

  Artist(String name, List<int> musics) {
    _name = name;
    _musics = musics;
  }
}