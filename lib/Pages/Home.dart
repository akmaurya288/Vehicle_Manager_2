import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final data=[0.0,1.0,1.5,2.0,0.0,0.0,-0.5,-1.0,-0.5,0.0,0.0,];
  @override
  Widget build(BuildContext context) {
    return Material(child:Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body:Container(
          color: Colors.red[50],
          child: StaggeredGridView.count(
            crossAxisCount: 2, crossAxisSpacing: 6.0, mainAxisSpacing: 6.0, padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 6.0),
            children: <Widget>[
              Material(
                  color: Colors.white,
                  elevation: 2.0,
                  shadowColor: Colors.black,
                  borderRadius: BorderRadius.circular(5.0),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
                      child: Sparkline(
                        data: data,
                        lineColor: Colors.redAccent,
                        pointsMode: PointsMode.all,
                        pointSize: 8.0,
                        pointColor: Colors.blue[200],),
                    ),
                  )
              ),
              Chips(),
              Chips(),
              Chips(),
              Chips(),
              Chips(),
              Chips(),
              Chips(),

            ],
            staggeredTiles: [
              StaggeredTile.extent(2, 240.0),
              StaggeredTile.extent(1, 150.0),
              StaggeredTile.extent(1, 130.0),
              StaggeredTile.extent(1, 150.0),
              StaggeredTile.extent(1, 250.0),
              StaggeredTile.extent(1, 200.0),
              StaggeredTile.extent(1, 180.0),
              StaggeredTile.extent(1, 180.0),
            ],

          ),
        )
    )
    );
  }
}

class Chips extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 2.5,
      shadowColor: Colors.black,
      borderRadius: BorderRadius.circular(6.0),
    );
  }
}

