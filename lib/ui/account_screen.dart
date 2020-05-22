import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    } else {
                      SystemNavigator.pop();
                    }
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
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
