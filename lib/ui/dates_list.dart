//import 'dart:js';

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:todoapp/doit_database_bus/doit_database_helper.dart';
import 'package:todoapp/custom_ui_widgets/custom_list_tile.dart';
import 'package:todoapp/doit_database_models/doit_tasks_data.dart';
import 'package:todoapp/ui_variables/dates_list_variables.dart';

// ignore: must_be_immutable
class DatesListScreen extends StatefulWidget {
  @override
  _DatesListScreenState createState() => _DatesListScreenState();

  // Hàm để add các widget chứa task
  // addTodayTaskTilesListItem() async {
  //   await refreshTodayTask();
  // todayTaskTilesList = [];

  // for (int i = 0; i < todayTask.length; i++) {
  //   Color a = await getListColor(todayTask[i].listId);
  //   todayTaskTilesList.add(
  //     TaskTile(
  //       taskData: todayTask[i],
  //       taskColor: a,
  //     ),
  //   );
  // }
  // }

  DatabaseHelper _databaseHelper = DatabaseHelper();
}

class _DatesListScreenState extends State<DatesListScreen> {
  DatabaseHelper _databaseHelper = DatabaseHelper();
  Color _color;

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

  refreshTodayTask() {
    todayTask = _databaseHelper.getTodayTask();
  }

  @override
  void initState() {
    super.initState();
    refreshTodayTask();
  }

  @override
  Widget build(BuildContext context) {
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
        _buildTodayList(),
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
    return FutureBuilder(
      future: todayTask,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none || snapshot.connectionState == ConnectionState.waiting) {
          print('Đã ghé ở đây...');
          return Text('Loading...');
        }
        List<TaskData> todayTaskList = snapshot.data;
        return Container(
          height: todayTaskList.length * 100.0,
          margin: EdgeInsets.symmetric(
            vertical: 15.0,
          ),
          child: ListView.separated(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            physics: NeverScrollableScrollPhysics(),
            itemCount: todayTaskList.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return Container(
                child: Container(
                  child: TaskTile(
                    taskData: todayTaskList[index],
                  ),
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
      },
    );
  }
}
