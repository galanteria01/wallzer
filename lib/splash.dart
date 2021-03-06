import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:wall_application/login.dart';

import 'home.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    User user = checkUser();
    // FirebaseAuth.instance.authStateChanges().listen((User user) {
    //   if(user == null){
    //     Login();
    //   }else{
    //     Home();
    //   }
    // });
    Timer(
      Duration(milliseconds: 2000),
        () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ThemeConsumer(child: user != null ? Home() : Login()))
    ));
  }

  User checkUser() {
    return FirebaseAuth.instance.currentUser;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Center(
          child: SpinKitCubeGrid(
            size: 64,
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
  }
}
