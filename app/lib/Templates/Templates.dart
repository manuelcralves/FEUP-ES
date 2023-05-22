import 'package:app/HomePage/HomePage.dart';
import 'package:app/Search/Frontend/Search_General_Agent_Frontend.dart';
import 'package:app/Search/Frontend/Search_General_Musics_Frontend.dart';
import 'package:flutter/material.dart';
import 'package:app/Search/Frontend/Search_General_Artists.dart';


import '../Index/index.dart';
import '../Search/Frontend/Search_Frontend_Musics.dart';
import '../profile/profile.dart';

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
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Index()),
                      (route) => false,
                );
                break;
              case 1:
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Search_General_Musics_Frontend()),
                      (route) => false,
                );
                break;
              case 2:
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                      (route) => false,
                );
                break;
            }
          },
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blue,
        showSelectedLabels: false,
        showUnselectedLabels: false,
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

    static Search_Options(BuildContext context){
      return BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label:'SearchMusics' ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label:'SearchArtists'),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Search_General_Musics_Frontend()));
              break;
            case 1:
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Search_General_Artists_Frontend()));
              break;
            case 2:
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Search_General_Agents_Frontend()));
              break;
          }
        },
        selectedItemColor: Colors.green,
      );
    }
}