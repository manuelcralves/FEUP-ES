
import 'dart:math';


import 'package:app/Playlist/Playlist_create_frontend.dart';
import 'package:app/login/login_backend.dart';
import 'package:app/login/login_frontend.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';

enum MenuValues{
login,
settings
}


class HomePage extends StatefulWidget {

  List<String> playlist_list = [];

  void playlist_add(String name){
    if(name!="") {
      playlist_list.add(name);
    }
  }
  void playlist_remove(String name){
    playlist_list.remove(name);
  }
  @override
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {


  MenuValues? menu;

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

  void signout(){
    Login_Backend().signout();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                'Spotivibes',
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(width: 10),
            user != null ? Text(
              user!.email!,
              style: TextStyle(fontSize: 12),
            ) : Text(
              'Not logged in',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.green[800],
        actions: [
          PopupMenuButton<MenuValues>(
            initialValue: menu,
            onSelected: (MenuValues that){
              switch(that){
                case MenuValues.login:{
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login_Page())
                  );
                  break;
                }
                case MenuValues.settings:{
                  //do something later;
                }
              }
            },
              itemBuilder: (context) => [
            PopupMenuItem(
                child: Text('Sign in/Create account'),
                value: MenuValues.login,
            ),
            PopupMenuItem(
                child: Text('Sign out'),
                onTap: signout
                ),
            PopupMenuItem(
                value:MenuValues.settings,
                child: Text('Settings(soon)')
            ),
          ],
            offset: Offset(0,20)
          )

        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(top: 70)),
          Text(
              "Playlists",
              style: TextStyle(fontSize: 30,fontFamily: AutofillHints.givenName),),
          FloatingActionButton(
              onPressed:(){ Navigator.push(
              context,
            MaterialPageRoute(builder: (context) => Playlist_Create()),
              );
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}