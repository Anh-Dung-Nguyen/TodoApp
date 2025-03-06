import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todoapp/data/models/task.dart';
import 'package:todoapp/utils/utils.dart';

class TaskDatasource {
  static final TaskDatasource _instance = TaskDatasource._();
  factory TaskDatasource() => _instance;

  TaskDatasource._() {
    _initDB();
  }

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, DbKeys.dbName);

    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      '''
        CREATE TABLE ${DbKeys.dbTable}(
          ${DbKeys.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${DbKeys.titleColumn} TEXT,
          ${DbKeys.noteColumn} TEXT,
          ${DbKeys.dateColumn} TEXT,
          ${DbKeys.timeColumn} TEXT,
          ${DbKeys.categoryColumn} TEXT,
          ${DbKeys.isCompletedColumn} INTEGER,
        )
      '''
    );
  }

  Future<int> addTask(Task task) async {
    final db = await database;
    return db.transaction((text) async {
      return await text.insert(
        DbKeys.dbTable, 
        task.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  Future<int> updateTask(Task task) async {
    final db = await database;
    return db.transaction((text) async {
      return await text.update(
        DbKeys.dbTable,
        task.toJson(), 
        where: 'id = ?',
        whereArgs: [task.id],
      );
    });
  }

  Future<int> deleteTask(Task task) async {
    final db = await database;
    return db.transaction((text) async {
      return await text.delete(
        DbKeys.dbTable, 
        where: 'id = ?',
        whereArgs: [task.id],
      );
    });
  }

  Future<List<Task>> getAllTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> data = await db.query(
      DbKeys.dbTable,
      orderBy: "id DESC",
    );
    return List.generate(
      data.length, 
      (index) => Task.fromJson(data[index]),
    );
  }
}