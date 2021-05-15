import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class WallsList extends StatefulWidget {
  @override
  _WallsListState createState() => _WallsListState();
}

class _WallsListState extends State<WallsList> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Wallpapers(),
    );
  }

  // ignore: non_constant_identifier_names
  Widget Loading(){
    return Container(
      child: Center(
          child: Text(
              "Hold on...",
              style: TextStyle(fontSize: 24),
          )
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget Wallpapers() {
    return new FutureBuilder(
        future: fetchAlbum(),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          try {
            Map content = snapshot.data;
            return content == null ? Loading() : Expanded(
                child: new OrientationBuilder(builder: (context, orientation) {
                  return StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    itemCount: content["results"].length,
                    itemBuilder: (BuildContext context, int index) => Container(
                      child: Image.network(
                        content["results"][index]["urls"]["thumb"].toString(),
                      ),),
                    staggeredTileBuilder: (int index) =>
                     StaggeredTile.fit(1),
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                  );
                }));
          } catch (e) {
            return Text(
              "Error Fetching Data",
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold
              ),
            );
          }
        });
  }

  Future<Map> fetchAlbum() async{
    // var response = http.get(Uri.https('api.unsplash.com', '/search/photos/?client_id=fpUByHaj-12ZqLk5LAtsQ7x99Dg7qOM2tGGo2aBx1Lw&query=avengers'));
    http.Response response = await http.get('https://api.unsplash.com/search/photos/?client_id=fpUByHaj-12ZqLk5LAtsQ7x99Dg7qOM2tGGo2aBx1Lw&query=avengers');
    return json.decode(response.body);
  }
}
