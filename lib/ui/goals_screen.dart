import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GoalsScreen extends StatefulWidget {
  @override
  _GoalsScreenState createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFFAF3F0),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Center(
                    child: Text(
                      "Finished",
                      textDirection: TextDirection.ltr,
                      style: GoogleFonts.roboto(
                        fontSize: 35,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 350, top: 10),
                  child: Image.asset(
                    'images/goals.gif',
                    width: 50,
                    height: 70,
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
