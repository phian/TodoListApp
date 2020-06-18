import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../data/data.dart';
import 'main_screen.dart';

class SearchScreen extends StatefulWidget {
  final int lastFocusedScreen;

  SearchScreen({this.lastFocusedScreen});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  TextEditingController _controller = TextEditingController();
  List<String> _userChoicesList = ["COMPLETED", "ALL", "INCOMPLETE"];
  List<Widget> _userChoicesCards = [];

  // Biến để lưu lịa vị trí trc đó mà ng dùng lựa chọn
  int _lastFocusChoiceIndex = 1;

  // Các biến cho animation của dòng text
  AnimationController _controllerForMiddleText;
  Animation<double> _animationForMiddleText;
  int _durationForMiddleText;
  static double _beginForMiddleText, _endForMiddleText;

  bool _focus = true;

  @override
  void initState() {
    super.initState();

    _initUserChoiceWidgets();
    _initAnimationForMiddleText();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        // ignore: missing_return
        onWillPop: () async {
          setState(() {
            _focus = false;
          });

          _backToMainScreen();
        },
        child: Scaffold(
          backgroundColor: Color(0xFFFAF3F0),
          body: Container(
            child: Stack(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Transform.translate(
                      offset: Offset(0.0, _animationForMiddleText.value),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: FlatButton(
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.lightBlueAccent,
                            size: 40.0,
                          ),
                          onPressed: () async {
//                      if (Navigator.canPop(context)) {
//                        Navigator.pop(context);
//                      } else {
//                        SystemNavigator.pop();
//                      }

                            setState(() {
                              _focus = false;
                            });

                            _backToMainScreen();
                          },
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0.0, _animationForMiddleText.value),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text("Search",
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 40.0,
                                color: Colors.lightBlueAccent,
                                fontFamily: 'Adamina')),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0.0, _animationForMiddleText.value),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Image.asset(
                          'images/search.gif',
                          width: 150.0,
                          height: 150.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Transform.translate(
                    offset: Offset(0.0, _animationForMiddleText.value),
                    child: Container(
                      child: Text(
                        "Type to search your action titles and note",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 150.0,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            controller: _controller,
                            autofocus: _focus,
                            decoration: InputDecoration(
                                labelText: "Search for tasks",
                                hintText: "Search",
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                    color: Colors.lightBlueAccent,
                                  ),
                                  gapPadding: 10.0,
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              color: Colors.cyan,
                            ),
                            height: 50.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                InkWell(
                                  child: _userChoicesCards[0],
                                  onTap: () {
                                    _changeFocusChoiceCardColor(
                                        0, _lastFocusChoiceIndex);
                                  },
                                ),
                                InkWell(
                                  child: _userChoicesCards[1],
                                  onTap: () {
                                    _changeFocusChoiceCardColor(
                                        1, _lastFocusChoiceIndex);
                                  },
                                ),
                                InkWell(
                                  child: _userChoicesCards[2],
                                  onTap: () {
                                    _changeFocusChoiceCardColor(
                                        2, _lastFocusChoiceIndex);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Hàm để back về main screen
  void _backToMainScreen() {
    Data data = Data(
        isBack: true,
        isBackFromAddTaskScreen: false,
        lastFocusedScreen: widget.lastFocusedScreen,
        settingScreenIndex: 3);

    Navigator.pushReplacement(
        context,
        PageTransition(
            child: HomeScreen(
              data: data,
            ),
            type: PageTransitionType.leftToRight,
            duration: Duration(milliseconds: 300)));
  }

  // Hàm để khởi tạo các widget hiển thị cho phần search option
  void _initUserChoiceWidgets() {
    for (int i = 0; i < 3; i++) {
      _userChoicesCards.add(_userChoiceCard(
          _userChoicesList[i], i == 1 ? Color(0xFFFAF3F0) : Colors.cyan));
    }
  }

  // Hàm để thay đổi màu sắc của
  void _changeFocusChoiceCardColor(int changeIndex, int lastFocusedIndex) {
    setState(() {
      if (changeIndex != lastFocusedIndex) {
        _userChoicesCards[lastFocusedIndex] =
            _userChoiceCard(_userChoicesList[lastFocusedIndex], Colors.cyan);
        _userChoicesCards[changeIndex] =
            _userChoiceCard(_userChoicesList[changeIndex], Color(0xFFFAF3F0));

        _lastFocusChoiceIndex = changeIndex;
      }
    });
  }

  // Widget dùng để tạo search option card
  Widget _userChoiceCard(String userChoice, Color focusColor) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(7.0)),
        color: focusColor,
      ),
      padding: EdgeInsets.only(left: 7.0, right: 7.0),
      height: 25.0,
      child: Center(
        child: Text(
          "$userChoice",
          style: TextStyle(fontSize: 15.0, fontFamily: 'Roboto'),
        ),
      ),
    );
  }

  // Hàm để khởi tạo animtion cho dòng text 1
  void _initAnimationForMiddleText() {
    // Animation cho dòng chữ ở giữa màn hình
    _durationForMiddleText = 300;
    _controllerForMiddleText = AnimationController(
        vsync: this, duration: Duration(milliseconds: _durationForMiddleText));

    _beginForMiddleText = -300.0;
    _endForMiddleText = 15.0;
    _animationForMiddleText =
        Tween<double>(begin: _beginForMiddleText, end: _endForMiddleText)
            .animate(_controllerForMiddleText)
              ..addListener(() {
                setState(() {});
              })
              ..addStatusListener((AnimationStatus status) {
                if (status == AnimationStatus.completed) {
                  _beginForMiddleText = 15.0;
                  _endForMiddleText = 0.0;
                  _durationForMiddleText = 200;

                  _controllerForMiddleText = AnimationController(
                      vsync: this,
                      duration: Duration(milliseconds: _durationForMiddleText));

                  _animationForMiddleText = Tween<double>(
                          begin: _beginForMiddleText, end: _endForMiddleText)
                      .animate(_controllerForMiddleText)
                        ..addListener(() {
                          setState(() {});
                        });

                  _controllerForMiddleText.forward();
                }
              });

    Future.delayed(Duration(milliseconds: 200), () {
      _controllerForMiddleText.forward();
    });
  }
}
