import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todoapp/ui/main_screen.dart';
import 'package:todoapp/ui_variables/prefrence_screen_variables.dart';

import '../data/main_screen_data.dart';

class PreferenceScreen extends StatefulWidget {
  final int lastFocusedScreen;

  PreferenceScreen({this.lastFocusedScreen});

  @override
  _PreferenceScreenState createState() => _PreferenceScreenState();
}

class _PreferenceScreenState extends State<PreferenceScreen> {
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
              _builsPreferenceScreenHeader(),
              _buildPreferenceScreenMenu(),
            ],
          ),
        ),
      ),
    );
  }

// Preference screen header
  Widget _builsPreferenceScreenHeader() => Stack(
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
                "PREFERENCE",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 30.0,
                    color: Colors.lightBlueAccent,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ],
      );

  Widget _buildPreferenceScreenMenu() => Container(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.1,
            horizontal: MediaQuery.of(context).size.width * 0.05),
        child: Column(
          children: <Widget>[
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () => _changeFocusMenuWidgetColor(0, false),
              onTapCancel: () => _changeFocusMenuWidgetColor(0, false),
              onHighlightChanged: (isChanged) {
                if (isChanged) _changeFocusMenuWidgetColor(0, true);
              },
              child: Container(
                child: Text("DOIT",
                    style: TextStyle(
                      color:
                          Colors.black.withOpacity(preferenceMenuOpacities[0]),
                      fontSize: 25.0,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    )),
                alignment: Alignment.topLeft,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () => _changeFocusMenuWidgetColor(1, false),
              onTapCancel: () => _changeFocusMenuWidgetColor(1, false),
              onHighlightChanged: (isChanged) {
                if (isChanged) _changeFocusMenuWidgetColor(1, true);
              },
              child: Container(
                child: Text("Daily habbits setting",
                    style: TextStyle(
                      color:
                          Colors.black.withOpacity(preferenceMenuOpacities[1]),
                      fontSize: 25.0,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    )),
                alignment: Alignment.topLeft,
              ),
            ),
          ],
        ),
      );

// Hàm để chuyển trang
  Future<Widget> buildPageAsync() async {
    return Future.microtask(() {
      MainScreenData data = MainScreenData(
          isBack: true, lastFocusedScreen: widget.lastFocusedScreen);
      return HomeScreen(
        data: data,
      );
    });
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

  // Hàm để reset màu của icon và text của menu widget dc chọn
  void _changeFocusMenuWidgetColor(int focusedIndex, bool isFocused) {
    setState(() {
      if (isFocused)
        preferenceMenuOpacities[focusedIndex] = 0.25;
      else
        preferenceMenuOpacities[focusedIndex] = 1.0;
    });
  }
}
