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
    if (binTransformValue == null) {
      setState(() {
        binTransformValue = MediaQuery.of(context).size.height;
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
                _buildDeleteBinWidget(),
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
                child: (() {
                  // Check xem index của list đang là bao nhiêu để trả về widget tương ứng
                  if (index == 0) {
                    if (isVertical)
                      return verticalListWidgets[index];
                    else
                      return horizontalListWidgets[index];
                  }

                  if (index != 0) {
                    if (isVertical)
                      return Draggable(
                          onDragStarted: () {
                            setState(() {
                              dragIndex = index;
                              binTransformValue =
                                  -(MediaQuery.of(context).size.height * 0.06);
                            });
                          },
                          onDragEnd: (details) {
                            setState(() {
                              // dragIndex = 0;
                              binTransformValue =
                                  MediaQuery.of(context).size.height;
                            });
                          },
                          onDragCompleted: () {
                            setState(() {});
                          },
                          data: index,
                          maxSimultaneousDrags: 1,
                          child: verticalListWidgets[index],
                          childWhenDragging: Opacity(
                            opacity: 0.7,
                            child: Container(
                              width: listWidgetWidth,
                              height: listWidgetHeight,
                              child: verticalListWidgets[index],
                            ),
                          ),
                          feedback: Opacity(
                            opacity: 0.7,
                            child: Container(
                              width: listWidgetWidth,
                              height: listWidgetHeight,
                              child: verticalListWidgets[index],
                            ),
                          ));
                  }

                  return Draggable(
                      onDragStarted: () {
                        setState(() {
                          dragIndex = index;
                          binTransformValue =
                              -(MediaQuery.of(context).size.height * 0.06);
                        });
                      },
                      onDragEnd: (details) {
                        setState(() {
                          // dragIndex = 0;
                          binTransformValue =
                              MediaQuery.of(context).size.height;
                        });
                      },
                      onDragCompleted: () {
                        setState(() {
                          // dragIndex = 0;
                        });
                      },
                      data: index,
                      maxSimultaneousDrags: 1,
                      child: horizontalListWidgets[index],
                      childWhenDragging: Opacity(
                        opacity: 0.7,
                        child: Container(
                          height: MediaQuery.of(context).size.height -
                              (MediaQuery.of(context).size.height * 0.2),
                          width: listWidgetWidth,
                          child: horizontalListWidgets[index],
                        ),
                      ),
                      feedback: Opacity(
                        opacity: 0.7,
                        child: Container(
                          height: MediaQuery.of(context).size.height -
                              (MediaQuery.of(context).size.height * 0.2),
                          width: listWidgetWidth,
                          child: horizontalListWidgets[index],
                        ),
                      ));
                }()),
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
                  lastListChoseIndex = index;

                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return NewListScreen(
                      listTiltle: listTitles[lastListChoseIndex],
                      listColor: listColors[lastListChoseIndex + 1],
                      listIcon: null,
                      index: lastListChoseIndex,
                    );
                  }));
                }
              },
              onTapDown: (details) {
                setState(() {
                  binTransformValue =
                      -(MediaQuery.of(context).size.height * 0.06);
                });
              },
              onTapCancel: () {
                setState(() {
                  binTransformValue = MediaQuery.of(context).size.height;
                });
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
          lastListChoseIndex = verticalListWidgets.length - 1;

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
      int temp = lastListChoseIndex;

      if (isVertical) {
        listWidgetHeight = 90.0;
        listWidgetWidth = MediaQuery.of(context).size.width;

        lastListChoseIndex = 0;

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

          lastListChoseIndex = temp;
        }
      } else {
        listWidgetWidth = MediaQuery.of(context).size.width * 0.75;

        lastListChoseIndex = 0;

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

          lastListChoseIndex = temp;
        }
      }
    });
  }

  // Widget để chứa hình bin dùng cho việc xoá list
  Widget _buildDeleteBinWidget() => Container(
        alignment: Alignment.bottomCenter,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 350),
          transform: Matrix4.translationValues(0.0, binTransformValue, 0.0),
          width: 60.0,
          height: 60.0,
          child: DragTarget(
            builder: (context, List<int> acceptedData, rejectedData) {
              if (acceptedData.isEmpty)
                binWidgetImage = Image.asset(
                  "images/trash_with_closed_lid.png",
                  width: 60.0,
                  height: 60.0,
                );
              else {
                binWidgetImage = Image.asset(
                  "images/trash_with_open_lid.png",
                  width: 60.0,
                  height: 60.0,
                );
              }
              return binWidgetImage;
            },
            onWillAccept: (data) {
              return true;
            },
            onAccept: (data) async {
              if (dragIndex == data) {
                // Nếu ng dùng thả list ra và chấp nhận xoá thì sẽ remove list item đó theo id truy vấn từ vị trí tương ứng với vị trị kéo item
                var result = await _databaseHelper.getListsMap();

                if (result.length > 0) {
                  for (int i = 0; i < result.length; i++) {
                    if (i + 1 == dragIndex) {
                      var listInfo = result[i].values.toList();
                      _databaseHelper.deleteListData(listInfo[0]);

                      verticalListWidgets.removeAt(dragIndex);
                      horizontalListWidgets.removeAt(dragIndex);
                      listTitles.removeAt(dragIndex);
                      listColors.removeAt(dragIndex + 1);

                      setState(() {
                        previousLength--;
                        lastListChoseIndex = 0;
                        dragIndex = 0;
                        binTransformValue = MediaQuery.of(context).size.height;
                      });
                    }
                  }
                }
              }
            },
            onLeave: (data) {
              setState(() {});
            },
          ),
        ),
      );
}
