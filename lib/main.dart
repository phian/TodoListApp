import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/data/data.dart';
import 'package:todoapp/doit_database_bus/doit_database_helper.dart';
import './ui/main_screen.dart';
import 'dart:async';
import 'package:sqflite/src/factory_impl.dart' show databaseFactory;
export 'package:sqflite/src/factory_impl.dart' show databaseFactory;

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Biến để khởi tạo database và check xem db đã được tạo chưa
  DatabaseHelper _doitDatabaseHelper;
  String _doitDatabasePath = "";

  @override
  void initState() {
    super.initState();

    _doitDatabaseHelper = DatabaseHelper();
    _doitDatabaseHelper.initDoitDatabase();

    _getDoitDatabasePath().then((pathValue) {
      _databaseExists(pathValue).then((isExist) {
        if (isExist) {
          print('$_doitDatabasePath');
        }
      });
    });

    Data data = Data(
        isBack: false, lastFocusedScreen: 0, isBackFromAddTaskScreen: false);

    Future.delayed(
      Duration(seconds: 2),
      () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomeScreen(
            data: data,
          ),
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        body: Center(
      child: Image.asset(
        'images/todo_app_slogan.png',
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    ));
  }

  // Hàm để check xem database đã tồn tại hay chưa
  Future<bool> _databaseExists(String path) =>
      databaseFactory.databaseExists(path);

  // Hàm để lấy đường dẫn database
  Future<String> _getDoitDatabasePath() async {
    Directory doitDatabaseStoredDirectory =
        await getApplicationDocumentsDirectory();
    _doitDatabasePath = doitDatabaseStoredDirectory.path + "doit.db";
    return _doitDatabasePath;
  }
}
