import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todoapp/data/data.dart';

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
  List<String> _choicesList = [
    'Normal task',
    'Special task',
    'Achievement task'
  ];
  List<Widget> _choices = List();
  List<bool> _visibilities = [true, true, true];

  TimeOfDay _time = TimeOfDay.now();

  double _chooseListSheetHeight;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _selectedChoice = _choicesList[0];
    _chooseListSheetHeight = 205;
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
                    padding:
                        EdgeInsets.only(left: 25, right: 25, top: 8, bottom: 8),
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
                        )
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
                        onPressed: () {
                          print('Done');
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
    Data data = Data(
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
          labelStyle: TextStyle(
              color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
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
    int selectedIndex;

    for (int i = 0; i < _choices.length; i++) {
      if (selectedItem.compareTo(_choicesList[i]) == 0) {
        selectedIndex = i;
        break;
      }
    }

    switch (selectedIndex) {
      case 0:
      case 2:
        _visibilities[0] = _visibilities[1] = _visibilities[2] = true;
        break;
      default:
        _visibilities[1] = _visibilities[2] = false;
    }
  }

  void _onListPress() {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            color: Color(0xFFECEFF1),
          ),
          height: _chooseListSheetHeight,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Choose list",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  physics: AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width / 12),
                  children: <Widget>[
                    Container(
                      height: 60,
                      child: Center(
                        child: Text("No list"),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      height: 60,
                      child: Center(
                        child: Text("Add new list"),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void onTimeChanged(TimeOfDay newTime) {
    setState(() {
      _time = newTime;
    });
  }

  void _onSchedulePress() {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return ScheduleSheet();
      },
    );
  }
}

class ScheduleSheet extends StatefulWidget {
  @override
  _ScheduleSheetState createState() => _ScheduleSheetState();
}

class _ScheduleSheetState extends State<ScheduleSheet> {
  List<String> _scheduleTittle = [
    'Today',
    'Tomorrow',
    'This week',
    'Later',
    'Choose date'
  ];
  int _selectedScheduleIndex = 0;
  String _scheduleChoseDateText;
  DateTime _scheduleChoseDateTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scheduleChoseDateTime = DateTime.now();
    _scheduleChoseDateText =
        DateFormat("EEEEEEEE dd MMMM yyyyy").format(_scheduleChoseDateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: Color(0xFFECEFF1),
      ),
      height: MediaQuery.of(context).size.height * 0.9,
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Schedule",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _scheduleTittle.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.only(right: 5.0),
                  alignment: Alignment.center,
                  child: ListTile(
                    leading: _selectedScheduleIndex == index
                        ? Opacity(
                            opacity: 1.0,
                            child: Icon(Icons.check),
                          )
                        : Opacity(
                            opacity: 0.0,
                            child: Icon(Icons.check),
                          ),
                    title: Text(_scheduleTittle[index]),
                    trailing: (_selectedScheduleIndex == index && index == 0)
                        ? Text(DateFormat("EEEEEEEE dd MMMM yyyyy")
                            .format(DateTime.now()))
                        : (_selectedScheduleIndex == index && index == 1)
                            ? Text(DateFormat("EEEEEEEE dd MMMM yyyyy")
                                .format(DateTime.now().add(Duration(days: 1))))
                            : (_selectedScheduleIndex == index &&
                                    index == _scheduleTittle.length - 1)
                                ? Text(_scheduleChoseDateText)
                                : null,
                    onTap: () {
                      setState(() {
                        _selectedScheduleIndex = index;

                        _scheduleChoseDateText =
                            DateFormat("EEEEEEEE dd MMMM yyyyy")
                                .format(_scheduleChoseDateTime);
                      });

                      if (index == _scheduleTittle.length - 1) {
                        showRoundedDatePicker(
                          theme: ThemeData.dark(),
                          context: context,
                          initialDate: _scheduleChoseDateTime,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        ).then((value) {
                          setState(() {
                            if (value != null) _scheduleChoseDateTime = value;

                            _scheduleChoseDateText =
                                DateFormat("EEEEEEEE dd MMMM yyyy")
                                    .format(_scheduleChoseDateTime);

                            // Xét điều kiện xem người dùng có chọn trùng với ngày của 4 choice menu trên hay không
                            if (DateFormat("dd MMMM yyyyy")
                                    .format(_scheduleChoseDateTime) ==
                                DateFormat("dd MMMM yyyyy")
                                    .format(DateTime.now())) {
                              _selectedScheduleIndex = 0;

                              return;
                            } else if (DateFormat("dd MMMM yyyyy")
                                    .format(_scheduleChoseDateTime) ==
                                DateFormat("dd MMMM yyyyy").format(
                                    DateTime.now().add(Duration(days: 1)))) {
                              _selectedScheduleIndex = 1;

                              return;
                            } else if (DateFormat("dd MMMM yyyyy")
                                    .format(_scheduleChoseDateTime) ==
                                DateFormat("dd MMMM yyyyy").format(
                                    DateTime.now().add(Duration(
                                        days: 6 - DateTime.now().weekday)))) {
                              _selectedScheduleIndex = 2;
                            } else if (DateFormat("dd MMMM yyyyy")
                                    .format(_scheduleChoseDateTime) ==
                                DateFormat("dd MMMM yyyyy").format(
                                    DateTime.now().add(Duration(
                                        days: 7 - DateTime.now().weekday)))) {
                              _selectedScheduleIndex = 3;
                            }
                          });
                        });
                      } else if (index == 0 || index == 1) {
                        setState(() {
                          _scheduleChoseDateTime = index == 0
                              ? DateTime.now()
                              : DateTime.now().add(Duration(days: 1));
                          _scheduleChoseDateText =
                              DateFormat("EEEEEEEE dd MMMM yyyyy")
                                  .format(_scheduleChoseDateTime);
                        });
                      } else {
                        setState(() {
                          if (index == 2) {
                            _scheduleChoseDateTime = DateTime.now().add(
                                Duration(days: 6 - DateTime.now().weekday));
                            _scheduleChoseDateText =
                                DateFormat("EEEEEEEE dd MMMM yyyyy")
                                    .format(_scheduleChoseDateTime);
                          } else {
                            _scheduleChoseDateTime = DateTime.now().add(
                                Duration(days: 7 - DateTime.now().weekday));
                            _scheduleChoseDateText =
                                DateFormat("EEEEEEEE dd MMMM yyyyy")
                                    .format(_scheduleChoseDateTime);
                          }
                        });
                      }
                    },
                  ),
                );
              },
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Repeats",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          ListTile(
            onTap: _onRepeatTap,
            title: Text("Open repeats set up"),
            leading: Opacity(
              opacity: 0.0,
              child: Icon(Icons.check),
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
          Expanded(child: SizedBox()),
        ],
      ),
    );
  }

  void _onRepeatTap() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => RepeatSheet());
  }
}

class RepeatSheet extends StatefulWidget {
  @override
  _RepeatSheetState createState() => _RepeatSheetState();
}

class _RepeatSheetState extends State<RepeatSheet> {
  List<double> _opacitiesForFirstMenu = [1.0, 0.0];
  bool _isVisible = false;

  List<double> _opacitiesForSecondMenu = [1.0, 0.0, 0.0, 0.0];
  int _lastSelectedIndexInSecondMenu = 0;

  String _sRepeatTimeCount = "1";
  String _sRepeatTimeCount1 = "day";
  int _iRepeatTimeCount = 1;
  List<String> _dailyChoiceCardContents = ["S", "M", "T", "W", "T", "F", "S"];
  List<Widget> _dailyChoiceCards;
  List<int> _selectedIndex;
  bool _isWeeklyRepeat = false;

  bool _isMonthlyRepeat = false;
  List<double> _opacitiesForFourthMenu = [1.0, 0.0];
  String _monthlyRepeatDateName;

  List<double> _opacitiesForForFifthMenu = [1.0, 0.0, 0.0];
  String _endSecondChoiceText = "After a number of times",
      _endSecondChoiceMultiCountText;
  int _endSecondChoiceCount;
  bool _isSecondChoiceButtonVisible = false;

  String
      _endDay; // Biến để hiển thị format cho ngày mà người dùng chọn trong phần ENDS
  DateTime _initTimeForEndDay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _initDailyRepeatCardList();
    _initTimeForEndDay = DateTime.now();
    _endDay = null;
  }

  @override
  Widget build(BuildContext context) {
    /// Làm tiếp phần chuyển đổi số ít + nhiều của phần reapeat every
    ///

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
        color: Colors.white,
      ),
      child: ListView(
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 12.0),
                  child: Text(
                    'REPEATS SET UP',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  onTap: () {
                    setState(() {
                      _opacitiesForFirstMenu[0] = 1.0;
                      _opacitiesForFirstMenu[1] = 0.0;

                      _isVisible = false;

                      _resetFrequencyWidgetState();
                    });
                  },
                  title: Text("Off"),
                  leading: Opacity(
                    opacity: _opacitiesForFirstMenu[0],
                    child: Icon(Icons.check),
                  ),
                ),
                ListTile(
                  onTap: () {
                    setState(() {
                      _opacitiesForFirstMenu[0] = 0.0;
                      _opacitiesForFirstMenu[1] = 1.0;

                      _isVisible = true;
                    });
                  },
                  title: Text("On complete"),
                  leading: Opacity(
                    opacity: _opacitiesForFirstMenu[1],
                    child: Icon(Icons.check),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Visibility(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Text(
                          "FREQUENCY",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        ListTile(
                          onTap: () {
                            _changeSecondMenuIconOpacity(0);

                            _isWeeklyRepeat = false;
                            _isMonthlyRepeat = false;

                            _resetMonthlyChoiceIconOpacity();
                          },
                          title: Text("Daily"),
                          leading: Opacity(
                            opacity: _opacitiesForSecondMenu[0],
                            child: Icon(Icons.check),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            _changeSecondMenuIconOpacity(1);

                            _isWeeklyRepeat = true;
                            _isMonthlyRepeat = false;

                            _resetMonthlyChoiceIconOpacity();
                            _initDailyRepeatCardList();
                          },
                          title: Text("Weekly"),
                          leading: Opacity(
                            opacity: _opacitiesForSecondMenu[1],
                            child: Icon(Icons.check),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            _changeSecondMenuIconOpacity(2);

                            _isMonthlyRepeat = true;
                            _isWeeklyRepeat = false;

                            _changeMonthlyRepeatDateName();
                          },
                          title: Text("Monthly"),
                          leading: Opacity(
                            opacity: _opacitiesForSecondMenu[2],
                            child: Icon(Icons.check),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            _changeSecondMenuIconOpacity(3);

                            _isWeeklyRepeat = false;
                            _isMonthlyRepeat = false;

                            _resetMonthlyChoiceIconOpacity();
                          },
                          title: Text("Yearly"),
                          leading: Opacity(
                            opacity: _opacitiesForSecondMenu[3],
                            child: Icon(Icons.check),
                          ),
                        ),
                      ],
                    ),
                  ),
                  visible: _isVisible,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Visibility(
                  visible: _isVisible,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: <Widget>[
                        Text(
                          "REPEAT EVERY",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Stack(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 2.0),
                              child: ListTile(
                                leading: Icon(
                                  Icons.check,
                                  color: Colors.transparent,
                                ),
                                title: Text(
                                    "$_sRepeatTimeCount $_sRepeatTimeCount1"),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: 15.0,
                                  left:
                                      MediaQuery.of(context).size.width / 2.6),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 70.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.0),
                                          bottomLeft: Radius.circular(10.0)),
                                      border: Border.all(color: Colors.black),
                                    ),
                                    height: 30.0,
                                    child: FlatButton(
                                      child: Center(child: Icon(Icons.remove)),
                                      onPressed: () {
                                        setState(() {
                                          if (_iRepeatTimeCount > 1) {
                                            _iRepeatTimeCount--;
                                            _sRepeatTimeCount =
                                                _iRepeatTimeCount.toString();

                                            _changeRepeatCountTextToMultiple();
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: 70.0,
                                    transform: Matrix4.translationValues(
                                        -1.0, 0.0, 0.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10.0),
                                          bottomRight: Radius.circular(10.0)),
                                      border: Border.all(color: Colors.black),
                                    ),
                                    height: 30.0,
                                    child: FlatButton(
                                      child: Center(child: Icon(Icons.add)),
                                      onPressed: () {
                                        _iRepeatTimeCount++;
                                        setState(() {
                                          _sRepeatTimeCount =
                                              _iRepeatTimeCount.toString();

                                          _changeRepeatCountTextToMultiple();
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          child: Stack(
                            children: <Widget>[
                              Visibility(
                                child: Center(
                                    child: Text(
                                  "REPEAT ON",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                                visible: (_isWeeklyRepeat == false &&
                                        _isMonthlyRepeat == false)
                                    ? false
                                    : true,
                              ),
                              Visibility(
                                visible: _isWeeklyRepeat,
                                child: Container(
                                  padding: EdgeInsets.only(top: 15.0),
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        leading: Icon(
                                          Icons.check,
                                          color: Colors.transparent,
                                        ),
                                        title: Row(
                                          children: <Widget>[
                                            InkWell(
                                              child: _dailyChoiceCards[0],
                                              onTap: () {
                                                _changeDailyRepeatCardColor(0);
                                              },
                                            ),
                                            InkWell(
                                              child: _dailyChoiceCards[1],
                                              onTap: () {
                                                _changeDailyRepeatCardColor(1);
                                              },
                                            ),
                                            InkWell(
                                              child: _dailyChoiceCards[2],
                                              onTap: () {
                                                _changeDailyRepeatCardColor(2);
                                              },
                                            ),
                                            InkWell(
                                              child: _dailyChoiceCards[3],
                                              onTap: () {
                                                _changeDailyRepeatCardColor(3);
                                              },
                                            ),
                                            InkWell(
                                              child: _dailyChoiceCards[4],
                                              onTap: () {
                                                _changeDailyRepeatCardColor(4);
                                              },
                                            ),
                                            InkWell(
                                              child: _dailyChoiceCards[5],
                                              onTap: () {
                                                _changeDailyRepeatCardColor(5);
                                              },
                                            ),
                                            InkWell(
                                              child: _dailyChoiceCards[6],
                                              onTap: () {
                                                _changeDailyRepeatCardColor(6);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: _isMonthlyRepeat,
                                child: Container(
                                  padding: EdgeInsets.only(top: 15.0),
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        onTap: () {
                                          setState(() {
                                            _opacitiesForFourthMenu[1] = 0.0;
                                            _opacitiesForFourthMenu[0] = 1.0;
                                          });
                                        },
                                        leading: Opacity(
                                            child: Icon(Icons.check),
                                            opacity:
                                                _opacitiesForFourthMenu[0]),
                                        title: Text(
                                            "Day ${DateTime.now().day} of month"),
                                      ),
                                      ListTile(
                                        onTap: () {
                                          setState(() {
                                            _opacitiesForFourthMenu[1] = 1.0;
                                            _opacitiesForFourthMenu[0] = 0.0;
                                          });

                                          _changeMonthlyRepeatDateName();
                                        },
                                        leading: Opacity(
                                          child: Icon(Icons.check),
                                          opacity: _opacitiesForFourthMenu[1],
                                        ),
                                        title: Text(
                                            "Every 1st $_monthlyRepeatDateName"),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "ENDS",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              ListTile(
                                onTap: () {
                                  _changeEndsWidgetIconOpacity(0);

                                  setState(() {
                                    _endSecondChoiceText =
                                        "After a number of times";
                                    _isSecondChoiceButtonVisible = false;

                                    _endDay = null;
                                  });
                                },
                                leading: Opacity(
                                  child: Icon(Icons.check),
                                  opacity: _opacitiesForForFifthMenu[0],
                                ),
                                title: Text("Never"),
                              ),
                              ListTile(
                                onTap: () {
                                  _changeEndsWidgetIconOpacity(1);
                                  setState(() {
                                    _endSecondChoiceCount = 1;
                                    _endSecondChoiceMultiCountText = "time";
                                    _endSecondChoiceText =
                                        "After $_endSecondChoiceCount $_endSecondChoiceMultiCountText";
                                    _isSecondChoiceButtonVisible = true;

                                    _endDay = null;
                                  });
                                },
                                leading: Opacity(
                                  child: Icon(Icons.check),
                                  opacity: _opacitiesForForFifthMenu[1],
                                ),
                                title: Row(
                                  children: <Widget>[
                                    Text("$_endSecondChoiceText"),
                                    Visibility(
                                      visible: _isSecondChoiceButtonVisible,
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                40),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: 70.0,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10.0),
                                                    bottomLeft:
                                                        Radius.circular(10.0)),
                                                border: Border.all(
                                                    color: Colors.black),
                                              ),
                                              height: 30.0,
                                              child: FlatButton(
                                                child: Center(
                                                    child: Icon(Icons.remove)),
                                                onPressed: () {
                                                  _onIncreaseOrDecreaseInEndsChoice(
                                                      false);
                                                },
                                              ),
                                            ),
                                            Container(
                                              width: 70.0,
                                              transform:
                                                  Matrix4.translationValues(
                                                      -1.0, 0.0, 0.0),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10.0),
                                                    bottomRight:
                                                        Radius.circular(10.0)),
                                                border: Border.all(
                                                    color: Colors.black),
                                              ),
                                              height: 30.0,
                                              child: FlatButton(
                                                child: Center(
                                                    child: Icon(Icons.add)),
                                                onPressed: () {
                                                  _onIncreaseOrDecreaseInEndsChoice(
                                                      true);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ListTile(
                                onTap: () {
                                  _changeEndsWidgetIconOpacity(2);

                                  setState(() {
                                    _endSecondChoiceText =
                                        "After a number of times";
                                    _isSecondChoiceButtonVisible = false;

                                    _endDay = DateFormat('dd MMMM yyyy')
                                        .format(_initTimeForEndDay);

                                    showRoundedDatePicker(
                                      context: context,
                                      theme: ThemeData.dark(),
                                      initialDate: _initTimeForEndDay,
                                      firstDate: DateTime.now()
                                          .subtract(Duration(days: 1)),
                                      lastDate: DateTime(2100),
                                    ).then((value) {
                                      setState(() {
                                        _endDay = DateFormat('dd MMMM yyyy')
                                            .format(value);
                                        _initTimeForEndDay = value;
                                      });
                                    });
                                  });
                                },
                                leading: Opacity(
                                  child: Icon(Icons.check),
                                  opacity: _opacitiesForForFifthMenu[2],
                                ),
                                title: Text("On a date"),
                                trailing: Visibility(
                                  child: Text("$_endDay"),
                                  visible: _endDay == null ? false : true,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Card dùng cho phần pick thứ trong daily repeat
  Widget _dailyRepeatChoiceCard(String cardContent, double transitionX,
      Color backgroundColor, Color textColor, BorderRadius boxRadius) {
    return Container(
        transform: Matrix4.translationValues(transitionX, 0.0, 0.0),
        padding:
            EdgeInsets.only(top: 5.0, bottom: 5.0, left: 15.0, right: 15.0),
        decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: Colors.black),
            borderRadius: boxRadius),
        child: Text(
          "$cardContent",
          style: TextStyle(color: textColor),
        ));
  }

  // Hàm để khởi tạo các card cho phần pick thứ trong daily repeat
  void _initDailyRepeatCardList() {
    _dailyChoiceCards = [];
    _selectedIndex = [];

    double transitionX = 0;

    for (int i = 0; i < _dailyChoiceCardContents.length; i++) {
      transitionX--;
      if (i == 0) {
        _dailyChoiceCards.add(_dailyRepeatChoiceCard(
          _dailyChoiceCardContents[i],
          transitionX,
          Colors.white,
          Colors.black,
          BorderRadius.only(
              topLeft: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0)),
        ));
      } else if (i == _dailyChoiceCardContents.length - 1) {
        _dailyChoiceCards.add(_dailyRepeatChoiceCard(
          _dailyChoiceCardContents[i],
          transitionX,
          Colors.white,
          Colors.black,
          BorderRadius.only(
              topRight: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0)),
        ));
      } else {
        _dailyChoiceCards.add(_dailyRepeatChoiceCard(
          _dailyChoiceCardContents[i],
          transitionX,
          Colors.white,
          Colors.black,
          BorderRadius.all(Radius.circular(0.0)),
        ));
      }
    }
  }

  // Hàm để thay đổi màu của card dc chọn (tick hoặc untick)
  void _changeDailyRepeatCardColor(int selectedIndex) {
    setState(() {
      if (_selectedIndex.toSet().toList().contains(selectedIndex) == false) {
        _selectedIndex.add(selectedIndex);
        if (selectedIndex == 0) {
          _dailyChoiceCards[selectedIndex] = _dailyRepeatChoiceCard(
              _dailyChoiceCardContents[selectedIndex],
              selectedIndex == 0 ? 0.0 : -selectedIndex,
              Colors.black,
              Colors.white,
              BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              ));
        } else if (selectedIndex == _dailyChoiceCardContents.length - 1) {
          _dailyChoiceCards[selectedIndex] = _dailyRepeatChoiceCard(
              _dailyChoiceCardContents[selectedIndex],
              selectedIndex == 0 ? 0.0 : -selectedIndex.toDouble(),
              Colors.black,
              Colors.white,
              BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ));
        } else {
          _dailyChoiceCards[selectedIndex] = _dailyRepeatChoiceCard(
              _dailyChoiceCardContents[selectedIndex],
              selectedIndex == 0 ? 0.0 : -selectedIndex.toDouble(),
              Colors.black,
              Colors.white,
              BorderRadius.all(Radius.circular(0.0)));
        }
      } else {
        if (selectedIndex == 0) {
          _dailyChoiceCards[selectedIndex] = _dailyRepeatChoiceCard(
              _dailyChoiceCardContents[selectedIndex],
              selectedIndex == 0 ? 0.0 : -selectedIndex,
              Colors.white,
              Colors.black,
              BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              ));
        } else if (selectedIndex == _dailyChoiceCardContents.length - 1) {
          _dailyChoiceCards[selectedIndex] = _dailyRepeatChoiceCard(
              _dailyChoiceCardContents[selectedIndex],
              selectedIndex == 0 ? 0.0 : -selectedIndex.toDouble(),
              Colors.white,
              Colors.black,
              BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ));
        } else {
          _dailyChoiceCards[selectedIndex] = _dailyRepeatChoiceCard(
              _dailyChoiceCardContents[selectedIndex],
              selectedIndex == 0 ? 0.0 : -selectedIndex.toDouble(),
              Colors.white,
              Colors.black,
              BorderRadius.all(Radius.circular(0.0)));
        }

        _selectedIndex.remove(selectedIndex);
      }
    });
  }

  // Hàm để reset các giá trị dùng cho phần Frequency khi người dùng ấn off repeat
  void _resetFrequencyWidgetState() {
    setState(() {
      _iRepeatTimeCount = 1;
      _sRepeatTimeCount = _iRepeatTimeCount.toString();
      _sRepeatTimeCount1 = "day";

      _opacitiesForSecondMenu[0] = 1.0;
      _opacitiesForSecondMenu[_lastSelectedIndexInSecondMenu] =
          _lastSelectedIndexInSecondMenu != 0 ? 0.0 : 1.0;

      _changeSecondMenuIconOpacity(_lastSelectedIndexInSecondMenu);
      _lastSelectedIndexInSecondMenu = 0;
    });
  }

  // Hàm để thay đổi xuất hiện của icon phía trc lựa chọn trong Frequency
  void _changeSecondMenuIconOpacity(int selectedIndex) {
    setState(() {
      if (selectedIndex != _lastSelectedIndexInSecondMenu) {
        _opacitiesForSecondMenu[selectedIndex] = 1.0;
        _opacitiesForSecondMenu[_lastSelectedIndexInSecondMenu] = 0.0;

        _lastSelectedIndexInSecondMenu = selectedIndex;
        _iRepeatTimeCount = 1;

        _updateCountText(selectedIndex);
      }
    });
  }

  // Reset lại test hiển thị khi người dùng thay đổi lựa chọn trong Frequency
  void _updateCountText(int selectedIndex) {
    setState(() {
      switch (selectedIndex) {
        case 0:
          _sRepeatTimeCount = 1.toString();
          _sRepeatTimeCount1 = "day";
          break;
        case 1:
          _sRepeatTimeCount = 1.toString();
          _sRepeatTimeCount1 = "week";
          break;
        case 2:
          _sRepeatTimeCount = 1.toString();
          _sRepeatTimeCount1 = "month";
          break;
        case 3:
          _sRepeatTimeCount = 1.toString();
          _sRepeatTimeCount1 = "year";
          break;
      }
    });
  }

  // Hàm để thay đổi chữ sau số lượng thành mô tả số nhiều hay số ít
  void _changeRepeatCountTextToMultiple() {
    setState(() {
      switch (_lastSelectedIndexInSecondMenu) {
        case 0:
          _sRepeatTimeCount1 = _iRepeatTimeCount > 1 ? "days" : "day";
          break;
        case 1:
          _sRepeatTimeCount1 = _iRepeatTimeCount > 1 ? "weeks" : "week";
          break;
        case 2:
          _sRepeatTimeCount1 = _iRepeatTimeCount > 1 ? "months" : "month";
          break;
        case 3:
          _sRepeatTimeCount1 = _iRepeatTimeCount > 1 ? "years" : "year";
          break;
      }
    });
  }

  // Hàm để reset
  void _resetMonthlyChoiceIconOpacity() {
    setState(() {
      _opacitiesForFourthMenu[0] = 1.0;
      _opacitiesForFourthMenu[1] = 0.0;
    });
  }

  // Hàm để thay đổi opacity của widget dc chọn trong ENDS menu
  void _changeEndsWidgetIconOpacity(int selectedIndex) {
    setState(() {
      for (int i = 0; i < _opacitiesForForFifthMenu.length; i++) {
        _opacitiesForForFifthMenu[i] = i == selectedIndex ? 1.0 : 0.0;
      }
    });
  }

  // Hàm để cập nhật khi người dùng ấn nút tăng hoặc giảm trong phần ENDS
  void _onIncreaseOrDecreaseInEndsChoice(bool isIncrease) {
    if (isIncrease) {
      setState(() {
        _endSecondChoiceCount++;
        _endSecondChoiceMultiCountText = "times";

        _endSecondChoiceText =
            "After $_endSecondChoiceCount $_endSecondChoiceMultiCountText";
      });
    } else {
      setState(() {
        if (_endSecondChoiceCount > 1) {
          _endSecondChoiceCount--;
          _endSecondChoiceMultiCountText = "times";
          _endSecondChoiceText =
              "After $_endSecondChoiceCount $_endSecondChoiceMultiCountText";
        }
        if (_endSecondChoiceCount == 1) {
          _endSecondChoiceMultiCountText = "time";
          _endSecondChoiceText =
              "After $_endSecondChoiceCount $_endSecondChoiceMultiCountText";
        }
      });
    }
  }

  // Hàm để cập nhật ngày để nhắc nhở theo tháng trong monthly repeat
  void _changeMonthlyRepeatDateName() {
    setState(() {
      switch (DateTime.now().weekday) {
        case 1:
          _monthlyRepeatDateName = "Monday";
          break;
        case 2:
          _monthlyRepeatDateName = "Tuesday";
          break;
        case 3:
          _monthlyRepeatDateName = "Wednesday";
          break;
        case 4:
          _monthlyRepeatDateName = "Thursday";
          break;
        case 5:
          _monthlyRepeatDateName = "Friday";
          break;
        case 6:
          _monthlyRepeatDateName = "Saturday";
          break;
        default:
          _monthlyRepeatDateName = "Sunday";
          break;
      }
    });
  }
}
