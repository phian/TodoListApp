import 'package:flutter/material.dart';

// var typeColors = [Colors.red, Colors.black]; //
var listWidgets = []; // mảng lưu trữ các item của list view
var listTitles = [""]; // mảng lưu trữ các title của các list
// Biến dùng cho animation ẩn list view screen khi người dùng ấn add list
var listScreenOpacity = 1.0;
var listTitleTextColors = [
  Colors.black,
  Colors.white
]; // mảng lưu trữ màu của title của các list item
var listColors = [
  Colors.pink[300],
  Colors.white
]; // mảng lưu trữ màu của các list item
var scrollDirection = Axis.vertical; // Điều chỉnh hướng scroll của list view
// Hai biến dùng cho kích thước của một list item
var listWidgetHeight = 90.0;
var listWidgetWidth;
var previousLength =
    1; // Biến để check xem list title có dc add thêm dữ liệu mới hay chưa?
var isVertical = true; // Biến check xem ng dùng đang chọn chiều ngang hay dọc
// Biến để lưu trữ vị trí ng dùng chọn để nếu ng dùng có đổi màu thì có thể cập nhật theo vị trí này
var lastChoseIndex = 0;
var taskTitles = 0; // Biến dếm số lượn task đang có trang database
var isChangeColorClicked = false; // Biến để check xem ng dùng có đổi màu hay ko

// Widget để tạo ra UI cho list
Widget listWidget(String listTitle, Color listColor, int numberOfTasks,
        Color listTitleColor,
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
              lastChoseIndex == 0 ? "" : "$numberOfTasks",
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
