import 'package:app/login/login_backend.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Login_Backend {
  Future<User?> signUpWithEmailAndPassword(String email, String password) async {

    await Firebase.initializeApp();

    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      String x = e.code;
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    }
    catch (e) {
      print(e);
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword (String email, String password) async{

    await Firebase.initializeApp();

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return null;
  }

  Future<void> signout() async{
    try{
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e){
      print(e.code);
    }
  }
}