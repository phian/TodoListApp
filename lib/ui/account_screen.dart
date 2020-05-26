import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/data.dart';
import 'main_screen.dart';

int _lastFocusedScreen;

class AccountScreen extends StatefulWidget {
  AccountScreen({Key key, int lastFocusedScreen}) {
    _lastFocusedScreen = lastFocusedScreen;
  }

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
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
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: FlatButton(
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
                    style: GoogleFonts.roboto(
                      fontSize: 30.0,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                    padding: const EdgeInsets.only(right: 10.0, top: 8.0),
                    child: Icon(
                      CupertinoIcons.profile_circled,
                      size: 45.0,
                      color: Colors.lightBlueAccent,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
