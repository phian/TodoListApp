import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  _hexToColor(String code) {
    return Color(int.parse(code.substring(10, 16), radix: 16) + 0xFF000000);
  }

  String _listname = '';
  var _taskdate;
  @override
  void initState() {
    super.initState();
    widget.taskData.listName != null ? _listname = widget.taskData.listName + ' - ' : _listname = '';
    _taskdate = DateFormat('d/M/yyyy').parse(widget.taskData.taskDate);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.taskData.listId == null ? Colors.white : _hexToColor(widget.taskData.listColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Align(
        alignment: Alignment.center,
        child: ListTile(
          subtitle: Text(
            _listname + DateFormat("MMMM d").format(_taskdate).toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15.0,
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
