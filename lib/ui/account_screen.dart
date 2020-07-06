import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../data/main_screen_data.dart';
import 'main_screen.dart';

class AccountScreen extends StatefulWidget {
  final int lastFocusedScreen;

  AccountScreen({this.lastFocusedScreen});

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  double _accountScreenOpacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        // ignore: missing_return
        onWillPop: () async {
          _backToMainScreen();
        },
        child: Scaffold(
          backgroundColor: Color(0xFFFAF3F0),
          body: Stack(
            children: <Widget>[
              _buildAccountScreenHeader(),
              _accountScreenMenu(),
            ],
          ),
        ),
      ),
    );
  }

  // Account screen header
  Widget _buildAccountScreenHeader() => Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
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
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                "ACCOUNT",
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Roboto',
                    color: Colors.lightBlueAccent),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
                padding: const EdgeInsets.only(right: 10.0, top: 8.0),
                child: Image.asset(
                  "images/account.png",
                  width: 45.0,
                  height: 45.0,
                  color: Colors.lightBlueAccent,
                )),
          ),
        ],
      );

  // Account screen menu
  Widget _accountScreenMenu() => Container(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.1,
            horizontal: MediaQuery.of(context).size.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                setState(() {
                  _accountScreenOpacity = 1.0;
                });
              },
              onTapCancel: () {
                setState(() {
                  _accountScreenOpacity = 1.0;
                });
              },
              onHighlightChanged: (isChanged) {
                if (isChanged)
                  setState(() {
                    _accountScreenOpacity = 0.25;
                  });
              },
              child: Text(
                "Sign in/Create account",
                style: TextStyle(
                  fontSize: 27.0,
                  fontFamily: "Roboto",
                  color: Colors.black.withOpacity(_accountScreenOpacity),
                ),
              ),
            ),
          ],
        ),
      );

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
}
