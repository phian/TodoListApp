import 'dart:io';

import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:todoapp/animation/fade_route_builder.dart';
import 'package:todoapp/data/data.dart';
import 'package:todoapp/ui/about_screen.dart';
import 'package:todoapp/ui/account_screen.dart';
import 'package:todoapp/ui/goals_screen.dart';
import 'package:todoapp/ui/help_screen.dart';
import 'package:todoapp/ui/preference_screen.dart';
import 'package:todoapp/ui/search_screen.dart';
import 'package:todoapp/ui/tasks_list_screen.dart';
import 'package:todoapp/ui/tasks_screen.dart';
import 'package:todoapp/ui_variables/finished_list.dart';

import 'add_task_page.dart';
import 'getting_started_screen.dart';

class HomeScreen extends StatefulWidget {
  final Data data;
  bool isFirstTime = false;

  HomeScreen({this.data}) {
    if (this.data.isBack == false &&
        this.data.isBackFromAddTaskScreen == false) {
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
  // biến để check xem Icon thứ mấy dc focus trc đó
  int _lastFocusedIconIndex = 0;
  // Biến để check nếu ng dùng mở màn hình settings thì sẽ cho app tiếp tục focus vào màn hình trc đó
  int _settingsScreenIndex = -1;

// Hai biến để thay đổi margin khi ng dùng chọn màn hình settings
  double _marginTop = 0.0;
  double _marginBottom = 0.0;
  // Biến để dời screen hiện tại qua bên trái màn hình
  double _transitionXForMainScreen = 0.0;
  // Biến để thay đổi độ đậm của shadowbox của main screen khi ng dùng ấn chọn setting
  double _blur;
  // Biến để dời menu screen qua lại khi ng dùng chọn menu option
  double _transitionXForMenuScreen = 0.0;

// Phần của setting screen
  List<String> _settingMenuIcons = [
    "images/preference.png",
    "images/search.png",
    "images/help.png",
    "images/about.png",
    "images/getting_started.png",
    "images/account.png",
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

  // Animation chuyển page cho FAB
  final Duration animationDuration = Duration(milliseconds: 200);
  final Duration delay = Duration(milliseconds: 200);

  GlobalKey rectGetterKey = RectGetter.createGlobalKey();
  Rect rect;

  // Biến để khi ng dùng ấn qua setting menu thì sẽ disable các widget của main screen
  bool _mainScreenAbsorting = false;

  @override
  void initState() {
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
    if (widget.data.isBackFromAddTaskScreen) {
      if (widget.data.settingScreenIndex == -1) {
        _lastFocusedIconIndex = widget.data.lastFocusedScreen;
        _settingsScreenIndex = -1;

        _changePage(_lastFocusedIconIndex);

        widget.data.isBackFromAddTaskScreen = false;
      } else {
        _lastFocusedIconIndex = widget.data.lastFocusedScreen;
        _settingsScreenIndex = 3;

        _changePage(_settingsScreenIndex);

        widget.data.isBackFromAddTaskScreen = false;
      }
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
          // apkcombo.com/vi-vn/how-to-install/
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
          child: Stack(
            children: <Widget>[
              Scaffold(
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
                                offset:
                                    Offset(_animationForDOITMenu.value, 0.0),
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
                                            -(MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                (MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    (MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.75) +
                                                    10.0));

                                        Navigator.pushReplacement(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType
                                                    .rightToLeft,
                                                child: PreferenceScreen(
                                                  lastFocusedScreen:
                                                      _lastFocusedIconIndex,
                                                ),
                                                duration: Duration(
                                                    milliseconds: 300)));

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
                                            -(MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                (MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    (MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.75) +
                                                    10.0));

                                        Navigator.pushReplacement(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType
                                                    .rightToLeft,
                                                child: SearchScreen(
                                                  lastFocusedScreen:
                                                      _lastFocusedIconIndex,
                                                ),
                                                duration: Duration(
                                                    milliseconds: 300)));

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
                                            -(MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                (MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    (MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.75) +
                                                    10.0));

                                        Navigator.pushReplacement(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType
                                                    .rightToLeft,
                                                child: HelpScreen(
                                                  lastFocusedScreen:
                                                      _lastFocusedIconIndex,
                                                ),
                                                duration: Duration(
                                                    milliseconds: 300)));

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
                                            -(MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                (MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    (MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.75) +
                                                    10.0));

                                        Navigator.pushReplacement(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType
                                                    .rightToLeft,
                                                child: AboutScreen(
                                                  lastFocusedScreen:
                                                      _lastFocusedIconIndex,
                                                ),
                                                duration: Duration(
                                                    milliseconds: 300)));

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
                                            -(MediaQuery.of(context)
                                                    .size
                                                    .width +
                                                (MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.75));

                                        _settingScreenOpacity = 0.0;

                                        Future.delayed(
                                            Duration(milliseconds: 300), () {
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
                                            -(MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                (MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    (MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.75) +
                                                    10.0));

                                        Navigator.pushReplacement(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType
                                                    .rightToLeft,
                                                child: AccountScreen(
                                                  lastFocusedScreen:
                                                      _lastFocusedIconIndex,
                                                ),
                                                duration: Duration(
                                                    milliseconds: 300)));

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
                      margin: EdgeInsets.only(
                          top: _marginTop, bottom: _marginBottom),
                      child: InkWell(
                        child: AbsorbPointer(
                          child: _screenList[_lastFocusedIconIndex],
                          absorbing: _mainScreenAbsorting,
                        ),
                        onTap: () {
                          setState(() {
                            // Quay lại màn hình trc đó ng dùng focus
                            _changePage(_lastFocusedIconIndex);

                            _transitionXForMainScreen = 0.0;
                            _transitionXForMenuScreen =
                                MediaQuery.of(context).size.width;

                            _marginTop = 0.0;
                            _marginBottom = 0.0;

                            _blur = 0.0;

                            _mainScreenAbsorting = false;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                floatingActionButton: RectGetter(
                  key: rectGetterKey,
                  child: Container(
                    width: 55.0,
                    height: 55.0,
                    child: FloatingActionButton(
                      backgroundColor: Color(0xFF425195),
                      elevation: 2.0,
                      child: Icon(Icons.add),
                      onPressed: _onTap,
                    ),
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
                        backgroundColor: Color(0xAA425195),
                        icon: Image.asset(
                          "images/home.png",
                          color: Colors.grey,
                          width: 30.0,
                          height: 30.0,
                        ),
                        activeIcon: Image.asset(
                          "images/home.png",
                          color: Color(0xFF425195),
                          width: 30.0,
                          height: 30.0,
                        ),
                        title: Text(
                          "Home",
                          style: TextStyle(color: Color(0xFF425195)),
                        )),
                    BubbleBottomBarItem(
                        backgroundColor: Color(0xAA425195),
                        icon: Image.asset(
                          "images/done_tasks.png",
                          color: Colors.grey,
                          width: 30.0,
                          height: 30.0,
                        ),
                        activeIcon: Image.asset(
                          "images/done_tasks.png",
                          color: Color(0xFF425195),
                          width: 30.0,
                          height: 30.0,
                        ),
                        title: Text(
                          "Done",
                          style: TextStyle(color: Color(0xFF425195)),
                        )),
                    BubbleBottomBarItem(
                        backgroundColor: Color(0xAA425195),
                        icon: Image.asset(
                          "images/tasks.png",
                          color: Colors.grey,
                          width: 30.0,
                          height: 30.0,
                        ),
                        activeIcon: Image.asset(
                          "images/tasks.png",
                          color: Color(0xFF425195),
                          width: 30.0,
                          height: 30.0,
                        ),
                        title: Text(
                          "Task Lists",
                          style: TextStyle(
                            color: Color(0xFF425195),
                          ),
                        )),
                    BubbleBottomBarItem(
                        backgroundColor: Color(0xAA425195),
                        icon: Image.asset(
                          "images/setting.png",
                          color: Colors.grey,
                          width: 30.0,
                          height: 30.0,
                        ),
                        activeIcon: Image.asset(
                          "images/setting.png",
                          color: Color(0xFF425195),
                          width: 30.0,
                          height: 30.0,
                        ),
                        title: Text(
                          "Settings",
                          style: TextStyle(
                            color: Color(0xFF425195),
                          ),
                        ))
                  ],
                ),
              ),
              _ripple(),
            ],
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

        setState(() {
          _mainScreenAbsorting = false;
        });
      } else {
        _settingsScreenIndex = 3;

        _transitionXForMainScreen = -(MediaQuery.of(context).size.width * 0.75);
        _marginTop = 60;
        _marginBottom = 60;

        _transitionXForMenuScreen = 0.0;

        _blur = 2.5;

        setState(() {
          _mainScreenAbsorting = true;
        });
      }
    });
  }

  // Hàm để detect xem ng dùng có ấn back button ko để đưa ra thông báo
  void _onWillPop() {
    showDialog(
        context: context,
        builder: (_) => AssetGiffyDialog(
              image: Image.asset(
                "images/question2.gif",
                fit: BoxFit.cover,
              ),
              title: Text(
                "Are you sure you want to exit DOIT?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w100),
              ),
              entryAnimation: EntryAnimation.BOTTOM,
              buttonOkText: Text(
                "Yes",
                style: TextStyle(color: Colors.white),
              ),
              buttonOkColor: Color(0xFF425195),
              onOkButtonPressed: () => exit(0),
              onCancelButtonPressed: () => Navigator.of(context).pop(false),
              buttonCancelColor: Colors.red,
              cornerRadius: 30.0,
            ));
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
      String image, String menuText, Color iconColor, Color textColor) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: <Widget>[
          Image.asset(
            image,
            color: iconColor,
            width: 20.0,
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, top: 2.0),
            child: Text(
              "$menuText",
              style: TextStyle(
                  fontSize: 20.0, fontFamily: 'AbhayaLibre', color: textColor),
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

// Hàm sự kiện để chạy animation
  void _onTap() async {
    setState(() => rect = RectGetter.getRectFromKey(
        rectGetterKey)); //<-- set rect to be size of fab
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //<-- on the next frame...
      setState(() => rect = rect.inflate(1.1 *
          MediaQuery.of(context).size.longestSide)); //<-- set rect to be big
      Future.delayed(animationDuration + delay,
          _goToNextPage); //<-- after delay, go to next page
    });
  }

  void _goToNextPage() {
    isPickColorFinished = false;
    Navigator.of(context)
        .pushReplacement(FadeRouteBuilder(
            page: AddTaskPage(
          lastFocusedScreen: _lastFocusedIconIndex,
          settingScreenIndex: _settingsScreenIndex,
        )))
        .then((_) => setState(() => rect = null));
  }

  Widget _ripple() {
    if (rect == null) {
      return Container();
    }
    return AnimatedPositioned(
      duration: animationDuration, //<--specify the animation duration
      left: rect.left,
      right: MediaQuery.of(context).size.width - rect.right,
      top: rect.top,
      bottom: MediaQuery.of(context).size.height - rect.bottom,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF425195),
        ),
      ),
    );
  }
}
