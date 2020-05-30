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
          Data data =
              Data(isBack: true, lastFocusedScreen: widget.lastFocusedScreen);

          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: HomeScreen(
                    data: data,
                  ),
                  type: PageTransitionType.leftToRight));
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
                      padding: const EdgeInsets.only(top: 8.0),
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

                          Data data = Data(
                              isBack: true,
                              lastFocusedScreen: widget.lastFocusedScreen);

                          Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  child: HomeScreen(
                                    data: data,
                                  ),
                                  type: PageTransitionType.leftToRight));
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 13.0),
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
                      padding: EdgeInsets.only(right: 15.0),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.tag_faces,
                          size: 50.0,
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
                          style: TextStyle(fontSize: 40.0, fontFamily: 'AbrilFatface'),
                        ),
                        Text(
                          "D & A studio",
                          style: TextStyle(fontSize: 30.0, fontFamily: 'RobotoCondensed'),
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
}
