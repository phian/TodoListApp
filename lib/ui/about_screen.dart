import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../data/data.dart';
import 'main_screen.dart';

class AboutScreen extends StatefulWidget {
  final int lastFocusedScreen;

  AboutScreen({this.lastFocusedScreen});

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        // ignore: missing_return
        onWillPop: () async {
          _backToMainScreen();
        },
        child: Scaffold(
          body: Container(
            color: Color(0xFFFAF3F0),
            child: Stack(
              children: <Widget>[
                Stack(children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: FlatButton(
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.lightBlueAccent,
                          size: 40.0,
                        ),
                        onPressed: () async {
//                    if (Navigator.canPop(context)) {
//                      Navigator.pop(context);
//                    } else {
//                      SystemNavigator.pop();
//                    }

                          _backToMainScreen();
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 21.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "ABOUT",
                        style: TextStyle(
                            fontSize: 35.0,
                            fontWeight: FontWeight.w300,
                            color: Colors.lightBlueAccent),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 82.0,
                      height: 80.0,
                      child: IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          "images/smile.png",
                          fit: BoxFit.cover,
                          width: 45.0,
                          height: 45.0,
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                    ),
                  )
                ]),
                Padding(
                  padding: const EdgeInsets.only(top: 250.0),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          child: Image.asset(
                            'images/todo_app_icon.png',
                            width: 150.0,
                            height: 150.0,
                          ),
                        ),
                        Text(
                          "DOIT",
                          style: TextStyle(
                              fontSize: 40.0, fontFamily: 'AbrilFatface'),
                        ),
                        Text(
                          "D & A studio",
                          style: TextStyle(
                              fontSize: 30.0, fontFamily: 'RobotoCondensed'),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text("© DOIT, D & A Todo App"),
                  ),
                )
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
}
