import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:vehicle_manager_2/DataBase/DriverModel.dart';
import 'package:vehicle_manager_2/DataBase/VehicleModel.dart';
import 'package:vehicle_manager_2/Util/DbHelper.dart';

class AddVehicle extends StatefulWidget {
  final String appBarTitle;
  final VehicleDB vehicleDB;
  final bool edit;
  AddVehicle(this.vehicleDB,this.appBarTitle,this.edit);

  @override
  _AddVehicleState createState() => _AddVehicleState(this.vehicleDB, this.appBarTitle, this.edit);
}

class _AddVehicleState extends State<AddVehicle> {

  DatabaseHelper helper= DatabaseHelper();
  File _carimage;
  String _plateno;
  String appBarTitle;
  VehicleDB vehicleDB;
  bool edit=false;
  _AddVehicleState(this.vehicleDB, this.appBarTitle, this.edit);

  TextEditingController plateNoController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController carimageController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    checkEmpty();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: null,

        child:Scaffold(
          appBar: AppBar(
            title: Text(appBarTitle),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.delete_forever),
                  tooltip: 'Delete',
                  onPressed: _delete),
              IconButton(
                icon: Icon(Icons.edit),
                tooltip: 'Edit',
                onPressed:()=> setState(() {
                  edit=true;
                }),
              ),
              IconButton(
                  icon: Icon(Icons.save),
                  tooltip: 'Save',
                  onPressed:_save
              )
            ],
          ),
          body: Padding(padding: EdgeInsets.only(top:15.0, left:10.0, right:10.0),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    enabled: edit,
                    controller: plateNoController,
                    onChanged: (value) {
                      debugPrint('Something changed in Title Text Field');
                      updateTitle();
                    },
                    decoration: InputDecoration(
                        labelText: 'Driver Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    enabled: edit,
                    controller: modelController,
                    onChanged: (value) {
                      debugPrint('Something changed in Title Text Field' + value);
                      setState(() {
                        updateTitle();
                      });
                    },
                    decoration: InputDecoration(
                        labelText: 'Contact Mobile Number',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    enabled: edit,
                    controller: typeController,
                    onChanged: (value) {
                      debugPrint('Something changed in Title Text Field');
                      updateTitle();
                    },
                    decoration: InputDecoration(
                        labelText: 'Address',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(20),
                      child:Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 1)
                          ),

                          child:Padding(
                            padding: EdgeInsets.all(5),
                            child:SizedBox(
                              height: 256,
                              width: 192,
                              child:  _carimage==null ? Text("Select Image"):Image.file(_carimage),
                            ),
                          )
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Text ("Police Verification",style: TextStyle(fontSize: 23),),
                        Row(
                          children: <Widget>[
                            RaisedButton(
                                child: Icon(Icons.image),
                                onPressed: getImageGallery
                            ),
                            RaisedButton(
                              child: Icon(Icons.camera),
                              onPressed:getImageCamera,
                            )

                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
  Future getImageGallery()async{
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery,maxHeight: 1024.0,maxWidth: 768.0);
    setState(() {
      _carimage=imageFile;
    });
  }
  Future getImageCamera()async{
    var imageFile = await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 1024.0,maxHeight: 768.0);
    setState(() {
      _carimage=imageFile;
    });
  }

  Future checkEmpty() async{
    if(vehicleDB.plateno!=null){
      _plateno=vehicleDB.plateno;

      plateNoController.text=vehicleDB.plateno;
      modelController.text=vehicleDB.modelno;
      carimageController.text=vehicleDB.carimage;
      typeController.text=vehicleDB.type;

      setState(() {
        _carimage = File.fromUri(Uri.file(vehicleDB.carimage));
      });
    }
  }
  void updateTitle(){
    vehicleDB.plateno=plateNoController.text;
    vehicleDB.modelno=modelController.text;
    vehicleDB.type=typeController.text;
  }
  // Save data to database
  void _save() async {
    String path=(await getApplicationDocumentsDirectory()).path;
    if(Directory('$path/images/vehicle/').existsSync()==false)
      new Directory('$path/images/vehicle/').create(recursive: true);

    if(_carimage!=plateNoController.text&&File('$path/images/vehicle/$_plateno.jpg').existsSync()){
      File('$path/images/vehicle/$_plateno.jpg').delete();
    }
    if(_carimage!=null) {
      String imgname = plateNoController.text;
      File saveimg1 = await _carimage.copy(
          '$path/images/vehicle/$imgname.jpg');
      vehicleDB.carimage = saveimg1.path;
      debugPrint(saveimg1.path);
    }

    int result;
    if (vehicleDB.vehicleID != null) {  // Case 1: Update operation
      debugPrint(vehicleDB.vehicleID.toString());
      result = await helper.updatevehicleNote(vehicleDB);
    } else { // Case 2: Insert Operation
      result = await helper.insertvehicleNote(vehicleDB);
    }

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

  void _delete() async {

    if(_carimage!=null)
    _carimage.delete();
    moveToLastScreen();

    // Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
    // the detail page by pressing the FAB of NoteList page.
    if (vehicleDB.vehicleID == null) {
      _showAlertDialog('Status', 'No Note was deleted');
      return;
    }

    // Case 2: User is trying to delete the old note that already has a valid ID.
    int result = await helper.deletevehicalNote(vehicleDB.vehicleID);
    if (result != 0) {
      _showAlertDialog('Status', 'Note Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting Note');
    }
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
