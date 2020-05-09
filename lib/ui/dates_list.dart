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
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 30.0),
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
                                  padding: const EdgeInsets.only(left: 30.0),
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
                                SizedBox(
                                  height: 5.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 30.0),
                                  child: Container(
                                    width: 150,
                                    child: Text(
                                      "Note",
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
                              padding: const EdgeInsets.only(left: 115.0),
                              child: InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.more_horiz,
                                  color: Colors.grey,
                                ),
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
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 30.0),
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
                                  padding: const EdgeInsets.only(left: 30.0),
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
                                SizedBox(
                                  height: 5.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 30.0),
                                  child: Container(
                                    width: 150,
                                    child: Text(
                                      "Note",
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
                              padding: const EdgeInsets.only(left: 115.0),
                              child: InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.more_horiz,
                                  color: Colors.grey,
                                ),
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
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 30.0),
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
                                  padding: const EdgeInsets.only(left: 30.0),
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
                                SizedBox(
                                  height: 5.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 30.0),
                                  child: Container(
                                    width: 150,
                                    child: Text(
                                      "Note",
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
                              padding: const EdgeInsets.only(left: 115.0),
                              child: InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.more_horiz,
                                  color: Colors.grey,
                                ),
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
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 30.0),
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
                                  padding: const EdgeInsets.only(left: 30.0),
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
                                SizedBox(
                                  height: 5.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 30.0),
                                  child: Container(
                                    width: 150,
                                    child: Text(
                                      "Note",
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
                              padding: const EdgeInsets.only(left: 115.0),
                              child: InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.more_horiz,
                                  color: Colors.grey,
                                ),
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
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 30.0),
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
                                    padding: const EdgeInsets.only(left: 30.0),
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
                                SizedBox(
                                  height: 5.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 30.0),
                                  child: Container(
                                    width: 150,
                                    child: Text(
                                      "Note",
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
                              padding: const EdgeInsets.only(left: 115.0),
                              child: InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.more_horiz,
                                  color: Colors.grey,
                                ),
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
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 30.0),
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
                                  padding: const EdgeInsets.only(left: 30.0),
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
                                SizedBox(
                                  height: 5.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 30.0),
                                  child: Container(
                                    width: 150,
                                    child: Text(
                                      "Note",
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
                              padding: const EdgeInsets.only(left: 115.0),
                              child: InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.more_horiz,
                                  color: Colors.grey,
                                ),
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