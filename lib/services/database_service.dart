import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
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

    return await openDatabase(
      path,
      version: 2, // Increment version for migration
      onCreate: _createDatabase,
      onUpgrade: _upgradeDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        file_name TEXT NOT NULL,
        duration INTEGER NOT NULL,
        date_created TEXT NOT NULL
      )
    ''');
  }

  Future<void> _upgradeDatabase(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    print(
      'DatabaseService: Upgrading database from version $oldVersion to $newVersion',
    );

    if (oldVersion < 2) {
      print('DatabaseService: Migrating from file_path to file_name');

      // Migrate from file_path to file_name
      await db.execute('ALTER TABLE $_tableName ADD COLUMN file_name TEXT');

      // Update existing records to extract filename from full path
      final records = await db.query(_tableName);
      print(
        'DatabaseService: Found ${records.length} existing records to migrate',
      );

      for (final record in records) {
        final filePath = record['file_path'] as String?;
        if (filePath != null) {
          final fileName = basename(filePath);
          print(
            'DatabaseService: Migrating record ${record['id']}: $filePath -> $fileName',
          );
          await db.update(
            _tableName,
            {'file_name': fileName},
            where: 'id = ?',
            whereArgs: [record['id']],
          );
        }
      }

      // Remove the old file_path column (SQLite doesn't support DROP COLUMN directly)
      print('DatabaseService: Creating new table structure');
      await db.execute('''
        CREATE TABLE ${_tableName}_new (
          id TEXT PRIMARY KEY,
          name TEXT NOT NULL,
          file_name TEXT NOT NULL,
          duration INTEGER NOT NULL,
          date_created TEXT NOT NULL
        )
      ''');

      await db.execute('''
        INSERT INTO ${_tableName}_new (id, name, file_name, duration, date_created)
        SELECT id, name, file_name, duration, date_created FROM $_tableName
        WHERE file_name IS NOT NULL
      ''');

      await db.execute('DROP TABLE $_tableName');
      await db.execute('ALTER TABLE ${_tableName}_new RENAME TO $_tableName');

      print('DatabaseService: Migration completed successfully');
    }
  }

  Future<String> _getRecordingsDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<String> _getFullFilePath(String fileName) async {
    final recordingsDir = await _getRecordingsDirectory();
    return join(recordingsDir, fileName);
  }

  Future<List<Recording>> getAllRecordings() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      orderBy: 'date_created DESC',
    );

    final recordingsDir = await _getRecordingsDirectory();

    return List.generate(maps.length, (i) {
      final fileName = maps[i]['file_name'] as String;
      final fullPath = join(recordingsDir, fileName);

      return Recording(
        id: maps[i]['id'],
        name: maps[i]['name'],
        filePath: fullPath,
        duration: maps[i]['duration'],
        dateCreated: DateTime.parse(maps[i]['date_created']),
      );
    });
  }

  Future<void> insertRecording(Recording recording) async {
    final db = await database;
    final fileName = basename(recording.filePath);

    await db.insert(_tableName, {
      'id': recording.id,
      'name': recording.name,
      'file_name': fileName,
      'duration': recording.duration,
      'date_created': recording.dateCreated.toIso8601String(),
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateRecording(Recording recording) async {
    final db = await database;
    final fileName = basename(recording.filePath);

    await db.update(
      _tableName,
      {
        'id': recording.id,
        'name': recording.name,
        'file_name': fileName,
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
