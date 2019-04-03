class InsuranceDb{

  int _vehicalID;
  int _insuranceCost;
  String _insuranceDuedate;
  String _insuranceCompany;

  InsuranceDb(this._insuranceCost,this._insuranceCompany,this._insuranceDuedate);
  InsuranceDb.withID(this._insuranceCost,this._insuranceCompany,this._insuranceDuedate,this._vehicalID);

  int get insuranceCost =>_insuranceCost;
  String get insuranceComapny => _insuranceCompany;
  String get insuranceDueDate => _insuranceDuedate;
  int get vehicalId =>_vehicalID;

  set vehicalId(int  newid) {
    _vehicalID = newid;
  }

set insuranceCost(int newic){
    
      this._insuranceCost=newic;
    
  }
set insuranceCompany(String newico){
    
      this._insuranceCompany=newico;
    
  }
set insuranceDueDate(String newidd){
 
    this._insuranceDuedate=newidd;
    
  }

   Map<String,dynamic>toInsuranceMap(){
    var map=Map<String,dynamic>();
    if(vehicalId != null){
      map['ID'] = _vehicalID;
    }
    
    map['vehicalId']=_vehicalID;
    map['insuranceCost']=_insuranceCost;
    map['insuranceCompany']=_insuranceCompany;
    map['insuranceDueDate']=_insuranceDuedate;
    
    return map;
   }
   InsuranceDb.fromInsuranceMapObject(dynamic map){

      this._vehicalID= map['vehicalId'];
      this._insuranceCost= map['insuranceCost'];
    this._insuranceCompany=map['insuranceCompany'];
    this._insuranceDuedate=map['insuranceDueDate'];
     
   }
}