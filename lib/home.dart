import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wall_application/settings.dart';
import 'package:wall_application/walls.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 0;
  final List<Widget> _children = [Walls(), Settings()];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
          body: _children[_index],
          bottomNavigationBar: BottomNavigationBar(

            onTap: onTabTapped,
            currentIndex: _index,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.wallpaper),
                label: "Walls"
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                label: "Settings"
              )
            ],
          ),
        ),
    );
  }
  void onTabTapped(int index){
    setState(() {
      _index = index;
    });
  }
}
