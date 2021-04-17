import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Walls extends StatefulWidget {
  @override
  _WallsState createState() => _WallsState();
}

class _WallsState extends State<Walls> {

  handleSignout() {
    FirebaseAuth.instance.signOut();
    Navigator.pop(context);
}

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
          child: TextButton(
            child: Text("Signout"),
            onPressed: handleSignout,
          ),
        ),
    );
  }
}
