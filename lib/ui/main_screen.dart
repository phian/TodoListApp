import 'dart:io';

import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/data/data.dart';
import 'package:todoapp/ui/add_task_screen.dart';
import 'package:todoapp/ui/goals_screen.dart';
import 'package:todoapp/ui/settings_screen.dart';
import 'package:todoapp/ui/tasks_list_screen.dart';
import 'package:todoapp/ui/tasks_screen.dart';

GlobalKey _bottomMenuKey = GlobalKey();
// bool _isBack, _isFirstTime;
// int _lastFocusedScreen;

class HomeScreen extends StatefulWidget {
  final Data data;
  // final bool isBack;
  // final int lastFocusedScreen;
  bool isFirstTime = false;

  HomeScreen({this.data}) {
    // this.isBack = isBack;
    // this.lastFocusedScreen = lastFocusedScreen;

    if (this.data.isBack == false) {
      this.isFirstTime = true;
    }
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  List<Widget> _screenList = [
    TasksScreen(),
    GoalsScreen(),
    TasksListScreen(),
  ];
  int _lastFocusedIconIndex =
      0; // biến để check xem Icon thứ mấy dc focus trc đó
  int _settingsScreenIndex =
      -1; // Biến để check nếu ng dùng mở màn hình settings thì sẽ cho app tiếp tục focus vào màn hình trc đó

  double _marginTop =
      0.0; // Hai biến để thay đổi margin khi ng dùng chọn màn hình settings
  double _marginBottom = 0.0;
  double _transitionXForMainScreen =
      0.0; // Biến để dời screen hiện tại qua bên trái màn hình
  double _blur; // Biến để thay đổi độ đậm của shadowbox
  double
      _transitionXForMenuScreen = 0.0; // Biến để dời menu screen qua lại khi ng dùng chọn menu option

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _blur = 0.0;

    _checkIsBack();
  }

  // Hàm để check nếu ng dùng quay về main screen từ các screen trong setting
  void _checkIsBack() {
    // check xem có phải ng dùng vừa từ screen khác trong setting screen menu về hay không?
    if (widget.data.isBack) {
      _settingsScreenIndex = 3;
      _changePage(_settingsScreenIndex);

      _lastFocusedIconIndex = widget.data.lastFocusedScreen;
    }
  }

  // check nếu app mới khởi động lần đầu
  void _checkFirstTime() {
    if (widget.isFirstTime) {
      _lastFocusedIconIndex = 0;
      _settingsScreenIndex = -1;

      widget.isFirstTime = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    _checkFirstTime();

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Stack(
          overflow: Overflow.clip,
          children: <Widget>[
            Container(
              color: Color(0xFFFAF3F0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width - 120.0,
                    left: MediaQuery.of(context).size.width / 2 - 120.0),
                transform: Matrix4.translationValues(
                    _transitionXForMenuScreen, 0.0, 0.0),
                child: SettingsScreen(
                  lastFocusScreen: _lastFocusedIconIndex,
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: _blur,
                  ),
                ],
              ),
              transform: Matrix4.translationValues(
                  _transitionXForMainScreen, 0.0, 0.0),
              margin: EdgeInsets.only(top: _marginTop, bottom: _marginBottom),
              child: InkWell(
                child: _screenList[_lastFocusedIconIndex],
                onTap: () {
                  setState(() {
                    _changePage(
                        _lastFocusedIconIndex); // Quay lại màn hình trc đó ng dùng focus

                    _transitionXForMainScreen = 0.0;
                    _transitionXForMenuScreen =
                        MediaQuery.of(context).size.width;

                    _marginTop = 0.0;
                    _marginBottom = 0.0;

                    _blur = 0.0;
                  });
                },
              ),
            ),
          ],
        ),
        floatingActionButton: Container(
          width: 55.0,
          height: 55.0,
          child: FloatingActionButton(
            elevation: 2.0,
            tooltip: 'Add new task',
            child: Icon(Icons.add),
            onPressed: () {
              print('Tapped');

              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddTaskScreen(),
              ));
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: BubbleBottomBar(
          backgroundColor: Color(0xFFFAF3F0),
          opacity: .2,
          currentIndex: _settingsScreenIndex == -1
              ? _lastFocusedIconIndex
              : _settingsScreenIndex,
          onTap: _changePage,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          elevation: 8,
          //new
          fabLocation: BubbleBottomBarFabLocation.end,
          //new
          hasNotch: true,
          //new, gives a cute ink effect
          hasInk: true,
          //optional, uses theme color if not specified
          inkColor: Colors.black12,
          items: <BubbleBottomBarItem>[
            BubbleBottomBarItem(
                backgroundColor: Colors.redAccent,
                icon: Icon(CupertinoIcons.tags, size: 30, color: Colors.red),
                activeIcon:
                    Icon(CupertinoIcons.tags, size: 30, color: Colors.indigo),
                title: Text(
                  "Recent",
                  style: TextStyle(color: Colors.red.shade900),
                )),
            BubbleBottomBarItem(
                backgroundColor: Colors.deepPurple,
                icon: Icon(CupertinoIcons.check_mark_circled_solid,
                    size: 30, color: Colors.purple),
                activeIcon: Icon(CupertinoIcons.check_mark_circled_solid,
                    size: 30, color: Colors.indigo),
                title: Text(
                  "Goals",
                  style: TextStyle(color: Colors.deepPurple.shade900),
                )),
            BubbleBottomBarItem(
                backgroundColor: Colors.teal,
                icon: Icon(CupertinoIcons.book, size: 30, color: Colors.teal),
                activeIcon:
                    Icon(CupertinoIcons.book, size: 30, color: Colors.indigo),
                title: Text(
                  "Tasks List",
                  style: TextStyle(
                    color: Colors.teal.shade900,
                  ),
                )),
            BubbleBottomBarItem(
                backgroundColor: Colors.green,
                icon:
                    Icon(CupertinoIcons.settings, size: 30, color: Colors.cyan),
                activeIcon: Icon(CupertinoIcons.settings,
                    size: 30, color: Colors.indigo),
                title: Text(
                  "Settings",
                  style: TextStyle(color: Colors.green.shade900),
                ))
          ],
        ),
      ),
    );
  }

  // Hàm để cập nhật vị trí tab hiện tại của bottom bar
  void _changePage(int value) {
    setState(() {
      if (value != 3) {
        _lastFocusedIconIndex = value;
        _settingsScreenIndex = -1;

        _transitionXForMainScreen = 0.0;
        _transitionXForMenuScreen = MediaQuery.of(context).size.width;

        _marginTop = 0.0;
        _marginBottom = 0.0;

        _blur = 0.0;
      } else {
        _settingsScreenIndex = 3;

        _transitionXForMainScreen = -350.0;
        _marginTop = 60;
        _marginBottom = 60;

        _transitionXForMenuScreen = 0.0;

        _blur = 2.5;
      }
    });
  }

  // Hàm để detect xem ng dùng có ấn back button ko để đưa ra thông báo
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Alert!'),
            content: Text('Are you sure you want to exit app?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => exit(0),
                child: Text('Yes'),
              ),
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
            ],
          ),
        )) ??
        false;
  }
}
