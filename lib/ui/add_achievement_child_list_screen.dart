import 'package:flutter/material.dart';
import 'package:todoapp/ui/child_list_choose_color_screen.dart';
import 'package:todoapp/ui/new_child_list_screen.dart';
import 'package:todoapp/ui_variables/achievement_lists_screen_variables.dart';

class AddChildListForMotherListScreen extends StatefulWidget {
  final int tag;
  final String motherListHeader;
  AddChildListForMotherListScreen({this.tag, this.motherListHeader});

  @override
  _AddChildListForMotherListScreenState createState() =>
      _AddChildListForMotherListScreenState();
}

class _AddChildListForMotherListScreenState
    extends State<AddChildListForMotherListScreen> {
  // Biến để check xem ng dùng có ấn vào phần thêm list không
  bool _isAddItemClick;

  @override
  void initState() {
    super.initState();
    _isAddItemClick = false;

    _initFirstWidget();
    if (childListWidgets.length > 1) _initListWidgetsFromDbData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          color: Color(0xFFFFE4D4),
          child: AnimatedOpacity(
            opacity: childListScreenOpacity,
            duration: Duration(milliseconds: 300),
            child: Stack(
              children: <Widget>[
                Hero(
                  tag: "${widget.tag}",
                  child: Text(""),
                ),
                Stack(
                  children: <Widget>[
                    _buildAddChildListScreenHeaderText(),
                    _buildCloseScreenButton(),
                    _buildAchievementHeaderImage(),
                    _buildChildListView(),
                    _buildDeleteBinWidget(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Header text
  Widget _buildAddChildListScreenHeaderText() => Container(
        padding: EdgeInsets.only(top: 26.0),
        alignment: Alignment.topCenter,
        child: Text(
          "${widget.motherListHeader}",
          style: TextStyle(
            fontSize: 35.0,
            fontWeight: FontWeight.w100,
            color: Color(0xFF425195),
            decoration: TextDecoration.none,
          ),
        ),
      );

  // Close button
  Widget _buildCloseScreenButton() => Container(
        padding: EdgeInsets.symmetric(
          vertical: 12.7,
          horizontal: 12.0,
        ),
        alignment: Alignment.topLeft,
        child: Container(
          height: 65.0,
          width: 65.0,
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(90.0),
            ),
            child: Icon(
              Icons.close,
              size: 35.0,
              color: Color(0xFF425195),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      );

  // Achievement's child lists screen header image
  Widget _buildAchievementHeaderImage() => Container(
        padding: EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 15.0,
        ),
        child: Image.asset(
          "images/achievement.png",
          width: 55.0,
          height: 55.0,
          color: Color(0xFF425195),
        ),
        alignment: Alignment.topRight,
      );

  // Hàm để init widget đầu tiên (dấu cộng)
  void _initFirstWidget() {
    for (int i = 0; i < childListWidgets.length; i++)
      if (childListWidgets[i].length == 0)
        setState(() {
          childListWidgets[i].add(childListWidget(
            "",
            childListColors[0],
            Colors.white,
            Icons.add,
          ));
        });

    print(childListWidgets[0].length);
  }

  // Hàm để khởi tạo các widget từ data dc đọc lên từ database
  void _initListWidgetsFromDbData() {
    setState(() {
      for (int i = 0; i < childListWidgets.length; i++) {
        for (int j = 0; j < childListWidgets[i].length; j++) {
          childListWidgets[i][0] = childListWidget(
            "",
            childListColors[0],
            Colors.white,
            Icons.add,
          );
          if (j != childListWidgets[i].length - 1)
            childListWidgets[i][j] = childListWidget(
                childListTitles[i],
                childListColors[i + 1],
                childListColors[i + 1] == Color(0xFFFAFAFA)
                    ? childListTitleColors[0]
                    : childListTitleColors[1]);
          else if (i == childListWidgets[i].length - 1) {
            if (_isAddItemClick) {
              childListWidgets[i][j] = childListWidget(
                childListTitles[0],
                childListColors[1],
                childListTitleColors[1],
              );
            } else {
              childListWidgets[i][j] = childListWidget(
                  childListTitles[i],
                  childListColors[i + 1],
                  childListColors[i + 1] == Color(0xFFFAFAFA)
                      ? childListTitleColors[0]
                      : childListTitleColors[1]);
            }
          }
        }
      }
    });
  }

  // Build child list view
  Widget _buildChildListView() => Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.15,
        ),
        height: MediaQuery.of(context).size.height * 0.9,
        child: ListView.separated(
            padding: EdgeInsets.only(
              left: 15.0,
              right: 15.0,
            ),
            scrollDirection: Axis.horizontal,
            physics: AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Nếu ng dùng ấn dấu + để thêm task
                  if (index == 0) {
                    setState(() {
                      childListScreenOpacity = 0.0;
                      _isAddItemClick = true;

                      childListWidgets[widget.tag - 1].add(childListWidget(
                          childListTitles[0],
                          childListColors[1],
                          childListTitleColors[1]));
                      lastChildListChoseIndex = childListWidgets.length - 1;

                      Future.delayed(Duration(milliseconds: 350), () {
                        _addNewLChildist();
                      });

                      // Cộng đến item sau
                      lastChildListTag =
                          "${widget.tag + childListWidgets[widget.tag - 1].length}";
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return NewChildListScreen(
                          listTiltle: childListTitles[0],
                          listColor: childListColors[1],
                          listIcon: null,
                          tag: lastChildListTag,
                        );
                      }));
                    });
                  } else if (index != 0) {
                    lastChildListChoseIndex = index;

                    // Lấy tag của item hiện tại
                    lastChildListTag = "${widget.tag + index + 1}";
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return NewChildListScreen(
                        listTiltle: childListTitles[lastChildListChoseIndex],
                        listColor: childListColors[lastChildListChoseIndex + 1],
                        listIcon: null,
                        tag: lastChildListTag,
                      );
                    }));
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: 50.0,
                  child: Hero(
                    tag: "${widget.tag + index + 1}",
                    child: () {
                      if (index == 0) {
                        return childListWidgets[widget.tag - 1][index];
                      }

                      return Draggable(
                          onDragStarted: () {
                            setState(() {
                              childDragIndex = index;
                              childListBinTransformValue =
                                  -(MediaQuery.of(context).size.height * 0.06);
                            });
                          },
                          onDragEnd: (details) {
                            setState(() {
                              // dragIndex = 0;
                              childListBinTransformValue =
                                  MediaQuery.of(context).size.height;
                            });
                          },
                          onDragCompleted: () {
                            setState(() {
                              childListBinTransformValue =
                                  MediaQuery.of(context).size.height;
                            });
                          },
                          data: index,
                          maxSimultaneousDrags: 1,
                          child: childListWidgets[widget.tag - 1][index],
                          childWhenDragging: Opacity(
                            opacity: 0.7,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.9,
                              width: MediaQuery.of(context).size.width,
                              child: childListWidgets[widget.tag - 1][index],
                            ),
                          ),
                          feedback: Opacity(
                            opacity: 0.7,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.9,
                              width: MediaQuery.of(context).size.width,
                              child: childListWidgets[widget.tag - 1][index],
                            ),
                          ));
                    }(),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 10,
              );
            },
            itemCount: childListWidgets[widget.tag - 1].length),
      );

  // Hàm để add một list mới
  void _addNewLChildist() {
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
                if (value.isEmpty == false) childListTitles.add(value);

                Navigator.of(context).pop();
              },
            ),
          );
        }).whenComplete(() {
      setState(() {
        childListScreenOpacity = 1.0;

        if (childListTitles.length != previousChildListTitlesLegnth) {
          // Cấp nhật vị trí mới cho phần chọn item và cập nhật độ dài mới của list title để lưu trữ lại
          previousChildListTitlesLegnth = childListTitles.length;
          lastChildListChoseIndex = childListWidgets.length - 1;
          // Cập nhật là việc pick màu bắt đầu
          isChildPickColorFinished = false;
          _isAddItemClick = false;

          // Cập nhật số lượng list con cho hiển thị của list mẹ
          totalChildLists[widget.tag - 1] = childListWidgets.length - 1;

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
            return ChildListChooseColorScreen(
              childListTitle: childListTitles[childListTitles.length - 1],
            );
          }));
        } else {
          if (childListWidgets.length > 1)
            // Nếu ko có title mới dc add thì ta sẽ xoá item cuối của list widget
            childListWidgets[widget.tag - 1]
                .removeAt(childListWidgets.length - 1);
          Navigator.pop(context);
        }
      });
    });
  }

  // Widget để chứa hình bin dùng cho việc xoá list
  Widget _buildDeleteBinWidget() => Container(
        alignment: Alignment.bottomCenter,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 350),
          transform:
              Matrix4.translationValues(0.0, childListBinTransformValue, 0.0),
          width: 60.0,
          height: 60.0,
          child: DragTarget(
            builder: (context, List<int> acceptedData, rejectedData) {
              if (acceptedData.isEmpty)
                childListBinImage = Image.asset(
                  "images/trash_with_closed_lid.png",
                  width: 60.0,
                  height: 60.0,
                );
              else {
                childListBinImage = Image.asset(
                  "images/trash_with_open_lid.png",
                  width: 60.0,
                  height: 60.0,
                );
              }
              return childListBinImage;
            },
            onWillAccept: (data) {
              return true;
            },
            onAccept: (data) {
              if (childDragIndex == data) {
                // Nếu ng dùng thả list ra và chấp nhận xoá thì sẽ remove list item đó theo id truy vấn từ vị trí tương ứng với vị trị kéo item
                // var result = await _databaseHelper.getListsMap();

                // if (result.length > 0) {
                //   for (int i = 0; i < result.length; i++) {
                //     if (i + 1 == motherListdragIndex) {
                //       var listInfo = result[i].values.toList();
                //       _databaseHelper.deleteListData(listInfo[0]);

                childListWidgets[widget.tag - 1].removeAt(childDragIndex);
                childListTitles.removeAt(motherListDragIndex);
                // totalChildListTasks.removeAt(motherListDragIndex - 1);

                setState(() {
                  previousChildListTitlesLegnth--;
                  print(
                      "previousMotherListTitlesLength-- ${previousMotherListTitlesLength--}");
                  lastChildListChoseIndex = 0;
                  childDragIndex = 0;
                  childListBinTransformValue =
                      MediaQuery.of(context).size.height;
                });
                //     }
                //   }
                // }
              }
            },
            onLeave: (data) {
              setState(() {});
            },
          ),
        ),
      );
}
