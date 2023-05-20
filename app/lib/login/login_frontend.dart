import 'package:app/Templates/Templates.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/login/login_backend.dart';

import '../Index/index.dart';
import '../main.dart';

class Login_Page extends StatefulWidget{
  Login_Page({super.key});

  @override
  State<Login_Page> createState() => LoginAccount();
}

class LoginAccount extends State<Login_Page>{

  final _formKey = GlobalKey<FormState>();

  Login_Backend login_backend = Login_Backend();

  String? _email;
  String? _password;

  Future<void> submit_login() async {
    try {
      await login_backend.signInWithEmailAndPassword(_email!, _password!);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Index()),
      );
    } catch (e) {
      // Handle login failure, show error message, etc.
      print('Login failed: $e');
    }
  }

  Future<void> submit_signup() async{
    if (_email != null && _password != null) {
      await login_backend.signUpWithEmailAndPassword(_email!, _password!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formKey,
      appBar:Templates().AppbarSpotivibes(),
      body:  Container(
          margin: EdgeInsets.all(40),
          child: Column(
          children: [
          Container(
            margin: EdgeInsets.all(20),
          ),
          SizedBox( height: 160),
          TextFormField(
            key: Key("email"),
            decoration: InputDecoration(
              labelText: 'Username or email',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your username or email';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _email = value;
              });
            },
          ),
          SizedBox(height: 30),
          TextFormField(
            key: Key("password"),
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _password = value;
              });
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 50),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
            SizedBox(height: 250,),
            Expanded(
              key: Key("Sign In"),
              flex: 3,
              child: ElevatedButton(
                onPressed: submit_login,
                child: Text('Login'),
              ),
            ),
            SizedBox(width: 40,),
              Expanded(
                key: Key("Create"),
                flex: 3,
                child: ElevatedButton(
                  onPressed: submit_signup,
                  child: Text('Signup'),
                ),
              ),
          ]
          ),
          ),
        ],
      ),
      )
    );
  }

}