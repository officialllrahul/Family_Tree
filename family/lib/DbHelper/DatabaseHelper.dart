import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:family/DataModel/person_model.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  String personTable = 'person';
  String colId = 'id';
  String colName = 'name';
  String colRelationship = 'relationship';
  String colFamilyTitle = 'family_title';
  String colAge = 'age';

  // Private constructor
  DatabaseHelper._createInstance();

  // Singleton pattern to ensure only one instance of DatabaseHelper is created
  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper!;
  }

  // Getter for the database instance
  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  // Initialize the database
  Future<Database> initializeDatabase() async {
    String path = join(await getDatabasesPath(), 'family_tree.db');
    var familyTreeDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return familyTreeDatabase;
  }

  // Create the database table if it doesn't exist
  void _createDb(Database db, int newVersion) async {
    await db.execute(
      'CREATE TABLE $personTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colRelationship TEXT, $colAge INTEGER, $colFamilyTitle TEXT)',
    );
  }

  // Insert operation
  Future<int> insertPerson(Person person) async {
    Database db = await this.database;
    var result = await db.insert(personTable, person.toMap());
    return result;
  }

  // Get all persons
  Future<List<Map<String, dynamic>>> getPersonsMapList() async {
    Database db = await this.database;
    var result = await db.query(personTable);
    return result;
  }

  // Convert the List<Map<String, dynamic>> into List<Person>
  Future<List<Person>> getPersonList() async {
    var personMapList = await getPersonsMapList();
    int count = personMapList.length;

    List<Person> personList = [];
    for (int i = 0; i < count; i++) {
      personList.add(Person.fromMapObject(personMapList[i]));
    }
    return personList;
  }

  // Update operation
  Future<int> updatePerson(Person person) async {
    var db = await this.database;
    var result = await db.update(personTable, person.toMap(), where: '$colId = ?', whereArgs: [person.id]);
    return result;
  }

  // Delete operation
  Future<int> deletePerson(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $personTable WHERE $colId = ?', [id]);
    return result;
  }
}
