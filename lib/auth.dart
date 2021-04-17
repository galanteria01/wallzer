import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FirebaseAuth auth = FirebaseAuth.instance;
Future<UserCredential> handleSignup(String email, String password) async {
  try{
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    return userCredential;
  } on FirebaseAuthException catch(e) {
    if(e.code == "weak-password"){
      SnackBar(content: Text("The password is weak"),);
    }else if (e.code == "email-already-in-use"){
      SnackBar(content: Text("Consider logging in"),);
    }
  } catch(e) {
    SnackBar(content: Text(e.code));
  }
  return null;
}

Future<UserCredential> handleLogin(String email, String password) async {
  try{
    UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  } on FirebaseAuthException catch (e) {
    if(e.code == "user-not-found"){
      SnackBar(content: Text("User isn't found in database"),);
    }else if(e.code == "wrong-password"){
      SnackBar(content: Text("Wrong password provided"),);
    }
  }
  return null;
}