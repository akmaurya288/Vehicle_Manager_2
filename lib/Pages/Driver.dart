import 'package:flutter/material.dart';
import 'package:vehicle_manager_2/DataBase/DriverModel.dart';
import 'package:vehicle_manager_2/DataBase/VehicleModel.dart';
import 'package:vehicle_manager_2/Util/DbHelper.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as IO;
import 'package:vehicle_manager_2/Screen/AddDriver.dart';

class Driver extends StatefulWidget {
  @override
  _DriverState createState() => _DriverState();
}

class _DriverState extends State<Driver> {
  DatabaseHelper helper = DatabaseHelper();
  List<DriverDB> model;
  List<VehicleDB> vehicleDB;
  int vcount =0;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (model == null) {
      model = List<DriverDB>();
      updateListView();
    }
    return Material(
        child:Scaffold(

          appBar:AppBar(
            title: Text("Driver"),
            elevation: 5,
          ),
      body: Container(
        color: Colors.red[50],
        child: ListView.builder(
          itemCount: count,
          itemBuilder: (BuildContext context1,int index){
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
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(IO.File.fromUri(Uri.file(model[index].driverImage))))
                                ),
                              )
                          ),
                          Divider(height: 5,color: Colors.black,),
                          Text(model[index].driverName,style: TextStyle(
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
                            Text("Phone No.:",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                            Text(this.model[index].mobno.toString(),style: TextStyle(fontSize: 20),),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text("Vehicle ID:",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                            Text(this.model[index].driverID.toString(),style: TextStyle(fontSize: 20),),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Text("On Leave",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
                            Switch(
                              value: getLeaveValue(this.model[index].leave),
                              onChanged: (value) {
                                setState(() {
                                  this.model[index].leave = value.toString();
                                });
                              },
                              activeTrackColor: Colors.lightGreenAccent,
                              activeColor: Colors.green,
                            ),
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
        onPressed:()=>navigateToDetail(DriverDB(0,'','','',0,'','','',0,'',''),'Add Driver',true),
        backgroundColor: Colors.redAccent,
        tooltip: "Add new Todo",
        child: new Icon(Icons.add,color: Colors.white,),
      ),
        ),
    );
  }

  DropdownButton getDropdown(DriverDB model){
    List<String> _vehicleList=[];
    int vcount = 0;
    String _vehicle;
    final Future<Database> dbFuture = helper.initializeDatabase();
    dbFuture.then((database){
      Future<List<VehicleDB>> noteListFuture = helper.getVehicalPlateList();
      noteListFuture.then((vehicles){
        setState(() {
          this.vehicleDB = vehicles;
          vcount = vehicles.length;
        });
      });
    });

    if(model.vehicleID!=null){
      _vehicle=vehicleDB[model.vehicleID].plateno;
    }

    if(vehicleDB!=null){
      for (int i = 0; i < vcount; i++) _vehicleList.add(vehicleDB[i].plateno);
      _vehicle=vehicleDB[1].plateno;
    }else{
      _vehicleList.add("No Vehicles");
      _vehicle = "No Vehicles";
    }

    debugPrint(_vehicle);
    debugPrint(vcount.toString());
    return DropdownButton<String>(
      items: _vehicleList.map((String value){
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      value: _vehicle,
      onChanged: (String value){
        setState(() {
          _vehicle=value;
        });
      },
    );
  }

  bool getLeaveValue(String st){
    debugPrint(st);
    if(st=='true')return true;
        else return false;
  }

  void _delete(BuildContext context, DriverDB driverDB) async {

    int result = await helper.deleteDriverNote(driverDB.driverID);
    if (result != 0) {
      _showSnackBar(context, 'Note Deleted Successfully');
      updateListView();
    }
  }
  void _showSnackBar(BuildContext context, String message) {

    final snackBar = SnackBar(duration: Duration(seconds: 1),content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }
  void navigateToDetail(DriverDB driverDB, String title, bool edit) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddDriver(driverDB, title, edit);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = helper.initializeDatabase();
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
}
