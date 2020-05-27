import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/data.dart';
import 'main_screen.dart';

int _lastFocusedScreen;

class AboutScreen extends StatefulWidget {
  AboutScreen({Key key, int lastFocusedScreen}) : super(key: key) {
    _lastFocusedScreen = lastFocusedScreen;
  }

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
          Data data = Data(isBack: true, lastFocusedScreen: _lastFocusedScreen);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomeScreen(
              data: data,
            ),
          ));
        },
        child: Scaffold(
          body: Container(
            color: Color(0xFFFAF3F0),
            child: Stack(
              children: <Widget>[
                Stack(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: FlatButton(
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.lightBlueAccent,
                        size: 40.0,
                      ),
                      onPressed: () {
//                    if (Navigator.canPop(context)) {
//                      Navigator.pop(context);
//                    } else {
//                      SystemNavigator.pop();
//                    }

                        Data data = Data(
                            isBack: true, lastFocusedScreen: _lastFocusedScreen);

                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HomeScreen(
                            data: data,
                          ),
                        ));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 13.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "ABOUT",
                        style: GoogleFonts.roboto(
                            fontSize: 35.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.lightBlueAccent),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 345.0),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.tag_faces,
                        size: 50.0,
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
                          style: GoogleFonts.abrilFatface(fontSize: 40.0),
                        ),
                        Text(
                          "D & A studio",
                          style: GoogleFonts.robotoCondensed(fontSize: 30.0),
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
