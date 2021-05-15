import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:wall_application/login.dart';
import 'firebase/auth.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  void signout() async {
    await handleSignout();
    if(checkUser() == null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          ListTile(
            title: Text("Switch mode"),
            onTap: () {
              ThemeProvider.controllerOf(context).nextTheme();
            },
            leading: Icon(Icons.wb_incandescent_outlined),
          ),
          ListTile(
            title: Text("About"),
            leading: Icon(Icons.person),
          ),
          ListTile(
            title: Text("Notifications"),
            leading: Icon(Icons.notifications),
            onTap: signout,
          ),
          ListTile(
            title: Text("Feedback"),
            leading: Icon(Icons.feedback),
            onTap: signout,
          ),
          ListTile(
            title: Text("Sign out"),
            leading: Icon(Icons.logout),
            onTap: signout,
          ),

          Center(
            child: Text("Copyright 2021 Shanu"),
          )
        ],
      ),
    );
  }
}
