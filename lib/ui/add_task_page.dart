import 'package:flutter/material.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
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
  double _opacity = 0.0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _backToMainScreen();
      },
      child: Scaffold(
        backgroundColor: Color(0xFFFAF3F0),
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
                            leading: Icon(Icons.alarm), //list icon
                            title: Text("Schedule"),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            onTap: onSchedulePress,
                          ),
                        ),
                        Visibility(
                          visible: _visibilities[1],
                          child: ListTile(
                            leading: Icon(Icons.assignment), //list icon
                            title: Text("Choose List"),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            onTap: _onListPress,
                          ),
                        ),
                        Visibility(
                          visible: _visibilities[2],
                          child: ListTile(
                            leading: Icon(Icons.notifications), //list icon
                            title: Text("Reminder"),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              FocusScope.of(context).unfocus();
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

    _choicesList.forEach((item) {
      _choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          labelStyle: TextStyle(
              color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          backgroundColor: Colors.grey.shade300,
          selectedColor: Colors.orange.shade200,
          selected: _selectedChoice == item,
          onSelected: (selected) {
            setState(() {
              _selectedChoice = item;

              _checkChoseItem(item);
            });
          },
        ),
      ));
    });
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
                  padding: EdgeInsets.all(35),
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
                    Container(
                      height: 60,
                      child: Center(
                        child: Text("Đồ án 1"),
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

  void onSchedulePress() {
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
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      leading: Opacity(
                        child: Icon(Icons.check),
                        opacity: _opacity,
                      ),
                      title: Text("Today"),
                      //trailing: Text(DateFormat.yMMMMEEEEd().format(new DateTime.now())),
                      onTap: () {
                        setState(() {
                          _opacity = 1;
                        });
                      },
                    ),
                    ListTile(
                      leading: Opacity(
                        child: Icon(Icons.check),
                        opacity: 0.0,
                      ),
                      title: Text("Tomorrow"),
                      //trailing: Text(DateFormat.yMMMMEEEEd().format(new DateTime.now())),
                      onTap: () {
                        setState(() {});
                      },
                    ),
                    ListTile(
                      leading: null,
                      title: Text("Later"),
                      //trailing: Text(DateFormat.yMMMMEEEEd().format(new DateTime.now())),
                      onTap: () {
                        setState(() {});
                      },
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
}