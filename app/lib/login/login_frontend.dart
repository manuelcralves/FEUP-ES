import 'package:app/Templates/Templates.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/login/login_backend.dart';

import '../Index/index.dart';
import '../main.dart';

class Login_Page extends StatefulWidget {
  Login_Page({Key? key}) : super(key: key);

  @override
  State<Login_Page> createState() => LoginAccount();
}

class LoginAccount extends State<Login_Page> {
  final _formKey = GlobalKey<FormState>();
  Login_Backend login_backend = Login_Backend();
  String? _email;
  String? _password;

  Future<void> submit_login() async {
    try {
      bool isAuthenticated = await login_backend.checkAuthentication(_email!, _password!);

      if (isAuthenticated) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Index()),
        );
      } else {
        // Handle invalid credentials
        print('Invalid login credentials');
      }
    } catch (e) {
      // Handle login failure, show error message, etc.
      print('Login failed: $e');
    }
  }



  Future<void> submit_signup() async {
    if (_email != null && _password != null) {
      await login_backend.signUpWithEmailAndPassword(_email!, _password!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Templates().AppbarSpotivibes(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      key: Key("Sign In"),
                      onPressed: submit_login,
                      child: Text('Login'),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      key: Key("Create"),
                      onPressed: submit_signup,
                      child: Text('Signup'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
