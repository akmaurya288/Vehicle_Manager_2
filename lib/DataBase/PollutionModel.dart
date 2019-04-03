class pollutionDB{

  int _vehicalID;
  String _pollutionlastDate;
  String _pollutionNextDate;
  int _pollutionCost;
  pollutionDB(this._pollutionCost,this._pollutionlastDate,this._pollutionNextDate);
  pollutionDB.withID(this._pollutionCost,this._pollutionlastDate,this._pollutionNextDate,this._vehicalID);

  int get pollutionCost => _pollutionCost;
  String get pollutionlast => _pollutionlastDate;
  String get pollutionNextDate => _pollutionNextDate;
  int get vehicalId =>_vehicalID;

set vehicalId(int  newid) {
    _vehicalID = newid;
  }

set pollutionCost(int newpc){
    
    this._pollutionCost=newpc;
    
  } 
set pollutionlast(String newfl){
    
    this._pollutionlastDate=newfl;
    
  }
set pollutionNextDate(String newnd){
    
    this._pollutionNextDate=newnd;
    
  }
 Map<String,dynamic>toPollutionMap(){
    var map=Map<String,dynamic>();
    if(vehicalId != null){
      map['ID'] = _vehicalID;
    }
    map['vehicalId']=_vehicalID;
     map['pollutionCost']= _pollutionCost;
    map['pollutionlast']=_pollutionlastDate;
    map['pollutionNextDate']=_pollutionNextDate;
    return map;
 }

 pollutionDB.fromPollutionMapObject(dynamic map){
   this._vehicalID= map['vehicalId'];
   this. _pollutionCost= map['pollutionCost'];
    this._pollutionlastDate=map['pollutionlast'];
    this._pollutionNextDate=  map['pollutionNextDate'];
 }
}