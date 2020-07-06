import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todoapp/data/main_screen_data.dart';
import 'package:todoapp/data/repeat_choice_data.dart';
import 'package:todoapp/data/special_repeat_data.dart';
import 'package:todoapp/doit_database_models/doit_schedule_data.dart';
import 'package:todoapp/doit_database_models/doit_tasks_data.dart';
import 'package:todoapp/set_up_widgets/list_sheet.dart';
import 'package:todoapp/set_up_widgets/schedule_sheet.dart';
import 'package:todoapp/set_up_widgets/special_schedule_sheet.dart';
import 'package:todoapp/ui_variables/task_screen_variables.dart';
import 'package:todoapp/doit_database_bus/doit_database_helper.dart';

import 'main_screen.dart';

class AddTaskPage extends StatefulWidget {
  int lastFocusedScreen;
  int settingScreenIndex;
  AddTaskPage({this.lastFocusedScreen, this.settingScreenIndex});

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  String _selectedChoice = "";
  List<String> _choicesList = ['Normal task', 'Special task', 'Achievement task'];
  List<Widget> _choices = List();
  List<bool> _visibilities = [true, true, true, false];

  DatabaseHelper _databaseHelper = DatabaseHelper();

  TimeOfDay _time = TimeOfDay.now();
  final _textController = TextEditingController();
  int _selectedIndex; // index của loại task

  ScheduleSheet _scheduleSheet = ScheduleSheet();
  SpecialScheduleSheet _specialScheduleSheet = SpecialScheduleSheet();
  ListSheet _listSheet = ListSheet();

  RepeatChoiceData _repeatsChoiceData;
  SpecialRepeatChoiceData _specialRepeatChoiceData;

  int _choseListIndex;

  String strSeparator = "__,__";

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _selectedChoice = _choicesList[0];
    _repeatsChoiceData = RepeatChoiceData();
    _specialRepeatChoiceData = SpecialRepeatChoiceData();

    isNormalFirstTime = true;
    isSpecialFirstTime = true;
  }

  String convertArrayToString(List<int> array) {
    String str = "";
    for (int i = 0; i < array.length; i++) {
      str = str + array[i].toString();

      if (i < array.length - 1) {
        str = str + strSeparator;
      }
    }
    return str;
  }

  List<int> convertStringToArray(String str) {
    return str.split(strSeparator).map(int.parse).toList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _backToMainScreen();
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              ListView(
                padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 25, right: 25, top: 8, bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 6,
                          spreadRadius: 5,
                          color: Colors.grey[200],
                        )
                      ],
                    ),
                    child: TextField(
                      //autofocus: true,
                      controller: _textController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Colors.black12,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        hintText: "Task name",
                      ),
                      maxLines: null,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      cursorColor: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: _buildChoiceList(),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Card(
                    margin: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: <Widget>[
                        Visibility(
                          visible: _visibilities[0],
                          child: ListTile(
                            leading: Image.asset(
                              "images/calendar.png",
                              width: 30.0,
                              height: 30.0,
                            ),
                            title: Text("Schedule"),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            onTap: _onSchedulePress,
                          ),
                        ),
                        Visibility(
                          visible: _visibilities[1],
                          child: ListTile(
                            leading: Image.asset(
                              "images/tasks.png",
                              width: 30.0,
                              height: 30.0,
                            ),
                            title: Text("Choose List"),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            onTap: _onListPress,
                          ),
                        ),
                        Visibility(
                          visible: _visibilities[2],
                          child: ListTile(
                            leading: Image.asset(
                              "images/notification.png",
                              width: 30.0,
                              height: 30.0,
                            ), //list icon
                            title: Text("Reminder"),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              //FocusScope.of(context).unfocus();
                              Navigator.of(context).push(
                                showPicker(
                                  value: _time,
                                  context: context,
                                  onChange: onTimeChanged,
                                  is24HrFormat: false,
                                ),
                              );
                            },
                          ),
                        ),
                        Visibility(
                          visible: _visibilities[3],
                          child: ListTile(
                            leading: Image.asset(
                              "images/calendar.png",
                              width: 30.0,
                              height: 30.0,
                            ),
                            title: Text("Schedule 2"),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            onTap: _onSchedule2Press,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 2,
                      child: FlatButton(
                        color: Colors.white,
                        child: Icon(Icons.close),
                        onPressed: () {
                          _backToMainScreen();
                        },
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 2,
                      child: FlatButton(
                        color: Colors.white,
                        child: Icon(Icons.done),
                        onPressed: () async {
                          //==================================
                          //           them task normal
                          // var strWeekChoice = convertArrayToString(_repeatsChoiceData.weekRepeatDateChoiceIndex);
                          // _databaseHelper.insertDataToScheduleTable(
                          //   ScheduleData(
                          //     scheduleRepeatDate: _scheduleSheet.schedulePickedDate.toString(),
                          //     scheduleSetUpStatus: _repeatsChoiceData.isOnOrOff,
                          //     scheduleFrequencyChoice: _repeatsChoiceData.frequencyChoice,
                          //     scheduleRerepeatTimes: _repeatsChoiceData.repeatTimes,
                          //     scheduleWeeklyChoiceDates: strWeekChoice,
                          //     scheduleMonthlyChoice: _repeatsChoiceData.monthlyRepeatChoice.toString(),
                          //     scheduleEndsNeverChoice: _repeatsChoiceData.endsChoice,
                          //     scheduleEndsDate: _repeatsChoiceData.endsDateChoice.toString(),
                          //     scheduleEndsNumberOfTimes: _repeatsChoiceData.endsAfetrNumberOfTimesChoice,
                          //   ),
                          // );

                          // _databaseHelper.insertDataToTaskTable(
                          //   TaskData(
                          //     taskName: _textController.text,
                          //     listId: _choseListIndex,
                          //     taskStatus: 0,
                          //     taskType: _selectedIndex,
                          //     taskRemainderTime: _time.toString(),
                          //     scheduleId: await _databaseHelper.getNewScheduleID(),
                          //   ),
                          // );
                          print(convertArrayToString(_repeatsChoiceData.weekRepeatDateChoiceIndex));
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Hàm để back về main screen
  void _backToMainScreen() {
    MainScreenData data = MainScreenData(
        isBack: false,
        isBackFromAddTaskScreen: true,
        lastFocusedScreen: widget.lastFocusedScreen,
        settingScreenIndex: widget.settingScreenIndex);

    Navigator.pushReplacement(
        context,
        PageTransition(
            child: HomeScreen(
              data: data,
            ),
            type: PageTransitionType.leftToRightWithFade,
            duration: Duration(milliseconds: 300)));
  }

  _buildChoiceList() {
    _choices = List();

    for (int i = 0; i < _choicesList.length; i++) {
      _choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(_choicesList[i]),
          labelStyle: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          backgroundColor: Colors.grey.shade300,
          selectedColor: Colors.orange.shade200,
          selected: _selectedChoice == _choicesList[i],
          onSelected: (selected) {
            setState(() {
              _selectedChoice = _choicesList[i];

              _checkChoseItem(_choicesList[i]);
            });
          },
        ),
      ));
    }
    return _choices;
  }

  void _checkChoseItem(String selectedItem) {
    for (int i = 0; i < _choices.length; i++) {
      if (selectedItem.compareTo(_choicesList[i]) == 0) {
        _selectedIndex = i;
        break;
      }
    }

    switch (_selectedIndex) {
      case 0:
      case 2:
        _visibilities[0] = _visibilities[1] = _visibilities[2] = true;
        _visibilities[3] = false;
        break;
      default:
        _visibilities[1] = _visibilities[2] = _visibilities[0] = false;
        _visibilities[3] = true;
    }
  }

  void _onListPress() {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return _listSheet;
      },
    ).whenComplete(() {
      _choseListIndex = choseListIndex;
      print("chose list index: $_choseListIndex");
    });
  }

  void onTimeChanged(TimeOfDay newTime) {
    setState(() {
      _time = newTime;
    });
  }

  void _onSchedulePress() {
    if (_scheduleSheet.schedulePickedDate == null) {
      _scheduleSheet = ScheduleSheet(data: _repeatsChoiceData, initTime: DateTime.now());
    } else {
      _scheduleSheet = ScheduleSheet(
        initTime: _scheduleSheet.schedulePickedDate,
        data: _repeatsChoiceData,
      );
    }

    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return _scheduleSheet;
      },
    ).whenComplete(() {
      setState(() {
        _repeatsChoiceData = _scheduleSheet.repeatChoiceData;
      });
    });
  }

  void _onSchedule2Press() {
    if (_specialScheduleSheet.schedulePickedDate == null) {
      _specialScheduleSheet = SpecialScheduleSheet(data: _specialRepeatChoiceData, initTime: DateTime.now());
    } else {
      _specialScheduleSheet = SpecialScheduleSheet(
        initTime: _specialScheduleSheet.schedulePickedDate,
        data: _specialRepeatChoiceData,
      );
    }

    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return _specialScheduleSheet;
      },
    ).whenComplete(() {
      setState(() {
        _specialRepeatChoiceData = _specialScheduleSheet.specialRepeatChoiceData;
      });
    });
  }
}
