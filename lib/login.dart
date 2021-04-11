import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  void handleSubmit() async {
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: _emailController.text, password: _passController.text);
      print(userCredential);
    } on FirebaseAuthException catch (e) {
      if(e.code == "user-not-found"){
        SnackBar(content: Text("User isn't found in database"),);
      }else if(e.code == "wrong-password"){
        SnackBar(content: Text("Wrong password provided"),);
      }
    }
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
                          labelText: 'Full name',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.drive_file_rename_outline)
                      ),
                    ),
                  ],
                ),

                Column(
                  children: [
                    TextFormField(
                      controller: _passController,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: 'Full name',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.drive_file_rename_outline)
                      ),
                    ),
                  ],
                ),

                ElevatedButton(
                    onPressed: handleSubmit,
                    child: Text("Login")
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("New?"),
                    TextButton(
                        onPressed: () {},
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
