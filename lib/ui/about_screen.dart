import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFFAF3F0),
        child: Column(
          children: <Widget>[
            Stack(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: FlatButton(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.cyanAccent,
                    size: 40.0,
                  ),
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    } else {
                      SystemNavigator.pop();
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 13.0),
                child: Center(
                  child: Text(
                    "About",
                    style: GoogleFonts.roboto(
                      fontSize: 35.0,
                      fontWeight: FontWeight.w500,
                    ),
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
                      style: GoogleFonts.abrilFatface(
                          fontSize: 40.0
                      ),
                    ),
                    Text(
                      "D & A studio",
                      style: GoogleFonts.robotoCondensed(
                          fontSize: 30.0
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 240.0),
              child: Text(
                  "© DOIT, D & A Todo App"
              ),
            )
          ],
        ),
      ),
    );
  }
}
