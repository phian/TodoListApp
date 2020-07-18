import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoapp/doit_database_bus/doit_database_helper.dart';
import 'package:todoapp/custom_ui_widgets/custom_list_tile.dart';
import 'package:todoapp/doit_database_models/doit_tasks_data.dart';
import 'package:todoapp/set_up_widgets/task_sheet.dart';
import 'package:todoapp/ui_variables/dates_list_variables.dart';

// ignore: must_be_immutable
class DatesListScreen extends StatefulWidget {
  @override
  _DatesListScreenState createState() => _DatesListScreenState();
}

class _DatesListScreenState extends State<DatesListScreen>
    with TickerProviderStateMixin {
  DatabaseHelper _databaseHelper = DatabaseHelper();

  // Các biến cho animation của các item
  double _itemScale;
  AnimationController _itemAniController;

  @override
  void initState() {
    super.initState();
    _refreshTodayTask();

    _itemAniController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
  }

  // Hàm để đọc data các task đang có trong db
  _refreshTodayTask() {
    todayTask = _databaseHelper.getTodayTask();
  }

  @override
  Widget build(BuildContext context) {
    _itemScale = 1 - _itemAniController.value;

    return ListView(
      physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            'Today',
            textDirection: TextDirection.ltr,
            style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Roboto',
            ),
          ),
        ),
        _buildTodayList(),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            'Tomorrow',
            textDirection: TextDirection.ltr,
            style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Roboto',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            top: 20.0,
          ),
          child: Text(
            'Later',
            textDirection: TextDirection.ltr,
            style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Roboto',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTodayList() {
    return FutureBuilder(
      future: todayTask,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Center(
                child: Text(
              'Loading...',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
                fontFamily: 'Roboto',
              ),
            )),
          );
        } else if (snapshot.hasData == null) {
          // Điều kiện chỗ này sai, chưa biết fix ...
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Center(
                child: Text(
              'You have no task today!',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
                fontFamily: 'Roboto',
              ),
            )),
          );
        }
        List<TaskData> todayTaskList = snapshot.data;
        return Container(
          height: todayTaskList.length * 100.0,
          margin: EdgeInsets.symmetric(vertical: 15, horizontal: 28),
          child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            itemCount: todayTaskList.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return Container(
                child: Container(
                  child: GestureDetector(
                    onTapUp: _onTapUp,
                    onTapDown: _onTapDown,
                    onTapCancel: _onTapCancel,
                    child: Transform.scale(
                      scale: _itemScale,
                      child: Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        child: TaskTile(
                          taskData: todayTaskList[index],
                        ),
                        actions: <Widget>[
                          IconSlideAction(
                            iconWidget: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.remove_circle_outline,
                                  size: 25.0,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Delete",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            color: Colors.transparent,
                            onTap: () {},
                          ),
                          IconSlideAction(
                            iconWidget: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.access_time,
                                  size: 25.0,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Reschedule",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            color: Colors.transparent,
                            onTap: () {},
                          ),
                        ],
                        secondaryActions: <Widget>[
                          IconSlideAction(
                            iconWidget: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.done,
                                  size: 25.0,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Complete",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            color: Colors.transparent,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  height: 80.0,
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 5.0,
              );
            },
          ),
        );
      },
    );
  }

  // Hàm gọi khi ng dùng ấn vào task và show ra bottom sheet để ng dùng chỉnh
  void _showScheduleBottomSheet() async {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return TaskSheet();
      },
    );
  }

  // Hàm bắt sự kiện khi ng dùng bắt đầu ấn vào item
  void _onTapUp(TapUpDetails details) {
    _itemAniController.reverse();

    _showScheduleBottomSheet();
  }

  // Hàm bắt sự kiện nếu ng dùng hoàn thành việc ấn vào item
  void _onTapDown(TapDownDetails details) {
    _itemAniController.forward();
  }

  // Hàm sự kiện nếu ng dùng ko ấn vào item nữa
  void _onTapCancel() {
    _itemAniController.reverse();
  }
}
