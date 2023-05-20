import 'package:app/HomePage/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:app/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:app/profile/profile.dart';
import 'package:app/settings/settings.dart';
import '../login/login_backend.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../settings/settings.dart';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  Future<void> signout() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Redirect to the homepage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Index Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Settings()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: signout, // Call the signout function
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome to the Index page!'),
      ),
    );
  }
}
