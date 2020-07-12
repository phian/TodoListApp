//import 'dart:js';

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/doit_database_bus/doit_database_helper.dart';
import 'package:todoapp/doit_database_models/doit_lists_data.dart';
import 'package:todoapp/doit_database_models/doit_tasks_data.dart';

// ignore: must_be_immutable
class DatesListScreen extends StatefulWidget {
  @override
  _DatesListScreenState createState() => _DatesListScreenState();
}

DatabaseHelper _databaseHelper = DatabaseHelper();

class _DatesListScreenState extends State<DatesListScreen> {
  List<TaskData> todayTask;
  List<TaskData> tomorrowTask;
  List<TaskData> laterTask;

  refreshTodayTask() async {
    await _databaseHelper.getTodayTask().then((value) {
      todayTask = value;
    });
  }

  _getTask() {}

  refreshTmrTask() {
    setState(() {
      _databaseHelper.getTmrTask().then((value) {
        tomorrowTask = value;
      });
    });
  }

  refreshLaterTask() {
    setState(() {
      _databaseHelper.getLaterTask().then((value) {
        laterTask = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    todayTask = [];
    tomorrowTask = [];
    laterTask = [];
    refreshTodayTask();
    //refreshTmrTask();
    //refreshLaterTask();
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
      child: ListView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        physics: NeverScrollableScrollPhysics(),
        itemExtent: 80.0,
        itemCount: todayTask.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return TaskTile(taskData: todayTask[index]);
        },
      ),
    );
  }
}

class TaskTile extends StatefulWidget {
  final TaskData taskData;
  TaskTile({Key key, this.taskData}) : super(key: key);
  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  String colorStr = "0xFFFFFFFF";
  Color _taskColor;
  List<ListData> _queryData;

  _getListColor(int listid) async {
    print("list id: $listid");
    await _databaseHelper.getListColor(listid).then((value) {
      for (var i = 0; i < value.length; i++) {
        colorStr = value[i].values.toList()[i] ?? "Color(0xFFFFFFFF)";
        print(value[i].values.toList()[i]);
      }
    });

    print("colorStr: $colorStr");
  }

  void _hexToColor() async {
    _taskColor = Color(int.parse(_queryData[0].listColor.substring(10, 16), radix: 16) + 0xFF000000);
  }

  void _getListData() async {
    await _databaseHelper.getListByListID(widget.taskData.listId).then((value) {
      _queryData = value;
    });
  }

  @override
  void initState() {
    super.initState();

    _getListData();
    _hexToColor();
  }

  @override
  Widget build(BuildContext context) {
    _hexToColor();

    return Container(
      decoration: BoxDecoration(
        color: _taskColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Align(
        alignment: Alignment.center,
        child: ListTile(
          subtitle: Text(
            widget.taskData.taskDate,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: 'Roboto',
              color: Colors.grey,
            ),
          ),
          title: Text(
            widget.taskData.taskName,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 22.0,
              fontFamily: 'Roboto',
            ),
          ),
        ),
      ),
    );
  }
}
