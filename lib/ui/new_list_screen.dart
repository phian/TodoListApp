import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:todoapp/animation/fade_route_builder.dart';
import 'package:todoapp/ui_variables/finished_list.dart';
import 'package:todoapp/ui_variables/list_screen_variables.dart';

import 'add_task_page.dart';
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
  // Các biến cho animation chuyển screen qua screen add task
  final Duration animationDuration = Duration(milliseconds: 200);
  final Duration delay = Duration(milliseconds: 200);

  GlobalKey rectGetterKey = RectGetter.createGlobalKey();
  Rect rect;

  String _listTitle;
  Color _listColor;

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
  Widget _listWidget(String listTitle, Color listColor) {
    _listTitle = listTitle;
    _listColor = listColor;

    return Container(
      width: listWidgetWidth,
      height: listWidgetHeight,
      child: Scaffold(
        backgroundColor: widget.listColor,
        body: Stack(
          children: <Widget>[
            _buildTextAndAddIcon(),
            _displayListTitleWiedget(),
            _changeColorButton(),
            _closeButton(),
            _ripple(),
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: listColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  // Phần dấu cộng và dòng text
  Widget _buildTextAndAddIcon() => Align(
        alignment: Alignment.center,
        child: Container(
          height: 150.0,
          child: Column(
            children: <Widget>[
              RectGetter(
                key: rectGetterKey,
                child: Container(
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
                        color: _listColor == Color(0xfffafafa)
                            ? Colors.black
                            : Colors.white,
                        fit: BoxFit.cover,
                      )),
                      onPressed: _onAddButtonPressed,
                    ),
                  ),
                ),
              ),
              Text(
                "Add new DOIT to this list",
                textAlign: TextAlign.center,
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 25.0,
                    color: _listColor == Color(0xfffafafa)
                        ? Colors.black
                        : Colors.white),
              ),
            ],
          ),
        ),
      );

  // Phần hiển thị list title
  Widget _displayListTitleWiedget() => Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            width: 220.0,
            padding: EdgeInsets.only(
              bottom: 40.0,
            ),
            child: Text(
              "$_listTitle",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.center,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 30.0,
                  color: _listColor == Color(0xfffafafa)
                      ? Colors.black
                      : Colors.white),
            )),
      );

  // Change color button
  Widget _changeColorButton() => Opacity(
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
                color: _listColor == Color(0xfffafafa)
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
      );

  // Close button
  Widget _closeButton() => Opacity(
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
                color: _listColor == Color(0xfffafafa)
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
      );

  // Hàm sự kiện để chạy animation
  void _onAddButtonPressed() async {
    setState(() => rect = RectGetter.getRectFromKey(
        rectGetterKey)); //<-- set rect to be size of fab
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //<-- on the next frame...
      setState(() => rect = rect.inflate(1.1 *
          MediaQuery.of(context).size.longestSide)); //<-- set rect to be big
      Future.delayed(animationDuration + delay,
          _goToAddTaskPage); //<-- after delay, go to next page
    });
  }

  // Hàm để gọi lệnh chuyển sang trang thêm task
  void _goToAddTaskPage() {
    isPickColorFinished = false;
    Navigator.of(context)
        .pushReplacement(FadeRouteBuilder(
            page: AddTaskPage(
          lastFocusedScreen: mainScreenLastFocusedIndex,
          settingScreenIndex: mainScreenSettingScreenIndex,
        )))
        .then((_) => setState(() => rect = null));
  }

  // Widget tạo animation
  Widget _ripple() {
    if (rect == null) {
      return Container();
    }
    return AnimatedPositioned(
      duration: animationDuration, //<--specify the animation duration
      left: rect.left,
      right: MediaQuery.of(context).size.width - rect.right - 20.0,
      top: rect.top,
      bottom: MediaQuery.of(context).size.height - rect.bottom + 50.0,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF425195),
        ),
      ),
    );
  }
}
