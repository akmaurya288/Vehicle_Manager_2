class FuelDB{
  
  int _vehicalID;
  String _lastFilledDate;
  int _distanceCovered;
  int _average;
  int _fuelCost;
  int _howMuch;
  FuelDB(this._lastFilledDate,this._average,this._fuelCost,this._howMuch,this._distanceCovered);
  FuelDB.withId(this._lastFilledDate,this._average,this._fuelCost,this._howMuch,this._distanceCovered,this._vehicalID);

  int get distanceCovered =>_distanceCovered;
  String get lastFilledDate =>_lastFilledDate;
  int get average =>_average;
  int get fuelCost =>_fuelCost;
  int get howMuch =>_howMuch;
  int get vehicalId =>_vehicalID;

set distanceCovered(int newdc){
  
      this._distanceCovered=newdc;
    
  }
set lastFilledDate(String newfd){
    if(newfd.length>0){
      this._lastFilledDate=newfd;
    }
  }
set average(int newaverage){
    
    this._average= newaverage;
    
  }
set fuelCost(int newfc){
    if(newfc>0){
      this._fuelCost=newfc;
    }}
set vehicalId(int  newid) {
    _vehicalID = newid;
  }
set howMuch(int newhw){
    if(newhw>=0){
      this._howMuch=newhw;
    }

  }

   Map<String,dynamic>toFuelMap(){
    var map=Map<String,dynamic>();
    if(vehicalId != null){
      map['ID'] = _vehicalID;
    }
    map['vehicalId']=_vehicalID;
  map['distanceCovered']=_distanceCovered;
  map['lastFilledDate']=_lastFilledDate;
  map['average']=_average;
  map['fuelCost']=_fuelCost;
  map['howMuch']=_howMuch;
  return map;}
  FuelDB.fromFuelMapObject(dynamic map){
      this._vehicalID= map['vehicalId'];
     this._distanceCovered=  map['distanceCovered'];
    this._lastFilledDate=map['lastFilledDate'];
    this._average=map['average'];
    this._fuelCost=map['fuelCost'];
     this._howMuch=map['howMuch'];
   }


}