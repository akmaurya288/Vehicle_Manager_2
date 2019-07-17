import 'package:flutter/material.dart';
import 'package:vehicle_manager_2/DataBase/DriverModel.dart';
import 'package:vehicle_manager_2/DataBase/VehicleModel.dart';
import 'package:vehicle_manager_2/Util/DbHelper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as IO;
import 'package:vehicle_manager_2/Screen/AddVehicle.dart';
import 'package:vehicle_manager_2/Screen/AddDriver.dart';
import 'package:vehicle_manager_2/Screen/SelectVehicle.dart';


class AssignVehicle extends StatefulWidget {
  final DriverDB driverDB;
  AssignVehicle(this.driverDB);

  @override
  _AssignVehicleState createState() => _AssignVehicleState(this.driverDB);
}

class _AssignVehicleState extends State<AssignVehicle> {
  DatabaseHelper helper = DatabaseHelper();
  List<DriverDB> model;
  List<VehicleDB> vehicleDB;
  DriverDB driverDB;

  int vcount =0;
  int count = 0;
  _AssignVehicleState(this.driverDB);

  @override
  Widget build(BuildContext context) {
    if (model == null) {
      model = List<DriverDB>();
      updateListView();
    }
    if (vehicleDB == null) {
      vehicleDB = List<VehicleDB>();
      updateListView();
    }
    return Material(
      child:Scaffold(
        appBar: AppBar(
          title: Text("Assign Vehicle"),
//          actions: <Widget>[
//            IconButton(
//                icon: Icon(Icons.save),
//                tooltip: 'Save',
//                onPressed:()=>_save()
//            )
//          ],
        ),
        body: Container(
          color: Colors.red[50],
          child: ListView.builder(
            itemCount: count,
            itemBuilder: (BuildContext context,int index){
              return Padding(padding: EdgeInsets.all(3),
                child: Container(
                color: Colors.red[50],
                alignment: Alignment.center,
                child: Row(children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              color: Colors.white
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
                                    child: model[index].driverImage==null ? Text("No Image"):Image.file(IO.File.fromUri(Uri.file(model[index].driverImage))),
                                  )
                              ),
                              Divider(height: 5,color: Colors.black,),
                              Text(model[index].driverName,style: TextStyle(
                                fontSize: 16.0,fontWeight: FontWeight.bold,
                              ),)
                            ],
                          )
                      ),
                      onTap:()=>navigateToDriverDetail(this.model[index],'Driver',false),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: model[index].vehicleID>999 ? _AddVehicleInfo(index):_GetVehicleInfo(model[index].vehicleID-1),
                  ),
                ],
                ),
              ));
            },
          ),
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
  void navigateToVehicleDetail(VehicleDB vehicleDB, String title, bool edit) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddVehicle(vehicleDB, title, edit);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void navigateToDriverDetail(DriverDB model, String title, bool edit) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddDriver(model, title, edit);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void navigateToSelectVehicle(int index) async {
    int result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SelectVehice();
    }));
debugPrint(result.toString());
if(result!=null)
    if (result >-1) {
      setState(() {
        model[index].vehicleID=result;
        model[index].leave="false";
        helper.updateDriverNote(model[index]);
      });
    }
  }


  void updateListView() {

    final Future<Database> dbFuture = helper.initializeDatabase();
    dbFuture.then((database){
      Future<List<VehicleDB>> noteListFuture = helper.getVehicleList();
      noteListFuture.then((vehicleDB) {
        setState(() {
          this.vehicleDB = vehicleDB;
          this.count = vehicleDB.length;
        });
      });
    });
    dbFuture.then((database) {
      Future<List<DriverDB>> noteListFuture = helper.getNoteList();
      noteListFuture.then((model) {
        setState(() {
          this.model = model;
          this.count = model.length;
        });
      });
    });
  }

  _GetVehicleInfo(int index){
    return GestureDetector(
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Colors.white
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
                    child: vehicleDB[index].carimage==null ? Text("No Image"):Image.file(IO.File.fromUri(Uri.file(vehicleDB[index].carimage))),
                  )
              ),
              Divider(height: 5,color: Colors.black,),
              Text(vehicleDB[index].plateno,style: TextStyle(
                fontSize: 16.0,fontWeight: FontWeight.bold,
              ),)
            ],
          )
      ),
      onTap:()=>navigateToVehicleDetail(this.vehicleDB[index],'Driver',false),
    );
  }

  _AddVehicleInfo(int index){
    return GestureDetector(
      child: Container(
        height: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Colors.white
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
             Center(
               child: Text("Assign Vehicle"),
             )
            ],
          )
      ),
      onTap:()=>navigateToSelectVehicle(index),
    );
  }

  void _save() async {
    int result;
      result = await helper.updateDriverNote(driverDB);

    moveToLastScreen();
    if (result == 0) {
      _showAlertDialog('Status', 'Problem Saving Note');
    } else{
      _showAlertDialog('Status', 'Details Saved Successfully');
    }
  }

  void moveToLastScreen() {
    Navigator.pop(context,true);
  }


  void _showAlertDialog(String title, String message) {

    Fluttertoast.showToast(msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.black12,
        textColor: Colors.white,
        fontSize: 16.0);

    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
        context: context,
        builder: (_) => alertDialog
    );
  }
}
