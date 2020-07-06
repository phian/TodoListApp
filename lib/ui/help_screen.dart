import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/main_screen_data.dart';
import '../presentation/facebook_icon.dart';
import 'package:package_info/package_info.dart';

import 'main_screen.dart';

class HelpScreen extends StatefulWidget {
  final int lastFocusedScreen;

  HelpScreen({this.lastFocusedScreen});

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
    super.initState();

    _getAppVersion();
    _initForWidgetInHelpScreen();

    for (int i = 0; i < 4; i++) {
      _opacities.add(1.0);
    }
  }

  @override
  void dispose() {
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
          _backToMainScreen();
        },
        child: Scaffold(
          backgroundColor: Color(0xFFFAF3F0),
          body: Container(
            child: Stack(
              children: <Widget>[
                _displayHelpScreenHeaderWidget(),
                Stack(
                  children: <Widget>[
                    _contactSupportWidget(),
                    _displayFacebookIconWidget(),
                    _faqWidget(),
                    _featureRequestWidget(),
                  ],
                ),
                _displayAppVersionWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // App header
  Widget _displayHelpScreenHeaderWidget() => Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 9.0),
              child: FlatButton(
                onPressed: () async {
                  _backToMainScreen();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.lightBlueAccent,
                  size: 32.0,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 17.0),
              child: Text(
                "HELP",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 30.0,
                  color: Colors.lightBlueAccent,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0, top: 8.0),
              child: Image.asset(
                'images/help.gif',
                width: 50.0,
                height: 50.0,
                color: Colors.lightBlueAccent,
              ),
            ),
          )
        ],
      );

  // Contact Support widget
  Widget _contactSupportWidget() => Positioned(
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

              _showNotification();
            },
            child: Transform.scale(
              scale: _scales[0],
              child: Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(360)),
                  color: Colors.greenAccent.shade400.withOpacity(_opacities[0]),
                ),
                child: Center(
                  child: Text(
                    "CONTACT SUPPORT",
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  // Display Facebook icon widdet
  Widget _displayFacebookIconWidget() => Positioned(
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
              _openWhatsApp();
            },
            child: Transform.scale(
              scale: _scales[1],
              child: Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(360)),
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
      );

  // FAQ widget
  Widget _faqWidget() => Positioned(
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
              _openFAQLink();
            },
            child: Transform.scale(
              scale: _scales[2],
              child: Container(
                width: 130.0,
                height: 130.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(360)),
                  color:
                      Colors.purpleAccent.shade400.withOpacity(_opacities[2]),
                ),
                child: Center(
                  child: Text(
                    "FAQ",
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  // Feature Request widget
  Widget _featureRequestWidget() => Positioned(
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
                width: 173.0,
                height: 173.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(360)),
                    color: Colors.pinkAccent.withOpacity(_opacities[3])),
                child: Center(
                  child: Text(
                    'FEATURE REQUEST',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  // Display app version widget
  Widget _displayAppVersionWidget() => Align(
        alignment: Alignment.bottomCenter,
        child: Text(
          "Version $_appVersion",
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 30.0,
            fontWeight: FontWeight.w100,
            color: Colors.black,
          ),
        ),
      );

  // Hàm để lấy version hiện tại của app
  void _getAppVersion() async {
    PackageInfo _packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      _appVersion = _packageInfo.version;
    });
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

  // Hàm để back về main screen
  void _backToMainScreen() {
    MainScreenData data = MainScreenData(
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

  // Hàm show thông báo để hỏi xem ng dùng có muốn mở Gmail ko
  void _showNotification() {
    showDialog(
        context: context,
        builder: (_) => AssetGiffyDialog(
              image: Image.asset(
                "images/mail.gif",
                fit: BoxFit.cover,
              ),
              title: Text(
                "DOIT want to open your email",
                textAlign: TextAlign.center,
                softWrap: true,
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w100,
                    fontFamily: "RobotoSlab"),
              ),
              entryAnimation: EntryAnimation.BOTTOM,
              buttonOkText: Text(
                "Open",
                style: TextStyle(color: Colors.white, fontFamily: "RobotoSlab"),
              ),
              buttonOkColor: Color(0xFF425195),
              onOkButtonPressed: () {
                _launchURL("phiannguyen1806@hmail.com, 17520392@gm.uit.edu.vn",
                    "[Feedback]", "Hi friendly DOIT support people,");
              },
              onCancelButtonPressed: () {
                Navigator.of(context).pop(false);
              },
              buttonCancelColor: Colors.red,
              buttonCancelText: Text(
                "Cancel",
                style: TextStyle(color: Colors.white, fontFamily: "RobotoSlab"),
              ),
              cornerRadius: 30.0,
            ));
  }

  // Hàm để mở email trong máy của ng dùng và chuyển phần rating vào đó
  _launchURL(String toMailAddress, String subject, String body) async {
    var url = 'mailto:$toMailAddress?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Hàm để mở ứng dụng WhatsApp
  void _openWhatsApp() async {
    try {
      var whatsappUrl = "whatsapp://send?phone=0346275955";
      await launch(whatsappUrl);
    } catch (e) {
      showDialog(
          context: context,
          builder: (_) => AssetGiffyDialog(
                image: Image.asset(
                  "images/error.gif",
                  fit: BoxFit.fitHeight,
                ),
                title: Text(
                  "Oops! There is no WhatsApp available!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w100,
                      fontFamily: "RobotoSlab"),
                ),
                entryAnimation: EntryAnimation.BOTTOM,
                buttonOkText: Text(
                  "OK",
                  style:
                      TextStyle(color: Colors.white, fontFamily: "RobotoSlab"),
                ),
                buttonOkColor: Colors.red,
                onOkButtonPressed: () {
                  Navigator.of(context).pop(false);
                },
                onlyOkButton: true,
                cornerRadius: 30.0,
              ));
    }
  }

  // Run FAQ support link,
  void _openFAQLink() async {
    try {
      var faqUrl =
          "https://github.com/angapkpro0123/TodoListApp/blob/master/README.md";
      await launch(faqUrl);
    } catch (e) {
      showDialog(
          context: context,
          builder: (_) => AssetGiffyDialog(
                image: Image.asset(
                  "images/error.gif",
                  fit: BoxFit.fitHeight,
                ),
                title: Text(
                  "Something when wrong",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w100,
                      fontFamily: "RobotoSlab"),
                ),
                entryAnimation: EntryAnimation.BOTTOM,
                buttonOkText: Text(
                  "OK",
                  style:
                      TextStyle(color: Colors.white, fontFamily: "RobotoSlab"),
                ),
                buttonOkColor: Colors.red,
                onOkButtonPressed: () {
                  Navigator.of(context).pop(false);
                },
                onlyOkButton: true,
                cornerRadius: 30.0,
              ));
    }
  }
}
