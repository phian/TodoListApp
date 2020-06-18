import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/doit_database_models/doit_lists_data.dart';
import 'package:todoapp/doit_database_models/doit_schedule_data.dart';
import 'package:todoapp/doit_database_models/doit_tasks_data.dart';

class DatabaseHelper {
  static DatabaseHelper _doitDatabaseHelper; // Singleton DatabaseHelper
  static Database _doitDatabase;

  String listTable = 'LIST_TABLE';
  String colListId = "LIST_ID";
  String colListName = 'LIST_NAME';
  String colListColor = 'LIST_COLOR';

  String taskTable = 'TASK_TABLE';
  String colTaskId = 'TASK_ID';
  String colListIdForTaskTable = 'LIST_ID';
  String colScheduleId1 = 'SCHEDULE_ID';
  String colTaskName = 'TASK_NAME';
  String colTaskStatus = 'TASK_STATUS';
  String colTaskType = 'TASK_TYPE';
  String colTaskRemainderTime = 'TASK_REMAINDER_TIME';

  String scheduleTable = 'SCHEDULE_TABLE';
  String colScheduleId = 'SCHEDULE_ID';
  String colScheduleRepeatDate = 'REPEAT_DATE';
  String colScheduleSetUpStatus = 'SCHEDULE_STATUS';
  String colScheduleFrequencyChoice = 'FREQUENCY_CHOICE';
  String colScheduleRepeatTimes = 'REPEAT_TIMES';
  String colScheduleWeeklyChoiceDates = 'WEEKLY_CHOICE_DATES';
  String colScheduleMonthlyChoice = 'MONTHLY_CHOICE';
  String colScheduleEndsNeverChoice = 'NEVER_CHOICE';
  String colScheduleEndsNumberOfTimes = 'NUMBER_OF_TIMES';
  String colScheduleEndsDate = 'ENDS_DATE';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_doitDatabaseHelper == null) {
      _doitDatabaseHelper = DatabaseHelper
          ._createInstance(); // Thực thi một lần duy nhất, singleton object
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
    Directory doitDatabaseStoredDirectory =
        await getApplicationDocumentsDirectory();
    String doitDatabasePath = doitDatabaseStoredDirectory.path + 'doit.db';

    // Mở hoặc khởi tạo database tại đường dẫn được đưa trc
    var doitDatabase = await openDatabase(doitDatabasePath,
        version: 1, onCreate: _createDoitDatabase);

    return doitDatabase;
  }

  // Hàm để khởi tạo database
  void _createDoitDatabase(Database doitDatabase, int newVersion) async {
    await doitDatabase.execute(
        'CREATE TABLE $listTable($colListId INTEGER PRIMARY KEY AUTOINCREMENT, $colListName TEXT, $colListColor TEXT)');

    await doitDatabase.execute(
        "CREATE TABLE $taskTable($colTaskId INTEGER PRIMARY KEY AUTOINCREMENT, $colListIdForTaskTable INTEGER REFERENCES $listTable($colListId), $colScheduleId1 INTEGER REFERENCES $scheduleTable($colScheduleId), $colTaskName TEXT, $colTaskStatus INTEGER, $colTaskType TEXT, $colTaskRemainderTime TEXT)");

    await doitDatabase.execute(
        "CREATE TABLE $scheduleTable($colScheduleId INTEGER PRIMARY KEY AUTOINCREMENT, $colScheduleRepeatDate TEXT, $colScheduleSetUpStatus INTEGER, $colScheduleFrequencyChoice INTEGER, $colScheduleRepeatTimes INTEGER, $colScheduleWeeklyChoiceDates TEXT, $colScheduleMonthlyChoice TEXT, $colScheduleEndsNeverChoice INTEGER, $colScheduleEndsNumberOfTimes INTEGER, $colScheduleEndsDate TEXT)");
  }

  // Hàm để lấy thông tin từ list table
  Future<List<Map<String, dynamic>>> getListsMap() async {
    Database doitDatabase = await this.getDoitDatabase;

    var queryResult = await doitDatabase.query(listTable);
    return queryResult;
  }

  // Hàm để lấy thông tin từ task table
  Future<List<Map<String, dynamic>>> getTasksMap() async {
    Database doitDatabase = await this.getDoitDatabase;

    var queryResult = await doitDatabase.query(taskTable);
    return queryResult;
  }

  // Hàm để lấy thông tin từ schedule table
  Future<List<Map<String, dynamic>>> getSchedulesMap() async {
    Database doitDatabase = await this.getDoitDatabase;

    var queryResult = await doitDatabase.query(scheduleTable);
    return queryResult;
  }

  //------------------------------------Phần  insert----------------------------------------//
  // Hàm để insert dữ liệu vào bảng list
  Future<int> insertDataToListTable(ListData listData) async {
    Database doitDatabase = await this.getDoitDatabase;

    var insertResult = await doitDatabase.insert(listTable, listData.toMap());
    return insertResult;
  }

  // Hàm để insert dữ liệu vào bảng task
  Future<int> insertDataToTaskTable(TaskData taskData) async {
    Database doitDatabase = await this.getDoitDatabase;

    var insertResult = await doitDatabase.insert(listTable, taskData.toMap());
    return insertResult;
  }

  // Hàm để insert dữ liệu vào bảng task's schedule
  Future<int> insertDataToScheduleTable(ScheduleData scheduleData) async {
    Database doitDatabase = await this.getDoitDatabase;

    var insertResult =
        await doitDatabase.insert(listTable, scheduleData.toMap());
    return insertResult;
  }
  //----------------------------------------------------------------------------------------//

  //------------------------------------Phần  update----------------------------------------//

  // Hàm để update dữ liệu vào bảng list
  Future<int> updateListData(ListData listData) async {
    var doitDatabase = await this.getDoitDatabase;

    var updateResult = await doitDatabase.update(listTable, listData.toMap(),
        where: '$colListId = ?', whereArgs: [listData.listId]);
    return updateResult;
  }

  // Hàm để update dữ liệu vào bảng task
  Future<int> updateTaskData(TaskData taskData) async {
    var doitDatabase = await this.getDoitDatabase;

    var updateResult = await doitDatabase.update(taskTable, taskData.toMap(),
        where: '$colTaskId = ?', whereArgs: [taskData.taskId]);
    return updateResult;
  }

  // Hàm để update dữ liệu vào bảng task's schedule
  Future<int> updateScheduleData(ScheduleData scheduleData) async {
    var doitDatabase = await this.getDoitDatabase;

    var updateResult = await doitDatabase.update(
        scheduleTable, scheduleData.toMap(),
        where: '$colScheduleId = ?', whereArgs: [scheduleData.scheduleId]);
    return updateResult;
  }
  //----------------------------------------------------------------------------------------//

  //------------------------------------Phần  delete----------------------------------------//

  // Hàm để xoá data trong bảng list
  Future<int> deleteListData(int listId) async {
    var doitDatabase = await this.getDoitDatabase;

    var deleteResult = await doitDatabase
        .delete(listTable, where: '$colListId = ?', whereArgs: [listId]);
    return deleteResult;
  }

  // Hàm để xoá data trong bảng task
  Future<int> deleteTaskData(int taskId) async {
    var doitDatabase = await this.getDoitDatabase;

    var deleteResult = await doitDatabase
        .delete(taskTable, where: '$colTaskId = ?', whereArgs: [taskId]);
    return deleteResult;
  }

  // Hàm để xoá data trong bảng task's schedule
  Future<int> deleteScheduleData(int scheduleId) async {
    var doitDatabase = await this.getDoitDatabase;

    var deleteResult = await doitDatabase.delete(scheduleTable,
        where: '$colScheduleId = ?', whereArgs: [scheduleId]);
    return deleteResult;
  }
  //----------------------------------------------------------------------------------------//

  //--------------------------Phần  lấy số lượng phần tử từ các bảng------------------------//

  // Hàm để lấy số lượng phần tử từ bảng list
  Future<int> getListObjectsCount() async {
    var doitDatabase = await this.getDoitDatabase;
    List<Map<String, dynamic>> listTableObjects =
        await doitDatabase.rawQuery('Select COUNT (*) FROM $listTable');

    int countResult = Sqflite.firstIntValue(listTableObjects);
    return countResult;
  }

  // Hàm để lấy số lượng phần tử từ bảng task
  Future<int> getTaskObjectsCount() async {
    var doitDatabase = await this.getDoitDatabase;
    List<Map<String, dynamic>> taskTableObjects =
        await doitDatabase.rawQuery('Select COUNT (*) FROM $taskTable');

    int countResult = Sqflite.firstIntValue(taskTableObjects);
    return countResult;
  }

  // Hàm để lấy số lượng phần tử từ bảng schedule
  Future<int> getScheduleObjectsCount() async {
    var doitDatabase = await this.getDoitDatabase;
    List<Map<String, dynamic>> scheduleTableObjects =
        await doitDatabase.rawQuery('Select COUNT (*) FROM $scheduleTable');

    int countResult = Sqflite.firstIntValue(scheduleTableObjects);
    return countResult;
  }

  //----------------------------------------------------------------------------------------//
}
