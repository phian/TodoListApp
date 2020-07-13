//import 'dart:js';

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:todoapp/doit_database_bus/doit_database_helper.dart';
import 'package:todoapp/custom_ui_widgets/custom_list_tile.dart';
import 'package:todoapp/ui_variables/dates_list_variables.dart';

// ignore: must_be_immutable
class DatesListScreen extends StatefulWidget {
  @override
  _DatesListScreenState createState() => _DatesListScreenState();

  // Hàm để add các widget chứa task
  addTodayTaskTilesListItem() async {
    await refreshTodayTask();
    todayTaskTilesList = [];
    for (int i = 0; i < todayTask.length; i++) {
      todayTaskTilesList.add(
        TaskTile(
          taskData: todayTask[i],
        ),
      );
    }
  }

  DatabaseHelper _databaseHelper = DatabaseHelper();
  refreshTodayTask() async {
    await _databaseHelper.getTodayTask().then((value) {
      todayTask = value;
    });
  }

  getTask() {}

  refreshTmrTask() async {
    await _databaseHelper.getTmrTask().then((value) {
      tomorrowTask = value;
    });
  }

  refreshLaterTask() async {
    await _databaseHelper.getLaterTask().then((value) {
      laterTask = value;
    });
  }
}

class _DatesListScreenState extends State<DatesListScreen> {
  DatabaseHelper _databaseHelper = DatabaseHelper();

  // Hàm để add các widget chứa task
  // _addTodayTaskTilesListItem() async {
  //   await refreshTodayTask();
  //   todayTaskTilesList = [];
  //   for (int i = 0; i < todayTask.length; i++) {
  //     todayTaskTilesList.add(
  //       TaskTile(
  //         taskData: todayTask[i],
  //       ),
  //     );
  //   }
  // }

  // refreshTodayTask() async {
  //   await _databaseHelper.getTodayTask().then((value) {
  //     todayTask = value;
  //   });
  // }

  // getTask() {}

  // refreshTmrTask() async {
  //   await _databaseHelper.getTmrTask().then((value) {
  //     tomorrowTask = value;
  //   });
  // }

  // refreshLaterTask() async {
  //   await _databaseHelper.getLaterTask().then((value) {
  //     laterTask = value;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // todayTask = [];
    // tomorrowTask = [];
    // laterTask = [];
    //_refreshTmrTask();
    //_refreshLaterTask();
  }

  @override
  Widget build(BuildContext context) {
    double _paddingLeftAndRight = MediaQuery.of(context).size.width / 9.0;
    double _screenWidth = MediaQuery.of(context).size.width;
    return ListView(
      physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            'Today',
            textDirection: TextDirection.ltr,
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Roboto',
            ),
          ),
        ),
        todayTask.length != 0
            ? _buildTodayList()
            : SizedBox(
                height: 50.0,
              ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            'Tomorrow',
            textDirection: TextDirection.ltr,
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Roboto',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            top: 20.0,
          ),
          child: Text(
            'Later',
            textDirection: TextDirection.ltr,
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Roboto',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTodayList() {
    return Container(
      height: todayTask.length * 100.0,
      margin: EdgeInsets.symmetric(
        vertical: 15.0,
      ),
      child: ListView.separated(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        physics: NeverScrollableScrollPhysics(),
        itemCount: todayTask.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return Container(
            child: Container(
              child: todayTaskTilesList[index],
              height: 80.0,
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 10.0,
          );
        },
      ),
    );
  }
}
