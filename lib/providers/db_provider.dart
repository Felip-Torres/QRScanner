import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbProvider {

  static Database? _database;

  static final DbProvider db = DbProvider._();

  DbProvider._();

  Future<Database> get database async{
    _database ??= await initDB();

    return _database!;
  }

  //Inicia la base de datos y cra la tabla Scans
  Future<Database> initDB() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'Scans.db');
    print(path);

    return await openDatabase(
      path, 
      version: 1,
      onOpen: (db){},
      onCreate: (Database db, int version) async{
        await db.execute('''
          CREATE TABLE Scans( 
           id INTEGER PRIMARY KEY,
           tipus TEXT,
           valor TEXT
          )
        ''');
      }
    );
  }

  //Inserta un scan en la base de datos con codigo sql
  Future<int> insertRawScan(ScanModel nouScan) async {
    final id = nouScan.id;
    final tipus = nouScan.tipus;
    final valor = nouScan.valor;

    final db = await database;

    final res = await db.rawInsert('''
      INSERT INTO Scans(id, tipus, valor)
       VALUES($id, $tipus, $valor)
    ''');
    return res;
  }

  //Inserta un scan en la base de datos
  Future<int> insertScan(ScanModel nouScan) async {
    final db = await database;

    final res = await db.insert("Scans", nouScan.toMap());
    
    return res;
  }

  //Devuelve todos los scans de la base de datos
  Future<List<ScanModel>> getAllScan() async{
    final db = await database;
    final res = await db.query("Scans");
    return res.isNotEmpty ? res.map((e) => ScanModel.fromMap(e)).toList() : [];
  }

  //Devuelve un scan por su id
  Future<ScanModel?> getScanById(int id) async{
    final db = await database;
    final res = await db.query("Scans", where: "id = ?", whereArgs: [id]);

    if(res.isNotEmpty){
      return ScanModel.fromMap(res.first);
    }
    return null;
  }

  //Devuelve todos los scans de un tipo
  Future<List<ScanModel>> getScanPerTipus(String tipus) async{
    final db = await database;
    final res = await db.query("Scans", where: "tipus = ?", whereArgs: [tipus]);
    return res.isNotEmpty ? res.map((e) => ScanModel.fromMap(e)).toList() : [];
  }

  //Actualiza un scan
  Future<int> updateScan(ScanModel nouScan) async{
    final db = await database;
    final res = await db.update("Scans", nouScan.toMap(),
    where: "id = ?", whereArgs: [nouScan.id]);

    return res;
  }

  //Borra todos los scans
  Future<int> deleteAllScans() async{
    final db = await database;
    final res = await db.rawDelete('''
      DELETE FROM Scans
    ''');
    return res;
  }

  //Borra un scan por su id
  Future<int> deleteScan(int id) async{
    final db = await database;
    final res = await db.delete("Scans", where: "id = ?", whereArgs: [id]);
    return res;
  }
}