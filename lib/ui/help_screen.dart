import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/data.dart';
import '../presentation/facebook_icon.dart';
import 'package:package_info/package_info.dart';

import 'main_screen.dart';

int _lastFocusedScreen;

class HelpScreen extends StatefulWidget {
  HelpScreen({Key key, int lastFocusedScreen}) : super(key: key) {
    _lastFocusedScreen = lastFocusedScreen;
  }

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> with TickerProviderStateMixin {
  static double _begin = 1.0, _end = 1.1;
  Tween<double> _scaleButtonTween;
  String _appVersion = ""; // Biến để lấy version của app để hiển thị

  List<AnimationController> _controllers = [];
  List<double> _scales = [];
  List<double> _opacities = [];

  int _tappedWidgetIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getAppVersion();
    _initForWidgetInHelpScreen();

    for (int i = 0; i < 4; i++) {
      _opacities.add(1.0);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    for (int i = 0; i < _controllers.length; i++) {
      _controllers[i].dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    _scaleButtonTween = Tween<double>(begin: _begin, end: _end);
    for (int i = 0; i < 4; i++) {
      _scales[i] = 1 - _controllers[i].value;
    }

    return SafeArea(
          child: WillPopScope(
        // ignore: missing_return
        onWillPop: () async {
          Data data = Data(isBack: true, lastFocusedScreen: _lastFocusedScreen);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomeScreen(data: data,),
          ));
        },
        child: Scaffold(
          body: Container(
            color: Color(0xFFFAF3F0),
            child: Stack(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: FlatButton(
                        onPressed: () {
//                      if (Navigator.canPop(context)) {
//                        Navigator.pop(context);
//                      } else {
//                        SystemNavigator.pop();
//                      }

                          Data data = Data(
                              isBack: true,
                              lastFocusedScreen: _lastFocusedScreen);
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomeScreen(
                              data: data,
                            ),
                          ));
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.lightBlueAccent,
                          size: 32.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        "HELP",
                        style: GoogleFonts.roboto(
                          fontSize: 30.0,
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0, top: 8.0),
                      child: Image.asset(
                        'images/help.gif',
                        width: 50.0,
                        height: 50.0,
                        color: Colors.lightBlueAccent,
                      ),
                    )
                  ],
                ),
                Stack(
                  children: <Widget>[
                    Positioned(
                      top: MediaQuery.of(context).size.height / 5,
                      left: MediaQuery.of(context).size.width / 3,
                      child: TweenAnimationBuilder(
                        onEnd: _onEnd,
                        tween: _scaleButtonTween,
                        duration: Duration(milliseconds: 500),
                        builder: (context, scale, child) {
                          return Transform.scale(
                            scale: scale,
                            child: child,
                          );
                        },
                        child: GestureDetector(
                          onTapCancel: () {
                            _onTapCancel(0);
                          },
                          onTapDown: (details) {
                            _onTapDown(details, 0);
                          },
                          onTapUp: (details) {
                            _onTapUp(details, 0);
                          },
                          child: Transform.scale(
                            scale: _scales[0],
                            child: Container(
                              width: 200.0,
                              height: 200.0,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(360)),
                                color: Colors.greenAccent.shade400
                                    .withOpacity(_opacities[0]),
                              ),
                              child: Center(
                                child: Text(
                                  "CONTACT SUPPORT",
                                  style: GoogleFonts.roboto(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height / 2.25,
                      left: MediaQuery.of(context).size.width / 3.1,
                      child: TweenAnimationBuilder(
                        onEnd: _onEnd,
                        tween: _scaleButtonTween,
                        duration: Duration(milliseconds: 700),
                        builder: (context, scale, child) {
                          return Transform.scale(
                            scale: scale,
                            child: child,
                          );
                        },
                        child: GestureDetector(
                          onTapCancel: () {
                            _onTapCancel(1);
                          },
                          onTapDown: (details) {
                            _onTapDown(details, 1);
                          },
                          onTapUp: (details) {
                            _onTapUp(details, 1);
                          },
                          child: Transform.scale(
                            scale: _scales[1],
                            child: Container(
                              width: 80.0,
                              height: 80.0,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(360)),
                                  color: Colors.blue.withOpacity(_opacities[1])),
                              child: Center(
                                  child: Icon(
                                FacebookIcon.facebook,
                                size: 35.0,
                                color: Colors.white,
                              )),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height / 2.15,
                      left: MediaQuery.of(context).size.width / 1.9,
                      child: TweenAnimationBuilder(
                        onEnd: _onEnd,
                        tween: _scaleButtonTween,
                        duration: Duration(milliseconds: 900),
                        builder: (context, scale, child) {
                          return Transform.scale(
                            scale: scale,
                            child: child,
                          );
                        },
                        child: GestureDetector(
                          onTapCancel: () {
                            _onTapCancel(2);
                          },
                          onTapDown: (details) {
                            _onTapDown(details, 2);
                          },
                          onTapUp: (details) {
                            _onTapUp(details, 2);
                          },
                          child: Transform.scale(
                            scale: _scales[2],
                            child: Container(
                              width: 130.0,
                              height: 130.0,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(360)),
                                color: Colors.purpleAccent.shade400
                                    .withOpacity(_opacities[2]),
                              ),
                              child: Center(
                                child: Text(
                                  "FAQ",
                                  style: GoogleFonts.roboto(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height / 1.82,
                      left: MediaQuery.of(context).size.width / 8,
                      child: TweenAnimationBuilder(
                        onEnd: _onEnd,
                        tween: _scaleButtonTween,
                        duration: Duration(milliseconds: 1400),
                        builder: (context, scale, child) {
                          return Transform.scale(
                            scale: scale,
                            child: child,
                          );
                        },
                        child: GestureDetector(
                          onTapCancel: () {
                            _onTapCancel(3);
                          },
                          onTapDown: (details) {
                            _onTapDown(details, 3);
                          },
                          onTapUp: (details) {
                            _onTapUp(details, 3);
                          },
                          child: Transform.scale(
                            scale: _scales[3],
                            child: Container(
                              width: 175.0,
                              height: 175.0,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(360)),
                                  color: Colors.pinkAccent
                                      .withOpacity(_opacities[3])),
                              child: Center(
                                child: Text(
                                  'FEATURE REQUEST',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Version $_appVersion",
                    style: GoogleFonts.roboto(
                      fontSize: 28.0,
                      fontWeight: FontWeight.w100,
                      color: Colors.black,
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

  // Hàm để lấy version hiện tại của app
  void _getAppVersion() async {
    PackageInfo _packageInfo = await PackageInfo.fromPlatform();

    _appVersion = _packageInfo.version;
  }

  // Hàm để bắt sự kiện khi người dùng án vào widget trong help screen
  void _onTapDown(TapDownDetails details, int tappedIndex) {
    setState(() {
      _tappedWidgetIndex = tappedIndex;
      _opacities[tappedIndex] = 0.25;

      _controllers[tappedIndex].forward();
    });
  }

  // Hàm để bắt sự kiện khi người dùng ko ấn widget trong help screen nữa
  void _onTapUp(TapUpDetails details, int tappedIndex) {
    setState(() {
      _tappedWidgetIndex = tappedIndex;
      _opacities[tappedIndex] = 1.0;

      _controllers[tappedIndex].reverse();
    });
  }

  // Hàm để check nếu ng dùng ko còn hover trên widget nữa
  void _onTapCancel(int tappedIndex) {
    setState(() {
      _tappedWidgetIndex = tappedIndex;
      _opacities[tappedIndex] = 1.0;

      _controllers[tappedIndex].reverse();
    });
  }

  // Hàm để reset kích thước của widget trong hrlp screen khi animation đã hoàn tất
  void _onEnd() {
    setState(() {
      _begin = 1.1;
      _end = 1.0;

      // reset kích thước lại cho widget
      _scaleButtonTween = Tween<double>(begin: _begin, end: _end);
    });
  }

  // Hàm khởi tạo các controller và animation cho các widget
  void _initForWidgetInHelpScreen() {
    for (int i = 0; i < 4; i++) {
      _controllers.add(AnimationController(
          vsync: this,
          duration: Duration(milliseconds: 100),
          lowerBound: 0.0,
          upperBound: 0.2)
        ..addListener(() {
          setState(() {});
        }));

      _scales.add(1 - _controllers[i].value);
    }
  }
}
