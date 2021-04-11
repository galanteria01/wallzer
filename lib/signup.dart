import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  handleSignup() async {
    try{
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: _emailController.text, password: _passController.text);
    } on FirebaseAuthException catch(e) {
      if(e.code == "weak-password"){
        SnackBar(content: Text("The password is weak"),);
      }else if (e.code == "email-already-in-use"){
        SnackBar(content: Text("Consider logging in"),);
      }
    } catch(e) {
      SnackBar(content: Text(e.code));
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
                    onPressed: handleSignup,
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
