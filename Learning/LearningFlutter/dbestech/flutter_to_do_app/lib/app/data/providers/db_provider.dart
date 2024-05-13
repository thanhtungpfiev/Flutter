import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/constants/db_constants/db_constants.dart';
import '../../core/constants/db_constants/db_task_fields_constants.dart';
import '../models/task.dart';

class DBProvider {
  static Database? _db;

  static Future<void> initDB() async {
    if (_db != null) {
      return;
    }
    try {
      String dbpath = await getDatabasesPath();
      String path = join(dbpath, DBConstants.dbName);
      _db = await openDatabase(
        path,
        version: DBConstants.version,
        onCreate: (db, version) {
          print('Create table for db');
          String sql = '''
        CREATE TABLE ${DBConstants.tableTasks} (
        ${DBTaskFieldsConstants.id} ${DBConstants.idType},
        ${DBTaskFieldsConstants.title} ${DBConstants.textType},
        ${DBTaskFieldsConstants.note} ${DBConstants.textType},
        ${DBTaskFieldsConstants.date} ${DBConstants.textType},
        ${DBTaskFieldsConstants.startTime} ${DBConstants.textType},
        ${DBTaskFieldsConstants.endTime} ${DBConstants.textType},
        ${DBTaskFieldsConstants.remind} ${DBConstants.integerType},
        ${DBTaskFieldsConstants.repeat} ${DBConstants.textType},
        ${DBTaskFieldsConstants.color} ${DBConstants.integerType},
        ${DBTaskFieldsConstants.isCompleted} ${DBConstants.integerType}
        )
        ''';
          return db.execute(sql);
        },
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<int> createTask(Task task) async {
    return await _db!.insert(DBConstants.tableTasks, task.toMap());
  }

  static Future<List<Map<String, dynamic>>> readAllTasks() async {
    return await _db!.query(DBConstants.tableTasks);
  }

  static Future<int> updateTask(Task task) async {
    return await _db!.update(DBConstants.tableTasks, task.toMap(),
        where: '${DBTaskFieldsConstants.id} = ?', whereArgs: [task.id]);
  }

  static Future<int> deleteTask(Task task) async {
    return await _db!.delete(DBConstants.tableTasks,
        where: '${DBTaskFieldsConstants.id} = ?', whereArgs: [task.id]);
  }
}
