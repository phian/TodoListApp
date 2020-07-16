import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:todoapp/ui_variables/habit_schedule_set_up_variables.dart';

class HabitSetUpSheet extends StatefulWidget {
  final String imageTitle;
  HabitSetUpSheet({this.imageTitle});

  @override
  _HabitSetUpSheetState createState() => _HabitSetUpSheetState();
}

class _HabitSetUpSheetState extends State<HabitSetUpSheet> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        height: MediaQuery.of(context).size.height * 0.45,
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: MediaQuery.of(context).size.height * 0.42 / 10,
          ),
          physics: AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          children: <Widget>[
            _buildScheduleSheetTitle(),
            SizedBox(
              height: 30.0,
            ),
            _buildBeginTimePicker(),
            SizedBox(
              height: 30.0,
            ),
            _buildEndTimePicker(),
            SizedBox(
              height: 30.0,
            ),
            _buildDistanceTimePicker(),
            SizedBox(
              height: 30.0,
            ),
            _buildSubmitAndCanelButton(),
          ],
        ),
      ),
    );
  }

  // Schedule title
  Widget _buildScheduleSheetTitle() => Container(
        alignment: Alignment.topCenter,
        child: Text(
          "Schedule for ${widget.imageTitle}",
          maxLines: 2,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  // Widget để ng dùng ấn vào và đặt để bắt đầu thông báo hằng ngày
  Widget _buildBeginTimePicker() => GestureDetector(
        onTap: () {
          showRoundedTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
            theme: ThemeData.dark(),
          ).then((value) {
            setState(() {
              if (value != null) habitScheduleBeginTime = value;
            });
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "Begin time: ",
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              () {
                if (habitScheduleBeginTime != null) {
                  if (habitScheduleBeginTime.hour < 10)
                    return "0${habitScheduleBeginTime.hour}";
                  else
                    return "${habitScheduleBeginTime.hour}";
                } else
                  return "Hour ";
              }(),
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            Text(
              () {
                return ":";
              }(),
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            Text(
              () {
                if (habitScheduleBeginTime != null) {
                  if (habitScheduleBeginTime.minute < 10)
                    return "0${habitScheduleBeginTime.minute}";
                  else
                    return "${habitScheduleBeginTime.minute}";
                } else
                  return "Minute";
              }(),
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      );

  // Widget để khi ng dùng ấn vào thì sẽ có thể pick thời gian kết thúc nhắc nhở
  Widget _buildEndTimePicker() => GestureDetector(
        onTap: () {
          showRoundedTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
            theme: ThemeData.dark(),
          ).then((value) {
            setState(() {
              if (value != null) habitScheduleEndTime = value;
            });
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "End time: ",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            Text(
              () {
                if (habitScheduleEndTime != null) {
                  if (habitScheduleEndTime.hour < 10)
                    return "0${habitScheduleEndTime.hour}";
                  else
                    return "${habitScheduleEndTime.hour}";
                } else
                  return "Hour";
              }(),
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            Text(
              () {
                return ":";
              }(),
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            Text(
              () {
                if (habitScheduleEndTime != null) {
                  if (habitScheduleEndTime.minute < 10)
                    return "0${habitScheduleEndTime.minute}";
                  else
                    return "${habitScheduleEndTime.minute}";
                } else
                  return "Minute";
              }(),
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      );

  // Widget để ng dùng ấn và chọn phần giãn cách cho nhắc nhở
  Widget _buildDistanceTimePicker() => GestureDetector(
        onTap: () {
          showRoundedTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
            theme: ThemeData.dark(),
          ).then((value) {
            setState(() {
              setState(() {
                if (value != null) habitScheduleDistanceTime = value;
              });
            });
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "Distance time: ",
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              () {
                if (habitScheduleDistanceTime != null) {
                  if (habitScheduleDistanceTime.hour < 10)
                    return "0${habitScheduleDistanceTime.hour}";
                  else
                    return "${habitScheduleDistanceTime.hour}";
                } else
                  return "Hour";
              }(),
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            Text(
              () {
                return ":";
              }(),
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            Text(
              () {
                if (habitScheduleDistanceTime != null) {
                  if (habitScheduleDistanceTime.minute < 10)
                    return "0${habitScheduleDistanceTime.minute}";
                  else
                    return "${habitScheduleDistanceTime.minute}";
                } else
                  return "Minute";
              }(),
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      );

  // 2 button để ng dùng submit hoặc cancel setup
  Widget _buildSubmitAndCanelButton() => Container(
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
                  _resetScheduleSetUpValue();
                  Navigator.of(context).pop(true);
                },
                child: Text(
                  "CANCEL",
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

  // Hàm reset các giá trị của các biến lưu trữ lựa chọn
  void _resetScheduleSetUpValue() {
    setState(() {
      habitScheduleBeginTime = null;
      habitScheduleEndTime = null;
      habitScheduleDistanceTime = null;
    });
  }

  // Hàm lưu các giá trị mà ng dùng đã chọn và lưu vào db
  void _saveScheduleDataToDb() {
    if (habitScheduleBeginTime == null ||
        habitScheduleEndTime == null ||
        habitScheduleDistanceTime == null) {
      _showNotification();
    }

    if (habitScheduleBeginTime != null &&
        habitScheduleEndTime != null &&
        habitScheduleDistanceTime != null) {
      // Lưu vào db...

      // Reset giá trị và thoát
      _resetScheduleSetUpValue();

      Navigator.of(context).pop(true);
    }
  }

  // Hàm show thông báo để hỏi xem ng dùng có muốn mở Gmail ko
  void _showNotification() async {
    await showDialog(
        context: context,
        builder: (_) => AssetGiffyDialog(
              image: Image.asset(
                "images/error.gif",
                fit: BoxFit.contain,
              ),
              title: Text(
                "Error! \nPlease complete all habit schedule data",
                textAlign: TextAlign.center,
                maxLines: 3,
                softWrap: true,
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w100,
                    fontFamily: "RobotoSlab"),
              ),
              entryAnimation: EntryAnimation.BOTTOM,
              buttonOkText: Text(
                "OK",
                style: TextStyle(color: Colors.white, fontFamily: "Roboto"),
              ),
              buttonOkColor: Color(0xFFD34157),
              onOkButtonPressed: () {
                Navigator.of(context).pop(false);
              },
              onlyOkButton: true,
              cornerRadius: 30.0,
            ));
  }
}
