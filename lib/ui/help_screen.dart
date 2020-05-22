import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../presentation/facebook_icon.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  static double _begin = 1.0, _end = 1.1;
  Tween<double> _scaleButtonTween;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _scaleButtonTween = Tween<double>(begin: _begin, end: _end);

    return Scaffold(
      body: Container(
        color: Color(0xFFFAF3F0),
        child: Stack(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
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
                      color: Colors.cyanAccent,
                      size: 32.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    "HELP",
                    style: GoogleFonts.roboto(
                      fontSize: 30.0,
                      color: Colors.cyanAccent,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0, top: 8.0),
                  child: Image.asset(
                    'images/help.gif',
                    width: 50.0,
                    height: 50.0,
                    color: Colors.cyanAccent,
                  ),
                )
              ],
            ),
            Stack(
              children: <Widget>[
                Positioned(
                  top: MediaQuery.of(context).size.height / 5,
                  left: MediaQuery.of(context).size.width / 3,
                  child: TweenAnimationBuilder(
                    onEnd: () {
                      setState(() {
                        _begin = 1.1;
                        _end = 1.0;

                        // reset kích thước lại cho widget
                        _scaleButtonTween = Tween<double>(begin: _begin, end: _end);
                      });
                    },
                    tween: _scaleButtonTween,
                    duration: Duration(milliseconds: 500),
                    builder: (context, scale, child) {
                      return Transform.scale(
                        scale: scale,
                        child: child,
                      );
                    },
                    child: Container(
                      width: 200.0,
                      height: 200.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(360)),
                        color: Colors.greenAccent.shade400,
                      ),
                      child: Center(
                        child: Text(
                          "CONTACT SUPPORT",
                          style: GoogleFonts.roboto(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 2.25,
                  left: MediaQuery.of(context).size.width / 3.1,
                  child: TweenAnimationBuilder(
                    onEnd: () {
                      setState(() {
                        _begin = 1.1;
                        _end = 1.0;

                        // reset kích thước lại cho widget
                        _scaleButtonTween = Tween<double>(begin: _begin, end: _end);
                      });
                    },
                    tween: _scaleButtonTween,
                    duration: Duration(milliseconds: 700),
                    builder: (context, scale, child) {
                      return Transform.scale(
                        scale: scale,
                        child: child,
                      );
                    },
                    child: Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(360)),
                          color: Colors.blue),
                      child: Center(
                          child: Icon(
                            FacebookIcon.facebook,
                            size: 35.0,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 2.15,
                  left: MediaQuery.of(context).size.width / 1.9,
                  child: TweenAnimationBuilder(
                    onEnd: () {
                      setState(() {
                        _begin = 1.1;
                        _end = 1.0;

                        // reset kích thước lại cho widget
                        _scaleButtonTween = Tween<double>(begin: _begin, end: _end);
                      });
                    },
                    tween: _scaleButtonTween,
                    duration: Duration(milliseconds: 900),
                    builder: (context, scale, child) {
                      return Transform.scale(
                        scale: scale,
                        child: child,
                      );
                    },
                    child: Container(
                      width: 130.0,
                      height: 130.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(360)),
                        color: Colors.purpleAccent.shade400,
                      ),
                      child: Center(
                        child: Text(
                          "FAQ",
                          style: GoogleFonts.roboto(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 1.82,
                  left: MediaQuery.of(context).size.width / 8,
                  child: TweenAnimationBuilder(
                    onEnd: () {
                      setState(() {
                        _begin = 1.1;
                        _end = 1.0;

                        // reset kích thước lại cho widget
                        _scaleButtonTween = Tween<double>(begin: _begin, end: _end);
                      });
                    },
                    tween: _scaleButtonTween,
                    duration: Duration(milliseconds: 1400),
                    builder: (context, scale, child) {
                      return Transform.scale(
                        scale: scale,
                        child: child,
                      );
                    },
                    child: Container(
                      width: 175.0,
                      height: 175.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(360)),
                          color: Colors.pinkAccent),
                      child: Center(
                        child: Text(
                          'FEATURE REQUEST',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
