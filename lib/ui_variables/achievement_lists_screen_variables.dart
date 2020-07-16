// Widget để tạo ra UI cho list
import 'package:flutter/material.dart';

// Mảng lưu trữ các mother List widget
List<Widget> motherListWidgets = [];
// Biến lưu trữ 2 màu mặc đinh cho list
List<Color> motherListColors = [
  Color(0xFFF883B8),
  Colors.white,
];
// Biến lưu trữ số lượng các list con và task con đang có trong db
List<int> totalChildLists = [], totalChildListTasks = [];
// Biến lưu trữ số lượng các list đang có trước đó trong motherListWidgets và childListWidgets
int previousMotherListTitlesLength = 0, previousChildListTitlesLegnth = 0;
// Biến lưu trữ các title đã dc add
List<String> motherListTitles = [""];
// Mảng chứa các widget của list con
List<List<Widget>> childListWidgets = [];
// Biến để lưu trữ các widget chứa nội dung các task con trong list con
List<Widget> childTasksList = [];
// Mảng chứa các titles của list con
List<String> childListTitles = [""];
// Mảng chứa các màu của các list con
List<Color> childListColors = [
  Color(0xFFF883B8),
  Colors.white,
];
// Mảng chứa các màu cho các title của list con
List<Color> childListTitleColors = [Colors.black, Colors.white];
// Biến thay đổi opacity cho màn hình child list
double childListScreenOpacity = 1.0;
// Biến chứa số cộ của màn hình chọn màu
int childListChooseColorScreenColumnCount = 3;
// Biến lưu vị trí task con trc đó mà ng dùng chọn
int lastChildListChoseIndex = 0, lastChoseMotherWidgetIndex = 0;
// Biến để lưu trữ tag của list con mà ng dùng add trc đó để có thể trả về khi pick màu xong
Object lastChildListTag;
// Biến để check xem ng dùng có chọn sửa mau hay ko
bool isChildScreenChangeColorClicked = false;
// Biến để check xem ng dùng đã hoàn thành việc pick màu hay chưa
var isChildPickColorFinished = false;
// Biến để xét xem list item nào đang dc drag (mother list và child list)
var motherListDragIndex;
var childDragIndex;
// Các biến cho animation của bin
var motherListBinTransformValue;
var motherListBinImage;
var childListBinTransformValue;
var childListBinImage;

// Widget hiển thị các widget của mother list
Widget achievementMotherListWidget(String listTitle, Color listColor,
        int numberOfLists, Color listTitleColor,
        [IconData listIcon]) =>
    Container(
      margin: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
      ),
      height: 90.0,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 220.0,
              child: listIcon == null
                  ? Text(
                      "$listTitle",
                      style: TextStyle(
                        fontSize: 30.0,
                        color: listTitleColor,
                        decoration: TextDecoration.none,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.center,
                    )
                  : Image.asset(
                      'images/add.png',
                      width: 40.0,
                      height: 40.0,
                    ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 30.0),
            child: Text(
              listIcon != null ? "" : "$numberOfLists",
              style: TextStyle(
                fontSize: 30.0,
                color: listTitleColor,
                decoration: TextDecoration.none,
              ),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: listColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );

// Widget để tạo ra UI cho list con theo chiều ngang
Widget childListWidget(String listTitle, Color listColor, Color listTitleColor,
        [IconData listIcon]) =>
    Container(
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Container(
                width: 230.0,
                child: listIcon != null
                    ? Image.asset(
                        'images/add.png',
                        width: 40.0,
                        height: 40.0,
                      )
                    : childTasksList.length == 0
                        ? Text(
                            "You have no DOIT in this list yet",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: listTitleColor,
                              decoration: TextDecoration.none,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            textAlign: TextAlign.center,
                          )
                        : ListView.separated(
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {},
                                child: childTasksList[index],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 7.0,
                              );
                            },
                            itemCount: childTasksList.length)),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(bottom: 40.0),
              child: Text(
                "$listTitle",
                style: TextStyle(
                  fontSize: 30.0,
                  color: listTitleColor,
                  decoration: TextDecoration.none,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                textDirection: TextDirection.ltr,
              ),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: listColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
