import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todoapp/ui/feature_requests_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/main_screen_data.dart';
import '../presentation/facebook_icon.dart';
import 'package:package_info/package_info.dart';
import 'package:full_screen_menu/full_screen_menu.dart';

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

  TextEditingController _confirmNameController = TextEditingController();

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
          backgroundColor: Color(0xFFFFE4D4),
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
            child: Container(
              width: 70.0,
              height: 70.0,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(90.0),
                ),
                onPressed: () async {
                  _backToMainScreen();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Color(0xFF425195),
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
                  color: Color(0xFF425195),
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
                color: Color(0xFF425195),
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
              _openFacebookContactMenu();
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

              _showConfirmNameNotification();
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
            color: Color(0xFF425195),
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

  // Hàm để show link menu để ng dùng có thể chọn và mở contact
  void _openFacebookContactMenu() {
    FullScreenMenu.show(
      context,
      backgroundColor: Colors.grey,
      items: [
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              InkWell(
                onTap: () {
                  _openAnOrDuyFacebook(0);
                },
                child: Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("Contact to Ân's Facebook"),
                      Icon(Icons.keyboard_arrow_right, color: Colors.black),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 0.0,
              ),
              InkWell(
                onTap: () {
                  _openAnOrDuyFacebook(1);
                },
                child: Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("Contact to Duy's Facebook"),
                      Icon(Icons.keyboard_arrow_right, color: Colors.black),
                    ],
                  ),
                ),
              ),
            ]),
      ],
    );
  }

  // Hàm để mở link fb của Ân or Duy
  void _openAnOrDuyFacebook(int userChoice) async {
    var facebookUrl;
    try {
      if (userChoice == 0)
        facebookUrl = "https://www.facebook.com/profile.php?id=100006720403618";
      else
        facebookUrl = "https://www.facebook.com/profile.php?id=100010490101458";
      await launch(facebookUrl);
    } catch (e) {
      showDialog(
          context: context,
          builder: (_) => AssetGiffyDialog(
                image: Image.asset(
                  "images/error.gif",
                  fit: BoxFit.fitHeight,
                ),
                title: Text(
                  "Oops! Something when wrong!",
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

  // Hàm gọi khi ng dùng ấn vào Feature Request
  void _showConfirmNameNotification() async {
    var confirmNameDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        padding: EdgeInsets.only(top: 15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height * 0.45,
        child: Stack(
          children: <Widget>[
            ListView(
              padding: EdgeInsets.only(
                left: 20.0,
                right: 20.0,
              ),
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                Text(
                  "Feature Request",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Your votes and comments on Feature Request board are public.",
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  "Please confirm the name you would like to use",
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextField(
                  autofocus: true,
                  controller: _confirmNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          12.0,
                        ),
                        borderSide: BorderSide(
                          width: 1.0,
                          style: BorderStyle.solid,
                          color: Colors.grey,
                        )),
                    hintText: "The name you use",
                    hintStyle: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              alignment: Alignment.bottomCenter,
              child: Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                            width: 1.0,
                            color: Colors.grey,
                          ),
                          right: BorderSide(
                            width: 1.0,
                            color: Colors.grey,
                          )),
                    ),
                    width: (MediaQuery.of(context).size.width * 0.85) / 2 - 9.0,
                    height: 50.0,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.0))),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.grey[300],
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                  ),
                  Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                              width: 1.0,
                              color: Colors.grey,
                            ),
                            left: BorderSide(
                              width: 1.0,
                              color: Colors.grey,
                            ))),
                    width: (MediaQuery.of(context).size.width * 0.85) / 2 - 6.8,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20.0))),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.grey[300],
                      onPressed: () {
                        Navigator.of(context).pop(false);
                        if (_confirmNameController.text.isNotEmpty)
                          _moveToFeatureRequestScreen();
                      },
                      child: Text(
                        "Continue",
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );

    showDialog(
        context: context, builder: (BuildContext context) => confirmNameDialog);
  }

  // Hàm để chuyển qua Feature Request screen
  void _moveToFeatureRequestScreen() {
    Future.delayed(Duration(milliseconds: 500), () {
      Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft,
              child: FeatureRequestsScreen(
                lastFocusedScreen: widget.lastFocusedScreen,
              ),
              duration: Duration(milliseconds: 300)));
    });
  }
}
