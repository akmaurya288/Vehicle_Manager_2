import 'package:flutter/material.dart';
import 'package:vehicle_manager_2/Pages/PaperFitness.dart';
import 'package:vehicle_manager_2/Pages/PaperInsurence.dart';
import 'package:vehicle_manager_2/Pages/PaperPollution.dart';
import 'package:vehicle_manager_2/Pages/PaperServicing.dart';

class Paper extends StatefulWidget {
  @override
  _PaperState createState() => _PaperState();
}

class _PaperState extends State<Paper> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child:DefaultTabController(length: 4,
    child: Scaffold(
        body:NestedScrollView(headerSliverBuilder: (BuildContext context,bool innerBoxIsScrolled){
    return <Widget>[
    SliverAppBar(
    pinned: true,
    floating: true,
    titleSpacing: 10,
    forceElevated: innerBoxIsScrolled,
    title: Text("Paper"),
    elevation: 4.0,
    backgroundColor: Colors.red,
    bottom: TabBar(
    indicatorColor: Colors.white,
    tabs: [
    Tab(text: 'Insurence',),
    Tab(text: 'Pollution',),
    Tab(text: 'Fitness',),
    Tab(text: 'Servicing',),
    ]),
    )
    ];
    },body: TabBarView(
          children: [PaperInsurence(), PaperPollution(), PaperFitness(), PaperServicing()],
        ),
      ),
    )
    )
    );
  }
}
