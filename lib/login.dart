import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wall_application/home.dart';
import 'package:wall_application/signup.dart';

import 'firebase/auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  void login() async{
    UserCredential user = await handleLogin(_emailController.text, _passController.text);
    if(user != null){
      _emailController.text = "";
      _passController.text = "";
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }
  }

  void registerNow() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Signup()));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
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
                Align(
                  child: Text(
                      "Login",
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                SizedBox(height: 250.0,),
                Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          labelText: 'Email Address',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.drive_file_rename_outline)
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32,),
                Column(
                  children: [
                    TextFormField(
                      controller: _passController,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock)
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 48,),
                ElevatedButton.icon(
                    onPressed: login,
                    icon: Icon(Icons.login),
                    label: Text("Login")
                ),
                SizedBox(height: 6,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("New?"),
                    TextButton(
                        onPressed: registerNow,
                        child: Text("Register now!")
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
