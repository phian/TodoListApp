import 'package:flutter/material.dart';
import 'package:todoapp/doit_database_bus/doit_database_helper.dart';
import 'package:todoapp/doit_database_models/doit_tasks_data.dart';
import 'package:todoapp/ui_variables/dates_list_variables.dart';

class TaskTile extends StatefulWidget {
  final TaskData taskData;
  TaskTile({Key key, this.taskData}) : super(key: key);
  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  String _colorStr;
  Color _taskColor;
  DatabaseHelper _databaseHelper = DatabaseHelper();

  // Hàm để add các widget chứa task
  _addTodayTaskTilesListItem() async {
    await _refreshTodayTask();
    todayTaskTilesList = [];
    for (int i = 0; i < todayTask.length; i++) {
      todayTaskTilesList.add(
        TaskTile(
          taskData: todayTask[i],
        ),
      );
    }
  }

  _refreshTodayTask() async {
    await _databaseHelper.getTodayTask().then((value) {
      todayTask = value;
    });
  }

  _getListColor(int listId) async {
    if (listId == null)
      _colorStr = "Color(0xFFFFFFFF)";
    // else {
    //   print("list id: $listId");
    //   await _databaseHelper.getListsMap().then((value) {
    //     for (int i = 0; i < value.length; i++) {
    //       var listInfo = value[i].values.toList();
    //       if (listInfo[0] == listId) _colorStr = listInfo[2];
    //       break;
    //     }
    //   });
    // }
    else if (listId != null)
      await _databaseHelper.getListColor(listId).then((value) {
        _colorStr = value[0].values.toList()[0];
      });

    // print("colorStr: $_colorStr");
  }

  void _hexToColor() async {
    await _getListColor(widget.taskData.listId);
    _taskColor =
        Color(int.parse(_colorStr.substring(10, 16), radix: 16) + 0xFF000000);
  }

  _initTasks(BuildContext context) {
    _addTodayTaskTilesListItem();
    _hexToColor();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => _initTasks(context));

    _addTodayTaskTilesListItem();
    _hexToColor();
  }

  @override
  Widget build(BuildContext context) {
    _addTodayTaskTilesListItem();
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
