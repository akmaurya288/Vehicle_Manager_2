class IncomeDB{
  int _vehicalID;
  String _incomeDate;
  int _income;

  IncomeDB(this._incomeDate,this._income,);
  IncomeDB.withID(this._vehicalID,this._incomeDate,this._income,);

  int get vehicalId =>_vehicalID;
  int get income => _income;
  String get incomeDate => _incomeDate;


  set vehicalId(int  newid) {
    _vehicalID = newid;
  }
  set income(int newfc){

    this._income=newfc;

  }
  set incomeDate(String newfl){

    this._incomeDate=newfl;

  }

  Map<String,dynamic>toIncomeMap(){
    var map=Map<String,dynamic>();
    if(vehicalId != null){
      map['ID'] = _vehicalID;
    }
    map['income']=_income;
    map['incomeDate']=_incomeDate;

    return map;
  }
  IncomeDB.fromIncomeMapObject(dynamic map){
    this._vehicalID= map['vehicalId'];
    this._income=map['income'];
    this._incomeDate=map['incomeDate'];

  }
}