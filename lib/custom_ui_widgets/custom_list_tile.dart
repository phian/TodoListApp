import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/doit_database_models/doit_tasks_data.dart';

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
  Color _textColor = Colors.white;
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
        color: widget.taskData.listId == null
            ? () {
                _textColor = Colors.black;
                return Colors.white;
              }()
            : _hexToColor(widget.taskData.listColor),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Align(
        alignment: Alignment.center,
        child: ListTile(
          subtitle: Text(
            _listname.toUpperCase() + DateFormat("EEE, d MMM").format(_taskdate).toString().toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: 'Roboto',
              color: _textColor,
            ),
          ),
          title: Text(
            widget.taskData.taskName,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _textColor,
              fontWeight: FontWeight.w500,
              fontSize: 22.0,
              fontFamily: 'Roboto',
            ),
          ),
        ),
      ),
    );
  }
}
