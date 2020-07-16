import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todoapp/doit_database_bus/doit_database_helper.dart';
import 'package:todoapp/doit_database_models/doit_lists_data.dart';
import 'package:todoapp/ui_variables/list_colors.dart';
import 'package:todoapp/ui_variables/list_screen_variables.dart';
import 'package:todoapp/ui_variables/task_screen_variables.dart';

class ListSheet extends StatefulWidget {
  List<String> listSheetListTitles = ['No list', 'Add new list'];
  List<Widget> listSheetListWidgets = [];
  List<Color> listSheetListColors = [Colors.white, Colors.blue[300]];

  @override
  _ListSheetState createState() => _ListSheetState();
}

class _ListSheetState extends State<ListSheet> with TickerProviderStateMixin {
  double _chooseListSheetHeight;

  List<Widget> _listWidgets;
  List<String> _listTitles;
  List<Color> _listColors;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller;
  String _newListTitle;

  Random _ranColorFromListColors;
  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();

    _chooseListSheetHeight = 205;
    _increaseListSheetHeight();

    _listWidgets = widget.listSheetListWidgets;
    _listTitles = widget.listSheetListTitles;
    _listColors = widget.listSheetListColors;

    _ranColorFromListColors = Random();

    if (_listWidgets.length == 0) _initListChoices();

    _controller = TextEditingController();
    _newListTitle = "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: Color(0xFFECEFF1),
      ),
      height: _chooseListSheetHeight,
      child: Column(
        children: <Widget>[
          _choooseListSheetHeader(),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                itemCount: _listWidgets.length,
                itemBuilder: (context, index) {
                  if (index < _listWidgets.length) {
                    return GestureDetector(
                      child: _listWidgets[index],
                      onTap: () {
                        if (index == 0 || index > 1) {
                          index == 0
                              ? choseListIndex = index
                              : choseListIndex = index - 1;

                          Navigator.of(context).pop();
                        } else if (index == 1) {
                          _createNewList();
                        }
                      },
                    );
                  }
                  return null;
                }),
          ),
        ],
      ),
    );
  }

  // Widget hiển thị Header của choose list sheet
  Widget _choooseListSheetHeader() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Choose list",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      );

  // Widget để tạo ra UI cho list
  Widget _listWidget(String listTitle, Color listColor, Color listTitleColor) =>
      Column(
        children: <Widget>[
          Container(
            height: 60,
            child: Center(
              child: Text(
                "$listTitle",
                style: TextStyle(color: listTitleColor),
              ),
            ),
            decoration: BoxDecoration(
              color: listColor,
            ),
          ),
          SizedBox(
            height: 3.0,
          )
        ],
      );

  // Hàm để khởi tạo các list cho người dùng chọn lựa
  void _initListChoices() {
    for (int i = 0; i < _listTitles.length; i++) {
      _listWidgets.add(_listWidget(
        _listTitles[i],
        _listColors[i],
        _listColors[i] == Colors.white ? Colors.black : Colors.white,
      ));
    }

    if (verticalListWidgets.length > 1) {
      for (int i = 0; i < verticalListWidgets.length; i++) {
        _listWidgets.add(_listWidget(
            listTitles[i + 1],
            listColors[i + 2],
            listColors[i + 2] == Color(0xFFFAFAFA)
                ? listTitleTextColors[0]
                : listTitleTextColors[1]));
      }
    }
  }

  // Hàm để show dialog cho người dùng add tên task mới
  void _createNewList() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Positioned(
                  right: -40.0,
                  top: -40.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.close),
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.isEmpty == false) _newListTitle = value;
                          },
                          autofocus: true,
                          controller: _controller,
                          style: TextStyle(fontSize: 20.0),
                          decoration: InputDecoration(
                              hintText: "New name",
                              labelText: "Your list's name",
                              border: OutlineInputBorder(
                                  gapPadding: 8.0,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)))),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          child: Text("OK"),
                          onPressed: () {
                            if (_newListTitle.isEmpty == false) {
                              setState(() {
                                if (verticalListWidgets.length == 0)
                                  _addFirstCard();

                                _addNewListSheetWidget();
                                _addNewTaskListScreenWidget();

                                if (_chooseListSheetHeight <
                                    MediaQuery.of(context).size.height *
                                        (2 / 3)) _chooseListSheetHeight += 63;

                                _newListTitle = "";
                              });
                            }

                            Navigator.of(context).pop();
                            _formKey.currentState.reset();
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  // Hàm khởi tạo card đầu tiên
  void _addFirstCard() {
    verticalListWidgets.add(verticalListWidget(
        "", listColors[0], taskTitles, listTitleTextColors[1], Icons.add));
    horizontalListWidgets.add(horizontalListWidget(
        "", listColors[0], listTitleTextColors[1], Icons.add));
  }

  // Hàm để add data cho các widget trong list sheet
  void _addNewListSheetWidget() {
// Add data cho các biến hiển thị ở list sheet
    widget.listSheetListTitles.add(_newListTitle);
    widget.listSheetListColors.add(listChoiceColors[
        _ranColorFromListColors.nextInt(listChoiceColors.length)]);

    widget.listSheetListWidgets.add(_listWidget(
        widget.listSheetListTitles[widget.listSheetListTitles.length - 1],
        widget.listSheetListColors[widget.listSheetListColors.length - 1],
        widget.listSheetListColors[widget.listSheetListColors.length - 1] ==
                Color(0xFFFAFAFA)
            ? Colors.black
            : Colors.white));
  }

  // Hàm để add data cho các biến hiển thị ở main screen
  void _addNewTaskListScreenWidget() {
    // Add data cho các biến hiển thị list ở main screen
    listTitles.add(_newListTitle);
    listColors
        .add(widget.listSheetListColors[widget.listSheetListColors.length - 1]);

    horizontalListWidgets.add(horizontalListWidget(
        listTitles[listTitles.length - 1],
        listColors[listColors.length - 1],
        listColors[listColors.length - 1] == Color(0xFFFAFAFA)
            ? listTitleTextColors[0]
            : listTitleTextColors[1]));
    verticalListWidgets.add(verticalListWidget(
        listTitles[listTitles.length - 1],
        listColors[listColors.length - 1],
        taskTitles,
        listColors[listColors.length - 1] == Color(0xFFFAFAFA)
            ? listTitleTextColors[0]
            : listTitleTextColors[1]));

    choseListIndex = verticalListWidgets.length - 1;

    //------------------------------------------------------------------------//
    var result = _databaseHelper.insertDataToListTable(ListData(
        listName: listTitles[listTitles.length - 1],
        listColor: listColors[listColors.length - 1].toString()));
    //------------------------------------------------------------------------//
  }

  // Hàm tăng kích thước sheet theo số list đang có
  void _increaseListSheetHeight() {
    if (verticalListWidgets.length > 1)
      for (int i = 1; i < verticalListWidgets.length; i++) {
        setState(() {
          _chooseListSheetHeight += 42;
        });
      }
  }
}
