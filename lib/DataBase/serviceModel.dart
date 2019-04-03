class ServiceDB{

  int _vehicalID;
  int _serviceCost;
  String _serviceDate;
  String _serviceType;
String _serviceWhat;
String _serviceWhere;

  ServiceDB(this._serviceCost,this._serviceDate,this._serviceType,this._serviceWhat,this._serviceWhere);
  ServiceDB.withID(this._vehicalID,this._serviceCost,this._serviceDate,this._serviceType,this._serviceWhat,this._serviceWhere);

  int get serviceCost =>_serviceCost;
  String get serviceDate => _serviceDate;
  String get serviceType => _serviceType;
  String get serviceWhat => _serviceWhat;
  String get serviceWhere => _serviceWhere;


  int get vehicalId =>_vehicalID;

  set vehicalId(int  newid) {
    _vehicalID = newid;
  }

  set serviceCost(int newic){

    this._serviceCost=newic;

  }
  set serviceDate(String newico){

    this._serviceDate=newico;

  }
  set serviceWhat(String newidd){

    this._serviceWhat=newidd;

  }
  set serviceWhere(String newidd){

    this._serviceWhere=newidd;

  }
  set serviceType(String newidd){

    this._serviceType=newidd;

  }


  Map<String,dynamic>toserviceMap(){
    var map=Map<String,dynamic>();
    if(vehicalId != null){
      map['ID'] = _vehicalID;
    }

    map['vehicalId']=_vehicalID;
    map['serviceCost']=_serviceCost;
    map['serviceDate']=_serviceDate;
    map['serviceType']=serviceType;
    map['serviceWhat']=serviceWhat;
    map['serviceWhere']=serviceWhere;

    return map;
  }
  ServiceDB.fromServiceMapObject(dynamic map){

    this._vehicalID= map['vehicalId'];
    this._serviceCost= map['serviceCost'];
    this._serviceDate=map['serviceDate'];
    this._serviceType=map['serviceType'];
    this._serviceWhat=map['serviceWhat'];
    this._serviceWhere=map['serviceWhere'];



  }



}