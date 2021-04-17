import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FirebaseAuth auth = FirebaseAuth.instance;
Future<UserCredential> handleSignup(String email, String password) async {
  try{
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    return userCredential;
  } on FirebaseAuthException catch(e) {
    if(e.code == "weak-password"){
      SnackBar(
        content: Text("The password is weak"),
        behavior: SnackBarBehavior.floating,
      );
    }else if (e.code == "email-already-in-use"){
      SnackBar(
        content: Text("Consider logging in"),
        behavior: SnackBarBehavior.floating,
      );
    }
  } catch(e) {
    SnackBar(
        content: Text(e.code),
      behavior: SnackBarBehavior.floating,
    );
  }
  return null;
}

Future<UserCredential> handleLogin(String email, String password) async {
  try{
    UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  } on FirebaseAuthException catch (e) {
    if(e.code == "user-not-found"){
      SnackBar(
        content: Text("User isn't found in database"),
        behavior: SnackBarBehavior.floating,
      );
    }else if(e.code == "wrong-password"){
      SnackBar(
        content: Text("Wrong password provided"),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: "Close",
          onPressed: () {},
        ),
      );
    }
  }
  return null;
}

Future<void> handleSignout() async {
  try{
    await FirebaseAuth.instance.signOut();
  } catch(e){
    SnackBar(
      content: Text(e.message),
      behavior: SnackBarBehavior.floating,
    );
  }
}

User checkUser() {
  return auth.currentUser;
}