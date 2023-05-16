import 'package:app/HomePage/HomePage.dart';
import 'package:app/Profile/Profile_frontend.dart';
import 'package:flutter/material.dart';

import '../Search/Search_frontend.dart';

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
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => search_frontend()));
                break;
              case 2:
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => profile_frontend()));
                break;
            }
          },
      );
    }
}