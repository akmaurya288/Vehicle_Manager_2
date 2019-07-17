import 'package:flutter/material.dart';
import 'package:vehicle_manager_2/DataBase/VehicleModel.dart';
import 'package:vehicle_manager_2/Util/DbHelper.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as IO;
import 'package:vehicle_manager_2/Screen/AddVehicle.dart';

class Vehicle extends StatefulWidget {
  @override
  _VehicleState createState() => _VehicleState();
}

class _VehicleState extends State<Vehicle> {
  DatabaseHelper helper = DatabaseHelper();
  List<VehicleDB> model;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (model == null) {
      model = List<VehicleDB>();
      updateListView();
    }
    return Material(
        child:Scaffold(
          appBar: AppBar(
            title: Text("Vehicles"),
          ),
      body: Container(
        color: Colors.red[50],
        child: ListView.builder(
          itemCount: count,
          itemBuilder: (BuildContext context,int index){
            return GestureDetector(child: Container(
              color: Colors.red[50],
              alignment: Alignment.center,
              child: Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.red[700]
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.all(3),
                              child: Container(
                                width: 100,
                                height: 85,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: model[index].carimage==null ? Text("No Image"):Image.file(IO.File.fromUri(Uri.file(model[index].carimage))),
                              )
                          ),
                          Divider(height: 5,color: Colors.black,),
                          Text(model[index].plateno,style: TextStyle(
                            fontSize: 16.0,fontWeight: FontWeight.bold,
                          ),)
                        ],
                      )
                  ),
                ),
                Expanded(
                    flex: 5
                    ,child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1,color: Colors.grey),
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.white
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text("Plate No.:",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                            Text(this.model[index].plateno,style: TextStyle(fontSize: 20),),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text("Vehicle ID:",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                            Text(this.model[index].vehicleID.toString(),style: TextStyle(fontSize: 20),),
                          ],
                        )
                      ],
                    ),),
                ))
              ],
              ),
            ),
              onTap:()=>navigateToDetail(this.model[index],'Driver',false),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:()=>navigateToDetail(VehicleDB('', '', '', ''),'Add Vehicle',true),
        backgroundColor: Colors.redAccent,
        tooltip: "Add new Todo",
        child: new Icon(Icons.add,color: Colors.white,),
      ),
        ),
    );
  }
  void _delete(BuildContext context, VehicleDB vehicleDB) async {

    int result = await helper.deleteDriverNote(vehicleDB.vehicleID);
    if (result != 0) {
      _showSnackBar(context, 'Note Deleted Successfully');
      updateListView();
    }
  }
  void _showSnackBar(BuildContext context, String message) {

    final snackBar = SnackBar(duration: Duration(seconds: 1),content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }
  void navigateToDetail(VehicleDB vehicleDB, String title, bool edit) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddVehicle(vehicleDB, title, edit);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {

    final Future<Database> dbFuture = helper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<VehicleDB>> noteListFuture = helper.getVehicleList();
      noteListFuture.then((model) {
        setState(() {
          this.model = model;
          this.count = model.length;
        });
      });
    });
  }
}
