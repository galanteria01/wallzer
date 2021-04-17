import 'package:flutter/material.dart';
import 'package:wall_application/firebase/storage.dart';

class CategoryCard extends StatelessWidget {
  String imagePath;
  String title;
  CategoryCard({this.title,this.imagePath});




  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Material(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  Image.asset(imagePath, ),
                  Positioned(
                    bottom: 18,
                    left: 18,
                    child:Text(
                        title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
