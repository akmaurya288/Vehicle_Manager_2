class FitDB{
  int _vehicalID;
  String _fitnesslastDate;
  String _fitnessNextDate;
  int _fitnessCost;

  FitDB(this._fitnessCost,this._fitnesslastDate,this._fitnessNextDate);
  FitDB.withID(this._fitnessCost,this._fitnesslastDate,this._fitnessNextDate,this._vehicalID);

  int get vehicalId =>_vehicalID;
  int get fitnessCost => _fitnessCost;
  String get fitnesslast => _fitnesslastDate;
  String get fitnessNextDate => _fitnessNextDate;

  set vehicalId(int  newid) {
    _vehicalID = newid;
  }
  set fitnessCost(int newfc){
    
    this._fitnessCost=newfc;
    
  }
  set fitnesslast(String newfl){
    
    this._fitnesslastDate=newfl;
    
  }
  set fitnessNextDate(String newnd){
    
    this._fitnessNextDate=newnd;
    
  }

   Map<String,dynamic>toFitMap(){
    var map=Map<String,dynamic>();
    if(vehicalId != null){
      map['ID'] = _vehicalID;
    }
    map['fitnessCost']=_fitnessCost;
    map['fitnesslast']=_fitnesslastDate;
    map['fitnessNextDate']=_fitnessNextDate;
    return map;
   }
   FitDB.fromFitMapObject(dynamic map){
      this._vehicalID= map['vehicalId'];
     this._fitnessCost=map['fitnessCost'];
    this._fitnesslastDate=map['fitnesslast'];
    this._fitnessNextDate= map['fitnessNextDate'];
   }
}