import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './dates_list.dart';
import 'tasks_icon.dart';

// Màu dùng cho các nút đang dc focus
MaterialColor _focusedIconColor1;
MaterialColor _focusedIconColor2;
MaterialColor _focusedIconColor3;
MaterialColor _focusedIconColor4;
int _lastFocusedIndex = 0; // biến để check xem Icon thứ mấy dc focus trc đó
String _dayName,
    _dateNumber,
    _month; // variables for displaying time in Calendar

GlobalKey _bottomMenuKey = GlobalKey();

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(vsync: this, length: 3);
    _initCalendarTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFFAF3F0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 7.0),
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 250,
                  decoration: BoxDecoration(
                      color: Color(0xFFFAF3F0),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3.0,
                          offset: Offset(0.0, 0.0),
                        ),
                      ]),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(30))),
                        height: 250,
                        child: ClipRRect(
                          child: Image.asset(
                            'images/calendar_background.png',
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, top: 25.0),
                                child: Text(
                                  'Tuesday ',
                                  textDirection: TextDirection.ltr,
                                  style: GoogleFonts.roboto(
                                      fontSize: 30, color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 25.0),
                                child: Text(
                                  '25,',
                                  textDirection: TextDirection.ltr,
                                  style: GoogleFonts.roboto(
                                      fontSize: 30, color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 25.0),
                                child: Text(
                                  ' Dec',
                                  textDirection: TextDirection.ltr,
                                  style: GoogleFonts.roboto(
                                      fontSize: 30, color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 55.0, top: 25.0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: 50,
                                      height: 50,
                                      child: FlatButton(
                                        onPressed: () {},
                                        child: Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      width: 50,
                                      height: 50,
                                      child: FlatButton(
                                        onPressed: () {},
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                      "S",
                                      textDirection: TextDirection.ltr,
                                      style: GoogleFonts.roboto(
                                          fontSize: 17, color: Colors.white),
                                    ),
                                    Text(
                                      "M",
                                      textDirection: TextDirection.ltr,
                                      style: GoogleFonts.roboto(
                                          fontSize: 17, color: Colors.white),
                                    ),
                                    Text(
                                      "T",
                                      textDirection: TextDirection.ltr,
                                      style: GoogleFonts.roboto(
                                          fontSize: 17, color: Colors.white),
                                    ),
                                    Text(
                                      "W",
                                      textDirection: TextDirection.ltr,
                                      style: GoogleFonts.roboto(
                                          fontSize: 17, color: Colors.white),
                                    ),
                                    Text(
                                      "T",
                                      textDirection: TextDirection.ltr,
                                      style: GoogleFonts.roboto(
                                          fontSize: 17, color: Colors.white),
                                    ),
                                    Text(
                                      "F",
                                      textDirection: TextDirection.ltr,
                                      style: GoogleFonts.roboto(
                                          fontSize: 17, color: Colors.white),
                                    ),
                                    Text(
                                      "S",
                                      textDirection: TextDirection.ltr,
                                      style: GoogleFonts.roboto(
                                          fontSize: 17, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20.0, top: 15.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                      width: 50,
                                      height: 70,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(15),
                                          color: Color(0xFFBDBDBD)),
                                      child: Center(
                                        child: Text(
                                          "Ngày",
                                          textDirection: TextDirection.ltr,
                                          style: GoogleFonts.roboto(
                                              fontSize: 17.0,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 50,
                                      height: 70,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(15),
                                          color: Color(0xFFBDBDBD)),
                                      child: Center(
                                        child: Text(
                                          "Ngày",
                                          textDirection: TextDirection.ltr,
                                          style: GoogleFonts.roboto(
                                              fontSize: 17.0,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 50,
                                      height: 70,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(15),
                                          color: Color(0xFFBDBDBD)),
                                      child: Center(
                                        child: Text(
                                          "Ngày",
                                          textDirection: TextDirection.ltr,
                                          style: GoogleFonts.roboto(
                                              fontSize: 17.0,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 50,
                                      height: 70,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(15),
                                          color: Color(0xFFBDBDBD)),
                                      child: Center(
                                        child: Text(
                                          "Ngày",
                                          textDirection: TextDirection.ltr,
                                          style: GoogleFonts.roboto(
                                              fontSize: 17.0,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 50,
                                      height: 70,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(15),
                                          color: Color(0xFFBDBDBD)),
                                      child: Center(
                                        child: Text(
                                          "Ngày",
                                          textDirection: TextDirection.ltr,
                                          style: GoogleFonts.roboto(
                                              fontSize: 17.0,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 50,
                                      height: 70,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(15),
                                          color: Color(0xFFBDBDBD)),
                                      child: Center(
                                        child: Text(
                                          "Ngày",
                                          textDirection: TextDirection.ltr,
                                          style: GoogleFonts.roboto(
                                              fontSize: 17.0,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 50,
                                      height: 70,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(15),
                                          color: Color(0xFFBDBDBD)),
                                      child: Center(
                                        child: Text(
                                          "Ngày",
                                          textDirection: TextDirection.ltr,
                                          style: GoogleFonts.roboto(
                                              fontSize: 17.0,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: FlatButton(
                              onPressed: () {},
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Stack(
                                  children: <Widget>[
                                    Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.white,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 7.0),
                                      child: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: SizedBox(
                height: 50,
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.transparent,
                  unselectedLabelColor: Color(0xFF4DB6AC),
                  labelColor: Color(0xFF00695C),
//                  indicator: BoxDecoration(
//                      gradient: LinearGradient(
//                          colors: [Color(0xFF2E7D32), Color(0xFFB9F6CA)]),
////                    color: Color(0xFFB9F6CA),
////                    borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
//                      borderRadius: BorderRadius.circular(50)
//                  ),
                  tabs: <Widget>[
                    Tab(
                      child: Icon(
                        Icons.today,
                        size: 30,
                      ),
                    ),
                    Tab(
                        child: Icon(
                          Icons.event,
                          size: 30,
                        )),
                    Tab(
                        child: Icon(
                          Icons.assistant_photo,
                          size: 30,
                        )),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  DatesListScreen(),
                  DatesListScreen(),
                  DatesListScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: 55.0,
        height: 55.0,
        child: FloatingActionButton(
          elevation: 2.0,
          tooltip: 'Add new task',
          child: Icon(Icons.add),
          onPressed: () {
            print('Tapped');
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BubbleBottomBar(
        backgroundColor: Color(0xFFFAF3F0),
        opacity: .2,
        currentIndex: _lastFocusedIndex,
        onTap: _changePage,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        //new
        fabLocation: BubbleBottomBarFabLocation.end,
        //new
        hasNotch: true,
        //new, gives a cute ink effect
        hasInk: true,
        //optional, uses theme color if not specified
        inkColor: Colors.black12,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Colors.redAccent,
              icon: Icon(CupertinoIcons.tags, size: 30, color: Colors.red),
              activeIcon:
              Icon(CupertinoIcons.tags, size: 30, color: Colors.indigo),
              title: Text(
                "Tasks",
                style: TextStyle(color: Colors.red.shade900),)),
          BubbleBottomBarItem(
              backgroundColor: Colors.deepPurple,
              icon: Icon(CupertinoIcons.check_mark_circled_solid,
                  size: 30, color: Colors.purple),
              activeIcon: Icon(CupertinoIcons.check_mark_circled_solid,
                  size: 30, color: Colors.indigo),
              title: Text("Goals",
                style: TextStyle(
                    color: Colors.deepPurple.shade900
                ),)),
          BubbleBottomBarItem(
              backgroundColor: Colors.teal,
              icon: Icon(CupertinoIcons.profile_circled,
                  size: 30, color: Colors.teal),
              activeIcon: Icon(CupertinoIcons.profile_circled,
                  size: 30, color: Colors.indigo),
              title: Text(
                "Profile",
                style: TextStyle(
                  color: Colors.teal.shade900,
                ),
              )),
          BubbleBottomBarItem(
              backgroundColor: Colors.green,
              icon: Icon(CupertinoIcons.settings, size: 30, color: Colors.cyan),
              activeIcon:
              Icon(CupertinoIcons.settings, size: 30, color: Colors.indigo),
              title: Text("Settings",
                style: TextStyle(
                    color: Colors.green.shade900
                ),))
        ],
      ),
    );
  }

  void _changePage(int value) {
    setState(() {
      _lastFocusedIndex = value;
    });
  }

  void _initCalendarTime() {}
}
