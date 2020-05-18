import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/ui/about_screen.dart';

int _lastFocusScreen;

class SettingsScreen extends StatefulWidget {
  SettingsScreen([int lastFocusScreen]) {
    _lastFocusScreen = lastFocusScreen;
  }

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<IconData> _settingMenuIcons = [
    Icons.brightness_7,
    Icons.search,
    Icons.help_outline,
    Icons.info_outline,
    Icons.explore,
    Icons.account_circle
  ];
  List<String> _settingMenuTexts = [
    "Preference",
    "Search",
    "Help",
    "About",
    "Getting Started",
    "Account"
  ];
  List<Widget> _settingMenuWidgets = [];

  @override
  Widget build(BuildContext context) {
    _initSettingMenuWidget(); // Gọi hàm để khởi tạo

    return Container(
      color: Color(0xFFFAF3F0),
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.width - 120.0,
          left: MediaQuery.of(context).size.width / 2 - 120.0),
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
              _changeFocusMenuWidgetColor(0, false);
            },
            onTapCancel: () {
              _changeFocusMenuWidgetColor(0, false);
            },
            onHighlightChanged: (isChanged) {
              if(isChanged) {
                _changeFocusMenuWidgetColor(0, true);
              }
            },
            child: _settingMenuWidgets[0],
          ),
          SizedBox(
            height: 10.0,
          ),
          InkWell(
            onTap: () {
              _changeFocusMenuWidgetColor(1, false);
            },
            onTapCancel: () {
              _changeFocusMenuWidgetColor(1, false);
            },
            onHighlightChanged: (isChanged) {
              if(isChanged) {
                _changeFocusMenuWidgetColor(1, true);
              }
            },
            child: _settingMenuWidgets[1],
          ),
          SizedBox(
            height: 10.0,
          ),
          InkWell(
            onTap: () {
              _changeFocusMenuWidgetColor(2, false);
            },
            onTapCancel: () {
              _changeFocusMenuWidgetColor(2, false);
            },
            onHighlightChanged: (isChanged) {
              if(isChanged) {
                _changeFocusMenuWidgetColor(2, true);
              }
            },
            child: _settingMenuWidgets[2],
          ),
          SizedBox(
            height: 10.0,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AboutScreen(_lastFocusScreen),
              ));
              _changeFocusMenuWidgetColor(3, false);
            },
            onTapCancel: () {
              _changeFocusMenuWidgetColor(3, false);
            },
            onHighlightChanged: (isChanged) {
              if(isChanged) {
                _changeFocusMenuWidgetColor(3, true);
              }
            },
            child: _settingMenuWidgets[3],
          ),
          SizedBox(
            height: 10.0,
          ),
          InkWell(
            onTap: () {
              _changeFocusMenuWidgetColor(4, false);
            },
            onTapCancel: () {
              _changeFocusMenuWidgetColor(4, false);
            },
            onHighlightChanged: (isChanged) {
              if(isChanged) {
                _changeFocusMenuWidgetColor(4, true);
              }
            },
            child: _settingMenuWidgets[4],
          ),
          SizedBox(
            height: 10.0,
          ),
          InkWell(
            onTap: () {
              _changeFocusMenuWidgetColor(5, false);
            },
            onTapCancel: () {
              _changeFocusMenuWidgetColor(5, false);
            },
            onHighlightChanged: (isChanged) {
              if(isChanged) {
                _changeFocusMenuWidgetColor(5, true);
              }
            },
            child: _settingMenuWidgets[5],
          ),
        ],
      ),
    );
  }

  // Hàm để khởi tạo các widgets cho setting menu
  void _initSettingMenuWidget() {
    for (int i = 0; i < 6; i++) {
      _settingMenuWidgets.add(_settingsMenuWidget(_settingMenuIcons[i],
          _settingMenuTexts[i], Colors.black, Colors.black));
    }
  }

  // Hàm để reset màu của icon và text của menu widget dc chọn
  void _changeFocusMenuWidgetColor(int focusedIndex, bool isFocused) {
    if (isFocused)
      setState(() {
        _settingMenuWidgets[focusedIndex] = _settingsMenuWidget(
            _settingMenuIcons[focusedIndex],
            _settingMenuTexts[focusedIndex],
            Colors.grey,
            Colors.grey);
      });
    else
      setState(() {
        _settingMenuWidgets[focusedIndex] = _settingsMenuWidget(
            _settingMenuIcons[focusedIndex],
            _settingMenuTexts[focusedIndex],
            Colors.black,
            Colors.black);
      });
  }

  // Widget để hiển thị trong setting menu
  Widget _settingsMenuWidget(
      IconData icon, String menuText, Color iconColor, Color textColor) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: iconColor,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              "$menuText",
              style: GoogleFonts.abhayaLibre(fontSize: 20.0, color: textColor),
            ),
          ),
        ],
      ),
    );
  }
}
