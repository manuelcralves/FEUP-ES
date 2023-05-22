import 'package:firebase_auth/firebase_auth.dart';

class Comment {
  late User _user;
  late String _comment;

  User getUser() {
    return _user;
  }

  void setUser(User user) {
    _user = user;
  }

  String getComment() {
    return _comment;
  }

  void setArtist(String comment) {
    _comment = comment;
  }

  Comment(User user, String comment) {
    _user = user;
    _comment = comment;
  }
}