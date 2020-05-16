import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Color _textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFAF3F0),
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.width - 120.0, left: MediaQuery.of(context).size.width / 2 - 120.0),
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              "DOIT",
              style: GoogleFonts.abhayaLibre(
                  fontSize: 35.0, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          InkWell(
            onTap: () {
              print("Preference tapped");
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Preference",
                style: GoogleFonts.abhayaLibre(
                    fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          InkWell(
            onTap: () {
              print("Search clicked");
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Search",
                style: GoogleFonts.abhayaLibre(
                    fontSize: 20.0
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          InkWell(
            onTap: () {
              print("Help clicked");
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Help",
                style: GoogleFonts.abhayaLibre(
                    fontSize: 20.0
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          InkWell(
            onTap: () {
              print("About clicked");
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                "About",
                style: GoogleFonts.abhayaLibre(
                    fontSize: 20.0,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          InkWell(
            onTap: () {
              print("Getting started clicked");
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Getting started",
                style: GoogleFonts.abhayaLibre(
                    fontSize: 20.0
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          InkWell(
            onTap: () {
              print("Account clicked");
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Account",
                style: GoogleFonts.abhayaLibre(
                    fontSize: 20.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
