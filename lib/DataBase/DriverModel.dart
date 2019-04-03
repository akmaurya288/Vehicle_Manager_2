class DriverDB{

  int _driverID;
  String _driverName;
  String _driverImage;
  int _mobno;
  String _address;
  int _vehicleID;
  String _med;
  String _policeVeri;
  String _licence;
  int _exp;
  String _date;
  String _expiry;
  String _leave;


  DriverDB(this._mobno,this._driverName,this._driverImage,this._address,this._vehicleID,this._med,this._policeVeri,this._licence,this._exp,this._date,this._expiry);
  DriverDB.withID(this._driverID,this._mobno,this._driverName,this._driverImage,this._address,this._vehicleID,this._med,this._policeVeri,this._licence,this._exp,this._date,this._expiry
  );

  String get driverName =>_driverName;
  String get driverImage =>_driverImage;
  int get driverID =>_driverID;
  String get adders =>_address;
  int get vehicleID =>_vehicleID;
  String get policeVeri =>_policeVeri;
  String get licence => _licence;
  String get medical =>_med;
  int get mobno=>_mobno;
  int get exp=>_exp;
  String get date => _date;
  String get expiry => _expiry;
  String get leave => _leave;
  //vehical

  set date(String newDate) {
    _date = newDate;
  }
  set driverName(String newID){
    if(newID.length>0){
      this._driverName=newID;
    }
  }
  set driverImage(String newID){
    if(newID.length>0){
      this._driverImage=newID;
    }
  }
  set driverID(int newID){
    if(newID>0){
      this._driverID=newID;
    }
  }
  set adders(String newAdders){
    if(newAdders.length>0){
      this._address=newAdders;
    }
  }
  set vehicleID(int newVehicleID){
    if(newVehicleID>0){
      this._vehicleID=newVehicleID;
    }
  }
  set policeVeri(String newPoliceVeri){
    if(newPoliceVeri.length>0){
      this._policeVeri=newPoliceVeri;
    }
  }
  set licence(String newPoliceVeri){
    if(newPoliceVeri.length>0){
      this._licence=newPoliceVeri;
    }
  }
  set medical(String newmedical){
    if(newmedical.length>0){
      this._med=newmedical;
    }
  }
  set leave(String newleave){
    if(newleave.length>0){
      this._leave=newleave;
    }
  }
  set expiry(String newexpiry){
    if(newexpiry.length>0){
      this._expiry=newexpiry;
    }
  }
  set mobno(int newMobno){
    if(newMobno>0){
      this._mobno=newMobno;
    }
  }
  set exp(int newExp){
    if(newExp<50){
      this._exp=newExp;
    }
  }
  //vehical

  Map<String,dynamic>toDriverMap(){
    var map=Map<String,dynamic>();
    if(driverID != null){
      map['driverID'] = _driverID;
    }
    map['driverName']=_driverName;
    map['driverImage']=_driverImage;
    map['driverID']=_driverID;
    map['exp']=_exp;
    map['mobno']=_mobno;
    map['medical']=_med;
    map['policeVeri']=_policeVeri;
    map['licence']=_licence;
    map['address']=_address;
    map['expiry']=_expiry;
    map['leave']=_leave;
    map['vehicleID']=vehicleID;
    return map;
  }

  DriverDB.fromDriverMapObject(dynamic map){
    this._driverName=map['driverName'];
    this._driverImage=map['driverImage'];
    this._driverID=map['driverID'];
    this._exp=map['exp'];
    this._mobno=map['mobno'];
    this._med=map['medical'];
    this._policeVeri=map['policeVeri'];
    this._licence=map['licence'];
    this._address=map['address'];
    this._expiry=map['expiry'];
    this._leave=map['leave'];
    this._vehicleID=map['vehicleID'];
  }


}