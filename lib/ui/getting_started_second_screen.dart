import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/ui/getting_started_screen.dart';

class GettingStartedSecondScreen extends StatefulWidget {
  @override
  _GettingStartedSecondScreenState createState() => _GettingStartedSecondScreenState();
}

class _GettingStartedSecondScreenState extends State<GettingStartedSecondScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () async {
        Future.delayed(const Duration(milliseconds: 0), () {
          setState(() {
            // Here you can write your code for open new view
            Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => GettingStartedScreen(),
            ));
          });
        });
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          child: Center(
            child: Text(
              "Second Screen",
              style: GoogleFonts.roboto(
                fontSize: 50.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
