import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todoapp/ui/preference_screen.dart';

class HabbitsSettingScreen extends StatefulWidget {
  final int lastFocusedScreen;

  HabbitsSettingScreen({this.lastFocusedScreen});

  @override
  _HabbitsSettingScreenState createState() => _HabbitsSettingScreenState();
}

class _HabbitsSettingScreenState extends State<HabbitsSettingScreen> {
  // Biến lấy thời gian hiện tại để hiển thị câu chào
  DateTime _currentTime;
  // Lời chào thay đổi theo
  String _greetingTitle;
  // List chứa các danh sách habit
  List<Widget> _habitCardsList;
  // List chứa các type của habits
  List<String> _habitTypesList;
  // List chứa đường dẫn hình ảnh
  List<String> _habitImagePaths;
  // List chứa các title habit
  List<String> _habitTitles;

  @override
  void initState() {
    super.initState();

    _initGreetingTitle();
  }

  @override
  Widget build(BuildContext context) {
    _initGreetingTitle();
    _initHabitCardsList();

    return SafeArea(
      child: WillPopScope(
        // ignore: missing_return
        onWillPop: () async {
          _backToAccountScreen();
        },
        child: Scaffold(
          backgroundColor: Color(0xFFFFE4D4),
          body: Stack(
            children: <Widget>[
              _buildHabitScreenHeader(),
            ],
          ),
        ),
      ),
    );
  }

  // Hàm để chứa code để back về Preference screen
  void _backToAccountScreen() {
    Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.leftToRightWithFade,
            child: PreferenceScreen(
              lastFocusedScreen: widget.lastFocusedScreen,
            ),
            duration: Duration(milliseconds: 300)));
  }

  // Hàm để check xem thời gian hiện tại là bao nhiêu để thay đổi lời chào tương ứng
  void _initGreetingTitle() async {
    _currentTime = DateTime.now();
    setState(() {
      if (_currentTime.hour >= 0 && _currentTime.hour < 12) {
        _greetingTitle = "Good \nMorning";
      } else if (_currentTime.hour >= 12 && _currentTime.hour < 18) {
        _greetingTitle = "Good \nAfternoon";
      } else {
        _greetingTitle = "Good \nEvening";
      }
    });
  }

  // Habit screen header
  Widget _buildHabitScreenHeader() => Container(
        child: Stack(
          children: <Widget>[
            NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    expandedHeight: MediaQuery.of(context).size.height * 0.35,
                    floating: true,
                    pinned: true,
                    backgroundColor: Color(0xFFFAB992),
                    flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Container(
                          transform: Matrix4.translationValues(0.0, 10.0, 0.0),
                          child: Text("Necessary Habits",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 27.0,
                                  fontWeight: FontWeight.w100)),
                        ),
                        background: Stack(
                          children: <Widget>[
                            Image.asset(
                              "images/afternoon.gif",
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              alignment: Alignment.topRight,
                              padding: EdgeInsets.only(top: 10.0, right: 10.0),
                              child: Text(
                                "$_greetingTitle",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 25.0),
                              ),
                            ),
                          ],
                        )),
                  ),
                ];
              },
              body: Container(
                alignment: Alignment.topCenter,
                child: ListView(
                  physics: AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                    // List 1
                    _habitCardsList[0],
                    SizedBox(
                      height: 20.0,
                    ),
                    Align(
                      child: Text(
                        _habitTypesList[0],
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFD34157)),
                      ),
                    ),

                    // List 2
                    _habitCardsList[1],
                    SizedBox(
                      height: 20.0,
                    ),
                    Align(
                      child: Text(
                        _habitTypesList[1],
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFD34157)),
                      ),
                    ),

                    // List 3
                    _habitCardsList[2],
                    SizedBox(
                      height: 20.0,
                    ),
                    Align(
                      child: Text(
                        _habitTypesList[2],
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFD34157)),
                      ),
                    ),

                    // List 4
                    _habitCardsList[3],
                    SizedBox(
                      height: 20.0,
                    ),
                    Align(
                        child: Text(
                      _habitTypesList[3],
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFD34157)),
                    )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 73.0,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Icon(
                  Icons.arrow_back,
                  size: 30.0,
                  color: Colors.black,
                ),
                onPressed: _backToAccountScreen,
              ),
              alignment: Alignment.topLeft,
              margin: EdgeInsets.symmetric(vertical: 9.0),
            ),
          ],
        ),
      );

  // Danh sách các habits
  Widget _habitCards(String imagePath, String imageTitle, int itemsAmount) =>
      Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Swiper(
          onTap: (index) {
            print("Index $index tapped");
          },
          onIndexChanged: (index) {
            print("index: $index");
          },
          index: 0,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xFF425195),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Stack(
                  children: <Widget>[
                    Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 30.0),
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "$imageTitle",
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 30.0, color: Color(0xFFFFE4D4)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: itemsAmount,
          itemWidth: MediaQuery.of(context).size.width * 0.7,
          itemHeight: MediaQuery.of(context).size.height * 0.5,
          layout: SwiperLayout.TINDER,
        ),
      );

  // Hàm để khởi tạo các habit cards list
  void _initHabitCardsList() {
    _habitTypesList = [
      "Health habits",
      "Career habits",
      "Fitness habits",
      "Reduce stress habits"
    ];
    _habitImagePaths = [
      "images/drink_water.png",
      "images/career_habit.png",
      "images/fitness.png",
      "images/reduce_stress.png"
    ];
    _habitTitles = [
      "Drink water",
      "Take a short rest",
      "Do a small Yoga excercise",
      "Relax your body"
    ];
    _habitCardsList = [];

    for (int i = 0; i < _habitImagePaths.length; i++)
      _habitCardsList.add(_habitCards(_habitImagePaths[i], _habitTitles[i], 5));
  }
}
