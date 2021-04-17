import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wall_application/home.dart';

import 'firebase/auth.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  void signup () async {
    UserCredential user = await handleSignup(_emailController.text, _passController.text);
    if(user!=null){
      _emailController.text = "";
      _passController.text = "";
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Align(alignment: Alignment.centerLeft,
                    child: Text("Sign up",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 32.0
                  ),)),
                SizedBox(height: 200,),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Full name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.drive_file_rename_outline)
                  ),

                ),
                SizedBox(height: 64,),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email)
                  ),
                ),
                SizedBox(height: 64,),
                TextFormField(
                  controller: _passController,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock)
                  ),
                ),
                SizedBox(height: 64,),
                ElevatedButton.icon(
                    onPressed: signup,
                    label: Text("Sign up"),
                    icon: Icon(Icons.app_registration),
                  style: ButtonStyle(
                  ),

                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
