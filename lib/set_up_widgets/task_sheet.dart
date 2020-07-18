import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/data/repeat_choice_data.dart';
import 'package:todoapp/set_up_widgets/task_schedule_sheet.dart';

class TaskSheet extends StatefulWidget {
  final String taskName, listName, calendarDate;
  final Color taskColor;

  TaskSheet({this.taskName, this.taskColor, this.listName, this.calendarDate});

  @override
  _TaskSheetState createState() => _TaskSheetState();
}

class _TaskSheetState extends State<TaskSheet> {
  TimeOfDay _time = TimeOfDay.now();
  RepeatChoiceData _taskRepeatsChoiceData;
  TaskScheduleSheet _taskScheduleSheet = TaskScheduleSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        color: widget.taskColor == null ? Colors.white : widget.taskColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Stack(
        children: <Widget>[
          _buildTaskMenuWidgets(),
          _buildSubmitAndCanelButton(),
        ],
      ),
    );
  }

  // Task name, task title và các menu item
  Widget _buildTaskMenuWidgets() => Container(
        padding: EdgeInsets.only(
          top: 20.0,
          right: 15.0,
          left: 15.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ListTile(
              title: Text(
                widget.taskName == null ? "Task's name" : "${widget.taskName}",
                style: TextStyle(fontSize: 25.0),
              ),
              subtitle: Container(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  widget.listName == null ? "Task's list" : widget.listName,
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: () {
                _showScheduleSetUpSheet();
              },
              leading: Image.asset(
                "images/calendar.png",
                width: 30.0,
                height: 30.0,
                fit: BoxFit.contain,
              ),
              title: Text(
                widget.calendarDate == null ? "Schedule" : widget.calendarDate,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            ListTile(
              leading: Image.asset(
                "images/notification.png",
                width: 30.0,
                height: 30.0,
              ), //list icon
              title: Text("Reminder"),
              onTap: () {
                //FocusScope.of(context).unfocus();
                Navigator.of(context).push(
                  showPicker(
                    value: _time,
                    context: context,
                    onChange: _onTimeChanged,
                    is24HrFormat: false,
                  ),
                );
              },
            ),
          ],
        ),
      );

  // Hàm sự kiện khi ng dùng thay đổi thời gian
  void _onTimeChanged(TimeOfDay newTime) {
    setState(() {
      _time = newTime;
    });
  }

  // 2 button để ng dùng submit hoặc cancel setup
  Widget _buildSubmitAndCanelButton() => Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.only(bottom: 1.0, left: 10.0, right: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              height: 50.0,
              width: MediaQuery.of(context).size.width / 2 - 10,
              child: FlatButton(
                onPressed: () {
                  _deleteTaskInDb();
                  Navigator.of(context).pop(true);
                },
                child: Text(
                  "DELETE",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              height: 50.0,
              width: MediaQuery.of(context).size.width / 2 - 10,
              child: FlatButton(
                onPressed: () {
                  _saveScheduleDataToDb();
                  Navigator.of(context).pop(true);
                },
                child: Text(
                  "COMPLETE",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  // Hàm dùng khi ng dùng ấn nút Complete để save data
  void _saveScheduleDataToDb() {}

  // Hàm để khi ng dùng ấn nút delete thì ta sẽ xoá task khỏi db
  void _deleteTaskInDb() {}

  // Hàm gọi khi ng dùng ấn vào Calendar để mở sheet schedule
  void _showScheduleSetUpSheet() {
    if (_taskScheduleSheet.schedulePickedDate == null) {
      _taskScheduleSheet = TaskScheduleSheet(
          data: _taskRepeatsChoiceData, initTime: DateTime.now());
    } else {
      _taskScheduleSheet = TaskScheduleSheet(
        initTime: _taskScheduleSheet.schedulePickedDate,
        data: _taskRepeatsChoiceData,
      );
    }

    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return _taskScheduleSheet;
      },
    ).whenComplete(() {
      setState(() {
        _taskRepeatsChoiceData = _taskScheduleSheet.repeatChoiceData;
      });
    });
  }
}
