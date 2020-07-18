import 'package:flutter/material.dart';
import 'package:pimp_my_button/pimp_my_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todoapp/data/main_screen_data.dart';
import 'package:todoapp/presentation/forward_arrow_icon.dart';
import 'package:todoapp/ui/main_screen.dart';

class HowToUseScreen extends StatefulWidget {
  final int lastFocusedScreen;
  HowToUseScreen({this.lastFocusedScreen});

  @override
  _HowToUseScreenState createState() => _HowToUseScreenState();
}

class _HowToUseScreenState extends State<HowToUseScreen> {
  final _controller = PageController(viewportFraction: 0.8);
  double _screenOpacity;

  List<String> _screenImagePaths;
  List<String> _screenNames;

  double _buttonWidth, _buttonHeight;
  static double _beginForButtonAni, _endForButtonAni;
  int _durationForButtonAni;
  Tween<double> _scaleButtonTween;
  double _marginBottom;
  double _buttonBorder;

  bool _isEnd = false; // Biến check xem ng dùng có đang ở page cuối ko

  @override
  void initState() {
    super.initState();
    _initEndButtonFirstState();

    _screenOpacity = 0.0;
    _screenImagePaths = [
      "images/tasks_screen.png",
      "images/log_book_screen.png",
      "images/horizontal_lists_view.png",
      "images/vertical_lists_view.png",
      "images/setting_screen.png",
      "images/add_task_screen.png",
      "images/normal_list_screen.png",
      "images/mother_lists_screen.png",
      "images/child_lists_screen.png",
      "images/preference_setting_screen.png",
      "images/habits_screen.png",
      "images/search_screen.png",
      "images/help_screen.png",
      "images/features_request_screen.png",
      "images/about_screen.png",
      "images/rating_screen.png",
      "images/account_screen.png",
    ];
    _screenNames = [
      "Tasks screen",
      "Log book screen",
      "Lists screen in horizontal view",
      "Lists screen in vertical view",
      "Setting screen",
      "Add task screen",
      "Normal list screen",
      "Achievement mother lists screen",
      "Achivement child lists screen",
      "Preference setting screen",
      "Daily necessary habits screen",
      "Search screen",
      "Help screen",
      "Feature requests screen",
      "About screen",
      "Rating screen",
      "Account screen",
    ];
  }

  @override
  Widget build(BuildContext context) {
    _marginBottom = MediaQuery.of(context).size.height * 0.042;

    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _screenOpacity = 1.0;
      });
    });

    return WillPopScope(
      // ignore: missing_return
      onWillPop: () async {
        _backToMainScreen();
      },
      child: SafeArea(
          child: Scaffold(
        body: AnimatedOpacity(
          opacity: _screenOpacity,
          duration: Duration(milliseconds: 300),
          child: Container(
            color: Color(0xFFFFE4D4),
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 20.0),
                  alignment: Alignment.topCenter,
                  child: Text(
                    "What DOIT have?",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "RobotoSlab",
                    ),
                  ),
                ),
                _buildEndButton(),
                Center(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(height: 16),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.76,
                          child: PageView(
                            onPageChanged: (index) {
                              if (index == _screenNames.length - 1) {
                                setState(() {
                                  _isEnd = true;
                                });
                                _initAnimationForForwardButton();
                              } else if (index == _screenNames.length - 2)
                                _reverseButtonAnimation();

                              if (index < _screenNames.length - 1)
                                setState(() {
                                  _isEnd = false;
                                });
                            },
                            physics: BouncingScrollPhysics(),
                            controller: _controller,
                            children:
                                List.generate(_screenNames.length, (index) {
                              return Column(
                                children: <Widget>[
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.7,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 2.0,
                                            color: Colors.grey,
                                          ),
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        child: Image.asset(
                                          _screenImagePaths[index],
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    _screenNames[index],
                                    maxLines: 3,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: "RobotoSlab",
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: SmoothPageIndicator(
                            controller: _controller,
                            count: 17,
                            effect: JumpingDotEffect(
                              spacing: 8.0,
                              activeDotColor: Color(0xFF425195),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  // End button
  Widget _buildEndButton() => Align(
        alignment: Alignment.bottomCenter,
        child: TweenAnimationBuilder(
          onEnd: _isEnd ? _onEnd : null,
          tween: _scaleButtonTween,
          duration: Duration(milliseconds: _durationForButtonAni),
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              child: child,
            );
          },
          child: PimpedButton(
            particle: Rectangle3DemoParticle(),
            pimpedWidgetBuilder: (context, controller) {
              return GestureDetector(
                onTap: () {
                  controller.forward(from: 0.0);
                  Future.delayed(Duration(milliseconds: 500), () {
                    _backToMainScreen();
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: _durationForButtonAni),
                  margin: EdgeInsets.only(bottom: _marginBottom),
                  width: _buttonWidth,
                  height: _buttonHeight,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(_buttonBorder)),
                    color: Colors.black,
                  ),
                  alignment: Alignment.bottomCenter,
                  child: Center(
                    child: Icon(
                      ForwardArrow.arrow_forward,
                      size: 25.0,
                      color: Colors.white.withOpacity(1.0),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );

  // Hàm để reset kích thước của widget khi animation trc đó hoàn tất
  void _onEnd() {
    setState(() {
      _beginForButtonAni = 1.07;
      _endForButtonAni = 1.0;
      _durationForButtonAni = 200;

      _scaleButtonTween =
          Tween<double>(begin: _beginForButtonAni, end: _endForButtonAni);
    });
  }

  // Hàm để back về main screen
  void _backToMainScreen() {
    MainScreenData data = MainScreenData(
        isBack: true,
        isBackFromAddTaskScreen: false,
        lastFocusedScreen: widget.lastFocusedScreen,
        settingScreenIndex: 3);

    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomeScreen(
              data: data,
            )));
  }

  // Hàm để khởi tạo animation cho Button
  void _initAnimationForForwardButton() {
    _buttonWidth = 55.0;
    _buttonHeight = 55.0;
    _buttonBorder = 360;

    // Animation cho button
    _beginForButtonAni = 0.0;
    _endForButtonAni = 1.07;
    _durationForButtonAni = 500;
    _scaleButtonTween =
        Tween<double>(begin: _beginForButtonAni, end: _endForButtonAni);
  }

  // Hàm để reverse button animation nếu ng dùng back về page trc
  void _reverseButtonAnimation() {
    setState(() {
      _buttonWidth = 55.0;
      _buttonHeight = 55.0;
      _buttonBorder = 360;

      // Animation cho button
      _beginForButtonAni = 1.1;
      _endForButtonAni = 0.0;
      _durationForButtonAni = 500;
      _scaleButtonTween =
          Tween<double>(begin: _beginForButtonAni, end: _endForButtonAni);
    });
  }

  // Hàm init state đầu cho button
  void _initEndButtonFirstState() {
    _buttonWidth = 0.0;
    _buttonHeight = 0.0;
    _beginForButtonAni = 0.0;
    _endForButtonAni = 0.0;
    _scaleButtonTween =
        Tween<double>(begin: _beginForButtonAni, end: _endForButtonAni);
    _buttonBorder = 360;
    _durationForButtonAni = 1000;
  }
}
