
import 'package:firebase_auth/firebase_auth.dart';

class Comment {
  late String _email;
  late String _comment;

  String getEmail() {
    return _email;
  }

  void setUser(String user) {
    _email = user;
  }

  String getComment() {
    return _comment;
  }

  void setArtist(String comment) {
    _comment = comment;
  }

  Comment(String email, String comment) {
    _email = email;
    _comment = comment;
  }
}

