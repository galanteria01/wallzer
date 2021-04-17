
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wall_application/loading.dart';
import 'package:wall_application/something_went_wrong.dart';
import 'package:wall_application/splash.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {

  bool _initialized = false;
  bool _error = false;

  void initialiseFlutterFire() async {
    try{
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    }catch(error){
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initialiseFlutterFire();
    super.initState();
  }

  @override
  void setState(fn) {
    // FirebaseAuth.instance.authStateChanges().listen((User user) {
    //   if(user != null){
    //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
    //   }
    // });
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    if(_error){
      return SomethingWentWrong();
    }
    if(!_initialized){
      return Loading();
    }
    return Splash();
  }
}
