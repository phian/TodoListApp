import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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
  @override
  Widget build(BuildContext context) {
    int columnCount = 3;

    return WillPopScope(
      // ignore: missing_return
      onWillPop: () async {
        if (isChangeColorClicked == false) {
          listColors.add(listChoiceColors[13]);

          verticalListWidgets[lastChoseIndex] = verticalListWidget(
              listTitles[listTitles.length - 1],
              listColors[listColors.length - 1],
              taskTitles,
              listColors[listColors.length - 1] == Color(0xfffafafa)
                  ? listTitleTextColors[0]
                  : listTitleTextColors[1],
              null);

          horizontalListWidgets[lastChoseIndex] = horizontalListWidget(
              listTitles[listTitles.length - 1],
              listColors[listColors.length - 1],
              listColors[listColors.length - 1] == Color(0xfffafafa)
                  ? listTitleTextColors[0]
                  : listTitleTextColors[1],
              null);

          isPickColorFinished = true;

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
            return NewListScreen(
              listTiltle: listTitles[listTitles.length - 1],
              listColor: listColors[listColors.length - 1],
              listIcon: null,
              index: lastChoseIndex,
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
        backgroundColor: Color(0xFFFAF3F0),
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
                            onTap: () {
                              if (isChangeColorClicked == false) {
                                listColors.add(listChoiceColors[index]);

                                verticalListWidgets[lastChoseIndex] =
                                    verticalListWidget(
                                        listTitles[listTitles.length - 1],
                                        listColors[listColors.length - 1],
                                        taskTitles,
                                        listColors[listColors.length - 1] ==
                                                Color(0xfffafafa)
                                            ? listTitleTextColors[0]
                                            : listTitleTextColors[1],
                                        null);

                                horizontalListWidgets[lastChoseIndex] =
                                    horizontalListWidget(
                                        listTitles[listTitles.length - 1],
                                        listColors[listColors.length - 1],
                                        listColors[listColors.length - 1] ==
                                                Color(0xfffafafa)
                                            ? listTitleTextColors[0]
                                            : listTitleTextColors[1],
                                        null);

                                isPickColorFinished = true;

                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (_) {
                                  return NewListScreen(
                                    listTiltle:
                                        listTitles[listTitles.length - 1],
                                    listColor:
                                        listColors[listColors.length - 1],
                                    listIcon: null,
                                    index: lastChoseIndex,
                                  );
                                }));
                              } else {
                                listColors[lastChoseIndex + 1] =
                                    listChoiceColors[index];

                                verticalListWidgets[lastChoseIndex] =
                                    verticalListWidget(
                                        listTitles[lastChoseIndex],
                                        listColors[lastChoseIndex + 1],
                                        taskTitles,
                                        listColors[lastChoseIndex + 1] ==
                                                Color(0xfffafafa)
                                            ? listTitleTextColors[0]
                                            : listTitleTextColors[1],
                                        null);

                                horizontalListWidgets[lastChoseIndex] =
                                    horizontalListWidget(
                                        listTitles[lastChoseIndex],
                                        listColors[lastChoseIndex + 1],
                                        listColors[lastChoseIndex + 1] ==
                                                Color(0xfffafafa)
                                            ? listTitleTextColors[0]
                                            : listTitleTextColors[1],
                                        null);

                                isPickColorFinished = false;

                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (_) {
                                  return NewListScreen(
                                    listTiltle: listTitles[lastChoseIndex],
                                    listColor: listColors[lastChoseIndex + 1],
                                    listIcon: null,
                                    index: lastChoseIndex,
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
