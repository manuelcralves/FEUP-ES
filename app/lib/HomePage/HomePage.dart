import 'package:app/Playlist/Playlist_Backend.dart';
import 'package:app/Playlist/Playlist_create_frontend.dart';
import 'package:app/Templates/Templates.dart';
import 'package:app/login/login_backend.dart';
import 'package:app/login/login_frontend.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Index/index.dart';
import '../Playlist/PlaylistPage.dart';
import '../main.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        this.user = user;
      });
    });
  }

  void signout() {
    Login_Backend().signout();
  }

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      return Index();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Spotivibes',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.green[800],
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome to Spotivibes",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                "Let's get started",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login_Page()),
                  );
                },
                child: Text(
                  'Let\'s Go',
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Index()),
                  );
                },
                child: Text(
                  'Continue as Guest',
                  style: TextStyle(fontSize: 16),
                ),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  side: BorderSide(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}