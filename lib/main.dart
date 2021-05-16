import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:wall_application/loading.dart';
import 'package:wall_application/models/category.dart';
import 'package:wall_application/something_went_wrong.dart';
import 'package:wall_application/splash.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final Future<Database> database = openDatabase(
    join(await getDatabasesPath(), 'category.db'),
    onCreate: (db, version){
      return db.execute(
        "CREATE TABLE category(id INTEGER PRIMARY KEY, title TEXT, endpoint TEXT, imageURL TEXT "
      );
    },
    version: 1
  );

  Future<void> addCategory(Category category) async{
    final Database db = await database;
    await db.insert(
        'category',
        category.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<List<Category>> categories() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('dogs');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Category(
        id: maps[i]['id'],
        title: maps[i]['title'],
        endpoint: maps[i]['endpoint'],
        imageURL: maps[i]['imageURL']
      );
    });
  }

  Future<void> updateDog(Category category) async {
    final db = await database;

    await db.update(
      'category',
      category.toMap(),
      where: "id = ?",
      whereArgs: [category.id],
    );
  }

  Future<void> deleteCategory(int id) async {
    final db = await database;

    await db.delete(
      'category',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
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
    return ThemeProvider(
      loadThemeOnInit: true,
      saveThemesOnChange: true,
      themes: [
        AppTheme.dark(id: "dark_theme"),
        AppTheme.light(id: "light_theme")
      ],
        child: ThemeConsumer(
          child: Builder(
            builder: (themeContext) => MaterialApp(
              theme: ThemeProvider.themeOf(themeContext).data,
              home: Splash(),
            ),
          ),
        )
    );
  }
}
