import 'package:flutter/cupertino.dart';
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
      itemExtent: 300,
      children: <Widget>[
        Container(
          width: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'Today',
                  textDirection: TextDirection.ltr,
                  style: GoogleFonts.courgette(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: Container(
                  width: 400,
                  height: 220,
                  child: ListView(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(90),
                                  color: Color(0xFFFF8A80),
                                ),
                                child: Icon(
                                  Icons.person,
                                  size: 30,
                                  color: Color(0xFFB71C1C),
                                ),
                                width: 55,
                                height: 55,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    width: 150,
                                    child: Text(
                                      "Eat breakfast",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      textDirection: TextDirection.ltr,
                                      style: GoogleFonts.aclonica(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    width: 150,
                                    child: Text(
                                      "December 25, 8:00-9:00",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      textDirection: TextDirection.ltr,
                                      style: GoogleFonts.aclonica(
                                          fontSize: 10.0, color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 60.0),
                              child: Icon(
                                Icons.more_horiz,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(90),
                                  color: Color(0xFFFF8A80),
                                ),
                                child: Icon(
                                  Icons.book,
                                  size: 30,
                                  color: Color(0xFFB71C1C),
                                ),
                                width: 55,
                                height: 55,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    width: 150,
                                    child: Text(
                                      "Read a book",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      textDirection: TextDirection.ltr,
                                      style: GoogleFonts.aclonica(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    width: 150,
                                    child: Text(
                                      "December 25, 9:00-10:00",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      textDirection: TextDirection.ltr,
                                      style: GoogleFonts.aclonica(
                                          fontSize: 10.0, color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 60.0),
                              child: Icon(
                                Icons.more_horiz,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'Tomorrow',
                  textDirection: TextDirection.ltr,
                  style: GoogleFonts.courgette(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: Container(
                  width: 400,
                  height: 220,
                  child: ListView(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(90),
                                  color: Color(0xFFFF8A80),
                                ),
                                child: Icon(
                                  Icons.work,
                                  size: 30,
                                  color: Color(0xFFB71C1C),
                                ),
                                width: 55,
                                height: 55,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    width: 150,
                                    child: Text(
                                      "Do homework",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      textDirection: TextDirection.ltr,
                                      style: GoogleFonts.aclonica(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    width: 150,
                                    child: Text(
                                      "December 26, 8:00-9:00",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      textDirection: TextDirection.ltr,
                                      style: GoogleFonts.aclonica(
                                          fontSize: 10.0, color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 55.0),
                              child: Icon(
                                Icons.more_horiz,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(90),
                                  color: Color(0xFFFF8A80),
                                ),
                                child: Icon(
                                  Icons.restaurant_menu,
                                  size: 30,
                                  color: Color(0xFFB71C1C),
                                ),
                                width: 55,
                                height: 55,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    width: 150,
                                    child: Text(
                                      "Have lunch",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      textDirection: TextDirection.ltr,
                                      style: GoogleFonts.aclonica(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    width: 150,
                                    child: Text(
                                      "December 26, 11:00-12:00",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      textDirection: TextDirection.ltr,
                                      style: GoogleFonts.aclonica(
                                          fontSize: 10.0, color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 55.0),
                              child: Icon(
                                Icons.more_horiz,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'Later',
                  textDirection: TextDirection.ltr,
                  style: GoogleFonts.courgette(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: Container(
                  width: 400,
                  height: 220,
                  child: ListView(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(90),
                                  color: Color(0xFFFF8A80),
                                ),
                                child: Icon(
                                  Icons.home,
                                  size: 30,
                                  color: Color(0xFFB71C1C),
                                ),
                                width: 55,
                                height: 55,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    width: 150,
                                    child: Text(
                                      "Do housework",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      textDirection: TextDirection.ltr,
                                      style: GoogleFonts.aclonica(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  width: 150,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      "December 27, 8:00-9:00",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      textDirection: TextDirection.ltr,
                                      style: GoogleFonts.aclonica(
                                          fontSize: 10.0, color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 55.0),
                              child: Icon(
                                Icons.more_horiz,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(90),
                                  color: Color(0xFFFF8A80),
                                ),
                                child: Icon(
                                  Icons.pets,
                                  size: 30,
                                  color: Color(0xFFB71C1C),
                                ),
                                width: 55,
                                height: 55,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    width: 150,
                                    child: Text(
                                      "Take bath for Pupies",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      textDirection: TextDirection.ltr,
                                      style: GoogleFonts.aclonica(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    width: 150,
                                    child: Text(
                                      "December 27, 10:00-11:00",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      textDirection: TextDirection.ltr,
                                      style: GoogleFonts.aclonica(
                                          fontSize: 10.0, color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 55.0),
                              child: Icon(
                                Icons.more_horiz,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/*
ListView(
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
* */
