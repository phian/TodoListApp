import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todoapp/ui/rating_screen.dart';

import '../data/main_screen_data.dart';
import 'main_screen.dart';

class AboutScreen extends StatefulWidget {
  final int lastFocusedScreen;

  AboutScreen({this.lastFocusedScreen});

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  double _transitionForAboutScreen = 0.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        // ignore: missing_return
        onWillPop: () async {
          _backToMainScreen();
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          transform:
              Matrix4.translationValues(0.0, _transitionForAboutScreen, 0.0),
          child: Scaffold(
            backgroundColor: Color(0xFFFFE4D4),
            body: Container(
              child: Stack(
                children: <Widget>[
                  _aboutScreenHeader(),
                  _aboutTitle(),
                  _aboutScreenContent(),
                  _displayAppCopyRight()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // About screen header
  Widget _aboutScreenHeader() => Stack(children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            padding: const EdgeInsets.only(top: 15.0),
            child: FlatButton(
              child: Icon(
                Icons.arrow_back,
                color: Color(0xFF425195),
                size: 40.0,
              ),
              onPressed: () async {
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
                  color:Color(0xFF425195)),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTapUp: (details) {
              setState(() {
                _transitionForAboutScreen = -MediaQuery.of(context).size.height;
              });

              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      type: PageTransitionType.downToUp,
                      child: RatingScreen(
                        lastFocusedScreen: widget.lastFocusedScreen,
                      ),
                      duration: Duration(milliseconds: 300)));
            },
            child: Container(
              margin: EdgeInsets.only(top: 13.0, right: 15.0),
              width: 50.0,
              height: 50.0,
              child: Image.asset(
                "images/smile.png",
                fit: BoxFit.cover,
                width: 45.0,
                height: 45.0,
                color: Color(0xFF425195),
              ),
            ),
          ),
        )
      ]);

  // About Screen title
  Widget _aboutTitle() => Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.12),
        child: Text(
          "Why DOIT?",
          style: TextStyle(
            fontSize: 50.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  // About content
  Widget _aboutScreenContent() => Container(
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.25),
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
                style: TextStyle(fontSize: 40.0, fontFamily: 'AbrilFatface'),
              ),
              Text(
                "D & A studio",
                style: TextStyle(fontSize: 30.0, fontFamily: 'RobotoCondensed'),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
                child: Text(
                  "This is a useful Todo App for your life made by Duy and Ân. We're third year student in UIT Viet Nam. You can use this app to make a daily plan, add your special task to notify every month, year..., You can also make big plan for your self to record achievements in your life and the last is that you can make a notify for daily inportant habit like having excercises, drink water and more. We hope this app will make your life better and easier",
                  maxLines: 10,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 17.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  // Copy right
  Widget _displayAppCopyRight() => Container(
        padding: EdgeInsets.only(bottom: 10.0),
        alignment: Alignment.bottomCenter,
        child: Text(
          "© DOIT, D & A Todo App",
          style: TextStyle(fontFamily: 'Roboto'),
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
