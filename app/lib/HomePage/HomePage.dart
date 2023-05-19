
import 'dart:math';


import 'package:app/Playlist/Playlist_Backend.dart';
import 'package:app/Playlist/Playlist_create_frontend.dart';
import 'package:app/Templates/Templates.dart';
import 'package:app/login/login_backend.dart';
import 'package:app/login/login_frontend.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Playlist/PlaylistPage.dart';
import '../main.dart';

enum MenuValues{
login,
settings
}


class HomePage extends StatefulWidget {

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
      body: Container(
        margin: EdgeInsets.only(left: 20),
        child: Container(
          child: Visibility(
            visible: FirebaseAuth.instance.currentUser?.uid!=null,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.only(top: 70)),
              Text(
              "Playlists",
              style: TextStyle(fontSize: 30, fontFamily: AutofillHints.givenName),
            ),
              Padding(padding: EdgeInsets.only(top: 70)),
              FloatingActionButton(
              onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Playlist_Create()),
              );
            },
            child: const Icon(Icons.add),
          ),
              SizedBox(height: 16),
              Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: Playlist_Backend.getPlaylistsFromFirebase(),
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      Map<dynamic, dynamic>? playlists = snapshot.data!.snapshot.value;
                      if (playlists != null) {
                        List<Widget> buttons = [];
                        playlists.forEach((key, value) {
                          buttons.add(
                            Column(
                              children: [
                                const SizedBox(
                                  height: 16,
                                ),
                                FloatingActionButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => PlaylistPage(title: key)),
                                    );
                                  },
                                  child:Text(key),
                                  backgroundColor: Colors.blue,
                                ),
                              ],
                            ),
                          );
                        });
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: buttons,
                        );
                      }
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
        ),
      ),
      ),
      bottomNavigationBar: Templates.Footer(context)
    );
  }
}