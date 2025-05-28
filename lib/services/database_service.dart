import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/recording.dart';

class DatabaseService {
  static Database? _database;
  static const String _tableName = 'recordings';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'voice_memos.db');

    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        file_path TEXT NOT NULL,
        duration INTEGER NOT NULL,
        date_created TEXT NOT NULL
      )
    ''');
  }

  Future<List<Recording>> getAllRecordings() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      orderBy: 'date_created DESC',
    );

    return List.generate(maps.length, (i) {
      return Recording(
        id: maps[i]['id'],
        name: maps[i]['name'],
        filePath: maps[i]['file_path'],
        duration: maps[i]['duration'],
        dateCreated: DateTime.parse(maps[i]['date_created']),
      );
    });
  }

  Future<void> insertRecording(Recording recording) async {
    final db = await database;
    await db.insert(_tableName, {
      'id': recording.id,
      'name': recording.name,
      'file_path': recording.filePath,
      'duration': recording.duration,
      'date_created': recording.dateCreated.toIso8601String(),
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateRecording(Recording recording) async {
    final db = await database;
    await db.update(
      _tableName,
      {
        'id': recording.id,
        'name': recording.name,
        'file_path': recording.filePath,
        'duration': recording.duration,
        'date_created': recording.dateCreated.toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [recording.id],
    );
  }

  Future<void> deleteRecording(String id) async {
    final db = await database;
    await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
