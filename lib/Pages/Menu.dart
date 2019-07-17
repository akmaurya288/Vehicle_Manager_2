import 'package:flutter/material.dart';
import 'package:vehicle_manager_2/DataBase/DriverModel.dart';
import 'package:vehicle_manager_2/DataBase/VehicleModel.dart';
import 'package:vehicle_manager_2/Screen/AddVehicle.dart';
import 'package:vehicle_manager_2/Screen/AddDriver.dart';
import 'package:vehicle_manager_2/Screen/AssignVehicle.dart';
import 'package:vehicle_manager_2/Screen/settings.dart';
import 'package:vehicle_manager_2/Screen/backup.dart';
import 'package:vehicle_manager_2/Pages/Vehicle.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: NestedScrollView(headerSliverBuilder:(BuildContext context,bool innerBoxIsScrolled){
          return <Widget>[
            SliverAppBar(
              pinned: true,
              floating: true,
              titleSpacing: 10,
              forceElevated: innerBoxIsScrolled,
              title: Text("Menu"),
              elevation: 4.0,
              backgroundColor: Colors.red,
            )
          ];
        },
            body: Container(
                color: Colors.red[50],
                child:Padding( padding: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  ExpansionTile(
                    leading: Icon(Icons.add,size: 30,),
                    title: Text("Add", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        'Driver',
                      ),
                      leading: Icon(null),
                      onTap: ()=>navigateToAddDriver(DriverDB(0,'','','',0,'','','',0,'',''),'Add Driver',true, context)
                    ),
                    ListTile(
                      title: Text(
                        'Vehicle',
                      ),
                      leading: Icon(null),
                      onTap: ()=>navigateToAddVehicle(VehicleDB('', '', '', ''),'Add Vehicle',true, context),
                    ),
                    ListTile(
                      title: Text(
                        'Income',
                      ),
                      leading: Icon(null),
                      onTap: ()=>{},
                    ),
                  ],),

                  MaterialButton(onPressed: ()=>navigateToVehicles("Vehicles",context),
                    elevation: 5,
                    height: 60,
                    minWidth: MediaQuery.of(context).size.width,
                    child: Row(
                        children: <Widget>[
                          Icon(Icons.directions_car,size: 30,),
                          Text("  Vahicles",style: TextStyle(fontSize: 15),)
                        ]
                    ),
                  ),

                  MaterialButton(onPressed: ()=>navigateToAssignVehicle(DriverDB(0,'','','',0,'','','',0,'',''),context),
                    elevation: 5,
                    height: 60,
                    minWidth: MediaQuery.of(context).size.width,
                    child: Row(
                        children: <Widget>[
                          Icon(Icons.attachment,size: 30,),
                          Text("  Assign Vahicle",style: TextStyle(fontSize: 15),)
                        ]
                    ),
                  ),

                  MaterialButton(onPressed: ()=>navigateToBackup("Backup",context),
                    elevation: 5,
                    height: 60,
                    minWidth: MediaQuery.of(context).size.width,
                    child: Row(
                        children: <Widget>[
                          Icon(Icons.backup,size: 30,),
                          Text("  Backup",style: TextStyle(fontSize: 15),)
                        ]
                    ),
                  ),

                  MaterialButton(onPressed: ()=>navigateToSettings("Settings",context),
                    elevation: 5,
                    height: 60,
                    minWidth: MediaQuery.of(context).size.width,
                    child: Row(
                        children: <Widget>[
                          Icon(Icons.settings,size: 30,),
                          Text("  Settings",style: TextStyle(fontSize: 15),)
                        ]
                    ),
                  ),

                ],

              ),
            )),
        )
      ),
    );
  }

  void navigateToVehicles(String title, BuildContext context) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Vehicle();
    }));
  }

  void navigateToAssignVehicle(DriverDB driverDB,BuildContext context) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AssignVehicle(driverDB);
    }));
  }

  void navigateToSettings(String title, BuildContext context) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Settings();
    }));
  }

  void navigateToBackup(String title, BuildContext context) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Backup();
    }));
  }

  void navigateToAddDriver(DriverDB driverDB, String title, bool edit, BuildContext context) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddDriver(driverDB, title, edit);
    }));
  }

  void navigateToAddVehicle(VehicleDB vehicleDB, String title, bool edit, BuildContext context) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddVehicle(vehicleDB, title, edit);
    }));
  }
}
