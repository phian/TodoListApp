import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todoapp/ui/habit_schedule_setting_screen.dart';
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
  // Lời chào thay đổi theo thời gian trong ngày
  String _greetingTitle;
  // List chứa các danh sách habit
  List<Widget> _habitCardsList;
  // List chứa các type của habits
  List<String> _habitTypesList;
  // List chứa đường dẫn hình ảnh
  List<String> _healthHabitImagePaths,
      _careerHabitImagePaths,
      _fitnessHabitImagesPaths,
      _reduceStressImagePaths;
  // List chứa các title habit
  List<String> _healthHabitTitles,
      _careerHabitsTitles,
      _fitnessHabitTitles,
      _reduceStressHabitTitles;

  // Các list để gom toàn bộ các đường dẫn và title để add
  List<List<String>> _allHabitImagePaths;
  List<List<String>> _allHabitTitles;
  List<int> _allHabitItemAmount;

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
                                  color: () {
                                    if (_currentTime.hour >= 0 &&
                                        _currentTime.hour < 12) {
                                      return Colors.black;
                                    } else if (_currentTime.hour >= 12 &&
                                        _currentTime.hour < 18) {
                                      return Colors.black;
                                    } else {
                                      return Colors.white;
                                    }
                                  }(),
                                  fontSize: 27.0,
                                  fontWeight: FontWeight.w100)),
                        ),
                        background: Stack(
                          children: <Widget>[
                            Image.asset(
                              () {
                                if (_currentTime.hour >= 0 &&
                                    _currentTime.hour < 12) {
                                  return "images/morning.gif";
                                } else if (_currentTime.hour >= 12 &&
                                    _currentTime.hour < 18) {
                                  return "images/afternoon.gif";
                                } else {
                                  return "images/night.gif";
                                }
                              }(),
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              alignment: Alignment.topRight,
                              padding: EdgeInsets.only(top: 10.0, right: 10.0),
                              child: Text(
                                "$_greetingTitle",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25.0,
                                  color: () {
                                    if (_currentTime.hour >= 0 &&
                                        _currentTime.hour < 12) {
                                      return Colors.black;
                                    } else if (_currentTime.hour >= 12 &&
                                        _currentTime.hour < 18) {
                                      return Colors.black;
                                    } else {
                                      return Colors.white;
                                    }
                                  }(),
                                ),
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
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 70.0,
                height: 70.0,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    size: 30.0,
                    color: () {
                      if (_currentTime.hour >= 0 && _currentTime.hour < 12) {
                        return Colors.black;
                      } else if (_currentTime.hour >= 12 &&
                          _currentTime.hour < 18) {
                        return Colors.black;
                      } else {
                        return Colors.white;
                      }
                    }(),
                  ),
                  onPressed: _backToAccountScreen,
                ),
              ),
            ),
          ],
        ),
      );

  // Danh sách các habits
  Widget _habitCards(List<String> imagePaths, List<String> imageTitles,
          int itemsAmount, int tag) =>
      Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Swiper(
          index: 0,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return HabitScheduleSettingScreen(
                    imageHabitType: () {
                      int typeIndex;

                      for (int i = 0; i < _allHabitTitles.length; i++) {
                        for (int j = 0; j < _allHabitTitles[i].length; j++) {
                          if (imageTitles[index] == _allHabitTitles[i][j]) {
                            typeIndex = i;
                            break;
                          }
                        }
                        if (typeIndex != null) break;
                      }

                      return _habitTypesList[typeIndex];
                    }(),
                    imagePath: imagePaths[index],
                    imageTag: () {
                      return tag + index;
                    }(),
                    imageTitle: imageTitles[index],
                  );
                }));
              },
              child: Hero(
                tag: () {
                  return index + tag;
                }(),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFF425195),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topCenter,
                        child: Image.asset(
                          imagePaths[index],
                          fit: BoxFit.contain,
                          height:
                              (MediaQuery.of(context).size.height * 0.5) / 1.4,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 30.0),
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          imageTitles[index],
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Color(0xFFFFE4D4),
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
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
    // Images path
    _healthHabitImagePaths = [
      "images/drink_water.png",
      "images/washing_hands.png",
      "images/have_a_snack.png",
      "images/healthy_drink.png",
      "images/smile_face.png",
      "images/give_up_bad_habits.png",
    ];
    _careerHabitImagePaths = [
      "images/take_a_short_rest.png",
      "images/leave_work.png",
      "images/neck_rotate.png",
      "images/relax_hands.png",
      "images/summary_job.png",
      "images/remember_your_goals.png",
    ];
    _fitnessHabitImagesPaths = [
      "images/fitness.png",
      "images/have_a_walk.png",
      "images/sport.png",
      "images/physic_excercise.png",
      "images/eat_vegetable.png",
      "images/go_pushups.png",
    ];
    _reduceStressImagePaths = [
      "images/relax_body.png",
      "images/listen_to_music.png",
      "images/talk_to_a_friend.png",
      "images/do_your_hobbies.png",
      "images/meditation.png",
      "images/deep_breath.png"
    ];
    _allHabitImagePaths = [];
    _allHabitImagePaths.add(_healthHabitImagePaths);
    _allHabitImagePaths.add(_careerHabitImagePaths);
    _allHabitImagePaths.add(_fitnessHabitImagesPaths);
    _allHabitImagePaths.add(_reduceStressImagePaths);

    // Habit titles
    _healthHabitTitles = [
      "Drink Water",
      "Washing Hands",
      "Have A Snack",
      "Have A Healthy Drink",
      "Let's Smile",
      "Give Up Bad Habits",
    ];
    _careerHabitsTitles = [
      "Take A Short Rest",
      "Leave Work For A While",
      "Rotate Your Neck",
      "Relax Your Hands",
      "Summary Your Jobs",
      "Remember Your Goals",
    ];
    _fitnessHabitTitles = [
      "Do A Small Yoga Excercise",
      "Have A Walk",
      "Play Sports",
      "Do Physic Excercises",
      "Eat Some Vegetables",
      "Go Pushups",
    ];
    _reduceStressHabitTitles = [
      "Relax Your Body",
      "Listen To A Song",
      "Talk To Someone",
      "Do Your Hobbies",
      "Meditation",
      "Have A Deep Breath",
    ];
    _allHabitTitles = [];
    _allHabitTitles.add(_healthHabitTitles);
    _allHabitTitles.add(_careerHabitsTitles);
    _allHabitTitles.add(_fitnessHabitTitles);
    _allHabitTitles.add(_reduceStressHabitTitles);

    // All habit items amount
    _allHabitItemAmount = [6, 6, 6, 6];

    _habitCardsList = [];

    // Biến để để add tag cho các item của habit list
    int increaseTag = 0;
    for (int i = 0; i < _allHabitImagePaths.length; i++) {
      _habitCardsList.add(_habitCards(_allHabitImagePaths[i],
          _allHabitTitles[i], _allHabitItemAmount[i], increaseTag));
      increaseTag += 6;
    }
  }
}
