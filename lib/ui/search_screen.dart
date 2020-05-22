import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _controller = TextEditingController();
  List<String> _userChoicesList = ["COMPLETED", "ALL", "INCOMPLETE"];
  List<Widget> _userChoicesCards = [];

  // Biến để lưu lịa vị trí trc đó mà ng dùng lựa chọn
  int _lastFocusChoiceIndex = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _initUserChoiceWidgets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFFAF3F0),
        child: Stack(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: FlatButton(
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.lightBlueAccent,
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
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Search",
                    style: GoogleFonts.adamina(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlueAccent
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Image.asset(
                    'images/search.gif',
                    width: 150.0,
                    height: 150.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            Center(
              child: AnimatedContainer(
                curve: Curves.easeInOutSine,
                duration: Duration(milliseconds: 500),
                child:  Text(
                  "Type to search your action titles and note",
                  style: GoogleFonts.roboto(
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 150.0,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        controller: _controller,
                        autofocus: true,
                        decoration: InputDecoration(
                            labelText: "Search for tasks",
                            hintText: "Search",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                color: Colors.lightBlueAccent,
                              ),
                              gapPadding: 10.0,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Colors.cyan,
                        ),
                        height: 50.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            InkWell(
                              child: _userChoicesCards[0],
                              onTap: () {
                                _changeFocusChoiceCardColor(0, _lastFocusChoiceIndex);
                              },
                            ),
                            InkWell(
                              child: _userChoicesCards[1],
                              onTap: () {
                                _changeFocusChoiceCardColor(1, _lastFocusChoiceIndex);
                              },
                            ),
                            InkWell(
                              child: _userChoicesCards[2],
                              onTap: () {
                                _changeFocusChoiceCardColor(2, _lastFocusChoiceIndex);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Hàm để khởi tạo các widget hiển thị cho phần search option
  void _initUserChoiceWidgets() {
    for (int i = 0; i < 3; i++) {
      _userChoicesCards.add(_userChoiceCard(
          _userChoicesList[i], i == 1 ? Color(0xFFFAF3F0) : Colors.cyan));
    }
  }

  // Hàm để thay đổi màu sắc của
  void _changeFocusChoiceCardColor(int changeIndex, int lastFocusedIndex) {
    setState(() {
      if (changeIndex != lastFocusedIndex) {
        _userChoicesCards[lastFocusedIndex] =
            _userChoiceCard(_userChoicesList[lastFocusedIndex], Colors.cyan);
        _userChoicesCards[changeIndex] =
            _userChoiceCard(_userChoicesList[changeIndex], Color(0xFFFAF3F0));

        _lastFocusChoiceIndex = changeIndex;
      }
    });
  }

  // Widget dùng để tạo search option card
  Widget _userChoiceCard(String userChoice, Color focusColor) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(7.0)),
        color: focusColor,
      ),
      padding: EdgeInsets.only(left: 7.0, right: 7.0),
      height: 25.0,
      child: Center(
        child: Text(
          "$userChoice",
          style: GoogleFonts.roboto(fontSize: 15.0),
        ),
      ),
    );
  }
}
