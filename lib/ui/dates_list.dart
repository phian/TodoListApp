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
}

class _DatesListScreenState extends State<DatesListScreen> {
  DatabaseHelper _databaseHelper = DatabaseHelper();

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
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Center(
                child: Text(
              'Loading...',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
                fontFamily: 'Roboto',
              ),
            )),
          );
        } else if (snapshot.hasData == null) {
          // TODO: điều kiện chỗ này sai, chưa biết fix ...
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Center(
                child: Text(
              'You have no task today!',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
                fontFamily: 'Roboto',
              ),
            )),
          );
        }
        List<TaskData> todayTaskList = snapshot.data;
        return Container(
          height: todayTaskList.length * 85.0,
          margin: EdgeInsets.symmetric(vertical: 15, horizontal: 28),
          child: ListView.separated(
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
                height: 5.0,
              );
            },
          ),
        );
      },
    );
  }
}
