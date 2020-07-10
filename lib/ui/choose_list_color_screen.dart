import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:todoapp/doit_database_bus/doit_database_helper.dart';
import 'package:todoapp/doit_database_models/doit_lists_data.dart';
import 'package:todoapp/ui/new_list_screen.dart';
import 'package:todoapp/ui_variables/finished_list.dart';
import 'package:todoapp/ui_variables/list_colors.dart';
import 'package:todoapp/ui_variables/list_screen_variables.dart';

class ChooseColorScreen extends StatefulWidget {
  final String listTitle;

  ChooseColorScreen({this.listTitle});

  @override
  _ChooseColorScreenState createState() => _ChooseColorScreenState();
}

class _ChooseColorScreenState extends State<ChooseColorScreen> {
  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    int columnCount = 3;

    return WillPopScope(
      // ignore: missing_return
      onWillPop: () async {
        if (isChangeColorClicked == false) {
          listColors.add(listChoiceColors[13]);

          verticalListWidgets[lastListChoseIndex] = verticalListWidget(
              listTitles[listTitles.length - 1],
              listColors[listColors.length - 1],
              taskTitles,
              listColors[listColors.length - 1] == Color(0xfffafafa)
                  ? listTitleTextColors[0]
                  : listTitleTextColors[1],
              null);

          horizontalListWidgets[lastListChoseIndex] = horizontalListWidget(
              listTitles[listTitles.length - 1],
              listColors[listColors.length - 1],
              listColors[listColors.length - 1] == Color(0xfffafafa)
                  ? listTitleTextColors[0]
                  : listTitleTextColors[1],
              null);

          isPickColorFinished = true;

          //------------------------------------------------------------------//
          _databaseHelper.insertDataToListTable(ListData(
              listName: listTitles[listTitles.length - 1],
              listColor: listColors[listColors.length - 1].toString()));
          //------------------------------------------------------------------//

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
            return NewListScreen(
              listTiltle: listTitles[listTitles.length - 1],
              listColor: listColors[listColors.length - 1],
              listIcon: null,
              index: lastListChoseIndex,
            );
          }));
        } else {
          setState(() {
            isChangeColorClicked = false;
          });
          Navigator.pop(context);
        }
      },
      child: SafeArea(
          child: Scaffold(
        backgroundColor: Color(0xFFFFE4D4),
        body: Stack(
          children: <Widget>[
            AnimationLimiter(
              child: GridView.count(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.12),
                physics: AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                childAspectRatio: 3 / 2,
                crossAxisCount: columnCount,
                children: List.generate(
                  listColorCirclesContainer.length,
                  (int index) {
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      columnCount: columnCount,
                      child: ScaleAnimation(
                        child: FadeInAnimation(
                          child: GestureDetector(
                            child: listColorCirclesContainer[index],
                            onTap: () async {
                              if (isChangeColorClicked == false) {
                                listColors.add(listChoiceColors[index]);

                                verticalListWidgets[lastListChoseIndex] =
                                    verticalListWidget(
                                        listTitles[listTitles.length - 1],
                                        listColors[listColors.length - 1],
                                        taskTitles,
                                        listColors[listColors.length - 1] ==
                                                Color(0xfffafafa)
                                            ? listTitleTextColors[0]
                                            : listTitleTextColors[1],
                                        null);

                                horizontalListWidgets[lastListChoseIndex] =
                                    horizontalListWidget(
                                        listTitles[listTitles.length - 1],
                                        listColors[listColors.length - 1],
                                        listColors[listColors.length - 1] ==
                                                Color(0xfffafafa)
                                            ? listTitleTextColors[0]
                                            : listTitleTextColors[1],
                                        null);

                                isPickColorFinished = true;

                                //--------------------------------------------//
                                _databaseHelper.insertDataToListTable(ListData(
                                    listName: listTitles[listTitles.length - 1],
                                    listColor:
                                        listChoiceColors[index].toString()));
                                //--------------------------------------------//

                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (_) {
                                  return NewListScreen(
                                    listTiltle:
                                        listTitles[listTitles.length - 1],
                                    listColor:
                                        listColors[listColors.length - 1],
                                    listIcon: null,
                                    index: lastListChoseIndex,
                                  );
                                }));
                              } else {
                                listColors[lastListChoseIndex + 1] =
                                    listChoiceColors[index];

                                verticalListWidgets[lastListChoseIndex] =
                                    verticalListWidget(
                                        listTitles[lastListChoseIndex],
                                        listColors[lastListChoseIndex + 1],
                                        taskTitles,
                                        listColors[lastListChoseIndex + 1] ==
                                                Color(0xfffafafa)
                                            ? listTitleTextColors[0]
                                            : listTitleTextColors[1],
                                        null);

                                horizontalListWidgets[lastListChoseIndex] =
                                    horizontalListWidget(
                                        listTitles[lastListChoseIndex],
                                        listColors[lastListChoseIndex + 1],
                                        listColors[lastListChoseIndex + 1] ==
                                                Color(0xfffafafa)
                                            ? listTitleTextColors[0]
                                            : listTitleTextColors[1],
                                        null);

                                isPickColorFinished = false;

                                //--------------------------------------------//
                                // Nếu ng dùng chọn màu xong thì sẽ cập nhật lại giá trị màu mới vào db
                                var result =
                                    await _databaseHelper.getListsMap();

                                for (int i = 0; i < result.length; i++) {
                                  if (i + 1 == lastListChoseIndex) {
                                    var listInfo = result[i].values.toList();
                                    _databaseHelper.updateListData(ListData(
                                        listId: listInfo[0],
                                        listName:
                                            listTitles[lastListChoseIndex],
                                        listColor:
                                            listColors[lastListChoseIndex + 1]
                                                .toString()));

                                    setState(() {
                                      dragIndex = 0;
                                    });

                                    break;
                                  }
                                }

                                //--------------------------------------------//

                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (_) {
                                  return NewListScreen(
                                    listTiltle: listTitles[lastListChoseIndex],
                                    listColor:
                                        listColors[lastListChoseIndex + 1],
                                    listIcon: null,
                                    index: lastListChoseIndex,
                                  );
                                }));

                                isChangeColorClicked = false;
                              }
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              child: Text(
                "Choose color for: ${widget.listTitle}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: "Roboto",
                  decoration: TextDecoration.none,
                ),
              ),
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 15.0),
              color: Color(0xFFFAF3F0),
              height: 100.0,
            ),
          ],
        ),
      )),
    );
  }
}
