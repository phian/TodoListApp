import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/ui/main_screen.dart';

import '../data/data.dart';

int _lastFocusedScreen;

class PreferenceScreen extends StatefulWidget {
  PreferenceScreen({Key key, int lastFocusScreen}) : super(key : key) {
    _lastFocusedScreen = lastFocusScreen;
  }

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
          Data data = Data(isBack: true, lastFocusedScreen: _lastFocusedScreen);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomeScreen(data: data,),
          ));
        },
        child: Scaffold(
          backgroundColor: Color(0xFFFAF3F0),
          body: Container(
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: FlatButton(
                        onPressed: () {
//                      if (Navigator.canPop(context)) {
////                        Navigator.pop(context);
////                      } else {
////                        SystemNavigator.pop();
////                      }

                          Data data = Data(isBack: true, lastFocusedScreen: _lastFocusedScreen);
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomeScreen(data: data,),
                          ));
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
                        style: GoogleFonts.roboto(
                          fontSize: 30.0,
                          color: Colors.lightBlueAccent,
                          fontWeight: FontWeight.w500
                        ),
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
}
