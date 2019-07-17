import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:vehicle_manager_2/DataBase/DriverModel.dart';
import 'package:vehicle_manager_2/Util/DbHelper.dart';

class AddDriver extends StatefulWidget {
  final String appBarTitle;
  final DriverDB driverDB;
  final bool edit;
  AddDriver(this.driverDB,this.appBarTitle,this.edit);

  @override
  _AddDriverState createState() => _AddDriverState(this.driverDB, this.appBarTitle, this.edit);
}

class _AddDriverState extends State<AddDriver> {

  DatabaseHelper helper= DatabaseHelper();
  File _licenceimage;
  File _policeverificationimage;
  File _driverImage;
  String _drivername;
  String appBarTitle;
  DriverDB driverDB;
  bool edit=false;

  _AddDriverState(this.driverDB, this.appBarTitle, this.edit);
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController expiryController = TextEditingController();
  TextEditingController leaveController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController medicalController = TextEditingController();
  TextEditingController policeController = TextEditingController();
  TextEditingController licenceController = TextEditingController();
  TextEditingController DriverImageController = TextEditingController();


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
                      controller: nameController,
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
                      controller: mobileController,
                      keyboardType: TextInputType.numberWithOptions(decimal:false),
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
                      controller: addressController,
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
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: TextField(
                      enabled: edit,
                      controller: expiryController,
                      onChanged: (value) {
                        debugPrint('Something changed in Title Text Field');
                        updateTitle();
                      },
                      decoration: InputDecoration(
                          labelText: 'Licence Expiry',
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
                      controller: experienceController,
                      keyboardType: TextInputType.numberWithOptions(decimal: false),
                      onChanged: (value) {
                        debugPrint('Something changed in Title Text Field'+value);
                        updateTitle();


                      },
                      decoration: InputDecoration(
                          labelText: 'Experience',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)
                          )
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child:Padding(
                            padding: EdgeInsets.all(20),
                            child:Container(
                                decoration: BoxDecoration(
                                    border: Border.all(width: 1)
                                ),

                                child:Padding(
                                  padding: EdgeInsets.all(5),
                                  child:SizedBox(
                                    height: 200,
                                    width: 192,
                                    child:  _driverImage==null ? Text("Select Image"):Image.file(_driverImage),
                                  ),
                                )
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child:Column(
                            children: <Widget>[
                              Text ("Driver Image",style: TextStyle(fontSize: 23),),
                              Row(
                                children: <Widget>[
                                  RaisedButton(
                                      child: Icon(Icons.image),
                                      onPressed: getImageGalleryDriver
                                  ),
                                  RaisedButton(
                                    child: Icon(Icons.camera),
                                    onPressed:getImageCameraDriver,
                                  )
                                ],
                              )
                            ],
                          )),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                          child:Padding(
                        padding: EdgeInsets.all(20),
                        child:Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1)
                        ),

                        child:Padding(
                          padding: EdgeInsets.all(5),
                          child:SizedBox(
                          height: 200,
                          width: 192,
                          child:  _policeverificationimage==null ? Text("Select Image"):Image.file(_policeverificationimage),
                        ),
                        )
                      ),
                      ),),
                      Expanded(
                          flex:1,
                          child:Column(
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
                      )),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(flex: 1,
                          child:Padding(
                        padding: EdgeInsets.all(20),
                        child:Container(
                            decoration: BoxDecoration(
                                border: Border.all(width: 1)
                            ),

                            child:Padding(
                              padding: EdgeInsets.all(5),
                              child:SizedBox(
                                height: 200,
                                width: 192,
                                child:  _licenceimage==null ? Text("Select Image"):Image.file(_licenceimage),
                              ),
                            )
                        ),
                      )),
                      Expanded(
                        flex: 1,
                          child:Column(
                        children: <Widget>[
                          Text ("Licence",style: TextStyle(fontSize: 23),),
                          Row(
                            children: <Widget>[
                              RaisedButton(
                                  child: Icon(Icons.image),
                                  onPressed: getImageGalleryLicence,
                              ),
                              RaisedButton(
                                child: Icon(Icons.camera),
                                onPressed: getImageCameraLicence,
                              )

                            ],
                          )
                        ],
                      )),
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
      _policeverificationimage=imageFile;
    });
  }
  Future getImageCamera()async{
    var imageFile = await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 1024.0,maxHeight: 768.0);
    setState(() {
      _policeverificationimage=imageFile;
    });
  }
  Future getImageGalleryDriver()async{
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery,maxHeight: 1024.0,maxWidth: 768.0);
    setState(() {
      _driverImage=imageFile;
    });
  }
  Future getImageCameraDriver()async{
    var imageFile = await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 1024.0,maxHeight: 768.0);
    setState(() {
      _driverImage=imageFile;
    });
  }
  Future getImageGalleryLicence()async{
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery,maxHeight: 1024.0,maxWidth: 768.0);
    setState(() {
      _licenceimage=imageFile;
    });
  }
  Future getImageCameraLicence()async{
    var imageFile = await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 1024.0,maxHeight: 768.0);
    setState(() {
      _licenceimage=imageFile;
    });
  }

  Future checkEmpty() async{
    if(driverDB.driverID!=null){
      _drivername=driverDB.driverName;
      nameController.text = driverDB.driverName;
      addressController.text = driverDB.adders;
      expiryController.text = driverDB.expiry;
      medicalController.text = driverDB.medical;
      leaveController.text = driverDB.leave;
      policeController.text = driverDB.policeVeri;
      mobileController.text=driverDB.mobno.toString();
      experienceController.text=driverDB.exp.toString();
      setState(() {
        _driverImage = File.fromUri(Uri.file(driverDB.driverImage));
        _licenceimage=File.fromUri(Uri.file(driverDB.licence));
        _policeverificationimage=File.fromUri(Uri.file(driverDB.policeVeri));
      });
    }
  }
  void updateTitle(){
    driverDB.driverName = nameController.text;
    driverDB.adders = addressController.text;
    driverDB.expiry = expiryController.text;
    driverDB.medical = medicalController.text;
    driverDB.leave = leaveController.text;
    driverDB.mobno=int.parse(mobileController.text);
    driverDB.exp=int.parse(experienceController.text);

  }
  // Save data to database
  void _SaveImage()async{
    String path=(await getExternalStorageDirectory()).path;
    String imgname = nameController.text;
    File saveimg1 = await _policeverificationimage.copy(
        '$path/$imgname.jpg');
  }

  void _save() async {

    String path=(await getApplicationDocumentsDirectory()).path;
    if(Directory('$path/images/policeverification/').existsSync()==false)
      new Directory('$path/images/policeverification/').create(recursive: true);

    if(_drivername!=nameController.text&&File('$path/images/policeverification/$_drivername.jpg').existsSync()){
      File('$path/images/policeverification/$_drivername.jpg').delete();
    }
    if(_policeverificationimage!=null) {
      String imgname = nameController.text;
      File saveimg1 = await _policeverificationimage.copy(
          '$path/images/policeverification/$imgname.jpg');
      driverDB.policeVeri = saveimg1.path;
      debugPrint(saveimg1.path);
    }
    if(Directory('$path/images/licence/').existsSync()==false)
      new Directory('$path/images/licence/').create(recursive: true);
    if(_drivername!=nameController.text&&File('$path/images/licence/$_drivername.jpg').existsSync()){
      File('$path/images/licence/$_drivername.jpg').delete();
    }
    if(_licenceimage!=null) {
      String imgname = nameController.text;
      File saveimg2 = await _licenceimage.copy(
          '$path/images/licence/$imgname.jpg');
      driverDB.licence = saveimg2.path;
      debugPrint(saveimg2.path);
    }
    ;
    if(Directory('$path/images/Driver/').existsSync()==false)
      new Directory('$path/images/Driver/').create(recursive: true);

    if(_drivername!=nameController.text&&File('$path/images/Driver/$_drivername.jpg').existsSync()){
      File('$path/images/Driver/$_drivername.jpg').delete();
    }
    if(_driverImage!=null) {
      String imgname = nameController.text;
      File saveimg3 = await _driverImage.copy(
          '$path/images/Driver/$imgname.jpg');
      driverDB.driverImage = saveimg3.path;
      debugPrint(saveimg3.path);
    }

    driverDB.date = DateFormat.yMMMd().format(DateTime.now());

    if(driverDB.leave==null)
      driverDB.leave==true;

    int result;
    if (driverDB.driverID != null) {  // Case 1: U
      result = await helper.updateDriverNote(driverDB);
    } else { // Case 2: Insert Operation
      driverDB.vehicleID=99999;
      result = await helper.insertDriverNote(driverDB);
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

    _policeverificationimage.delete();
    _licenceimage.delete();
    moveToLastScreen();

    // Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
    // the detail page by pressing the FAB of NoteList page.
    if (driverDB.driverID == null) {
      _showAlertDialog('Status', 'No Note was deleted');
      return;
    }

    // Case 2: User is trying to delete the old note that already has a valid ID.
    int result = await helper.deleteDriverNote(driverDB.driverID);
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
