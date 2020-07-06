import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/data/repeat_choice_data.dart';

class RepeatSheet extends StatefulWidget {
  RepeatChoiceData repeatChoiceData =
      RepeatChoiceData(); // Biến để lưu trữ các data cần thiết khi người dùng hoàn thành set up để lưu trữ dữ liệu
  final RepeatChoiceData initChoiceData;

  RepeatSheet({this.initChoiceData}) {
    repeatChoiceData = initChoiceData;
  }

  @override
  _RepeatSheetState createState() => _RepeatSheetState();
}

class _RepeatSheetState extends State<RepeatSheet> {
  List<double> _opacitiesForFirstMenu = [1.0, 0.0];
  bool _isSecondMenuVisible = false;

  List<double> _opacitiesForSecondMenu = [1.0, 0.0, 0.0, 0.0];
  int _lastSelectedIndexInSecondMenu = 0;

  String _sRepeatTimeCount = "1";
  String _sRepeatTimeCount1 = "day";
  int _iRepeatTimeCount = 1;
  List<String> _dailyChoiceCardContents = ["S", "M", "T", "W", "T", "F", "S"];
  List<Widget> _dailyChoiceCards;
  List<int> _selectedIndex;
  bool _isWeeklyRepeat = false;

  bool _isMonthlyRepeat = false;
  List<double> _opacitiesForFourthMenu = [1.0, 0.0];
  String _monthlyRepeatDateName;
  String _monthlyRepeatTimeOrder;

  List<double> _opacitiesForFifthMenu = [1.0, 0.0, 0.0];
  String _endSecondChoiceText = "After a number of times", _endSecondChoiceMultiCountText;
  int _endSecondChoiceCount;
  bool _isSecondChoiceButtonVisible = false;

  String _endDay; // Biến để hiển thị format cho ngày mà người dùng chọn trong phần ENDS
  DateTime _initTimeForEndDay;

  @override
  void initState() {
    super.initState();

    _initDailyRepeatCardList();
    _initTimeForEndDay = DateTime.now();
    _endDay = null;

    if (isNormalFirstTime == false) _initPreviousChoiceState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
        color: Colors.white,
      ),
      child: ListView(
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 12.0),
                  child: Text(
                    'REPEATS SET UP',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  onTap: () {
                    setState(() {
                      _opacitiesForFirstMenu[0] = 1.0;
                      _opacitiesForFirstMenu[1] = 0.0;

                      _opacitiesForFourthMenu[0] = 1.0;
                      _opacitiesForFourthMenu[1] = 0.0;

                      _isSecondMenuVisible = false;
                      _isWeeklyRepeat = false;
                      _isMonthlyRepeat = false;

                      _resetFrequencyWidgetState();
                      _changeEndsWidgetIconOpacity(0);
                      _initDailyRepeatCardList();

                      widget.repeatChoiceData = RepeatChoiceData();
                    });
                  },
                  title: Text("Off"),
                  leading: Opacity(
                    opacity: _opacitiesForFirstMenu[0],
                    child: Icon(Icons.check),
                  ),
                ),
                ListTile(
                  onTap: () {
                    setState(() {
                      _opacitiesForFirstMenu[0] = 0.0;
                      _opacitiesForFirstMenu[1] = 1.0;

                      _isSecondMenuVisible = true;

                      widget.repeatChoiceData.isOnOrOff = 1;
                    });
                  },
                  title: Text("On complete"),
                  leading: Opacity(
                    opacity: _opacitiesForFirstMenu[1],
                    child: Icon(Icons.check),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Visibility(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Text(
                          "FREQUENCY",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        ListTile(
                          onTap: () {
                            // Gán để biết rằng ng dùng đã có set up schedule
                            isNormalFirstTime = false;

                            _changeSecondMenuIconOpacity(0);

                            _isWeeklyRepeat = false;
                            _isMonthlyRepeat = false;
                            _selectedIndex = [];
                            widget.repeatChoiceData.weekRepeatDateChoiceIndex = [];

                            _resetMonthlyChoiceIconOpacity();

                            widget.repeatChoiceData.frequencyChoice = 0;
                          },
                          title: Text("Daily"),
                          leading: Opacity(
                            opacity: _opacitiesForSecondMenu[0],
                            child: Icon(Icons.check),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            _changeSecondMenuIconOpacity(1);

                            if (_isWeeklyRepeat == false) {
                              _isWeeklyRepeat = true;
                              _isMonthlyRepeat = false;

                              _initDailyRepeatCardList();
                            }

                            _resetMonthlyChoiceIconOpacity();

                            widget.repeatChoiceData.frequencyChoice = 1;
                          },
                          title: Text("Weekly"),
                          leading: Opacity(
                            opacity: _opacitiesForSecondMenu[1],
                            child: Icon(Icons.check),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            _changeSecondMenuIconOpacity(2);

                            if (_isMonthlyRepeat == false) {
                              _isMonthlyRepeat = true;
                              _isWeeklyRepeat = false;
                            }
                            _selectedIndex = [];
                            widget.repeatChoiceData.weekRepeatDateChoiceIndex = [];

                            _changeMonthlyRepeatDateName();
                            _calculateOrderPlaceOfCurrentDate();

                            widget.repeatChoiceData.frequencyChoice = 2;
                          },
                          title: Text("Monthly"),
                          leading: Opacity(
                            opacity: _opacitiesForSecondMenu[2],
                            child: Icon(Icons.check),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            _changeSecondMenuIconOpacity(3);

                            _isWeeklyRepeat = false;
                            _isMonthlyRepeat = false;
                            _selectedIndex = [];
                            widget.repeatChoiceData.weekRepeatDateChoiceIndex = [];

                            _resetMonthlyChoiceIconOpacity();

                            widget.repeatChoiceData.frequencyChoice = 3;
                          },
                          title: Text("Yearly"),
                          leading: Opacity(
                            opacity: _opacitiesForSecondMenu[3],
                            child: Icon(Icons.check),
                          ),
                        ),
                      ],
                    ),
                  ),
                  visible: _isSecondMenuVisible,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Visibility(
                  visible: _isSecondMenuVisible,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: <Widget>[
                        Text(
                          "REPEAT EVERY",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Stack(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 2.0),
                              child: ListTile(
                                leading: Icon(
                                  Icons.check,
                                  color: Colors.transparent,
                                ),
                                title: Text("$_sRepeatTimeCount $_sRepeatTimeCount1"),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 15.0, left: MediaQuery.of(context).size.width / 2.6),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 70.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
                                      border: Border.all(color: Colors.black),
                                    ),
                                    height: 30.0,
                                    child: FlatButton(
                                      child: Center(child: Icon(Icons.remove)),
                                      onPressed: () {
                                        setState(() {
                                          if (_iRepeatTimeCount > 1) {
                                            _iRepeatTimeCount--;
                                            _sRepeatTimeCount = _iRepeatTimeCount.toString();

                                            widget.repeatChoiceData.repeatTimes = _iRepeatTimeCount;

                                            _changeRepeatCountTextToMultiple();
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: 70.0,
                                    transform: Matrix4.translationValues(-1.0, 0.0, 0.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0)),
                                      border: Border.all(color: Colors.black),
                                    ),
                                    height: 30.0,
                                    child: FlatButton(
                                      child: Center(child: Icon(Icons.add)),
                                      onPressed: () {
                                        setState(() {
                                          _iRepeatTimeCount++;
                                          _sRepeatTimeCount = _iRepeatTimeCount.toString();

                                          widget.repeatChoiceData.repeatTimes = _iRepeatTimeCount;

                                          _changeRepeatCountTextToMultiple();
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          child: Stack(
                            children: <Widget>[
                              Visibility(
                                child: Center(
                                    child: Text(
                                  "REPEAT ON",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                                visible: (_isWeeklyRepeat == false && _isMonthlyRepeat == false) ? false : true,
                              ),
                              Visibility(
                                visible: _isWeeklyRepeat,
                                child: Container(
                                  padding: EdgeInsets.only(top: 15.0),
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        leading: Icon(
                                          Icons.check,
                                          color: Colors.transparent,
                                        ),
                                        title: Row(
                                          children: <Widget>[
                                            InkWell(
                                              child: _dailyChoiceCards[0],
                                              onTap: () {
                                                _changeDailyRepeatCardColor(0);
                                              },
                                            ),
                                            InkWell(
                                              child: _dailyChoiceCards[1],
                                              onTap: () {
                                                _changeDailyRepeatCardColor(1);
                                              },
                                            ),
                                            InkWell(
                                              child: _dailyChoiceCards[2],
                                              onTap: () {
                                                _changeDailyRepeatCardColor(2);
                                              },
                                            ),
                                            InkWell(
                                              child: _dailyChoiceCards[3],
                                              onTap: () {
                                                _changeDailyRepeatCardColor(3);
                                              },
                                            ),
                                            InkWell(
                                              child: _dailyChoiceCards[4],
                                              onTap: () {
                                                _changeDailyRepeatCardColor(4);
                                              },
                                            ),
                                            InkWell(
                                              child: _dailyChoiceCards[5],
                                              onTap: () {
                                                _changeDailyRepeatCardColor(5);
                                              },
                                            ),
                                            InkWell(
                                              child: _dailyChoiceCards[6],
                                              onTap: () {
                                                _changeDailyRepeatCardColor(6);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: _isMonthlyRepeat,
                                child: Container(
                                  padding: EdgeInsets.only(top: 15.0),
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        onTap: () {
                                          setState(() {
                                            _opacitiesForFourthMenu[1] = 0.0;
                                            _opacitiesForFourthMenu[0] = 1.0;

                                            widget.repeatChoiceData.monthlyRepeatChoice = 0;
                                          });
                                        },
                                        leading: Opacity(child: Icon(Icons.check), opacity: _opacitiesForFourthMenu[0]),
                                        title: Text("Day ${DateTime.now().day} of month"),
                                      ),
                                      ListTile(
                                        onTap: () {
                                          setState(() {
                                            _opacitiesForFourthMenu[1] = 1.0;
                                            _opacitiesForFourthMenu[0] = 0.0;

                                            widget.repeatChoiceData.monthlyRepeatChoice = 1;
                                          });
                                        },
                                        leading: Opacity(
                                          child: Icon(Icons.check),
                                          opacity: _opacitiesForFourthMenu[1],
                                        ),
                                        title: Text("Every $_monthlyRepeatTimeOrder $_monthlyRepeatDateName"),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "ENDS",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              ListTile(
                                onTap: () {
                                  _changeEndsWidgetIconOpacity(0);

                                  setState(() {
                                    _endSecondChoiceText = "After a number of times";
                                    _isSecondChoiceButtonVisible = false;

                                    _endDay = null;

                                    widget.repeatChoiceData.endsChoice = 0;
                                  });
                                },
                                leading: Opacity(
                                  child: Icon(Icons.check),
                                  opacity: _opacitiesForFifthMenu[0],
                                ),
                                title: Text("Never"),
                              ),
                              ListTile(
                                onTap: () {
                                  _changeEndsWidgetIconOpacity(1);
                                  setState(() {
                                    _endSecondChoiceCount = 1;
                                    _endSecondChoiceMultiCountText = "time";
                                    _endSecondChoiceText =
                                        "After $_endSecondChoiceCount $_endSecondChoiceMultiCountText";
                                    _isSecondChoiceButtonVisible = true;

                                    _endDay = null;

                                    widget.repeatChoiceData.endsChoice = 1;
                                  });
                                },
                                leading: Opacity(
                                  child: Icon(Icons.check),
                                  opacity: _opacitiesForFifthMenu[1],
                                ),
                                title: Row(
                                  children: <Widget>[
                                    Text("$_endSecondChoiceText"),
                                    Visibility(
                                      visible: _isSecondChoiceButtonVisible,
                                      child: Container(
                                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 40),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: 70.0,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
                                                border: Border.all(color: Colors.black),
                                              ),
                                              height: 30.0,
                                              child: FlatButton(
                                                child: Center(child: Icon(Icons.remove)),
                                                onPressed: () {
                                                  _onIncreaseOrDecreaseInEndsChoice(false);
                                                },
                                              ),
                                            ),
                                            Container(
                                              width: 70.0,
                                              transform: Matrix4.translationValues(-1.0, 0.0, 0.0),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(10.0),
                                                    bottomRight: Radius.circular(10.0)),
                                                border: Border.all(color: Colors.black),
                                              ),
                                              height: 30.0,
                                              child: FlatButton(
                                                child: Center(child: Icon(Icons.add)),
                                                onPressed: () {
                                                  _onIncreaseOrDecreaseInEndsChoice(true);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ListTile(
                                onTap: () {
                                  _changeEndsWidgetIconOpacity(2);

                                  setState(() {
                                    _endSecondChoiceText = "After a number of times";
                                    _isSecondChoiceButtonVisible = false;

                                    _endDay = DateFormat('dd MMMM yyyy').format(_initTimeForEndDay);

                                    showRoundedDatePicker(
                                      context: context,
                                      theme: ThemeData.dark(),
                                      initialDate: _initTimeForEndDay,
                                      firstDate: DateTime.now().subtract(Duration(days: 1)),
                                      lastDate: DateTime(2100),
                                    ).then((value) {
                                      setState(() {
                                        if (value != null) {
                                          widget.repeatChoiceData.endsDateChoice = value;
                                          _endDay = DateFormat('dd MMMM yyyy').format(value);
                                          _initTimeForEndDay = value;
                                        }
                                      });
                                    });

                                    widget.repeatChoiceData.endsChoice = 2;
                                  });
                                },
                                leading: Opacity(
                                  child: Icon(Icons.check),
                                  opacity: _opacitiesForFifthMenu[2],
                                ),
                                title: Text("On a date"),
                                trailing: Visibility(
                                  child: Text("$_endDay"),
                                  visible: _endDay == null ? false : true,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Hàm để khởi tạo cho các phần mà ng dùng đã chọn trc đó
  void _initPreviousChoiceState() {
    setState(() {
      if (widget.repeatChoiceData.isOnOrOff == 0) {
        _opacitiesForFirstMenu[0] = 1.0;
        _opacitiesForFirstMenu[1] = 0.0;

        _opacitiesForFourthMenu[0] = 1.0;
        _opacitiesForFourthMenu[1] = 0.0;

        _isSecondMenuVisible = false;
        _isWeeklyRepeat = false;
        _isMonthlyRepeat = false;

        _resetFrequencyWidgetState();
        _changeEndsWidgetIconOpacity(0);
        _initDailyRepeatCardList();
      } else {
        _opacitiesForFirstMenu[0] = 0.0;
        _opacitiesForFirstMenu[1] = 1.0;

        _isSecondMenuVisible = true;
      }

      if (widget.repeatChoiceData.isOnOrOff == 1) {
        switch (widget.repeatChoiceData.frequencyChoice) {
          case 0:
            _opacitiesForSecondMenu[0] = 1.0;
            _opacitiesForSecondMenu[1] = _opacitiesForSecondMenu[2] = _opacitiesForSecondMenu[3] = 0.0;
            _lastSelectedIndexInSecondMenu = 0;

            _iRepeatTimeCount = widget.repeatChoiceData.repeatTimes;
            _sRepeatTimeCount = _iRepeatTimeCount.toString();
            _changeRepeatCountTextToMultiple();
            break;
          case 1:
            _opacitiesForSecondMenu[1] = 1.0;
            _opacitiesForSecondMenu[0] = _opacitiesForSecondMenu[2] = _opacitiesForSecondMenu[3] = 0.0;

            _lastSelectedIndexInSecondMenu = 1;

            _iRepeatTimeCount = widget.repeatChoiceData.repeatTimes;
            _sRepeatTimeCount = _iRepeatTimeCount.toString();
            _changeRepeatCountTextToMultiple();
            break;
          case 2:
            _opacitiesForSecondMenu[2] = 1.0;
            _opacitiesForSecondMenu[1] = _opacitiesForSecondMenu[0] = _opacitiesForSecondMenu[3] = 0.0;
            _lastSelectedIndexInSecondMenu = 2;

            _isMonthlyRepeat = true;
            _isWeeklyRepeat = false;
            _calculateOrderPlaceOfCurrentDate();
            _changeMonthlyRepeatDateName();

            _iRepeatTimeCount = widget.repeatChoiceData.repeatTimes;
            _sRepeatTimeCount = _iRepeatTimeCount.toString();
            _changeRepeatCountTextToMultiple();
            break;
          case 3:
            _opacitiesForSecondMenu[3] = 1.0;
            _opacitiesForSecondMenu[1] = _opacitiesForSecondMenu[2] = _opacitiesForSecondMenu[0] = 0.0;

            _lastSelectedIndexInSecondMenu = 3;

            _iRepeatTimeCount = widget.repeatChoiceData.repeatTimes;
            _sRepeatTimeCount = _iRepeatTimeCount.toString();
            _changeRepeatCountTextToMultiple();
            break;
        }
      }

      if (widget.repeatChoiceData.frequencyChoice == 1) {
        _dailyChoiceCards = [];
        _selectedIndex = widget.repeatChoiceData.weekRepeatDateChoiceIndex;

        _isWeeklyRepeat = true;
        _isMonthlyRepeat = false;

        double transitionX = 0;

        for (int i = 0; i < 7; i++) {
          transitionX--;
          if (i == 0) {
            _dailyChoiceCards.add(_dailyRepeatChoiceCard(
              _dailyChoiceCardContents[i],
              transitionX,
              _selectedIndex.contains(i) ? Colors.black : Colors.white,
              _selectedIndex.contains(i) ? Colors.white : Colors.black,
              BorderRadius.only(topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
            ));
          } else if (i == _dailyChoiceCardContents.length - 1) {
            _dailyChoiceCards.add(_dailyRepeatChoiceCard(
              _dailyChoiceCardContents[i],
              transitionX,
              _selectedIndex.contains(i) ? Colors.black : Colors.white,
              _selectedIndex.contains(i) ? Colors.white : Colors.black,
              BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0)),
            ));
          } else {
            _dailyChoiceCards.add(_dailyRepeatChoiceCard(
              _dailyChoiceCardContents[i],
              transitionX,
              _selectedIndex.contains(i) ? Colors.black : Colors.white,
              _selectedIndex.contains(i) ? Colors.white : Colors.black,
              BorderRadius.all(Radius.circular(0.0)),
            ));
          }
        }
      } else if (widget.repeatChoiceData.frequencyChoice == 2) {
        if (widget.repeatChoiceData.monthlyRepeatChoice == 0) {
          _opacitiesForFourthMenu[0] = 1.0;
          _opacitiesForFourthMenu[1] = 0.0;
        } else {
          _opacitiesForFourthMenu[0] = 0.0;
          _opacitiesForFourthMenu[1] = 1.0;
        }
      }

      switch (widget.repeatChoiceData.endsChoice) {
        case 0:
          _changeEndsWidgetIconOpacity(0);
          break;
        case 1:
          _changeEndsWidgetIconOpacity(1);
          _isSecondChoiceButtonVisible = true;

          _endSecondChoiceCount = widget.repeatChoiceData.endsAfetrNumberOfTimesChoice;
          _endSecondChoiceMultiCountText = _endSecondChoiceCount > 1 ? "times" : "time";
          _endSecondChoiceText = "After $_endSecondChoiceCount $_endSecondChoiceMultiCountText";
          break;
        default:
          _changeEndsWidgetIconOpacity(2);

          _initTimeForEndDay = widget.repeatChoiceData.endsDateChoice;
          _endDay = DateFormat('dd MMMM yyyy').format(_initTimeForEndDay);
          break;
      }
    });
  }

  // Hàm để khởi tạo cho các ô đã

  // Card dùng cho phần pick thứ trong daily repeat
  Widget _dailyRepeatChoiceCard(
      String cardContent, double transitionX, Color backgroundColor, Color textColor, BorderRadius boxRadius) {
    return Container(
        transform: Matrix4.translationValues(transitionX, 0.0, 0.0),
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 15.0, right: 15.0),
        decoration:
            BoxDecoration(color: backgroundColor, border: Border.all(color: Colors.black), borderRadius: boxRadius),
        child: Text(
          "$cardContent",
          style: TextStyle(color: textColor),
        ));
  }

  // Hàm để khởi tạo các card cho phần pick thứ trong daily repeat
  void _initDailyRepeatCardList() {
    _dailyChoiceCards = [];
    _selectedIndex = [];

    double transitionX = 0.0;

    for (int i = 0; i < _dailyChoiceCardContents.length; i++) {
      transitionX--;
      if (i == 0) {
        _dailyChoiceCards.add(_dailyRepeatChoiceCard(
          _dailyChoiceCardContents[i],
          transitionX,
          Colors.white,
          Colors.black,
          BorderRadius.only(topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
        ));
      } else if (i == _dailyChoiceCardContents.length - 1) {
        _dailyChoiceCards.add(_dailyRepeatChoiceCard(
          _dailyChoiceCardContents[i],
          transitionX,
          Colors.white,
          Colors.black,
          BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0)),
        ));
      } else {
        _dailyChoiceCards.add(_dailyRepeatChoiceCard(
          _dailyChoiceCardContents[i],
          transitionX,
          Colors.white,
          Colors.black,
          BorderRadius.all(Radius.circular(0.0)),
        ));
      }
    }
  }

  // Hàm để thay đổi màu của card dc chọn (tick hoặc untick)
  void _changeDailyRepeatCardColor(int selectedIndex) {
    setState(() {
      if (_selectedIndex.toSet().toList().contains(selectedIndex) == false) {
        _selectedIndex.add(selectedIndex);
        widget.repeatChoiceData.weekRepeatDateChoiceIndex.add(selectedIndex);

        if (selectedIndex == 0) {
          _dailyChoiceCards[selectedIndex] = _dailyRepeatChoiceCard(
              _dailyChoiceCardContents[selectedIndex],
              selectedIndex == 0 ? 0.0 : -(selectedIndex + 1),
              Colors.black,
              Colors.white,
              BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              ));
        } else if (selectedIndex == _dailyChoiceCardContents.length - 1) {
          _dailyChoiceCards[selectedIndex] = _dailyRepeatChoiceCard(
              _dailyChoiceCardContents[selectedIndex],
              selectedIndex == 0
                  ? 0.0
                  : -(selectedIndex + 1)
                      .toDouble(), // Do khi chạy vòng lặp |trasitionX| luôn lớn hơn i (selectedIndex) một đơn vị
              Colors.black,
              Colors.white,
              BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ));
        } else {
          _dailyChoiceCards[selectedIndex] = _dailyRepeatChoiceCard(
              _dailyChoiceCardContents[selectedIndex],
              selectedIndex == 0
                  ? 0.0
                  : -(selectedIndex + 1)
                      .toDouble(), // Do khi chạy vòng lặp |trasitionX| luôn lớn hơn i (selectedIndex) một đơn vị
              Colors.black,
              Colors.white,
              BorderRadius.all(Radius.circular(0.0)));
        }
      } else {
        if (selectedIndex == 0) {
          _dailyChoiceCards[selectedIndex] = _dailyRepeatChoiceCard(
              _dailyChoiceCardContents[selectedIndex],
              selectedIndex == 0
                  ? 0.0
                  : -(selectedIndex + 1), // Do khi chạy vòng lặp |trasitionX| luôn lớn hơn i (selectedIndex) một đơn vị
              Colors.white,
              Colors.black,
              BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              ));
        } else if (selectedIndex == _dailyChoiceCardContents.length - 1) {
          _dailyChoiceCards[selectedIndex] = _dailyRepeatChoiceCard(
              _dailyChoiceCardContents[selectedIndex],
              selectedIndex == 0
                  ? 0.0
                  : -(selectedIndex + 1)
                      .toDouble(), // Do khi chạy vòng lặp |trasitionX| luôn lớn hơn i (selectedIndex) một đơn vị
              Colors.white,
              Colors.black,
              BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ));
        } else {
          _dailyChoiceCards[selectedIndex] = _dailyRepeatChoiceCard(
              _dailyChoiceCardContents[selectedIndex],
              selectedIndex == 0
                  ? 0.0
                  : -(selectedIndex + 1)
                      .toDouble(), // Do khi chạy vòng lặp |trasitionX| luôn lớn hơn i (selectedIndex) một đơn vị
              Colors.white,
              Colors.black,
              BorderRadius.all(Radius.circular(0.0)));
        }

        _selectedIndex.remove(selectedIndex);
        widget.repeatChoiceData.weekRepeatDateChoiceIndex.remove(selectedIndex);
      }
    });
  }

  // Hàm để reset các giá trị dùng cho phần Frequency khi người dùng ấn off repeat
  void _resetFrequencyWidgetState() {
    setState(() {
      _iRepeatTimeCount = 1;
      _sRepeatTimeCount = _iRepeatTimeCount.toString();
      _sRepeatTimeCount1 = "day";

      _opacitiesForSecondMenu[0] = 1.0;
      _opacitiesForSecondMenu[_lastSelectedIndexInSecondMenu] = _lastSelectedIndexInSecondMenu != 0 ? 0.0 : 1.0;

      _changeSecondMenuIconOpacity(0);
      _lastSelectedIndexInSecondMenu = 0;
    });
  }

  // Hàm để reset các

  // Hàm để thay đổi xuất hiện của icon phía trc lựa chọn trong Frequency
  void _changeSecondMenuIconOpacity(int selectedIndex) {
    setState(() {
      if (selectedIndex != _lastSelectedIndexInSecondMenu) {
        _opacitiesForSecondMenu[selectedIndex] = 1.0;
        _opacitiesForSecondMenu[_lastSelectedIndexInSecondMenu] = 0.0;

        _lastSelectedIndexInSecondMenu = selectedIndex;
        _iRepeatTimeCount = 1;

        _updateCountText(selectedIndex);
      }
    });
  }

  // Reset lại test hiển thị khi người dùng thay đổi lựa chọn trong Frequency
  void _updateCountText(int selectedIndex) {
    setState(() {
      switch (selectedIndex) {
        case 0:
          _sRepeatTimeCount = 1.toString();
          _sRepeatTimeCount1 = "day";
          break;
        case 1:
          _sRepeatTimeCount = 1.toString();
          _sRepeatTimeCount1 = "week";
          break;
        case 2:
          _sRepeatTimeCount = 1.toString();
          _sRepeatTimeCount1 = "month";
          break;
        case 3:
          _sRepeatTimeCount = 1.toString();
          _sRepeatTimeCount1 = "year";
          break;
      }
    });
  }

  // Hàm để thay đổi chữ sau số lượng thành mô tả số nhiều hay số ít
  void _changeRepeatCountTextToMultiple() {
    setState(() {
      switch (_lastSelectedIndexInSecondMenu) {
        case 0:
          _sRepeatTimeCount1 = _iRepeatTimeCount > 1 ? "days" : "day";
          break;
        case 1:
          _sRepeatTimeCount1 = _iRepeatTimeCount > 1 ? "weeks" : "week";
          break;
        case 2:
          _sRepeatTimeCount1 = _iRepeatTimeCount > 1 ? "months" : "month";
          break;
        case 3:
          _sRepeatTimeCount1 = _iRepeatTimeCount > 1 ? "years" : "year";
          break;
      }
    });
  }

  // Hàm để reset
  void _resetMonthlyChoiceIconOpacity() {
    setState(() {
      _opacitiesForFourthMenu[0] = 1.0;
      _opacitiesForFourthMenu[1] = 0.0;
    });
  }

  // Hàm để thay đổi opacity của widget dc chọn trong ENDS menu
  void _changeEndsWidgetIconOpacity(int selectedIndex) {
    setState(() {
      for (int i = 0; i < _opacitiesForFifthMenu.length; i++) {
        _opacitiesForFifthMenu[i] = i == selectedIndex ? 1.0 : 0.0;
      }
    });
  }

  // Hàm để cập nhật khi người dùng ấn nút tăng hoặc giảm trong phần ENDS
  void _onIncreaseOrDecreaseInEndsChoice(bool isIncrease) {
    if (isIncrease) {
      setState(() {
        _endSecondChoiceCount++;

        _endSecondChoiceMultiCountText = "times";
        _endSecondChoiceText = "After $_endSecondChoiceCount $_endSecondChoiceMultiCountText";

        widget.repeatChoiceData.endsAfetrNumberOfTimesChoice = _endSecondChoiceCount;
      });
    } else {
      setState(() {
        if (_endSecondChoiceCount > 1) {
          _endSecondChoiceCount--;

          _endSecondChoiceMultiCountText = "times";
          _endSecondChoiceText = "After $_endSecondChoiceCount $_endSecondChoiceMultiCountText";

          widget.repeatChoiceData.endsAfetrNumberOfTimesChoice = _endSecondChoiceCount;
        }
        if (_endSecondChoiceCount == 1) {
          _endSecondChoiceMultiCountText = "time";
          _endSecondChoiceText = "After $_endSecondChoiceCount $_endSecondChoiceMultiCountText";

          widget.repeatChoiceData.endsAfetrNumberOfTimesChoice = _endSecondChoiceCount;
        }
      });
    }
  }

  // Hàm để cập nhật ngày để nhắc nhở theo tháng trong monthly repeat
  void _changeMonthlyRepeatDateName() {
    setState(() {
      switch (DateTime.now().weekday) {
        case 1:
          _monthlyRepeatDateName = "Monday";
          break;
        case 2:
          _monthlyRepeatDateName = "Tuesday";
          break;
        case 3:
          _monthlyRepeatDateName = "Wednesday";
          break;
        case 4:
          _monthlyRepeatDateName = "Thursday";
          break;
        case 5:
          _monthlyRepeatDateName = "Friday";
          break;
        case 6:
          _monthlyRepeatDateName = "Saturday";
          break;
        default:
          _monthlyRepeatDateName = "Sunday";
          break;
      }
    });
  }

  // Hàm để tính toán xem ngày hiện tại là ngày thứ (vd thứ 2, thứ 3,..) thứ mấy của tháng
  void _calculateOrderPlaceOfCurrentDate() {
    setState(() {
      int orderPlaceCount = 1;
      DateTime minusDate = DateTime.now();

      while (minusDate.month == DateTime.now().month) {
        minusDate = minusDate.add(Duration(days: -7));

        if (minusDate.month == DateTime.now().month) {
          orderPlaceCount++;
        } else {
          break;
        }
      }

      switch (orderPlaceCount) {
        case 1:
          _monthlyRepeatTimeOrder = "1st";
          break;
        case 2:
          _monthlyRepeatTimeOrder = "2nd";
          break;
        case 3:
          _monthlyRepeatTimeOrder = "3rd";
          break;

        default:
          _monthlyRepeatTimeOrder = "4th";
          break;
      }
    });
  }
}
