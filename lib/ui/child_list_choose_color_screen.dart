import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:todoapp/ui/new_child_list_screen.dart';
import 'package:todoapp/ui_variables/achievement_lists_screen_variables.dart';
import 'package:todoapp/ui_variables/list_colors.dart';

class ChildListChooseColorScreen extends StatefulWidget {
  final String childListTitle;
  ChildListChooseColorScreen({this.childListTitle});

  @override
  _ChildListChooseColorScreenState createState() =>
      _ChildListChooseColorScreenState();
}

class _ChildListChooseColorScreenState
    extends State<ChildListChooseColorScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () async {
        if (isChildScreenChangeColorClicked == false) {
          childListColors.add(listChoiceColors[13]);

          childListWidgets[lastChoseMotherWidgetIndex][lastChildListChoseIndex] = childListWidget(
              childListTitles[childListTitles.length - 1],
              childListColors[childListColors.length - 1],
              childListColors[childListColors.length - 1] == Color(0xfffafafa)
                  ? childListTitleColors[0]
                  : childListTitleColors[1],
              null);

          // Cập nhật là việc pick màu đã xong
          isChildPickColorFinished = true;

          //------------------------------------------------------------------//
          // _databaseHelper.insertDataToListTable(ListData(
          //     listName: listTitles[listTitles.length - 1],
          //     listColor: listColors[listColors.length - 1].toString()));
          //------------------------------------------------------------------//

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
            return NewChildListScreen(
              listTiltle: childListTitles[childListTitles.length - 1],
              listColor: childListColors[childListColors.length - 1],
              listIcon: null,
              tag: lastChildListTag,
            );
          }));
        } else {
          setState(() {
            isChildPickColorFinished = false;
          });
          Navigator.pop(context);
        }

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
          return NewChildListScreen(
            listTiltle: childListTitles[childListTitles.length - 1],
            listColor: childListColors[1],
            listIcon: null,
            tag: lastChildListTag,
          );
        }));
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            color: Color(0xFFFFE4D4),
            child: Stack(
              children: <Widget>[
                _buildchildTitleTextWidget(),
                _buildChoiceColorsGridView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Display child title text widget
  Widget _buildchildTitleTextWidget() => Container(
        padding: EdgeInsets.only(top: 15.0),
        alignment: Alignment.topCenter,
        child: Text(
          "Choose color for: ${widget.childListTitle}",
          maxLines: 2,
          textAlign: TextAlign.center,
          overflow: TextOverflow.fade,
          style: TextStyle(fontSize: 35.0),
        ),
      );

  // Color grid view
  Widget _buildChoiceColorsGridView() => Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.12,
        ),
        child: AnimationLimiter(
          child: GridView.count(
            padding: EdgeInsets.only(top: 15.0),
            physics:
                AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            childAspectRatio: 3 / 2,
            crossAxisCount: childListChooseColorScreenColumnCount,
            children: List.generate(
              listColorCirclesContainer.length,
              (int index) {
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  columnCount: childListChooseColorScreenColumnCount,
                  child: ScaleAnimation(
                    child: FadeInAnimation(
                      child: GestureDetector(
                        child: listColorCirclesContainer[index],
                        onTap: () async {
                          if (isChildScreenChangeColorClicked == false) {
                            childListColors.add(listChoiceColors[index]);

                            childListWidgets[lastChildListChoseIndex][childListWidgets[lastChildListChoseIndex].length - 1] =
                                childListWidget(
                                    childListTitles[childListTitles.length - 1],
                                    childListColors[childListColors.length - 1],
                                    childListColors[
                                                childListColors.length - 1] ==
                                            Color(0xfffafafa)
                                        ? childListTitleColors[0]
                                        : childListTitleColors[1],
                                    null);

                            // childListWidgets[lastChildListChoseIndex] =
                            //     childListWidget(
                            //         childListTitles[childListTitles.length - 1],
                            //         childListColors[childListColors.length - 1],
                            //         childListColors[
                            //                     childListColors.length - 1] ==
                            //                 Color(0xfffafafa)
                            //             ? childListTitleColors[0]
                            //             : childListTitleColors[1],
                            //         null);

                            isChildPickColorFinished = true;

                            //--------------------------------------------//
                            // _databaseHelper.insertDataToListTable(ListData(
                            //     listName: listTitles[listTitles.length - 1],
                            //     listColor: listChoiceColors[index].toString()));
                            //--------------------------------------------//

                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) {
                              return NewChildListScreen(
                                listTiltle:
                                    childListTitles[childListTitles.length - 1],
                                listColor:
                                    childListColors[childListColors.length - 1],
                                listIcon: null,
                                tag: lastChildListTag,
                              );
                            }));
                          } else {
                            childListColors[lastChildListChoseIndex + 1] =
                                listChoiceColors[index];

                            childListWidgets[lastChoseMotherWidgetIndex][lastChildListChoseIndex] =
                                childListWidget(
                                    childListTitles[lastChildListChoseIndex],
                                    childListColors[
                                        lastChildListChoseIndex + 1],
                                    childListColors[
                                                lastChildListChoseIndex + 1] ==
                                            Color(0xfffafafa)
                                        ? childListTitleColors[0]
                                        : childListTitleColors[1],
                                    null);

                            isChildPickColorFinished = false;

                            //--------------------------------------------//
                            // Nếu ng dùng chọn màu xong thì sẽ cập nhật lại giá trị màu mới vào db
                            // var result = await _databaseHelper.getListsMap();

                            // for (int i = 0; i < result.length; i++) {
                            //   if (i + 1 == lastListChoseIndex) {
                            //     var listInfo = result[i].values.toList();
                            //     _databaseHelper.updateListData(ListData(
                            //         listId: listInfo[0],
                            //         listName: listTitles[lastListChoseIndex],
                            //         listColor:
                            //             listColors[lastListChoseIndex + 1]
                            //                 .toString()));

                            //     setState(() {
                            //       dragIndex = 0;
                            //     });

                            //     break;
                            //   }
                            // }

                            //--------------------------------------------//

                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) {
                              return NewChildListScreen(
                                listTiltle:
                                    childListTitles[lastChildListChoseIndex],
                                listColor: childListColors[
                                    lastChildListChoseIndex + 1],
                                listIcon: null,
                                tag: lastChildListTag,
                              );
                            }));

                            isChildScreenChangeColorClicked = false;
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
      );
}
