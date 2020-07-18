import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todoapp/data/main_screen_data.dart';
import 'package:todoapp/ui/add_achievement_child_list_screen.dart';
import 'package:todoapp/ui/main_screen.dart';
import 'package:todoapp/ui_variables/achievement_lists_screen_variables.dart';

class AchievementListsScreen extends StatefulWidget {
  final int lastFocusedIndex;
  AchievementListsScreen({this.lastFocusedIndex});

  @override
  _AchievementListsScreenState createState() => _AchievementListsScreenState();
}

class _AchievementListsScreenState extends State<AchievementListsScreen> {
  @override
  void initState() {
    super.initState();

    if (motherListWidgets.length == 0) {
      _initFirstMotherListItem();
    }
    if (motherListWidgets.length > 1) {
      _initMotherListCount();
    }
  }

  @override
  Widget build(BuildContext context) {
    // if (motherListWidgets.length > 1) {
    //   _initMotherListCount();
    // }
    if (motherListBinTransformValue == null) {
      setState(() {
        motherListBinTransformValue = MediaQuery.of(context).size.height;
      });
    }

    return SafeArea(
      child: WillPopScope(
        // ignore: missing_return
        onWillPop: () async {
          _backToMainScreen();
        },
        child: Scaffold(
          body: Container(
            color: Color(0xFFFFE4D4),
            child: Stack(
              children: <Widget>[
                _buildAchievementScreenHeaderText(),
                _buildAchievementHeaderImage(),
                _buildCloseScreenButton(),
                _buildAchievemetListsListView(),
                _buildDeleteBinWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Achievement lists screen header text
  Widget _buildAchievementScreenHeaderText() => Container(
        padding: EdgeInsets.symmetric(vertical: 15.0),
        alignment: Alignment.topCenter,
        child: Text(
          "Achievement \nLists screen",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30.0,
            decoration: TextDecoration.none,
            color: Color(0xFF425195),
            fontWeight: FontWeight.w100,
          ),
        ),
      );

  // Achievement lists screen header image
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

  // Close button
  Widget _buildCloseScreenButton() => Container(
        padding: EdgeInsets.symmetric(
          vertical: 16.0,
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
              _backToMainScreen();
            },
          ),
        ),
      );

  // Hàm để khởi tạo item đầu tiên cho Achievement lists
  void _initFirstMotherListItem() {
    motherListWidgets.add(
      achievementMotherListWidget(
        "",
        Color(0xFFF883B8),
        totalChildLists.length,
        Colors.black,
        Icons.add,
      ),
    );
  }

  // Hàm để back về main screen
  void _backToMainScreen() {
    MainScreenData data = MainScreenData(
        isBack: false,
        isBackFromAddTaskScreen: true,
        lastFocusedScreen: widget.lastFocusedIndex,
        settingScreenIndex: -1);

    Navigator.pushReplacement(
        context,
        PageTransition(
            child: HomeScreen(
              data: data,
            ),
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 400)));
  }

  // Achievement lists ListView
  Widget _buildAchievemetListsListView() => Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.15,
        ),
        child: ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            physics: AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 300),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: GestureDetector(
                      onTap: () {
                        print("index $index tapped");
                        if (index == 0) {
                          setState(() {
                            // Nếu add list mới thì thêm số lượng list con mặc định, nếu ng dùng ko thêm list đó thì sẽ remove item này
                            totalChildLists.add(0);
                            motherListWidgets.add(
                              achievementMotherListWidget(
                                  motherListTitles[0],
                                  motherListColors[1],
                                  totalChildLists[totalChildLists.length - 1],
                                  Colors.transparent),
                            );
                          });
                          _addNewMotherList();
                        } else {
                          lastChoseMotherWidgetIndex = index;

                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return AddChildListForMotherListScreen(
                              tag: index,
                              motherListHeader: motherListTitles[index],
                            );
                          }));
                        }
                      },
                      child: Hero(
                        tag: "$index",
                        child: () {
                          if (index == 0) {
                            return motherListWidgets[index];
                          }

                          return Draggable(
                              onDragStarted: () {
                                setState(() {
                                  motherListDragIndex = index;
                                  motherListBinTransformValue =
                                      -(MediaQuery.of(context).size.height *
                                          0.06);
                                });
                              },
                              onDragEnd: (details) {
                                setState(() {
                                  // dragIndex = 0;
                                  motherListBinTransformValue =
                                      MediaQuery.of(context).size.height;
                                });
                              },
                              onDragCompleted: () {
                                setState(() {
                                  motherListBinTransformValue =
                                      MediaQuery.of(context).size.height;
                                });
                              },
                              data: index,
                              maxSimultaneousDrags: 1,
                              child: motherListWidgets[index],
                              childWhenDragging: Opacity(
                                opacity: 0.7,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: motherListWidgets[index],
                                ),
                              ),
                              feedback: Opacity(
                                opacity: 0.7,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: motherListWidgets[index],
                                ),
                              ));
                        }(),
                      ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 10.0,
              );
            },
            itemCount: motherListWidgets.length),
      );

  // Hàm để add một list mới
  void _addNewMotherList() {
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
                if (value.isNotEmpty) motherListTitles.add(value);
                Navigator.of(context).pop();
              },
            ),
          );
        }).whenComplete(() {
      if (motherListTitles.length != previousMotherListTitlesLength) {
        setState(() {
          previousMotherListTitlesLength = motherListTitles.length;

          motherListWidgets[motherListWidgets.length - 1] =
              achievementMotherListWidget(
            motherListTitles[motherListTitles.length - 1],
            motherListColors[1],
            totalChildLists[totalChildLists.length - 1],
            Colors.black,
          );
          lastChildListChoseIndex = motherListWidgets.length - 1;
          childListWidgets.add(List());
        });
      } else {
        if (motherListWidgets.length > 1) {
          motherListWidgets.removeAt(motherListWidgets.length - 1);
          totalChildLists.removeAt(totalChildLists.length - 1);
        }
      }
    });
  }

  // Hàm để hiển thị tổng các list con đang có trong list mẹ
  void _initMotherListCount() {
    if (totalChildLists.length > 0) {
      for (int i = 0; i < totalChildLists.length; i++) {
        motherListWidgets[i + 1] = achievementMotherListWidget(
          motherListTitles[i + 1],
          motherListColors[1],
          totalChildLists[i],
          Colors.black,
        );
      }
    }
  }

  // Widget để chứa hình bin dùng cho việc xoá list
  Widget _buildDeleteBinWidget() => Container(
        alignment: Alignment.bottomCenter,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 350),
          transform:
              Matrix4.translationValues(0.0, motherListBinTransformValue, 0.0),
          width: 60.0,
          height: 60.0,
          child: DragTarget(
            builder: (context, List<int> acceptedData, rejectedData) {
              if (acceptedData.isEmpty)
                motherListBinImage = Image.asset(
                  "images/trash_with_closed_lid.png",
                  width: 60.0,
                  height: 60.0,
                );
              else {
                motherListBinImage = Image.asset(
                  "images/trash_with_open_lid.png",
                  width: 60.0,
                  height: 60.0,
                );
              }
              return motherListBinImage;
            },
            onWillAccept: (data) {
              return true;
            },
            onAccept: (data) {
              if (motherListDragIndex == data) {
                // Nếu ng dùng thả list ra và chấp nhận xoá thì sẽ remove list item đó theo id truy vấn từ vị trí tương ứng với vị trị kéo item
                // var result = await _databaseHelper.getListsMap();

                // if (result.length > 0) {
                //   for (int i = 0; i < result.length; i++) {
                //     if (i + 1 == motherListdragIndex) {
                //       var listInfo = result[i].values.toList();
                //       _databaseHelper.deleteListData(listInfo[0]);

                motherListWidgets.removeAt(motherListDragIndex);
                motherListTitles.removeAt(motherListDragIndex);
                childListWidgets.removeAt(motherListDragIndex - 1);
                totalChildLists.removeAt(motherListDragIndex - 1);

                setState(() {
                  if (previousMotherListTitlesLength > 1)
                    previousMotherListTitlesLength--;
                  lastChoseMotherWidgetIndex = 0;
                  motherListDragIndex = 0;
                  motherListBinTransformValue =
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
