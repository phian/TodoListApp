import 'package:flutter/material.dart';
import 'package:todoapp/doit_database_bus/doit_database_helper.dart';
import 'package:todoapp/ui/choose_list_color_screen.dart';
import 'package:todoapp/ui/new_list_screen.dart';
import 'package:todoapp/ui_variables/list_screen_variables.dart';

class TasksListScreen extends StatefulWidget {
  @override
  _TasksListScreenState createState() => _TasksListScreenState();
}

class _TasksListScreenState extends State<TasksListScreen> {
  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();

    if (verticalListWidgets.length == 0) {
      _initFirstCard();
      _initListWidgetsFromDbData();
    }
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
    verticalListWidgets.add(verticalListWidget(
        "", listColors[0], taskTitles, listTitleTextColors[1], Icons.add));
    horizontalListWidgets.add(horizontalListWidget(
        "", listColors[0], listTitleTextColors[1], Icons.add));
  }

  // Hàm để khởi tạo các widget từ data dc đọc lên từ database
  void _initListWidgetsFromDbData() {
    setState(() {
      _databaseHelper.getListsMap().then((value) {
        for (int i = 0; i < value.length; i++) {
          var listInfo = value[i].values.toList();
          listTitles.add(listInfo[1]);
          listColors.add(Color(
              int.parse(listInfo[2].substring(10, 16), radix: 16) +
                  0xFF000000));
          verticalListWidgets.add(verticalListWidget(
              listInfo[1],
              listColors[listColors.length - 1],
              taskTitles,
              listColors[listColors.length - 1] == Color(0xFFFAFAFA)
                  ? listTitleTextColors[0]
                  : listTitleTextColors[1]));
          horizontalListWidgets.add(horizontalListWidget(
              listInfo[1],
              listColors[listColors.length - 1],
              listColors[listColors.length - 1] == Color(0xFFFAFAFA)
                  ? listTitleTextColors[0]
                  : listTitleTextColors[1]));
        }
      });
    });
  }

  // Widget hiển thị danh sách list đang có
  Widget _listScreenLists() => Container(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height -
                (MediaQuery.of(context).size.height * 0.88),
            bottom: isVertical == false
                ? MediaQuery.of(context).size.height -
                    (MediaQuery.of(context).size.height * 0.96)
                : 0.0),
        child: ListView.separated(
          scrollDirection: scrollDirection,
          padding: EdgeInsets.only(
            left: 20.0,
            right: 20.0,
          ),
          itemCount: isVertical
              ? verticalListWidgets.length
              : horizontalListWidgets.length,
          physics:
              AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Hero(
                tag: '$index',
                child: isVertical
                    ? verticalListWidgets[index]
                    : horizontalListWidgets[index],
              ),
              onTap: () {
                // Nếu ng dùng ấn dấu + để thêm task
                if (index == 0) {
                  setState(() {
                    listScreenOpacity = 0.0;

                    verticalListWidgets.add(verticalListWidget(listTitles[0],
                        listColors[1], taskTitles, listTitleTextColors[1]));
                    horizontalListWidgets.add(horizontalListWidget(
                        listTitles[0], listColors[1], listTitleTextColors[1]));

                    Future.delayed(Duration(milliseconds: 350), () {
                      _addNewList();
                    });

                    if (isVertical) {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return NewListScreen(
                          listTiltle: listTitles[0],
                          listColor: listColors[1],
                          listIcon: null,
                          index: verticalListWidgets.length - 1,
                        );
                      }));
                    } else {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return NewListScreen(
                          listTiltle: listTitles[0],
                          listColor: listColors[1],
                          listIcon: null,
                          index: horizontalListWidgets.length - 1,
                        );
                      }));
                    }
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
          lastChoseIndex = verticalListWidgets.length - 1;

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
            return ChooseColorScreen(
              listTitle: listTitles[listTitles.length - 1],
            );
          }));
        } else if (listTitles.length == previousLength &&
            verticalListWidgets.length > 1) {
          // Nếu ko có title mới dc add thì ta sẽ xoá item cuối của list widget
          verticalListWidgets.removeAt(verticalListWidgets.length - 1);
          horizontalListWidgets.removeAt(horizontalListWidgets.length - 1);
          Navigator.pop(context);
        }
      });
    });
  }

  // Hàm để chuyển kích thước cho các item trong list
  void _changeListItemSizes(bool isVertical) {
    setState(() {
      // gán biến tạm để lưu giá trị trc đó mà ng dùng chọn, sau khi add item đầu tiên thì sẽ reset lại
      int temp = lastChoseIndex;

      if (isVertical) {
        listWidgetHeight = 90.0;
        listWidgetWidth = MediaQuery.of(context).size.width;

        lastChoseIndex = 0;

        for (int i = 0; i < verticalListWidgets.length; i++) {
          verticalListWidgets[i] = i == 0
              ? verticalListWidget(listTitles[0], listColors[0], taskTitles,
                  listTitleTextColors[1], Icons.add)
              : verticalListWidget(
                  listTitles[i],
                  listColors[i + 1],
                  taskTitles,
                  listColors[i + 1] == Color(0xfffafafa)
                      ? listTitleTextColors[0]
                      : listTitleTextColors[1]);

          lastChoseIndex = temp;
        }
      } else {
        listWidgetWidth = MediaQuery.of(context).size.width * 0.75;

        lastChoseIndex = 0;

        for (int i = 0; i < horizontalListWidgets.length; i++) {
          horizontalListWidgets[i] = i == 0
              ? horizontalListWidget(listTitles[0], listColors[0],
                  listTitleTextColors[1], Icons.add)
              : horizontalListWidget(
                  listTitles[i],
                  listColors[i + 1],
                  listColors[i + 1] == Color(0xfffafafa)
                      ? listTitleTextColors[0]
                      : listTitleTextColors[1]);

          lastChoseIndex = temp;
        }
      }
    });
  }
}
