import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:vehicle_manager_2/DataBase/DriverModel.dart';
import 'package:vehicle_manager_2/DataBase/FitModel.dart';
import 'package:vehicle_manager_2/DataBase/FuelModel.dart';
import 'package:vehicle_manager_2/DataBase/IncomeModel.dart';
import 'package:vehicle_manager_2/DataBase/InsuranceModel.dart';
import 'package:vehicle_manager_2/DataBase/PollutionModel.dart';
import 'package:vehicle_manager_2/DataBase/Taxmodel.dart';
import 'package:vehicle_manager_2/DataBase/VehicleModel.dart';
import 'package:vehicle_manager_2/DataBase/serviceModel.dart';


class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;
  String noteTable = 'note_table';
  String coldId = 'driverID';
  String colname = 'driverName';
  String coldImage = 'driverImage';
  String coladd = 'address';
  String colvid = 'vehicleID';
  String colPov = 'policeVeri';
  String collicence = 'licence';
  String colmed = 'medical';
  String colmob = 'mobno';
  String colexp = 'exp';
  String colexpiry = 'expiry';
  String colleave = 'leave';

  //table name
  String vehicleTable = 'vehicle_table';
  String serviceTable = 'service_table';
  String taxTable = 'tax_table';
  String pollutionTable = 'pollution_table';
  String insuranceTable = 'insurance_table';
  String fueltable = 'fuel_table';
  String fittable = "fit_table";
  String Incometable = 'income_table';

  String vcolhowmuchfuel = 'howmuch';
  String vcolplate = 'plateno';
  String vcoltype = 'type';
  String vcolmodel = 'modelno';
  String colincomeDate = 'incomeDate';
  String colIncome = 'income';

  String vcoldisCovered = 'distanceCovered';
  String vcollastFilledDate = 'lastFilleDate';
  String vcolavg = 'average';
  String vcolfuelCost = 'fuelCost';
  String vcolinCost = 'insuranceCost';
  String vcolinscompany = 'insuranceCompany';
  String vcolinsDueDate = 'insuranceDueDate';
  String vcolserviceType = 'serviceType';
  String vcolserviceCost = 'serviceCost';
  String vcolserviceDate = 'serviceDate';
  String vcolserviceWhat = 'serviceWhat';
  String vcolserviceWhere = 'serviceWhere';
  String vcolfitCost = 'fitnessCost';
  String vcolfitLast = 'fitnesslast';
  String vcolfitNextDate = 'fitnessNextDate';
  String vcolpollCost = 'pollutionCost';
  String vcolpollLast = 'pollutionlast';
  String vcolpollNextDate = 'pollutionNextDate';
  String vcoltaxCost = 'taxCost';
  String vcoltaxWhy = 'taxWhy';
  String vcoltaxDate = 'taxDate';
  String vcoltaxNextDate = 'taxNextDate';
  String vcoltaxtype = 'taxType';
  String vcolcarImage='carImage';


  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper
          ._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'VehicleManager.db';

    // Open/create the database at a given path

    var notesDatabase = await openDatabase(
        path, version: 1, onCreate: _createDb);

    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $noteTable($coldId INTEGER PRIMARY KEY, $colvid INTEGER,$colname TEXT,$coldImage TEXT ,$coladd TEXT,'
            ' $colexp INTEGER, $colmed TEXT, $colPov TEXT, $collicence TEXT, $colmob INTEGER, $colexpiry TEXT, $colleave TEXT)');

    await db.execute(
        'CREATE TABLE $vehicleTable($colvid INTEGER PRIMARY KEY,$vcolmodel TEXT,$vcoltype TEXT,$vcolplate TEXT, $vcolcarImage TEXT,'
            'FOREIGN KEY($colvid) REFERENCES $noteTable($colvid))');

    await db.execute(
        'CREATE TABLE $fittable($colvid INTEGER PRIMARY KEY,$vcolfitLast TEXT,$vcolfitCost INTEGER,$vcolfitNextDate TEXT,'
            'FOREIGN KEY($colvid) REFERENCES $noteTable($colvid))');

    await db.execute(
        'CREATE TABLE $pollutionTable($colvid INTEGER PRIMARY KEY,$vcolpollCost INTEGER,$vcolpollLast TEXT,$vcolpollNextDate TEXT,'
            'FOREIGN KEY($colvid)REFERENCES $noteTable($colvid))');

    await db.execute(
        'CREATE TABLE $taxTable($colvid INTEGER PRIMARY KEY,$vcoltaxCost INTEGER,$vcoltaxDate TEXT,$vcoltaxNextDate TEXT,$vcoltaxtype TEXT,$vcoltaxWhy TEXT,'
            'FOREIGN KEY($colvid)REFERENCES $noteTable($colvid))');

    await db.execute(
        'CREATE TABLE $serviceTable($colvid INTEGER PRIMARY KEY,$vcolserviceCost INTEGER,$vcolserviceDate TEXT,$vcolserviceType TEXT,$vcolserviceWhat TEXT, $vcolserviceWhere TEXT,'
            'FOREIGN KEY($colvid)REFERENCES $noteTable($colvid))');

    await db.execute(
        'CREATE TABLE $insuranceTable($colvid INTEGER PRIMARY KEY,$vcolinCost INTEGER,$vcolinscompany TEXT,$vcolinsDueDate TEXT,'
            'FOREIGN KEY($colvid)REFERENCES $noteTable($colvid))');

    await db.execute(
        'CREATE TABLE $fueltable($colvid INTEGER PRIMARY KEY,$vcollastFilledDate TEXT,$vcolavg INTEGER,$vcolfuelCost INTEGER,$vcoldisCovered INTEGER,$vcolhowmuchfuel,'
            'FOREIGN KEY($colvid)REFERENCES $noteTable($colvid))');

    await db.execute(
        'CREATE TABLE $Incometable($colvid INTEGER PRIMARY KEY,$colIncome INTEGER,$colincomeDate TEXT, '
            'FOREIGN KEY($colvid)REFERENCES $noteTable($colvid))');
  }

  Future<List<Map<String, dynamic>>> getDriverMapList() async {
    Database db = await this.database;
    var result = await db.rawQuery(
        'SELECT * FROM $noteTable order by $coldId ASC');
    return result;
  }

  //vehical
  Future<List<Map<String, dynamic>>> getVehicleMapList() async {
    Database db = await this.database;
    var result = await db.rawQuery(
        'SELECT * FROM $vehicleTable order by $colvid ASC');
    return result;
  }

  Future<List<Map<String, dynamic>>> getFuelMapList() async {
    Database db = await this.database;
    var result = await db.rawQuery(
        'SELECT * FROM $fueltable order by $colvid ASC');
    return result;
  }

  Future<List<Map<String, dynamic>>> getFitMapList() async {
    Database db = await this.database;
    var result = await db.rawQuery(
        'SELECT * FROM $fittable order by $colvid ASC');
    return result;
  }

  Future<List<Map<String, dynamic>>> getInsuranceMapList() async {
    Database db = await this.database;
    var result = await db.rawQuery(
        'SELECT * FROM $insuranceTable order by $colvid ASC');
    return result;
  }

  Future<List<Map<String, dynamic>>> getPollutionMapList() async {
    Database db = await this.database;
    var result = await db.rawQuery(
        'SELECT * FROM $pollutionTable order by $colvid ASC');
    return result;
  }

  Future<List<Map<String, dynamic>>> getServiceMapList() async {
    Database db = await this.database;
    var result = await db.rawQuery(
        'SELECT * FROM $serviceTable order by $colvid ASC');
    return result;
  }

  Future<List<Map<String, dynamic>>> getTaxMapList() async {
    Database db = await this.database;
    var result = await db.rawQuery(
        'SELECT * FROM $taxTable order by $colvid ASC');
    return result;
  }

  Future<List<Map<String, dynamic>>> getIncomeMapList() async {
    Database db = await this.database;
    var result = await db.rawQuery(
        'SELECT * FROM $Incometable order by $colvid ASC');
    return result;
  }


  Future<List<Map<String, dynamic>>> getVehiclePlateMapList() async {
    Database db = await this.database;
    var result = await db.rawQuery(
        'SELECT $vcolplate,$colvid FROM $vehicleTable order by $colvid ASC');
    return result;
  }

  // Insert
  Future<int> insertDriverNote(DriverDB note) async {
    Database db = await this.database;
    var result = await db.insert(noteTable, note.toDriverMap());
    return result;
  }

  // vehicalInsert
  Future<int> insertvehicleNote(VehicleDB note) async {
    Database db = await this.database;
    var result = await db.insert(vehicleTable, note.toVehicleMap());
    return result;
  }

  Future<int> insertfuelNote(FuelDB note) async {
    Database db = await this.database;
    var result = await db.insert(fueltable, note.toFuelMap());
    return result;
  }

  Future<int> insertFitNote(FitDB note) async {
    Database db = await this.database;
    var result = await db.insert(fittable, note.toFitMap());
    return result;
  }

  Future<int> insertinsuranceNote(InsuranceDb note) async {
    Database db = await this.database;
    var result = await db.insert(insuranceTable, note.toInsuranceMap());
    return result;
  }

  Future<int> insertserviceNote(ServiceDB note) async {
    Database db = await this.database;
    var result = await db.insert(serviceTable, note.toserviceMap());
    return result;
  }

  Future<int> insertTaxNote(TaxDB note) async {
    Database db = await this.database;
    var result = await db.insert(taxTable, note.toTaxMap());
    return result;
  }

  Future<int> insertpollutionNote(pollutionDB note) async {
    Database db = await this.database;
    var result = await db.insert(pollutionTable, note.toPollutionMap());
    return result;
  }

  Future<int> insertincomeNote(IncomeDB note) async {
    Database db = await this.database;
    var result = await db.insert(Incometable, note.toIncomeMap());
    return result;
  }

  // Update
  Future<int> updateDriverNote(DriverDB note) async {
    var db = await this.database;
    var result = await db.update(
        noteTable, note.toDriverMap(), where: '$coldId= ?',
        whereArgs: [note.driverID]);
    return result;
  }

  Future<int> updatevehicleNote(VehicleDB note) async {
    var db = await this.database;
    var result = await db.update(
        vehicleTable, note.toVehicleMap(), where: '$colvid= ?',
        whereArgs: [note.vehicleID]);
    return result;
  }

  Future<int> updatefitNote(FitDB note) async {
    var db = await this.database;
    var result = await db.update(fittable, note.toFitMap(), where: '$colvid= ?',
        whereArgs: [note.vehicalId]);
    return result;
  }

  Future<int> updatefuelNote(FuelDB note) async {
    var db = await this.database;
    var result = await db.update(
        fueltable, note.toFuelMap(), where: '$colvid= ?',
        whereArgs: [note.vehicalId]);
    return result;
  }

  Future<int> updateinsuranceNote(InsuranceDb note) async {
    var db = await this.database;
    var result = await db.update(
        insuranceTable, note.toInsuranceMap(), where: '$colvid= ?',
        whereArgs: [note.vehicalId]);
    return result;
  }

  Future<int> updatepollutionNote(pollutionDB note) async {
    var db = await this.database;
    var result = await db.update(
        pollutionTable, note.toPollutionMap(), where: '$colvid= ?',
        whereArgs: [note.vehicalId]);
    return result;
  }

  Future<int> updateserviceNote(ServiceDB note) async {
    var db = await this.database;
    var result = await db.update(
        serviceTable, note.toserviceMap(), where: '$colvid= ?',
        whereArgs: [note.vehicalId]);
    return result;
  }

  Future<int> updatetaxNote(TaxDB note) async {
    var db = await this.database;
    var result = await db.update(taxTable, note.toTaxMap(), where: '$colvid= ?',
        whereArgs: [note.vehicalId]);
    return result;
  }

  Future<int> updateincomeNote(IncomeDB note) async {
    var db = await this.database;
    var result = await db.update(
        Incometable, note.toIncomeMap(), where: '$colvid= ?',
        whereArgs: [note.vehicalId]);
    return result;
  }

  // Delete
  Future<int> deleteDriverNote(int id) async {
    var db = await this.database;
    int result = await db.rawDelete(
        'DELETE FROM $noteTable WHERE $coldId= $id');
    return result;
  }

  // Delete vehical
  Future<int> deletevehicalNote(int id) async {
    var db = await this.database;
    int result = await db.rawDelete(
        'DELETE FROM $vehicleTable WHERE $colvid= $id');
    return result;
  }

  Future<int> deletedriverNote(int id) async {
    var db = await this.database;
    int result = await db.rawDelete(
        'DELETE FROM $noteTable WHERE $colvid= $id');
    return result;
  }

  Future<int> deletefitNote(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $fittable $colvid= $id');
    return result;
  }

  Future<int> deletefuelNote(int id) async {
    var db = await this.database;
    int result = await db.rawDelete(
        'DELETE FROM $fueltable WHERE $colvid= $id');
    return result;
  }

  Future<int> deleteInsuranceNote(int id) async {
    var db = await this.database;
    int result = await db.rawDelete(
        'DELETE FROM $insuranceTable WHERE $colvid= $id');
    return result;
  }

  Future<int> deletepollutionNote(int id) async {
    var db = await this.database;
    int result = await db.rawDelete(
        'DELETE FROM $pollutionTable WHERE $colvid= $id');
    return result;
  }

  Future<int> deleteserviceNote(int id) async {
    var db = await this.database;
    int result = await db.rawDelete(
        'DELETE FROM $serviceTable WHERE $colvid= $id');
    return result;
  }

  Future<int> deletetaxNote(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $taxTable WHERE $colvid= $id');
    return result;
  }

  Future<int> deleteincomeNote(int id) async {
    var db = await this.database;
    int result = await db.rawDelete(
        'DELETE FROM $Incometable WHERE $colvid= $id');
    return result;
  }
  // Future<int> getCount() async {
  // 	Database db = await this.database;
  // 	List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $noteTable');
  // 	int result = Sqflite.firstIntValue(x);
  // 	return result;
  // }

  Future<List<DriverDB>> getNoteList() async {
    var noteMapList = await getDriverMapList();
    int count = noteMapList.length;
    List<DriverDB> noteList = List<DriverDB>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      noteList.add(DriverDB.fromDriverMapObject(noteMapList[i]));
    }
    return noteList;
  }
   Future<List<FitDB>> getfitList() async {
    var FitMapList = await getFitMapList();
    int count = FitMapList.length;
    List<FitDB> noteList = List<FitDB>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      noteList.add(FitDB.fromFitMapObject(FitMapList[i]));
    }
    return noteList;
  }
   Future<List<FuelDB>> getFuelList() async {
    var FuelMapList = await getFuelMapList();
    int count = FuelMapList.length;
    List<FuelDB> noteList = List<FuelDB>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      noteList.add( FuelDB.fromFuelMapObject(FuelMapList[i]));
    }
    return noteList;
  }

   Future<List<InsuranceDb>> getInsuranceList() async {
    var InsuaranceMapList = await getInsuranceMapList();
    int count = InsuaranceMapList.length;
    List<InsuranceDb> noteList = List<InsuranceDb>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      noteList.add(InsuranceDb.fromInsuranceMapObject(InsuaranceMapList[i]));
    }
    return noteList;
  }

   Future<List<pollutionDB>> getPollutionList() async {
    var PollutionMapList = await getPollutionMapList();
    int count = PollutionMapList.length;
    List<pollutionDB> noteList = List<pollutionDB>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      noteList.add(pollutionDB.fromPollutionMapObject(PollutionMapList[i]));
    }
    return noteList;
  }
   Future<List<ServiceDB>> getServiceList() async {
    var ServiceMapList = await getServiceMapList();
    int count = ServiceMapList.length;
    List<ServiceDB> noteList = List<ServiceDB>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      noteList.add(ServiceDB.fromServiceMapObject(ServiceMapList[i]));
    }
    return noteList;
  }
   Future<List<TaxDB>> getTaxList() async {
    var TaxMapList = await getTaxMapList();
    int count = TaxMapList.length;
    List<TaxDB> noteList = List<TaxDB>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      noteList.add(TaxDB.fromTaxMapObject(TaxMapList[i]));
    }
    return noteList;
  }
  Future<List<VehicleDB>> getVehicleList() async {
    var VehicleMapList = await getVehicleMapList();
    int count = VehicleMapList.length;
    List<VehicleDB> noteList = List<VehicleDB>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      noteList.add(VehicleDB.fromVehicleMapObject(VehicleMapList[i]));
    }
    return noteList;
  }


  Future<List<VehicleDB>> getVehicalPlateList() async {
    var vehicalMapList = await getVehiclePlateMapList();
    int count = vehicalMapList.length;
    List<VehicleDB> noteList = List<VehicleDB>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      noteList.add(VehicleDB.fromVehicleMapObject(vehicalMapList[i]));
    }
    return noteList;
  }

  
  }