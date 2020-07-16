import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/doit_database_models/doit_lists_data.dart';
import 'package:todoapp/doit_database_models/doit_schedule_data.dart';
import 'package:todoapp/doit_database_models/doit_tasks_data.dart';
import 'package:todoapp/ui_variables/list_screen_variables.dart';

class DatabaseHelper {
  static DatabaseHelper _doitDatabaseHelper; // Singleton DatabaseHelper
  static Database _doitDatabase;

  String tabList = 'LIST_TABLE';
  String colListId = "LIST_ID";
  String colListName = 'LIST_NAME';
  String colListColor = 'LIST_COLOR';

  String tabTask = 'TASK_TABLE';
  String colTaskId = 'TASK_ID';
  String colTaskListId = 'LIST_ID';
  String colTaskRepeatId = 'REPEAT_ID';
  String colTaskName = 'TASK_NAME';
  String colTaskStatus = 'TASK_STATUS';
  String colTaskType = 'TASK_TYPE';
  String colTaskReminderTime = 'TASK_REMINDER_TIME';
  String colTaskDate = 'TASK_DATE';

  String tabRepeat = 'REPEAT_TABLE';
  String colRepeatId = 'REPEAT_ID';
  String colRepeatStatus = 'REPEAT_STATUS';
  String colFrequencyChoice = 'REPEAT_FREQUENCY_CHOICE';
  String colRepeatEvery = 'REPEAT_EVERY';
  String colRepeatOnWeek = 'REPEAT_ON_WEEK';
  String colRepeatOnMonth = 'REPEAT_ON_MONTH';
  String colRepeatEndChoice = 'END_CHOICE';
  String colRepeatEndAfterXTimes = 'END_AFTER_X_TIMES';
  String colRepeatEndOnDate = 'END_ON_DATE';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_doitDatabaseHelper == null) {
      _doitDatabaseHelper = DatabaseHelper._createInstance(); // Thực thi một lần duy nhất, singleton object
    }

    return _doitDatabaseHelper;
  }

// Hàm để get database
  Future<Database> get getDoitDatabase async {
    if (_doitDatabase == null) {
      _doitDatabase = await initDoitDatabase();
    }

    return _doitDatabase;
  }

  // Hàm để khởi tạo database
  Future<Database> initDoitDatabase() async {
    // Lấy đường dẫn iOS và Android để lưu trữ database
    Directory doitDatabaseStoredDirectory = await getApplicationDocumentsDirectory();
    String doitDatabasePath = doitDatabaseStoredDirectory.path + 'doit.db';

    // Mở hoặc khởi tạo database tại đường dẫn được đưa trc
    var doitDatabase = await openDatabase(doitDatabasePath, version: 1, onCreate: _createDoitDatabase);

    return doitDatabase;
  }

  // Hàm để khởi tạo database
  void _createDoitDatabase(Database doitDatabase, int newVersion) async {
    await doitDatabase.execute(
        'CREATE TABLE $tabList($colListId INTEGER PRIMARY KEY AUTOINCREMENT, $colListName TEXT, $colListColor TEXT)');

    await doitDatabase.execute(
        "CREATE TABLE $tabTask($colTaskId INTEGER PRIMARY KEY AUTOINCREMENT, $colTaskListId INTEGER REFERENCES $tabList($colListId), $colTaskRepeatId INTEGER REFERENCES $tabRepeat($colRepeatId), $colTaskName TEXT, $colTaskStatus INTEGER, $colTaskType INTEGER ,$colTaskDate TEXT, $colTaskReminderTime TEXT)");

    await doitDatabase.execute(
        "CREATE TABLE $tabRepeat($colRepeatId INTEGER PRIMARY KEY AUTOINCREMENT,  $colRepeatStatus INTEGER, $colFrequencyChoice INTEGER, $colRepeatEvery INTEGER, $colRepeatOnWeek TEXT, $colRepeatOnMonth TEXT, $colRepeatEndChoice INTEGER, $colRepeatEndAfterXTimes INTEGER, $colRepeatEndOnDate TEXT)");
    await doitDatabase.execute(
        'CREATE TRIGGER xoa_task_truoc_khi_xoa_list BEFORE DELETE ON LIST_TABLE BEGIN Delete from TASK_TABLE where LIST_ID = OLD.LIST_ID; END;');
  }

  // Hàm để remove List table
  Future<void> dropTableIfExistsThenRecreate() async {
    Database doitDatabase = await this.getDoitDatabase;

    await doitDatabase.execute("DROP TABLE IF EXISTS $tabList");

    await doitDatabase.execute(
        'CREATE TABLE $tabList($colListId INTEGER PRIMARY KEY AUTOINCREMENT, $colListName TEXT, $colListColor TEXT)');
  }

  // Hàm để lấy thông tin từ list table
  Future<List<Map<String, dynamic>>> getListsMap() async {
    Database doitDatabase = await this.getDoitDatabase;

    var queryResult = await doitDatabase.query(tabList);
    return queryResult;
  }

  // Hàm để lấy thông tin từ task table
  Future<List<Map<String, dynamic>>> getTasksMap() async {
    Database doitDatabase = await this.getDoitDatabase;

    var queryResult = await doitDatabase.query(tabTask);
    return queryResult;
  }

  // Hàm để lấy thông tin từ schedule table
  Future<List<Map<String, dynamic>>> getSchedulesMap() async {
    Database doitDatabase = await this.getDoitDatabase;

    var queryResult = await doitDatabase.query(tabRepeat);
    return queryResult;
  }

  //------------------------------------Phần  insert----------------------------------------//
  // Hàm để insert dữ liệu vào bảng list
  Future<int> insertDataToListTable(ListData listData) async {
    Database doitDatabase = await this.getDoitDatabase;

    var insertResult = await doitDatabase.insert(tabList, listData.toMap());
    return insertResult;
  }

  // Hàm để insert dữ liệu vào bảng task
  Future<int> insertDataToTaskTable(TaskData taskData) async {
    Database doitDatabase = await this.getDoitDatabase;

    var insertResult = await doitDatabase.insert(tabTask, taskData.toMap());
    return insertResult;
  }

  // Hàm để insert dữ liệu vào bảng task's schedule
  Future<int> insertDataToScheduleTable(RepeatData scheduleData) async {
    Database doitDatabase = await this.getDoitDatabase;

    var insertResult = await doitDatabase.insert(tabRepeat, scheduleData.toMap());
    return insertResult;
  }
  //----------------------------------------------------------------------------------------//

  //------------------------------------Phần  update----------------------------------------//

  // Hàm để update dữ liệu vào bảng list
  Future<int> updateListData(ListData listData) async {
    var doitDatabase = await this.getDoitDatabase;

    var updateResult =
        await doitDatabase.update(tabList, listData.toMap(), where: '$colListId = ?', whereArgs: [listData.listId]);
    print(listData.listId);
    return updateResult;
  }

  // Hàm để update dữ liệu vào bảng task
  Future<int> updateTaskData(TaskData taskData) async {
    var doitDatabase = await this.getDoitDatabase;

    var updateResult =
        await doitDatabase.update(tabTask, taskData.toMap(), where: '$colTaskId = ?', whereArgs: [taskData.taskId]);
    return updateResult;
  }

  // Hàm để update dữ liệu vào bảng task's schedule
  Future<int> updateScheduleData(RepeatData repeatData) async {
    var doitDatabase = await this.getDoitDatabase;

    var updateResult = await doitDatabase
        .update(tabRepeat, repeatData.toMap(), where: '$colRepeatId = ?', whereArgs: [repeatData.repeatId]);
    return updateResult;
  }
  //----------------------------------------------------------------------------------------//

  //------------------------------------Phần  delete----------------------------------------//

  // Hàm để xoá data trong bảng list
  Future<int> deleteListData(int listId) async {
    var doitDatabase = await this.getDoitDatabase;

    var deleteResult = await doitDatabase.delete(tabList, where: '$colListId = ?', whereArgs: [listId]);
    return deleteResult;
  }

  // Hàm để xoá data trong bảng task
  Future<int> deleteTaskData(int taskId) async {
    var doitDatabase = await this.getDoitDatabase;

    var deleteResult = await doitDatabase.delete(tabTask, where: '$colTaskId = ?', whereArgs: [taskId]);
    return deleteResult;
  }

  // Hàm để xoá data trong bảng task's schedule
  Future<int> deleteRepeatData(int repeatId) async {
    var doitDatabase = await this.getDoitDatabase;

    var deleteResult = await doitDatabase.delete(tabRepeat, where: '$colRepeatId = ?', whereArgs: [repeatId]);
    return deleteResult;
  }
  //----------------------------------------------------------------------------------------//

  //--------------------------Phần  lấy số lượng phần tử từ các bảng------------------------//

  // Hàm để lấy số lượng phần tử từ bảng list
  Future<int> getListObjectsCount() async {
    var doitDatabase = await this.getDoitDatabase;
    List<Map<String, dynamic>> listTableObjects = await doitDatabase.rawQuery('Select COUNT (*) FROM $tabList');

    int countResult = Sqflite.firstIntValue(listTableObjects);
    return countResult;
  }

  // Lấy ID schedule moi nhat
  Future<int> getNewRepeatID() async {
    var doitDatabase = await this.getDoitDatabase;

    return Future.value(
        Sqflite.firstIntValue(await doitDatabase.rawQuery('SELECT max($colRepeatId) from $tabRepeat')));
  }

  // Hàm để lấy số lượng phần tử từ bảng task
  Future<int> getTaskObjectsCount() async {
    var doitDatabase = await this.getDoitDatabase;
    List<Map<String, dynamic>> taskTableObjects = await doitDatabase.rawQuery('Select COUNT (*) FROM $tabTask');

    int countResult = Sqflite.firstIntValue(taskTableObjects);
    return countResult;
  }

  // Hàm để lấy số lượng phần tử từ bảng schedule
  Future<int> getScheduleObjectsCount() async {
    var doitDatabase = await this.getDoitDatabase;
    List<Map<String, dynamic>> scheduleTableObjects = await doitDatabase.rawQuery('Select COUNT (*) FROM $tabRepeat');

    int countResult = Sqflite.firstIntValue(scheduleTableObjects);
    return countResult;
  }

//=================================================================
  Future<List<Map<String, dynamic>>> getListName(int listId) async {
    var doitDatabase = await this.getDoitDatabase;

    var rs = await doitDatabase
        .rawQuery('Select $colTaskId,$colTaskDate, $colListName FROM $tabList WHERE $colListId = ?', [listId]);

    return rs;
  }

  Future<List<Map<String, dynamic>>> getListColor(int listId) async {
    var doitDatabase = await this.getDoitDatabase;

    var result = await doitDatabase.query(
      "$tabList",
      columns: [colListColor],
      where: "$colListId = ?",
      whereArgs: [listId],
    );

    return result;
  }

  Future<List<ListData>> getListByListID(int listid) async {
    var db = await this.getDoitDatabase;
    List<Map> maps = await db.rawQuery('Select * from $tabList where $colListId = ?', [listid]) ?? List<Map>();
    List<ListData> rs = [];
    rs.add(ListData.fromListMapObject(maps[0]));
    return rs;
  }
  //----------------------------------------------------------------------------------------//

  // get today task
  Future<List<TaskData>> getTodayTask() async {
    var db = await this.getDoitDatabase;
    var a = DateFormat('d/M/yyyy').format(DateTime.now());
    List<Map> maps = await db.rawQuery(
        'SELECT $colTaskId, $colTaskDate, $colTaskName, $tabTask.$colTaskListId, $colTaskReminderTime, $colTaskRepeatId, $colTaskStatus, $colTaskType, $colListColor, $colListName' +
            ' FROM $tabTask LEFT JOIN $tabList ON $tabTask.$colTaskListId = $tabList.$colTaskListId' +
            ' WHERE $colTaskDate = ? AND $colTaskType = ?',
        [a, 0]);
    List<TaskData> rs = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        rs.add(TaskData.fromTaskMapObject(maps[i]));
      }
    }
    return rs;
  }

  // get tomorrow task
  Future<List<TaskData>> getTmrTask() async {
    var db = await this.getDoitDatabase;
    var a = DateFormat('d/M/yyyy').format(DateTime.now().add(Duration(days: 1)));
    List<Map> maps = await db.rawQuery('SELECT * FROM $tabTask WHERE $colTaskDate =?', [a]);
    List<TaskData> rs = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        rs.add(TaskData.fromTaskMapObject(maps[i]));
      }
    }
    return rs;
  }

  //get later task
  Future<List<TaskData>> getLaterTask() async {
    var db = await this.getDoitDatabase;
    var a = DateFormat('d/M/yyyy').format(DateTime.now().add(Duration(days: 1)));
    List<Map> maps = await db.rawQuery('SELECT * FROM $tabTask WHERE $colTaskDate >?', [a]);
    List<TaskData> rs = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        rs.add(TaskData.fromTaskMapObject(maps[i]));
      }
    }
    return rs;
  }
}
