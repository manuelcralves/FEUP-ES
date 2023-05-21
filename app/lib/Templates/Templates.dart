import 'package:app/HomePage/HomePage.dart';
import 'package:app/Profile/Profile_frontend.dart';
import 'package:flutter/material.dart';

import '../Search/Search_Frontend_Musics.dart';

class Templates{



  static AppBar AppbarSpotivibes(){
    return (AppBar(
        title: Text('Spotivibes'),
        centerTitle: true,
        backgroundColor: Colors.green[800],)
      );
    }
    static BottomNavigationBar Footer(BuildContext context){
      return BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label:'HomePage' ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label:'SearchPage'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label:'ProfilePage')
            ],
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                break;
              case 1:
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Search_Frontend_Musics(playlist_name: '',)));
                break;
              case 2:
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => profile_frontend()));
                break;
            }
          },
      );
    }
    static SubTitle(String text){
      return Padding(
        padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 70.0),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
      );
    }
}