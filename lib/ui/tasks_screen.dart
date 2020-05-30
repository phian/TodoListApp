import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './dates_list.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen>
    with TickerProviderStateMixin {
  TabController _tabController;
  List<String> _weekDates = []; // List để lưu 7 ngày trong tuần đó để hiển thị
  List<Widget> _dateCardList =
      []; // List chứa các widget hiển thị card ngày trên Calendar
  List<Widget> _dateNameList = []; // List chứa các widget để hiển thị
  List<String> _weekDateNames = [
    "S",
    "M",
    "T",
    "W",
    "T",
    "F",
    "S"
  ]; // List để chứa các chữ cái đầu của tên của thứ trong tuần

  int _currentDateIndex; // Biến để chứa vị trí của ngày hiện tại trong tuần
  int _increaseClickedTime =
      0; // Biến để check xem ng dùng đã chuyển qua bao nhiêu tuần
  int _decreaseClickedTime =
      0; // Biến để check xem ng dùng đã chuyển qua bao nhiêu tuần
  int _lastFocusDate =
      0; // Biến để check xem giá trị ngày trc đó đang dc chọn là ngày nào

  String _dayName; // variables for displaying time in Calendar

  DateTime _pickedDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(vsync: this, length: 3);
    _initCalendarTime();
    _initCalendarCardsDate();

    // Gọi hàm để check thứ tự ngày hiện tãi trong tuần
    _currentDateIndex = _currentDateNum();
    _lastFocusDate = int.parse(_weekDates[0]);

    _addValueForDateNameList();
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
                          Stack(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, top: 25.0),
                                child: Text(
                                  '$_dayName',
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 30,
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width * 0.7,
                                    top: 20.0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: 50,
                                      height: 50,
                                      child: FlatButton(
                                        onPressed: _decreaseWeekDates,
                                        child: Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Container(
                                      width: 50,
                                      height: 50,
                                      child: FlatButton(
                                        onPressed: _increaseWeekDates,
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
                              Container(
                                padding: EdgeInsets.only(
                                    top: 20.0,
                                    left:
                                        MediaQuery.of(context).size.width / 25,
                                    right:
                                        MediaQuery.of(context).size.width / 27),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                              Container(
                                padding: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width / 25,
                                    right:
                                        MediaQuery.of(context).size.width / 25,
                                    top: MediaQuery.of(context).size.height /
                                        100),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    InkWell(
                                      child: _dateCardList[0],
                                      onTap: () {
                                        _changeFocusedCardColor(0);
                                      },
                                    ),
                                    InkWell(
                                      child: _dateCardList[1],
                                      onTap: () {
                                        _changeFocusedCardColor(1);
                                      },
                                    ),
                                    InkWell(
                                      child: _dateCardList[2],
                                      onTap: () {
                                        _changeFocusedCardColor(2);
                                      },
                                    ),
                                    InkWell(
                                      child: _dateCardList[3],
                                      onTap: () {
                                        _changeFocusedCardColor(3);
                                      },
                                    ),
                                    InkWell(
                                      child: _dateCardList[4],
                                      onTap: () {
                                        _changeFocusedCardColor(4);
                                      },
                                    ),
                                    InkWell(
                                      child: _dateCardList[5],
                                      onTap: () {
                                        _changeFocusedCardColor(5);
                                      },
                                    ),
                                    InkWell(
                                      child: _dateCardList[6],
                                      onTap: () {
                                        _changeFocusedCardColor(6);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: FlatButton(
                              onPressed: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: _pickedDate == null
                                            ? DateTime.now()
                                            : _pickedDate,
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2200))
                                    .then((date) {
                                  setState(() {
                                    _pickedDate = date;

                                    if (_pickedDate.month -
                                            DateTime.now().month ==
                                        0) {
                                      if (_pickedDate.day -
                                                  DateTime.now().day >=
                                              0 &&
                                          _pickedDate.day - DateTime.now().day <
                                              7) {
                                        for (int i = 0; i < 7; i++) {
                                          if (int.parse(_weekDates[i]) ==
                                              _pickedDate.day) {
                                            _changeFocusedCardColor(i);
                                            break;
                                          }
                                        }
                                      } else if (_pickedDate.day -
                                              DateTime.now().day >
                                          7) {
                                        _increaseTimeToSelectedDate(0);
                                      } else {
                                        _decreaseTimeToSelectedDate(0);
                                      }
                                    } else if (_pickedDate.month -
                                            DateTime.now().month >
                                        0) {
                                      _increaseTimeToSelectedDate(
                                          _pickedDate.month -
                                              DateTime.now().month);
                                    } else {
                                      _decreaseTimeToSelectedDate(
                                          DateTime.now().month -
                                              _pickedDate.month);
                                    }
                                  });
                                });
                              },
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
    );
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
  Widget _dateCard(String dateNum, double opacity, [Color color]) {
    return Container(
      width: 50,
      height: 70,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xFFBDBDBD).withOpacity(opacity)),
      child: Center(
        child: Text(
          "$dateNum",
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 17.0,
              color: color == null ? Colors.white : color),
        ),
      ),
    );
  }

  // Widget để hiển thị viết tắt của thứ trên Calendar
  Widget _weekDateName(String dateName) {
    return Text(
      "$dateName",
      style: TextStyle(fontSize: 17, color: Colors.white, fontFamily: 'Roboto'),
    );
  }

  // Hàm để xét xem ngày hiện tại đang là thứ mấy
  int _currentDateNum() {
    int currentIndex;

    currentIndex = DateTime.now().weekday;

    return currentIndex;
  }

  // Hàm để chuyển ngày thành số ngày của tuần kế tiếp
  void _increaseWeekDates() {
    setState(() {
      // Nếu chiều nào tăng thì chiều còn lại sẽ giảm
      _increaseClickedTime++;
      _decreaseClickedTime--;

      // Reset các list về rỗng để add dữ liệu mới
      _weekDates = [];
      _dateCardList = [];

      for (int i = 0; i < 7; i++) {
        _weekDates.add(DateFormat('dd').format(DateTime.now()
            .add(new Duration(days: i + 7 * _increaseClickedTime))));
      }

      // Add hiển thị của card ra screen
      for (int i = 0; i < 7; i++) {
        double opacity = 0;
        opacity = _lastFocusDate == int.parse(_weekDates[i])
            ? 0.85
            : 0.3; // Nếu ngày đang focus có trong tuần đang xem
        _dateCardList
            .add(_dateCard(_weekDates[i].toString(), opacity, Colors.white));
      }
      if (_lastFocusDate != int.parse(_weekDates[0])) {
        if (_decreaseClickedTime == 0)
          _dateCardList[0] =
              _dateCard(_weekDates[0], 0.3, Colors.yellow.shade500);
      }
    });
  }

  // Hàm để chuyển ngày thành số ngày của tuần kế tiếp
  void _decreaseWeekDates() {
    setState(() {
      // Nếu chiều nào tăng thì chiều còn lại sẽ giảm
      _decreaseClickedTime++;
      _increaseClickedTime--;

      // Reset các list về rỗng để add dữ liệu mới
      _weekDates = [];
      _dateCardList = [];

      for (int i = 0; i < 7; i++) {
        _weekDates.add(DateFormat('dd').format(DateTime.now()
            .add(new Duration(days: i - 7 * _decreaseClickedTime))));
      }

      // Add hiển thị của card ra screen
      for (int i = 0; i < 7; i++) {
        double opacity = 0;
        opacity = _lastFocusDate == int.parse(_weekDates[i])
            ? 0.85
            : 0.3; // Nếu ngày đang focus có trong tuần đang xem
        _dateCardList
            .add(_dateCard(_weekDates[i].toString(), opacity, Colors.white));
      }
      if (_lastFocusDate != int.parse(_weekDates[0])) {
        if (_decreaseClickedTime == 0)
          _dateCardList[0] =
              _dateCard(_weekDates[0], 0.3, Colors.yellow.shade500);
      }
    });
  }

  // Hàm sự kiện để thay đổi màu thẻ khi thẻ được focus
  void _changeFocusedCardColor(int selectedIndex, [bool isIncreaseOrDecrease]) {
    setState(() {
      // Nếu ng dùng đang dừng ở tuần khác hiện tại
      if (_increaseClickedTime != 0 && _decreaseClickedTime != 0) {
        if (isIncreaseOrDecrease == null) {
          // Nếu ng dùng ko dùng Calendar để chọn ngày
          if (int.parse(_weekDates[selectedIndex]) != _lastFocusDate) {
            _dateCardList[selectedIndex] =
                _dateCard(_weekDates[selectedIndex], 0.85);
            _lastFocusDate = int.parse(_weekDates[selectedIndex]);

            for (int i = 0; i < 7; i++) {
              if (selectedIndex != i) {
                _dateCardList[i] = _dateCard(_weekDates[i], 0.3);
              }
            }
          }
        } else {
          if (isIncreaseOrDecrease) {
            // Nếu ng dùng có dùng Calendar để chọn ngày
            if (int.parse(_weekDates[selectedIndex]) == _lastFocusDate) {
              _dateCardList[selectedIndex] =
                  _dateCard(_weekDates[selectedIndex], 0.85);
              _lastFocusDate = int.parse(_weekDates[selectedIndex]);

              for (int i = 0; i < 7; i++) {
                if (selectedIndex != i) {
                  _dateCardList[i] = _dateCard(_weekDates[i], 0.3);
                }
              }
            }
          }
        }
      } else if (_increaseClickedTime == 0 && _decreaseClickedTime == 0) {
        // Nếu ng dùng đang dừng ở tuần hiện tại
        if (selectedIndex == 0) {
          _dateCardList[0] = _dateCard(_weekDates[0].toString(), 0.85);
          _lastFocusDate = int.parse(_weekDates[selectedIndex]);
          for (int i = 1; i < 7; i++) {
            if (selectedIndex != i) {
              _dateCardList[i] = _dateCard(_weekDates[i], 0.3);
            }
          }
        } else {
          if (int.parse(_weekDates[selectedIndex]) != _lastFocusDate) {
            _dateCardList[0] = _dateCard(
                _weekDates[0].toString(), 0.3, Colors.yellow.shade500);
            _dateCardList[selectedIndex] =
                _dateCard(_weekDates[selectedIndex], 0.85);
            _lastFocusDate = int.parse(_weekDates[selectedIndex]);

            for (int i = 1; i < 7; i++) {
              if (selectedIndex != i) {
                _dateCardList[i] = _dateCard(_weekDates[i], 0.3);
              }
            }
          }
        }
      }
    });
  }

  // Hàm để tăng thời gian đến ngày ng dùng chọn
  void _increaseTimeToSelectedDate(int monthDistance) {
    bool _reachedDate =
        false; // Biến để check xem đã đến dc ngày mà ng dùng pick hay chưa?
    int checkMonthDistance =
        0; // biến để check xem đã đến đúng tháng ng dùng chọn hay chưa
    int focusIndex =
        -1; // Biến để check xem ngày ở vị trí nào của date card list cần thay đổi màu focus

    if (monthDistance == 0) {
      _increaseClickedTime = 0;
      _decreaseClickedTime = 0;

      while (true) {
        _weekDates = [];
        _dateCardList = [];

        for (int i = 0; i < 7; i++) {
          _weekDates.add(DateFormat('dd').format(DateTime.now()
              .add(new Duration(days: i + 7 * _increaseClickedTime))));
          _dateCardList.add(_dateCard(_weekDates[i], 0.3));
          if (int.parse(_weekDates[i]) == _pickedDate.day) {
            _reachedDate = true;
            focusIndex = i;
          }
        }

        if (_reachedDate) {
          _lastFocusDate = int.parse(_weekDates[focusIndex]);
          _changeFocusedCardColor(focusIndex, true);
          return;
        } else {
          _increaseClickedTime++;
          _decreaseClickedTime--;
        }
      }
    } else {
      _increaseClickedTime = 0;
      _decreaseClickedTime = 0;

      while (true) {
        _weekDates = [];
        _dateCardList = [];

        for (int i = 0; i < 7; i++) {
          _weekDates.add(DateFormat('dd').format(DateTime.now()
              .add(new Duration(days: i + 7 * _increaseClickedTime))));
          _dateCardList.add(_dateCard(_weekDates[i], 0.3));
          if (int.parse(_weekDates[i]) == _pickedDate.day) {
            if (checkMonthDistance == monthDistance) {
              _reachedDate = true;
              focusIndex = i;
            } else if (DateTime.now()
                    .add(new Duration(days: i + 7 * _increaseClickedTime))
                    .month !=
                DateTime.now().month) checkMonthDistance++;
          }
          if (_reachedDate && i > 6) {
            break;
          }
        }

        if (_reachedDate == true) {
          _lastFocusDate = int.parse(_weekDates[focusIndex]);
          _changeFocusedCardColor(focusIndex, true);
          return;
        } else {
          _increaseClickedTime++;
          _decreaseClickedTime--;
        }
      }
    }
  }

  // Hàm đẻ giảm ngày đến ngày mà ng dùng chọn
  void _decreaseTimeToSelectedDate(int monthDistance) {
    bool _reachedDate =
        false; // Biến để check xem đã đến dc ngày mà ng dùng pick hay chưa?
    int checkMonthDistance =
        0; // biến để check xem đã đến đúng tháng ng dùng chọn hay chưa
    int focusIndex;

    if (monthDistance == 0) {
      _increaseClickedTime = 0;
      _decreaseClickedTime = 0;

      while (true) {
        _weekDates = [];
        _dateCardList = [];

        for (int i = 0; i < 7; i++) {
          _weekDates.add(DateFormat('dd').format(_pickedDate
              .add(new Duration(days: i - 7 * _decreaseClickedTime))));
          _dateCardList.add(_dateCard(_weekDates[i], 0.3));
          if (int.parse(_weekDates[i]) == _pickedDate.day) {
            _reachedDate = true;
            focusIndex = i;
          }
        }

        if (_reachedDate == true) {
          _lastFocusDate = int.parse(_weekDates[focusIndex]);
          _changeFocusedCardColor(focusIndex, true);
          break;
        } else {
          _decreaseClickedTime++;
          _increaseClickedTime--;
        }
      }
    } else {
      _increaseClickedTime = 0;
      _decreaseClickedTime = 0;

      while (true) {
        _weekDates = [];
        _dateCardList = [];

        for (int i = 0; i < 7; i++) {
          _weekDates.add(DateFormat('dd').format(_pickedDate
              .add(new Duration(days: i - 7 * _decreaseClickedTime))));
          _dateCardList.add(_dateCard(_weekDates[i], 0.3));
          if (int.parse(_weekDates[i]) == _pickedDate.day) {
            if (checkMonthDistance == monthDistance) {
              _reachedDate = true;
              focusIndex = i;
            } else if (_pickedDate
                    .add(new Duration(days: i - 7 * _decreaseClickedTime))
                    .month !=
                DateTime.now().month) checkMonthDistance++;
          }
        }

        if (_reachedDate == true) {
          _lastFocusDate = int.parse(_weekDates[focusIndex]);
          _changeFocusedCardColor(focusIndex, true);
          break;
        } else {
          _decreaseClickedTime++;
          _increaseClickedTime--;
        }
      }
    }
  }

  // Hàm để khởi tạo giá trị ngày cho calendar cards
  void _initCalendarCardsDate() {
    for (int i = 0; i < 7; i++) {
      _weekDates.add(
          DateFormat('dd').format(DateTime.now().add(new Duration(days: i))));
    }

    for (int i = 0; i < 7; i++) {
      double opacity = i == 0 ? 0.85 : 0.3;
      _dateCardList.add(_dateCard(_weekDates[i].toString(), opacity));
    }
  }

  // Hàm để add value cho date name list
  void _addValueForDateNameList() {
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
  }
}
