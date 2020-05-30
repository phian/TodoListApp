import 'dart:io';

import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todoapp/data/data.dart';
import 'package:todoapp/ui/about_screen.dart';
import 'package:todoapp/ui/account_screen.dart';
import 'package:todoapp/ui/add_task_screen.dart';
import 'package:todoapp/ui/goals_screen.dart';
import 'package:todoapp/ui/help_screen.dart';
import 'package:todoapp/ui/preference_screen.dart';
import 'package:todoapp/ui/search_screen.dart';
import 'package:todoapp/ui/tasks_list_screen.dart';
import 'package:todoapp/ui/tasks_screen.dart';

import 'getting_started_screen.dart';

class HomeScreen extends StatefulWidget {
  final Data data;
  bool isFirstTime = false;

  HomeScreen({this.data}) {
    if (this.data.isBack == false) {
      this.isFirstTime = true;
    }
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
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
  double _transitionXForMenuScreen =
      0.0; // Biến để dời menu screen qua lại khi ng dùng chọn menu option

// Phần của setting screen
// List để chứa các screen trong setting menu và biến để chạy animation cho các screen này
  List<Widget> _settingMenuScreens = [
    PreferenceScreen(),
    SearchScreen(),
    HelpScreen(),
    AboutScreen(),
    GettingStartedScreen(),
    AccountScreen()
  ];

  List<IconData> _settingMenuIcons = [
    Icons.brightness_7,
    Icons.search,
    Icons.help_outline,
    Icons.info_outline,
    Icons.explore,
    Icons.account_circle
  ];
  List<String> _settingMenuTexts = [
    "Preference",
    "Search",
    "Help",
    "About",
    "Getting Started",
    "Account"
  ];
  List<Widget> _settingMenuWidgets = [];

  AnimationController _controllerForDOITMenu;
  Animation<double> _animationForDOITMenu;
  int _durationForDOITMenu;
  static double _beginForDOITMenu, _endForDOITMenu;

  double _settingScreenOpacity = 1.0;
  double _mainScreenOpacity = 1.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _blur = 0.0;
    _initAnimationForDOITSettingMenu();
  }

  // Hàm để check nếu ng dùng quay về main screen từ các screen trong setting
  void _checkIsBack() {
    // check xem có phải ng dùng vừa từ screen khác trong setting screen menu về hay không?
    if (widget.data.isBack) {
      _settingsScreenIndex = 3;
      _changePage(_settingsScreenIndex);

      _lastFocusedIconIndex = widget.data.lastFocusedScreen;

      widget.data.isBack = false;
    }
  }

  // check nếu app mới khởi động lần đầu
  void _checkFirstTime() {
    if (widget.isFirstTime) {
      _lastFocusedIconIndex = 0;
      _settingsScreenIndex = -1;

      _transitionXForMenuScreen = MediaQuery.of(context).size.width;

      widget.isFirstTime = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    _checkIsBack();
    _checkFirstTime();
    _initSettingMenuWidget(); // Gọi hàm để khởi tạo

    return AnimatedOpacity(
      opacity: _mainScreenOpacity,
      duration: Duration(milliseconds: 300),
      child: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            if (_transitionXForMainScreen == 0.0) {
              _onWillPop();
            } else {
              setState(() {
                _transitionXForMainScreen = 0.0;
                _transitionXForMenuScreen = MediaQuery.of(context).size.width;

                _marginTop = 0.0;
                _marginBottom = 0.0;

                _changePage(_lastFocusedIconIndex);
              });
            }
          },
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
                        top: MediaQuery.of(context).size.height / 3,
                        left: MediaQuery.of(context).size.width -
                            (MediaQuery.of(context).size.width * 0.75) +
                            10.0),
                    transform: Matrix4.translationValues(
                        _transitionXForMenuScreen, 0.0, 0.0),
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 100),
                      opacity: _settingScreenOpacity,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: MediaQuery.of(context).size.height / 3,
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.7),
                          child: Transform.translate(
                            offset: Offset(_animationForDOITMenu.value, 0.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Text("DOIT",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                          fontSize: 35.0,
                                          fontFamily: 'AbhayaLibre')),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                InkWell(
                                  onTap: () async {
                                    _transitionXForMenuScreen =
                                        -(MediaQuery.of(context).size.width -
                                            (MediaQuery.of(context).size.width -
                                                (MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.75) +
                                                10.0));

                                    Navigator.pushReplacement(
                                        context,
                                        PageTransition(
                                            type:
                                                PageTransitionType.rightToLeft,
                                            child: PreferenceScreen(
                                              lastFocusedScreen:
                                                  _lastFocusedIconIndex,
                                            ),
                                            duration:
                                                Duration(milliseconds: 300)));

                                    _changeFocusMenuWidgetColor(0, false);
                                  },
                                  onTapCancel: () {
                                    _changeFocusMenuWidgetColor(0, false);
                                  },
                                  onHighlightChanged: (isChanged) {
                                    if (isChanged) {
                                      _changeFocusMenuWidgetColor(0, true);
                                    }
                                  },
                                  child: _settingMenuWidgets[0],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                InkWell(
                                  onTap: () async {
                                    _transitionXForMenuScreen =
                                        -(MediaQuery.of(context).size.width -
                                            (MediaQuery.of(context).size.width -
                                                (MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.75) +
                                                10.0));

                                    Navigator.pushReplacement(
                                        context,
                                        PageTransition(
                                            type:
                                                PageTransitionType.rightToLeft,
                                            child: SearchScreen(
                                              lastFocusedScreen:
                                                  _lastFocusedIconIndex,
                                            ),
                                            duration:
                                                Duration(milliseconds: 300)));

                                    _changeFocusMenuWidgetColor(1, false);
                                  },
                                  onTapCancel: () {
                                    _changeFocusMenuWidgetColor(1, false);
                                  },
                                  onHighlightChanged: (isChanged) {
                                    if (isChanged) {
                                      _changeFocusMenuWidgetColor(1, true);
                                    }
                                  },
                                  child: _settingMenuWidgets[1],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                InkWell(
                                  onTap: () async {
                                    _transitionXForMenuScreen =
                                        -(MediaQuery.of(context).size.width -
                                            (MediaQuery.of(context).size.width -
                                                (MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.75) +
                                                10.0));

                                    Navigator.pushReplacement(
                                        context,
                                        PageTransition(
                                            type:
                                                PageTransitionType.rightToLeft,
                                            child: HelpScreen(
                                              lastFocusedScreen:
                                                  _lastFocusedIconIndex,
                                            ),
                                            duration:
                                                Duration(milliseconds: 300)));

                                    _changeFocusMenuWidgetColor(2, false);
                                  },
                                  onTapCancel: () {
                                    _changeFocusMenuWidgetColor(2, false);
                                  },
                                  onHighlightChanged: (isChanged) {
                                    if (isChanged) {
                                      _changeFocusMenuWidgetColor(2, true);
                                    }
                                  },
                                  child: _settingMenuWidgets[2],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                InkWell(
                                  onTap: () async {
                                    _transitionXForMenuScreen =
                                        -(MediaQuery.of(context).size.width -
                                            (MediaQuery.of(context).size.width -
                                                (MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.75) +
                                                10.0));

                                    Navigator.pushReplacement(
                                        context,
                                        PageTransition(
                                            type:
                                                PageTransitionType.rightToLeft,
                                            child: AboutScreen(
                                              lastFocusedScreen:
                                                  _lastFocusedIconIndex,
                                            ),
                                            duration:
                                                Duration(milliseconds: 300)));

                                    _changeFocusMenuWidgetColor(3, false);
                                  },
                                  onTapCancel: () {
                                    _changeFocusMenuWidgetColor(3, false);
                                  },
                                  onHighlightChanged: (isChanged) {
                                    if (isChanged) {
                                      _changeFocusMenuWidgetColor(3, true);
                                    }
                                  },
                                  child: _settingMenuWidgets[3],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                InkWell(
                                  onTap: () async {
                                    _transitionXForMainScreen =
                                        -(MediaQuery.of(context).size.width +
                                            (MediaQuery.of(context).size.width *
                                                0.75));

                                    _settingScreenOpacity = 0.0;

                                    Future.delayed(Duration(milliseconds: 300),
                                        () {
                                      setState(() {
                                        _mainScreenOpacity = 0.0;
                                      });
                                      Navigator.pushReplacement(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation1,
                                                  animation2) =>
                                              GettingStartedScreen(
                                            lastFocusedScreen:
                                                _lastFocusedIconIndex,
                                          ),
                                        ),
                                      );
                                    });

                                    _changeFocusMenuWidgetColor(4, false);
                                  },
                                  onTapCancel: () {
                                    _changeFocusMenuWidgetColor(4, false);
                                  },
                                  onHighlightChanged: (isChanged) {
                                    if (isChanged) {
                                      _changeFocusMenuWidgetColor(4, true);
                                    }
                                  },
                                  child: _settingMenuWidgets[4],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                InkWell(
                                  onTap: () async {
                                    _transitionXForMenuScreen =
                                        -(MediaQuery.of(context).size.width -
                                            (MediaQuery.of(context).size.width -
                                                (MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.75) +
                                                10.0));

                                    Navigator.pushReplacement(
                                        context,
                                        PageTransition(
                                            type:
                                                PageTransitionType.rightToLeft,
                                            child: AccountScreen(
                                              lastFocusedScreen:
                                                  _lastFocusedIconIndex,
                                            ),
                                            duration:
                                                Duration(milliseconds: 300)));

                                    _changeFocusMenuWidgetColor(5, false);
                                  },
                                  onTapCancel: () {
                                    _changeFocusMenuWidgetColor(5, false);
                                  },
                                  onHighlightChanged: (isChanged) {
                                    if (isChanged) {
                                      _changeFocusMenuWidgetColor(5, true);
                                    }
                                  },
                                  child: _settingMenuWidgets[5],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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
                  margin:
                      EdgeInsets.only(top: _marginTop, bottom: _marginBottom),
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
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
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
                    icon:
                        Icon(CupertinoIcons.tags, size: 30, color: Colors.red),
                    activeIcon: Icon(CupertinoIcons.tags,
                        size: 30, color: Colors.indigo),
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
                    icon:
                        Icon(CupertinoIcons.book, size: 30, color: Colors.teal),
                    activeIcon: Icon(CupertinoIcons.book,
                        size: 30, color: Colors.indigo),
                    title: Text(
                      "Tasks List",
                      style: TextStyle(
                        color: Colors.teal.shade900,
                      ),
                    )),
                BubbleBottomBarItem(
                    backgroundColor: Colors.green,
                    icon: Icon(CupertinoIcons.settings,
                        size: 30, color: Colors.cyan),
                    activeIcon: Icon(CupertinoIcons.settings,
                        size: 30, color: Colors.indigo),
                    title: Text(
                      "Settings",
                      style: TextStyle(color: Colors.green.shade900),
                    ))
              ],
            ),
          ),
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

        _transitionXForMainScreen = -(MediaQuery.of(context).size.width * 0.75);
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

  // Hàm để khởi tạo các widgets cho setting menu
  void _initSettingMenuWidget() {
    for (int i = 0; i < 6; i++) {
      _settingMenuWidgets.add(_settingsMenuWidget(_settingMenuIcons[i],
          _settingMenuTexts[i], Colors.black, Colors.black));
    }
  }

  // Hàm để reset màu của icon và text của menu widget dc chọn
  void _changeFocusMenuWidgetColor(int focusedIndex, bool isFocused) {
    if (isFocused)
      setState(() {
        _settingMenuWidgets[focusedIndex] = _settingsMenuWidget(
            _settingMenuIcons[focusedIndex],
            _settingMenuTexts[focusedIndex],
            Colors.grey,
            Colors.grey);
      });
    else
      setState(() {
        _settingMenuWidgets[focusedIndex] = _settingsMenuWidget(
            _settingMenuIcons[focusedIndex],
            _settingMenuTexts[focusedIndex],
            Colors.black,
            Colors.black);
      });
  }

  // Widget để hiển thị trong setting menu
  Widget _settingsMenuWidget(
      IconData icon, String menuText, Color iconColor, Color textColor) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: iconColor,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              "$menuText",
              style: TextStyle(fontSize: 20.0, fontFamily: 'AbhayaLibre'),
            ),
          ),
        ],
      ),
    );
  }

  // Hàm để khởi tạo animtion cho DOIT menu
  void _initAnimationForDOITSettingMenu() {
    // Animation cho DOIT menu
    _durationForDOITMenu = 400;
    _controllerForDOITMenu = AnimationController(
        vsync: this, duration: Duration(milliseconds: _durationForDOITMenu));

    _beginForDOITMenu = -150.0;
    _endForDOITMenu = 0.0;
    _animationForDOITMenu =
        Tween<double>(begin: _beginForDOITMenu, end: _endForDOITMenu)
            .animate(_controllerForDOITMenu)
              ..addListener(() {
                setState(() {});
              });

    _controllerForDOITMenu.forward();
  }
}
