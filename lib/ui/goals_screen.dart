import 'package:flutter/material.dart';

class GoalsScreen extends StatefulWidget {
  @override
  _GoalsScreenState createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen>
    with TickerProviderStateMixin {
  // Biến thay đổi đường dẫn hình ảnh cho hình bên góc phải
  List<String> _taskTypeIconPaths;
  // Biến lưu vị trí tab mà ng dùng chọn
  int _selectedTabIndex;
  // Controller cho TabBar
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _taskTypeIconPaths = [
      "images/completed_tasks.png",
      "images/completed_special_tasks.png",
      "images/completed_achievement_tasks.png"
    ];
    _selectedTabIndex = 0;

    _tabController = TabController(vsync: this, length: 3);
    _tabController.addListener(() {
      if (_tabController.index != _tabController.previousIndex) {
        setState(() {
          _selectedTabIndex = _tabController.index;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFFFE4D4),
        child: Stack(
          children: <Widget>[
            _buildLogBookScreenHeader(),
            _buildLogBookScreenBody(),
          ],
        ),
      ),
    );
  }

  //---------------------------------------Phần header---------------------------------------//
  // Log book screen header
  Widget _buildLogBookScreenHeader() => Stack(
        children: <Widget>[
          _buildLogBookScreenHeaderTest(),
          _buildLogBookScreenLeftIcon(),
          // _buildLogBookScreenRightIcon(),
        ],
      );

  // Haader test
  Widget _buildLogBookScreenHeaderTest() => Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        alignment: Alignment.topCenter,
        child: Text(
          "LOG BOOK",
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 35,
            color: Colors.black,
          ),
        ),
      );

  // Header right icon
  Widget _buildLogBookScreenLeftIcon() => Container(
        padding: EdgeInsets.only(
          top: 4.0,
          left: MediaQuery.of(context).size.width / 2 + 30.0,
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: Image.asset(
            'images/log_book.png',
            width: 50,
            height: 70,
          ),
        ),
      );

  // Header right icon
  Widget _buildLogBookScreenTaskTypeIcon(String iconPath) => Container(
        margin: EdgeInsets.only(
          right: 7.0,
        ),
        child: Image.asset(
          iconPath,
          width: 30,
          height: 30,
        ),
      );
  //---------------------------------------------------------------------------------------//

  //---------------------------------------Phần body---------------------------------------//
  Widget _buildLogBookScreenBody() => Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.12,
            ),
            child: Container(
              child: TabBar(
                labelPadding: EdgeInsets.only(
                  left: 20.0,
                ),
                onTap: (index) {
                  setState(() {
                    _selectedTabIndex = index;
                  });
                },
                isScrollable: true,
                controller: _tabController,
                indicatorColor: Colors.transparent,
                unselectedLabelColor: Colors.black38, // (0xFF4DB6AC),
                labelColor: Colors.black,
                tabs: <Widget>[
                  Container(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Tab(
                      child: Container(
                        height: 70.0,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(
                                  "Completed Tasks",
                                  style: TextStyle(fontSize: 25.0),
                                ),
                                _buildLogBookScreenTaskTypeIcon(
                                  _taskTypeIconPaths[0],
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 7.0),
                              height: 3.0,
                              width: 50.0,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  color: _selectedTabIndex == 0
                                      ? Color(0xFF425195)
                                      : Colors.transparent),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Tab(
                        child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              "Completed Special Tasks",
                              style: TextStyle(fontSize: 25.0),
                            ),
                            _buildLogBookScreenTaskTypeIcon(
                              _taskTypeIconPaths[1],
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 7.0),
                          height: 3.0,
                          width: 50.0,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              color: _selectedTabIndex == 1
                                  ? Colors.blue.shade900
                                  : Colors.transparent),
                        ),
                      ],
                    )),
                  ),
                  Container(
                    height: 50.0,
                    child: Tab(
                        child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              "Completed Achievement Tasks",
                              style: TextStyle(fontSize: 25.0),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                left: 10.0,
                              ),
                              child: _buildLogBookScreenTaskTypeIcon(
                                _taskTypeIconPaths[2],
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 7.0),
                          height: 3.0,
                          width: 50.0,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              color: _selectedTabIndex == 2
                                  ? Colors.blue.shade900
                                  : Colors.transparent),
                        ),
                      ],
                    )),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                _buildtempListView(),
                _buildtempListView(),
                _buildtempListView(),
              ],
            ),
          ),
        ],
      );

  // Temp ListView
  Widget _buildtempListView() => Container(
        padding: EdgeInsets.only(
          top: 20.0,
        ),
        child: ListView.separated(
          padding: EdgeInsets.only(
            right: 20.0,
            left: 20.0,
          ),
          physics: AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              height: 100.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 10.0,
            );
          },
        ),
      );
}
