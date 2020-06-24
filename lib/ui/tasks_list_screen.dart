import 'package:flutter/material.dart';
import 'package:todoapp/ui/choose_list_color_screen.dart';
import 'package:todoapp/ui/new_list_screen.dart';
import 'package:todoapp/ui_variables/list_screen_variables.dart';

class TasksListScreen extends StatefulWidget {
  @override
  _TasksListScreenState createState() => _TasksListScreenState();
}

class _TasksListScreenState extends State<TasksListScreen> {
  @override
  void initState() {
    super.initState();

    if (listWidgets.length == 0) _initFirstCard();
  }

  @override
  Widget build(BuildContext context) {
    if (listWidgetWidth == null) {
      setState(() {
        listWidgetWidth = MediaQuery.of(context).size.width;
      });
    }

    return WillPopScope(
      // ignore: missing_return
      onWillPop: () async {
        setState(() {
          listScreenOpacity = 1.0;
        });
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFFFAF3F0),
          body: AnimatedOpacity(
            duration: Duration(milliseconds: 350),
            opacity: listScreenOpacity,
            child: Stack(
              children: <Widget>[
                _listScreenLists(),
                _buildListsScreenHeader(),
                _buildChoiceButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Hàm khởi tạo card đầu tiên
  void _initFirstCard() {
    listWidgets.add(listWidget(
        "", listColors[0], taskTitles, listTitleTextColors[1], Icons.add));
  }

  // Widget hiển thị danh sách list đang có
  Widget _listScreenLists() => Container(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height -
                (MediaQuery.of(context).size.height * 0.85)),
        child: ListView.separated(
          scrollDirection: scrollDirection,
          padding: EdgeInsets.only(
            left: 20.0,
            right: 20.0,
          ),
          itemCount: listWidgets.length,
          physics:
              AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Hero(
                tag: '$index',
                child: listWidgets[index],
              ),
              onTap: () {
                if (index == 0) {
                  setState(() {
                    listScreenOpacity = 0.0;

                    listWidgets.add(listWidget(listTitles[0], listColors[1],
                        taskTitles, listTitleTextColors[1]));

                    Future.delayed(Duration(milliseconds: 350), () {
                      _addNewList();
                    });

                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return NewListScreen(
                        listTiltle: listTitles[0],
                        listColor: listColors[1],
                        listIcon: null,
                        index: listWidgets.length - 1,
                      );
                    }));
                  });
                } else if (index != 0) {
                  lastChoseIndex = index;

                  print(listColors[lastChoseIndex + 1]);

                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return NewListScreen(
                      listTiltle: listTitles[lastChoseIndex],
                      listColor: listColors[lastChoseIndex + 1],
                      listIcon: null,
                      index: lastChoseIndex,
                    );
                  }));
                }
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 7.0,
              width: 7.0,
            );
          },
        ),
      );

  // Header text
  Widget _buildListsScreenHeader() => Container(
        padding: EdgeInsets.only(left: 30.0, top: 20.0),
        alignment: Alignment.topLeft,
        child: Text(
          "Lists",
          style: TextStyle(
              decoration: TextDecoration.none,
              fontFamily: 'Roboto',
              fontSize: 40,
              color: Colors.red,
              fontWeight: FontWeight.w900),
        ),
      );

  // Các nút chọn dạng hiển thị
  Widget _buildChoiceButtons() => Container(
        alignment: Alignment.topRight,
        padding: EdgeInsets.only(top: 18.0, right: 30.0),
        child: Container(
          width: 50.0,
          height: 50.0,
          child: IconButton(
            alignment: Alignment.center,
            icon: Container(
                child: Image.asset(
              'images/swap.png',
              color: Colors.grey,
              fit: BoxFit.cover,
            )),
            onPressed: () {
              setState(() {
                isVertical = !isVertical;
                _changeListItemSizes(isVertical);
                scrollDirection = isVertical ? Axis.vertical : Axis.horizontal;
              });
            },
          ),
        ),
      );

  // Hàm để add một list mới
  void _addNewList() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.only(top: 12.0, left: 50.0, right: 50.0),
            height: MediaQuery.of(context).viewInsets.bottom == 0
                ? 100.0
                : 100 + MediaQuery.of(context).viewInsets.bottom,
            child: TextField(
              maxLines: 1,
              textAlign: TextAlign.center,
              autofocus: true,
              style: TextStyle(fontSize: 30.0),
              decoration: InputDecoration(
                  hintText: "New List",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  )),
              onSubmitted: (value) {
                if (value.isEmpty == false) listTitles.add(value);

                Navigator.of(context).pop();
              },
            ),
          );
        }).whenComplete(() {
      setState(() {
        listScreenOpacity = 1.0;

        if (listTitles.length != previousLength) {
          // Cấp nhật vị trí mới cho phần chọn item và cập nhật độ dài mới của list title để lưu trữ lại
          previousLength = listTitles.length;
          lastChoseIndex = listWidgets.length - 1;

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
            return ChooseColorScreen(
              listTitle: listTitles[listTitles.length - 1],
            );
          }));
        } else if (listTitles.length == previousLength &&
            listWidgets.length > 1) {
          // Nếu ko có title mới dc add thì ta sẽ xoá item cuối của list widget
          listWidgets.removeAt(listWidgets.length - 1);
          Navigator.pop(context);
        }
      });
    });
  }

  // Hàm để chuyển kích thước cho các item trong list
  void _changeListItemSizes(bool isVertical) {
    setState(() {
      if (isVertical) {
        listWidgetHeight = 90.0;
        listWidgetWidth = MediaQuery.of(context).size.width;
      } else {
        listWidgetHeight = MediaQuery.of(context).size.height;
        listWidgetWidth = MediaQuery.of(context).size.width - 20 * 2;
      }

      // gán biến tạm để lưu giá trị trc đó mà ng dùng chọn, sau khi add item đầu tiên thì sẽ reset lại
      int temp = lastChoseIndex;
      lastChoseIndex = 0;

      for (int i = 0; i < listWidgets.length; i++) {
        listWidgets[i] = i == 0
            ? listWidget(listTitles[0], listColors[0], taskTitles,
                listTitleTextColors[1], Icons.add)
            : listWidget(
                listTitles[i],
                listColors[i + 1],
                taskTitles,
                listColors[i + 1] == Color(0xfffafafa)
                    ? listTitleTextColors[1]
                    : listTitleTextColors[0]);

        lastChoseIndex = temp;
      }
    });
  }
}
