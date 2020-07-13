import 'package:flutter/material.dart';
import 'package:todoapp/ui/new_list_screen.dart';

// var typeColors = [Colors.red, Colors.black]; //
var verticalListWidgets = []; // mảng lưu trữ các item của list view
var listTitles = [""]; // mảng lưu trữ các title của các list
var listIds = [];

// Biến dùng cho animation ẩn list view screen khi người dùng ấn add list
var listScreenOpacity = 1.0;
var listTitleTextColors = [Colors.black, Colors.white]; // mảng lưu trữ màu của title của các list item
var listColors = [Colors.pink[300], Colors.white]; // mảng lưu trữ màu của các list item

var scrollDirection = Axis.vertical; // Điều chỉnh hướng scroll của list view
// Hai biến dùng cho kích thước của một list item
var listWidgetHeight = 90.0;
var listWidgetWidth;

// Biến để check xem list title có dc add thêm dữ liệu mới hay chưa?
var previousLength = 1;
var isVertical = true; // Biến check xem ng dùng đang chọn chiều ngang hay dọc

// Biến để lưu trữ vị trí ng dùng chọn để nếu ng dùng có đổi màu thì có thể cập nhật theo vị trí này
var lastListChoseIndex = 0;
var taskTitles = 0; // Biến dếm số lượn task đang có trang database
var isChangeColorClicked = false; // Biến để check xem ng dùng có đổi màu hay ko

// Mảng chứa các item của list khi người dùng chuyển sang chiều ngang
var horizontalListWidgets = [];
// Mảng chứa các item của task của 1 list khi người dùng chuyển sang chiều ngang
var horizontalTaskWidgets = [];

// Biến để lưu trữ lại vị trí màn hình mà trc đó ng dùng đang focus để sử dụng cho trang new list dùng khi chuyển qua trang add task
var mainScreenLastFocusedIndex = 0;
var mainScreenSettingScreenIndex = -1;

// Biến để lưu trữ vị trí màu mà ng dùng chọn để dùng cho phần insert
var selectedColorIndex;

// Biến để thay đổi transform cho trash icon và thay đổi hình ảnh icon khi ng dùng drag item đến bin
var binTransformValue;
var binWidgetImage;
var dragIndex; // Biến để xét xem list item nào đang dc drag

// Widget để tạo ra UI cho list
Widget verticalListWidget(String listTitle, Color listColor, int numberOfTasks, Color listTitleColor,
        [IconData listIcon]) =>
    Container(
      width: listWidgetWidth,
      height: listWidgetHeight,
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
              listIcon != null ? "" : "$numberOfTasks",
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

// Widget để tạo ra UI cho list theo chiều ngang
Widget horizontalListWidget(String listTitle, Color listColor, Color listTitleColor, [IconData listIcon]) =>
    Container(
      width: listWidgetWidth,
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
                    : horizontalTaskWidgets.length == 0
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
                                onTap: () {
                                  lastListChoseIndex = index;

                                  print(listColors[lastListChoseIndex + 1]);

                                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                                    return NewListScreen(
                                      listTiltle: listTitles[lastListChoseIndex],
                                      listColor: listColors[lastListChoseIndex + 1],
                                      listIcon: null,
                                      index: lastListChoseIndex,
                                    );
                                  }));
                                },
                                child: horizontalTaskWidgets[index],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 7.0,
                              );
                            },
                            itemCount: horizontalTaskWidgets.length)),
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
