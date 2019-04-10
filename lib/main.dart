import 'package:flutter/material.dart';
import 'package:vehicle_manager_2/Pages/Home.dart';
import 'package:vehicle_manager_2/Pages/Driver.dart';
import 'package:vehicle_manager_2/Pages/Income.dart';
import 'package:vehicle_manager_2/Pages/Paper.dart';
import 'package:vehicle_manager_2/Pages/Vehicle.dart';
import 'package:vehicle_manager_2/Pages/Menu.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vehicle Manager',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pagelist= [Home(),Driver(),Paper(),Income(),Menu()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pagelist[_selectedIndex],
      bottomNavigationBar: Theme(data: Theme.of(context).copyWith(
        // sets the background color of the `BottomNavigationBar`
          canvasColor: Colors.red,
          // sets the active color of the `BottomNavigationBar` if `Brightness` is light
          primaryColor: Colors.black,
          textTheme: Theme
              .of(context)
              .textTheme
              .copyWith(caption: new TextStyle(color: Colors.black))), //,
        child:BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home,), title: Text('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('Driver')),
          BottomNavigationBarItem(icon: Icon(Icons.pages), title: Text('Paper')),
          BottomNavigationBarItem(icon: Icon(Icons.attach_money), title: Text('Income')),
          BottomNavigationBarItem(icon: Icon(Icons.menu),title: Text("Menu")),
        ],
        currentIndex: _selectedIndex,
        iconSize: 20.0,

        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.white,
        onTap: _onItemTapped,
      ),
      )
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}