import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

DateTime _currentDate;

// ignore: must_be_immutable
class DatesListScreen extends StatefulWidget {
  DatesListScreen() {
    _currentDate = DateTime.now();
  }

  @override
  _DatesListScreenState createState() => _DatesListScreenState();
}

class _DatesListScreenState extends State<DatesListScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
//              useMagnifier: true,
//              magnification: 1.5,
      itemExtent: 160,
      children: <Widget>[
        Container(
            color: Color.fromRGBO(56, 43, 59, 5),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            height: 160,
            width: double.maxFinite,
            child: Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.ltr,
                  children: <Widget>[
                    Text(
                      'Today',
                      textDirection: TextDirection.ltr,
                      style: GoogleFonts.aclonica(
                          fontSize: 25,
                          fontWeight: FontWeight.w100,
                          color: Colors.white),
                    ),
                  ],
                ))),
        Container(
            color: Color.fromRGBO(56, 43, 59, 5),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            height: 160,
            width: double.maxFinite,
            child: Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.ltr,
                  children: <Widget>[
                    Text(
                      'Tomorrow',
                      textDirection: TextDirection.ltr,
                      style: GoogleFonts.aclonica(
                          fontSize: 25,
                          fontWeight: FontWeight.w100,
                          color: Colors.white),
                    ),
                  ],
                ))),
        Container(
            color: Color.fromRGBO(56, 43, 59, 5),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            height: 160,
            width: double.maxFinite,
            child: Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.ltr,
                  children: <Widget>[
                    Text(
                      'Chủ Nhật',
                      textDirection: TextDirection.ltr,
                      style: GoogleFonts.aclonica(
                          fontSize: 25,
                          fontWeight: FontWeight.w100,
                          color: Colors.white),
                    ),
                  ],
                ))),
        Container(
            color: Color.fromRGBO(56, 43, 59, 5),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            height: 160,
            width: double.maxFinite,
            child: Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.ltr,
                  children: <Widget>[
                    Text(
                      'Thứ Hai',
                      textDirection: TextDirection.ltr,
                      style: GoogleFonts.aclonica(
                          fontSize: 25,
                          fontWeight: FontWeight.w100,
                          color: Colors.white),
                    ),
                  ],
                ))),
        Container(
            color: Color.fromRGBO(56, 43, 59, 5),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            height: 160,
            width: double.maxFinite,
            child: Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.ltr,
                  children: <Widget>[
                    Text(
                      'Thứ Ba',
                      textDirection: TextDirection.ltr,
                      style: GoogleFonts.aclonica(
                          fontSize: 25,
                          fontWeight: FontWeight.w100,
                          color: Colors.white),
                    ),
                  ],
                ))),
        Container(
            color: Color.fromRGBO(56, 43, 59, 5),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            height: 160,
            width: double.maxFinite,
            child: Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.ltr,
                  children: <Widget>[
                    Text(
                      'Thứ Tư',
                      textDirection: TextDirection.ltr,
                      style: GoogleFonts.aclonica(
                          fontSize: 25,
                          fontWeight: FontWeight.w100,
                          color: Colors.white),
                    ),
                  ],
                ))),
        Container(
            color: Color.fromRGBO(56, 43, 59, 5),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            height: 160,
            width: double.maxFinite,
            child: Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.ltr,
                  children: <Widget>[
                    Text(
                      'Thứ Năm',
                      textDirection: TextDirection.ltr,
                      style: GoogleFonts.aclonica(
                          fontSize: 25,
                          fontWeight: FontWeight.w100,
                          color: Colors.white),
                    ),
                  ],
                ))),
        Container(
            color: Color.fromRGBO(56, 43, 59, 5),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            height: 160,
            width: double.maxFinite,
            child: Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.ltr,
                  children: <Widget>[
                    Text(
                      'Later',
                      textDirection: TextDirection.ltr,
                      style: GoogleFonts.aclonica(
                          fontSize: 25,
                          fontWeight: FontWeight.w100,
                          color: Colors.white),
                    ),
                  ],
                ))),
      ],
    );
  }
}
