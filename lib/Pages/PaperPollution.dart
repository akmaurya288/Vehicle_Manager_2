import 'package:flutter/material.dart';
import 'package:vehicle_manager_2/Screen/AddDriver.dart';
import 'package:vehicle_manager_2/DataBase/DriverModel.dart';

class PaperPollution extends StatefulWidget {
  @override
  _PaperPollutionState createState() => _PaperPollutionState();
}

class _PaperPollutionState extends State<PaperPollution> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton(
        onPressed:()=>navigateToDetail(DriverDB(0,'','','',0,'','','',0,'',''),'Add Driver',true),
        backgroundColor: Colors.redAccent,
        tooltip: "Add new Todo",
        child: new Icon(Icons.add,
          color: Colors.white,),
      ),
    );
  }

  void navigateToDetail(DriverDB driverDB, String title, bool edit) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddDriver(driverDB, title, edit);
    }));

    if (result == true) {
    }
  }
}
