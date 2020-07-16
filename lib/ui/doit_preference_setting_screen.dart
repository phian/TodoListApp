import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todoapp/ui/preference_screen.dart';
import 'package:todoapp/ui_variables/doit_preference_variables.dart';

class DOITPreferenceSettingScreen extends StatefulWidget {
  final int lastFocusedScreen;

  DOITPreferenceSettingScreen({this.lastFocusedScreen});

  @override
  _DOITPreferenceSettingScreenState createState() =>
      _DOITPreferenceSettingScreenState();
}

class _DOITPreferenceSettingScreenState
    extends State<DOITPreferenceSettingScreen> {
  @override
  void initState() {
    super.initState();

    _initFirstMenuWidgets();
    _initSecondMenuWidgets();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        // ignore: missing_return
        onWillPop: () async {
          _backToPreferenceScreen();
        },
        child: Scaffold(
          backgroundColor: Color(0xFFFFE4D4),
          body: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height - 70.0,
                child: ListView(
                  physics: AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  children: <Widget>[
                    _buildDOITSettingScreenFirstMenu(),
                    _buildDOITSettingScreenSecondMenu(),
                  ],
                ),
              ),
              _buildDOITSettingScreenHeader(),
            ],
          ),
        ),
      ),
    );
  }

  // Hàm để chứa code để back về Preference screen
  void _backToPreferenceScreen() {
    Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.leftToRightWithFade,
            child: PreferenceScreen(
              lastFocusedScreen: widget.lastFocusedScreen,
            ),
            duration: Duration(milliseconds: 300)));
  }

  // DOIT setting screen header
  Widget _buildDOITSettingScreenHeader() => Container(
        height: 70.0,
        child: Stack(
          children: <Widget>[
            Container(
              color: Color(0xFFFFE4D4),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 30.0,
                ),
                onPressed: _backToPreferenceScreen,
              ),
              alignment: Alignment.topLeft,
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 11.0),
            ),
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 15.0),
              child: Text(
                "DOIT",
                style: TextStyle(
                    fontSize: 37.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );

  // First menu header
  Widget _buildFirstMenuHeader() => Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.symmetric(
          horizontal: 15.0,
        ),
        child: Text(
          "EXPIRED IF NOT COMPLETED",
          style: TextStyle(fontSize: 22.0, color: Colors.grey),
        ),
      );

  // DOIT setting screen first menu
  Widget _buildDOITSettingScreenFirstMenu() => Container(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.42,
          transform: Matrix4.translationValues(
              0.0, MediaQuery.of(context).size.height * 0.11, .0),
          child: Column(
            children: <Widget>[
              _buildFirstMenuHeader(),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: firstMenuWidgets[0],
                onTap: () {
                  _changeSelectedIconOpacity(0);
                  _changeFirstMenuFocusedWidgetColor(0, false);
                },
                onTapCancel: () {
                  _changeFirstMenuFocusedWidgetColor(0, false);
                },
                onHighlightChanged: (isChanged) {
                  if (isChanged) _changeFirstMenuFocusedWidgetColor(0, true);
                },
              ),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: firstMenuWidgets[1],
                onTap: () {
                  _changeSelectedIconOpacity(1);
                  _changeFirstMenuFocusedWidgetColor(1, false);
                },
                onTapCancel: () {
                  _changeFirstMenuFocusedWidgetColor(1, false);
                },
                onHighlightChanged: (isChanged) {
                  if (isChanged) _changeFirstMenuFocusedWidgetColor(1, true);
                },
              ),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: firstMenuWidgets[2],
                onTap: () {
                  _changeSelectedIconOpacity(2);
                  _changeFirstMenuFocusedWidgetColor(2, false);
                },
                onTapCancel: () {
                  _changeFirstMenuFocusedWidgetColor(2, false);
                },
                onHighlightChanged: (isChanged) {
                  if (isChanged) _changeFirstMenuFocusedWidgetColor(2, true);
                },
              ),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: firstMenuWidgets[3],
                onTap: () {
                  _changeSelectedIconOpacity(3);
                  _changeFirstMenuFocusedWidgetColor(3, false);
                },
                onTapCancel: () {
                  _changeFirstMenuFocusedWidgetColor(3, false);
                },
                onHighlightChanged: (isChanged) {
                  if (isChanged) _changeFirstMenuFocusedWidgetColor(3, true);
                },
              ),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: firstMenuWidgets[4],
                onTap: () {
                  _changeSelectedIconOpacity(4);
                  _changeFirstMenuFocusedWidgetColor(4, false);
                },
                onTapCancel: () {
                  _changeFirstMenuFocusedWidgetColor(4, false);
                },
                onHighlightChanged: (isChanged) {
                  if (isChanged) _changeFirstMenuFocusedWidgetColor(4, true);
                },
              ),
            ],
          ),
        ),
      );

  // First menu widget
  Widget _firstMenuWidget(
          String title, double titleOpacity, double iconOpacity) =>
      Container(
        height: 27.0,
        margin: EdgeInsets.only(top: 20.0),
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black.withOpacity(titleOpacity)),
                textAlign: TextAlign.left,
                maxLines: 1,
              ),
              Icon(
                Icons.check,
                color: Colors.blue.withOpacity(iconOpacity),
              ),
            ],
          ),
        ),
      );

  // Hàm để init các widget của menu đầu tiên
  void _initFirstMenuWidgets() {
    firstMenuOptionTitles = [
      "Never",
      "After a fortnight",
      "After a month",
      "After 3 months",
      "After 6 months",
    ];
    firstMenuWidgets = [];
    firstMenuIconWidgetOpacities = [1.0, 0.0, 0.0, 0.0, 0.0];
    firstMenuTitleOpacities = [1.0, 1.0, 1.0, 1.0, 1.0];

    var index = 0;
    firstMenuOptionTitles.forEach((v) {
      firstMenuWidgets.add(_firstMenuWidget(v, firstMenuTitleOpacities[index],
          firstMenuIconWidgetOpacities[index]));
      index++;
    });
  }

  // Hàm để reset màu của icon và text của menu widget dc chọn
  void _changeFirstMenuFocusedWidgetColor(int focusedIndex, bool isFocused) {
    setState(() {
      if (isFocused) {
        firstMenuTitleOpacities[focusedIndex] = 0.25;
        firstMenuWidgets[focusedIndex] = _firstMenuWidget(
            firstMenuOptionTitles[focusedIndex],
            firstMenuTitleOpacities[focusedIndex],
            firstMenuIconWidgetOpacities[focusedIndex]);
      } else {
        firstMenuTitleOpacities[focusedIndex] = 1.0;
        firstMenuWidgets[focusedIndex] = _firstMenuWidget(
            firstMenuOptionTitles[focusedIndex],
            firstMenuTitleOpacities[focusedIndex],
            firstMenuIconWidgetOpacities[focusedIndex]);
      }
    });
  }

  // Hàm để reset icon opacity của menu đầu tiên khi ng dùng thay đổi lựa chọn
  void _changeSelectedIconOpacity(int selctedIndex) {
    setState(() {
      for (int i = 0; i < firstMenuIconWidgetOpacities.length; i++) {
        if (i == selctedIndex && firstMenuIconWidgetOpacities[i] != 1.0) {
          firstMenuIconWidgetOpacities[i] = 1.0;
          firstMenuWidgets[i] = _firstMenuWidget(firstMenuOptionTitles[i],
              firstMenuTitleOpacities[i], firstMenuIconWidgetOpacities[i]);
        } else if (i != selctedIndex) {
          firstMenuIconWidgetOpacities[i] = 0.0;
          firstMenuWidgets[i] = _firstMenuWidget(firstMenuOptionTitles[i],
              firstMenuTitleOpacities[i], firstMenuIconWidgetOpacities[i]);
        }
      }
    });
  }

  //------------------------------------------Second menu-----------------------------------------//

  // Second menu header
  Widget _buildSecondMenuHeader() => Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Text(
          "OVERDUE ACTIONS",
          style: TextStyle(fontSize: 22.0, color: Colors.grey),
        ),
      );

  // DOIT screen second menu
  Widget _buildDOITSettingScreenSecondMenu() => Container(
        height: 220.0,
        transform: Matrix4.translationValues(
            0.0, MediaQuery.of(context).size.height * 0.06, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _buildSecondMenuHeader(),
            SizedBox(
              height: 20.0,
            ),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: secondMenuWidgets[0],
              onTap: () {
                _changeSecondMenuIconOpacity(0);
                _changeSecondMenuFocusedWidgetColor(0, false);
              },
              onTapCancel: () {
                _changeSecondMenuFocusedWidgetColor(0, false);
              },
              onHighlightChanged: (isChanged) {
                if (isChanged) _changeSecondMenuFocusedWidgetColor(0, true);
              },
            ),
            SizedBox(
              height: 12.0,
            ),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: secondMenuWidgets[1],
              onTap: () {
                _changeSecondMenuIconOpacity(1);
                _changeSecondMenuFocusedWidgetColor(1, false);
              },
              onTapCancel: () {
                _changeSecondMenuFocusedWidgetColor(1, false);
              },
              onHighlightChanged: (isChanged) {
                if (isChanged) _changeSecondMenuFocusedWidgetColor(1, true);
              },
            ),
          ],
        ),
      );

  //Second menu widget
  Widget _secondMenuWidget(
          String title, double titleOpacity, double iconOpacity) =>
      Container(
        height: 60.0,
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black.withOpacity(titleOpacity),
            ),
            maxLines: 3,
          ),
          trailing: Icon(
            Icons.check,
            color: Colors.blue.withOpacity(iconOpacity),
          ),
        ),
      );

  // Hàm khởi tạo các widgets của second menu
  void _initSecondMenuWidgets() {
    secondMenuOptionTitles = [
      "Show overdue actions on schedule screen",
      "Automatically move overdue actions to today"
    ];
    secondMenuWidgets = [];
    secondMenuIconOpacities = [1.0, 1.0];
    secondMenuTitleOpacities = [1.0, 1.0];

    var index = 0;
    secondMenuOptionTitles.forEach((v) {
      secondMenuWidgets.add(_secondMenuWidget(
          v, secondMenuTitleOpacities[index], secondMenuIconOpacities[index]));
      index++;
    });
  }

  // Hàm để thay đổi hiển thị của icon cho second menu
  void _changeSecondMenuIconOpacity(int selectedIndex) {
    setState(() {
      if (selectedIndex == 0) {
        secondMenuIconOpacities[0] =
            secondMenuIconOpacities[0] == 1.0 ? 0.0 : 1.0;

        secondMenuWidgets[0] = _secondMenuWidget(secondMenuOptionTitles[0],
            secondMenuTitleOpacities[0], secondMenuIconOpacities[0]);
      } else {
        secondMenuIconOpacities[1] =
            secondMenuIconOpacities[1] == 1.0 ? 0.0 : 1.0;

        secondMenuWidgets[1] = _secondMenuWidget(secondMenuOptionTitles[1],
            secondMenuTitleOpacities[1], secondMenuIconOpacities[1]);
      }
    });
  }

  // Hàm để reset màu của icon và text của menu widget dc chọn
  void _changeSecondMenuFocusedWidgetColor(int focusedIndex, bool isFocused) {
    setState(() {
      if (isFocused) {
        secondMenuTitleOpacities[focusedIndex] = 0.25;
        secondMenuWidgets[focusedIndex] = _secondMenuWidget(
            secondMenuOptionTitles[focusedIndex],
            secondMenuTitleOpacities[focusedIndex],
            secondMenuIconOpacities[focusedIndex]);
      } else {
        secondMenuTitleOpacities[focusedIndex] = 1.0;
        secondMenuWidgets[focusedIndex] = _secondMenuWidget(
            secondMenuOptionTitles[focusedIndex],
            secondMenuTitleOpacities[focusedIndex],
            secondMenuIconOpacities[focusedIndex]);
      }
    });
  }
}
