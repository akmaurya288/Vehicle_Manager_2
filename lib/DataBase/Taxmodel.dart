class TaxDB{

  String _taxType;
  int _taxCost;
  String _taxDate;
  String _taxNextdate;
  String _taxWhy;
  int _vehicalID;
  TaxDB(this._taxCost,this._taxDate,this._taxNextdate,this._taxType,this._taxWhy);
  TaxDB.withID(this._taxCost,this._taxDate,this._taxNextdate,this._taxType,this._taxWhy,this._vehicalID);


  int get vehicalId =>_vehicalID;
  int get taxCost => _taxCost;
  String get taxDate => _taxDate;
  String get taxNextDate => _taxNextdate;
  String get taxType => _taxType;
  String get taxWhy => _taxWhy;


set taxDate(String newtd){
    
    this._taxDate=newtd;
    
  }
set taxCost(int newtc){
    
    this._taxCost=newtc;
    
  }
set taxNextDate(String newnd){
    
    this._taxNextdate=newnd;
    
  }
set taxType(String newtp){
    
    this._taxType=newtp;
    
  }
set taxWhy(String newtw){
    
    this._taxWhy=newtw;
    
  }
    set vehicalId(int  newid) {
    _vehicalID = newid;
  }


  Map<String,dynamic>toTaxMap(){
    var map=Map<String,dynamic>();
    if(vehicalId != null){
      map['ID'] = _vehicalID;
    }
    map['taxNextDate']= _taxNextdate;
    map['taxCost']= _taxCost;
    map['taxType']= _taxType;
    map['taxWhy']= _taxWhy;
    map['taxDate']= _taxDate;
    map['vehicalId']=_vehicalID;

    return map;
    }

    TaxDB.fromTaxMapObject(dynamic map){
      this. _taxCost=map['taxCost'];
       this._vehicalID= map['vehicalId'];
    this._taxType=map['taxType'];
    this._taxWhy= map['taxWhy'];
    this._taxDate=map['taxDate'];
    }
}