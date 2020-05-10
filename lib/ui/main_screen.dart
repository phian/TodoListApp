import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import './dates_list.dart';

int _lastFocusedIndex = 0; // biến để check xem Icon thứ mấy dc focus trc đó
String _dayName; // variables for displaying time in Calendar

GlobalKey _bottomMenuKey = GlobalKey();

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TabController _tabController;
  List<String> _weekDates = []; // List để lưu 7 ngày trong tuần đó để hiển thị
  List<Widget> _dateCardList = []; // List chứa các widget hiển thị card ngày trên Calendar
  List<Widget> _dateNameList = []; // List chứa các widget để hiển thị
  List<String> _weekDateNames = ["S", "M", "T", "W", "T", "F", "S"]; // List để chứa các chữ cái đầu của tên của thứ trong tuần

  int _currentDateIndex; // Biến để chứa vị trí của ngày hiện tại trong tuần

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(vsync: this, length: 3);
    _initCalendarTime();

    for (int i = 0; i < 7; i++) {
      _weekDates.add(
          DateFormat('dd').format(DateTime.now().add(new Duration(days: i))));
    }

    for (int i = 0; i < 7; i++) {
      _dateCardList.add(_dateCard(_weekDates[i].toString()));
    }

    // Gọi hàm để check thứ tự ngày hiện tãi trong tuần
    _currentDateIndex = _currentDateNum();

    ///
    /// Xét xem ngày hiện tại là thứ mấy
    /// + Nếu là chủ nhất thì add week name theo thứ tự mặc định trong list
    /// + Ngược lại thì chia ra 2 làm 2 vòng lặp, vòng lặp 1 để add từ vị trí
    /// hiện tại đến hết list và vòng lặp 2 để swap các ngày trc ngày hiện tại
    /// ra phía sau
    ///
    if (_currentDateIndex == 7) {
      for (int i = 0; i < 7; i++) {
        _dateNameList.add(_weekDateName(_weekDateNames[i].toString()));
      }
    } else {
      for (int j = _currentDateIndex; j < 7; j++) {
        _dateNameList.add(_weekDateName(_weekDateNames[j].toString()));
      }

      for (int i = 0; i < _currentDateIndex; i++) {
        _dateNameList.add(_weekDateName(_weekDateNames[i].toString()));
      }
    }

    setState(() {});
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
                  width: MediaQuery.of(context).size.width,
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
                                  '$_dayName',
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
                                    _dateNameList[0],
                                    _dateNameList[1],
                                    _dateNameList[2],
                                    _dateNameList[3],
                                    _dateNameList[4],
                                    _dateNameList[5],
                                    _dateNameList[6],
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
                                    _dateCardList[0],
                                    _dateCardList[1],
                                    _dateCardList[2],
                                    _dateCardList[3],
                                    _dateCardList[4],
                                    _dateCardList[5],
                                    _dateCardList[6],
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
                "Recent",
                style: TextStyle(color: Colors.red.shade900),
              )),
          BubbleBottomBarItem(
              backgroundColor: Colors.deepPurple,
              icon: Icon(CupertinoIcons.check_mark_circled_solid,
                  size: 30, color: Colors.purple),
              activeIcon: Icon(CupertinoIcons.check_mark_circled_solid,
                  size: 30, color: Colors.indigo),
              title: Text(
                "Goals",
                style: TextStyle(color: Colors.deepPurple.shade900),
              )),
          BubbleBottomBarItem(
              backgroundColor: Colors.teal,
              icon: Icon(CupertinoIcons.book,
                  size: 30, color: Colors.teal),
              activeIcon: Icon(CupertinoIcons.book,
                  size: 30, color: Colors.indigo),
              title: Text(
                "Tasks List",
                style: TextStyle(
                  color: Colors.teal.shade900,
                ),
              )),
          BubbleBottomBarItem(
              backgroundColor: Colors.green,
              icon: Icon(CupertinoIcons.settings, size: 30, color: Colors.cyan),
              activeIcon:
              Icon(CupertinoIcons.settings, size: 30, color: Colors.indigo),
              title: Text(
                "Settings",
                style: TextStyle(color: Colors.green.shade900),
              ))
        ],
      ),
    );
  }

  // Hàm để cập nhật vị trí tab hiện tại của bottom bar
  void _changePage(int value) {
    setState(() {
      _lastFocusedIndex = value;
    });
  }

  // Hàm để khởi tạo format ngày để hiển thị trên header ngày
  void _initCalendarTime() {
    // Lấy ngày hiện tại để hiển thị lên header ngày
    String formattedDate = DateFormat('EEEEEEEE dd MMM').format(DateTime.now());
    setState(() {
      _dayName = formattedDate;
    });
  }

  // Widget để hiển thị số trên Calendar
  Widget _dateCard(String dateNum) {
    return Container(
      width: 50,
      height: 70,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Color(0xFFBDBDBD).withOpacity(0.3)),
      child: Center(
        child: Text(
          "$dateNum",
          style: GoogleFonts.roboto(fontSize: 17.0, color: Colors.white),
        ),
      ),
    );
  }

  // Widget để hiển thị viết tắt của thứ trên Calendar
  Widget _weekDateName(String dateName) {
    return Text(
      "$dateName",
      style: GoogleFonts.roboto(fontSize: 17, color: Colors.white),
    );
  }

  // Hàm để xét xem ngày hiện tại đang là thứ mấy
  int _currentDateNum() {
    int currentIndex;

    currentIndex = DateTime.now().weekday;

    return currentIndex;
  }
}
