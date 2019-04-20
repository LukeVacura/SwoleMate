import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../model/employee.dart';
import '../model/models.dart';

class DBHelper{

  static Database _db;

  Future<Database> get db async {
    if(_db != null)
      return _db;
    _db = await initDb();
    return _db;
  }

  //Creating a database with name test.dn in your directory
  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "test.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  // Creating a table name Employee with fields
  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
      // Exercise - exerciseID (PK), exerciseName, exerciseType, exercisePref, exerciseSuf
      // ExerciseGroup - exerciseGroup (PK)
      // ExerciseBelongsTo - exerciseID (PK, FK), exerciseGroup (PK, FK)
    "CREATE TABLE Exercise(exerciseID INTEGER PRIMARY KEY, exerciseName TEXT, exerciseType INTEGER, exercisePref INTEGER , exerciseSuf INTEGER );" + 
    "CREATE TABLE ExerciseGroup(exerciseGroup TEXT PRIMARY KEY );" + 
    "CREATE TABLE ExerciseBelongsTo(exerciseID INTEGER PRIMARY KEY, exerciseGroup TEXT PRIMARY KEY, FOREIGN KEY (exerciseID) REFERENCES Exercise(exerciseID), FOREIGN KEY (exerciseGroup) REFERENCES ExerciseGroup(exerciseGroup));");
    print("Created tables");
  }

  // Retrieving exercises from Exercise Tables
  Future<List<Exercise>> getExercises() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Exercise');
    List<Exercise> exercises = new List();
    for (int i = 0; i < list.length; i++) {
      exercises.add(new Exercise(list[i]["exerciseID"], list[i]["exerciseName"], list[i]["exerciseType"], list[i]["exercisePref"], list[i]["exerciseSuf"]));
    }
    print(exercises.length);
    return exercises;
  }
  
  // Retrieving employees from Employee Tables
  Future<List<Employee>> getEmployees() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Employee');
    List<Employee> employees = new List();
    for (int i = 0; i < list.length; i++) {
      employees.add(new Employee(list[i]["firstname"], list[i]["lastname"], list[i]["mobileno"], list[i]["emailid"]));
    }
    print(employees.length);
    return employees;
  }

  void  addExercise(Exercise exercise) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawInsert(
          'INSERT INTO Exercise(exerciseID, exerciseName, exerciseType, exercisePref, exerciseSuf ) VALUES(' +
              '\'' +
              exercise.exerciseID +
              '\'' +
              ',' +
              '\'' +
              exercise.exerciseName+
              '\'' +
              ',' +
              '\'' +
              exercise.exerciseType.toString() +
              '\'' +
              ',' +
              '\'' +
              exercise.exercisePref.toString() +
              '\'' +
              ',' +
              '\'' +
              exercise.exerciseSuf.toString() +
              '\'' +
              ')');
    });
  }
  
  void saveEmployee(Employee employee) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawInsert(
          'INSERT INTO Employee(firstname, lastname, mobileno, emailid ) VALUES(' +
              '\'' +
              employee.firstName +
              '\'' +
              ',' +
              '\'' +
              employee.lastName +
              '\'' +
              ',' +
              '\'' +
              employee.mobileNo +
              '\'' +
              ',' +
              '\'' +
              employee.emailId +
              '\'' +
              ')');
    });
  }


}