import 'package:flutter/material.dart';
import 'package:todoapp/doit_database_models/doit_tasks_data.dart';

// 3 biến lưu các task hiển thị trong 3 phần Today, Tomorrow và Later
List<TaskData> todayTask = [];
List<TaskData> tomorrowTask = [];
List<TaskData> laterTask = [];

// List chứa các thẻ task
List<Widget> todayTaskTilesList = [];

// Các biến dùng để lấy màu cho các thẻ task
// String colorStr;
// Color taskColor;
