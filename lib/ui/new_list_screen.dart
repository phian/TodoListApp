import 'package:flutter/material.dart';
import 'package:todoapp/ui_variables/list_screen_variables.dart';

import 'choose_list_color_screen.dart';

class NewListScreen extends StatefulWidget {
  final IconData listIcon;
  final Color listColor;
  final String listTiltle;
  final int index;

  NewListScreen({this.listColor, this.listIcon, this.listTiltle, this.index});

  @override
  _NewListScreenState createState() => _NewListScreenState();
}

class _NewListScreenState extends State<NewListScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Hero(
        tag: '${widget.index}',
        child: _listWidget(widget.listTiltle, widget.listColor),
      ),
    );
  }

  // Widget để tạo ra UI cho list
  Widget _listWidget(String listTitle, Color listColor) => Container(
        width: listWidgetWidth,
        height: listWidgetHeight,
        child: Scaffold(
          backgroundColor: widget.listColor,
          body: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 150.0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(bottom: 32.0, left: 15.0),
                        child: Container(
                          width: 50.0,
                          height: 50.0,
                          child: IconButton(
                            alignment: Alignment.center,
                            icon: Container(
                                child: Image.asset(
                              'images/add.png',
                              width: 40.0,
                              height: 40.0,
                              color: listColor == Color(0xfffafafa)
                                  ? Colors.black
                                  : Colors.white,
                              fit: BoxFit.cover,
                            )),
                            onPressed: () {},
                          ),
                        ),
                      ),
                      Text(
                        "Add new DOIT to this list",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 25.0,
                            color: listColor == Color(0xfffafafa)
                                ? Colors.black
                                : Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    width: 220.0,
                    padding: EdgeInsets.only(
                      bottom: 40.0,
                    ),
                    child: Text(
                      "$listTitle",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 30.0,
                          color: listColor == Color(0xfffafafa)
                              ? Colors.black
                              : Colors.white),
                    )),
              ),
              Opacity(
                opacity: widget.listTiltle.isEmpty ? 0.0 : 1.0,
                child: Container(
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.only(bottom: 32.0, left: 15.0),
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    child: IconButton(
                      alignment: Alignment.center,
                      icon: Container(
                          child: Image.asset(
                        'images/change_color.png',
                        width: 40.0,
                        height: 40.0,
                        color: listColor == Color(0xfffafafa)
                            ? Colors.black
                            : Colors.white,
                        fit: BoxFit.cover,
                      )),
                      onPressed: () {
                        isChangeColorClicked = true;

                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) {
                          print(listTitles[listTitles.length - 1]);
                          return ChooseColorScreen(
                            listTitle: listTitles[listTitles.length - 1],
                          );
                        }));
                      },
                    ),
                  ),
                ),
              ),
              Opacity(
                opacity: widget.listTiltle.isEmpty ? 0.0 : 1.0,
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.only(bottom: 32.0, right: 15.0),
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    child: IconButton(
                      alignment: Alignment.center,
                      icon: Container(
                          child: Image.asset(
                        'images/close.png',
                        width: 40.0,
                        height: 40.0,
                        color: listColor == Color(0xfffafafa)
                            ? Colors.black
                            : Colors.white,
                        fit: BoxFit.cover,
                      )),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: listColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
      );
}
