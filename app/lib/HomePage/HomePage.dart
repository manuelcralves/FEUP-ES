
import 'dart:math';

import 'package:app/login/login_backend.dart';
import 'package:app/login/login_frontend.dart';
import 'package:flutter/material.dart';


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

  void signout(){
    Login_Backend().signout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spotivibes'),
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
      body: Center(
        child: Text('Bem-vindo à minha App!'),
      ),
    );
  }
}