class VehicleDB{
  int _vehicleID;
String _plateno;
String _type;
String _carimage;
String _modelno;


VehicleDB(this._plateno,this._type,this._carimage,this._modelno);
VehicleDB.withID(this._vehicleID,this._plateno,this._type,this._carimage,this._modelno);


int get vehicleID =>_vehicleID;
String get plateno =>_plateno;
String get type =>_type;
  String get carimage =>_carimage;
  String get modelno =>_modelno;


set vehicleID(int newVehicleID){
if(newVehicleID>0){
this._vehicleID=newVehicleID;
}
}

//vehical
set plateno(String newtype){
if(newtype.length>0){
this._plateno=newtype;
}
}
set type(String newtype){
if(newtype.length>0){
this._type=newtype;
}
}
set carimage(String newim){
    if(newim.length>0){
      this._carimage=newim;
    }
  }
  set modelno(String newm){
    if(newm.length>0){
      this._modelno=newm;
    }
  }


Map<String,dynamic>toVehicleMap(){
var map=Map<String,dynamic>();
if(vehicleID!= null){
map['vehicleID'] = _vehicleID;
}
map['plateno']=_plateno;
map['carImage']=_carimage;
map['modelno']=_modelno;
map['type']=_type;

return map;
}
VehicleDB.fromVehicleMapObject(dynamic map){
this._vehicleID=map['vehicleID'];
this._plateno=map['plateno'];
this._modelno=map['modelno'];
this._carimage=map['carImage'];
this._type=map['type'];


}
VehicleDB.fromVehicleListMapObject(dynamic map){
this._plateno=map['plateno'];
this._vehicleID=map['vehicleID'];
}
}