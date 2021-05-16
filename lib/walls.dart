import 'package:flutter/material.dart';
import 'package:wall_application/cards/category_card.dart';
import 'package:wall_application/walls_list.dart';

import 'firebase/storage.dart';

class Walls extends StatefulWidget {
  @override
  _WallsState createState() => _WallsState();
}

class _WallsState extends State<Walls> {
  String imagePath;

  Future<String> downloadURLExample() async {
    return await storage
        .ref('avengers/image1.jpg')
        .getDownloadURL();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              GestureDetector(
                child: CategoryCard(title: "Avengers", imagePath: 'images/avengers.jpg',),
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WallsList()))
                },
              ),
              Scrollbar(
                  child: ListView.builder(
                      itemBuilder: (context, index){
                        return CategoryCard(title: "Cars", imagePath: 'images/background.jpg',);
                      }
                  )
              )
            ],
          ),
        )
    );
  }
}
