import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/ui/tasks_screen.dart';

int _lastFocusedIconIndex = 0; // biến để check xem Icon thứ mấy dc focus trc đó

GlobalKey _bottomMenuKey = GlobalKey();

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> _screenList = [ TasksScreen() ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screenList[0],
      floatingActionButton: Container(
        width: 55.0,
        height: 55.0,
        child: FloatingActionButton(
          elevation: 2.0,
          tooltip: 'Add new task',
          child: Icon(Icons.add),
          onPressed: () {
            print('Tapped');
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BubbleBottomBar(
        backgroundColor: Color(0xFFFAF3F0),
        opacity: .2,
        currentIndex: _lastFocusedIconIndex,
        onTap: _changePage,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        //new
        fabLocation: BubbleBottomBarFabLocation.end,
        //new
        hasNotch: true,
        //new, gives a cute ink effect
        hasInk: true,
        //optional, uses theme color if not specified
        inkColor: Colors.black12,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Colors.redAccent,
              icon: Icon(CupertinoIcons.tags, size: 30, color: Colors.red),
              activeIcon:
              Icon(CupertinoIcons.tags, size: 30, color: Colors.indigo),
              title: Text(
                "Recent",
                style: TextStyle(color: Colors.red.shade900),
              )),
          BubbleBottomBarItem(
              backgroundColor: Colors.deepPurple,
              icon: Icon(CupertinoIcons.check_mark_circled_solid,
                  size: 30, color: Colors.purple),
              activeIcon: Icon(CupertinoIcons.check_mark_circled_solid,
                  size: 30, color: Colors.indigo),
              title: Text(
                "Goals",
                style: TextStyle(color: Colors.deepPurple.shade900),
              )),
          BubbleBottomBarItem(
              backgroundColor: Colors.teal,
              icon: Icon(CupertinoIcons.book, size: 30, color: Colors.teal),
              activeIcon:
              Icon(CupertinoIcons.book, size: 30, color: Colors.indigo),
              title: Text(
                "Tasks List",
                style: TextStyle(
                  color: Colors.teal.shade900,
                ),
              )),
          BubbleBottomBarItem(
              backgroundColor: Colors.green,
              icon: Icon(CupertinoIcons.settings, size: 30, color: Colors.cyan),
              activeIcon:
              Icon(CupertinoIcons.settings, size: 30, color: Colors.indigo),
              title: Text(
                "Settings",
                style: TextStyle(color: Colors.green.shade900),
              ))
        ],
      ),
    );
  }

  // Hàm để cập nhật vị trí tab hiện tại của bottom bar
  void _changePage(int value) {
    setState(() {
      _lastFocusedIconIndex = value;
    });
  }
}
