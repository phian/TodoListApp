import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/ui/getting_started_second_screen.dart';
import '../data/main_screen_data.dart';
import '../presentation/forward_arrow_icon.dart';
import 'main_screen.dart';

class GettingStartedScreen extends StatefulWidget {
  final int lastFocusedScreen;

  GettingStartedScreen({this.lastFocusedScreen});

  @override
  _GettingStartedScreenState createState() => _GettingStartedScreenState();
}

class _GettingStartedScreenState extends State<GettingStartedScreen>
    with TickerProviderStateMixin {
  // Các biến để chạy animation cho button
  double _buttonWidth, _buttonHeight, _resetMarginBottom;
  static double _beginForButtonAni, _endForButtonAni;
  int _durationForButtonAni;
  Tween<double> _scaleButtonTween;
  double _buttonBorder, _buttonOpacity;

  AnimationController _controllerForFirstText, _controllerForSecondText;
  Animation<double> _animationForFirstText, _animationForSecondText;
  int _durationForFirstText, _durationForSecondText;

  static double _beginForFirstText, _endForFirstText;
  static double _beginForSecondText, _endForSecondText;

  double _screenOpacity;

  @override
  void initState() {
    super.initState();

    _initAnimationForForwardButton();
    _initAnimationForFirstText();
    _initAnimationForSecondText();

    _screenOpacity = 0.0;
  }

  @override
  void dispose() {
    super.dispose();

    _controllerForFirstText.dispose();
    _controllerForSecondText.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _marginBottom = MediaQuery.of(context).size.height * 0.09;

    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _screenOpacity = 1.0;
      });
    });

    return AnimatedOpacity(
      opacity: _screenOpacity,
      duration: Duration(milliseconds: 200),
      child: SafeArea(
        child: WillPopScope(
          // ignore: missing_return
          onWillPop: () async {
            _backToMainScreen();
          },
          child: Scaffold(
            backgroundColor: Colors.cyanAccent.shade400,
            body: Container(
              child: Stack(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.7),
                        child: Transform.translate(
                          offset: Offset(0.0, _animationForFirstText.value),
                          child: Text(
                            "Welcome to DOIT",
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.7),
                        child: Transform.translate(
                          offset: Offset(0.0, _animationForSecondText.value),
                          child: Container(
                            width:
                                MediaQuery.of(context).size.width * (2 / 2.5),
                            child: Text(
                              "Keep on top of everything in your head, whether it's movies to watch or the details of your next big project",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 16.0,
                                  color: Colors.brown),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TweenAnimationBuilder(
                      onEnd: _onEnd,
                      tween: _scaleButtonTween,
                      duration: Duration(milliseconds: _durationForButtonAni),
                      builder: (context, scale, child) {
                        return Transform.scale(
                          scale: scale,
                          child: child,
                        );
                      },
                      child: GestureDetector(
                        onTapDown: _onTapDown,
                        child: AnimatedContainer(
                          onEnd: _onEndForTransitionScreenEvent,
                          duration:
                              Duration(milliseconds: _durationForButtonAni),
                          margin: EdgeInsets.only(
                              bottom: _resetMarginBottom == -1
                                  ? _marginBottom
                                  : _resetMarginBottom),
                          width: _buttonWidth,
                          height: _buttonHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(_buttonBorder)),
                            color: Colors.black,
                          ),
                          alignment: Alignment.bottomCenter,
                          child: Center(
                            child: Icon(
                              ForwardArrow.arrow_forward,
                              size: 25.0,
                              color: Colors.white.withOpacity(_buttonOpacity),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

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

  // Hàm để chuyển screen khi animation của button đã xong
  void _onEndForTransitionScreenEvent() {
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        // Here you can write your code for open new view
        Navigator.of(context).pushReplacement(PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              GettingStartedSecondScreen(
            lastFocusedScreen: widget.lastFocusedScreen,
          ),
        ));
      });
    });
  }

  // Hàm để khởi tạo animtion cho dòng text 1
  void _initAnimationForFirstText() {
    // Animation cho dòng chữ 1
    _durationForFirstText = 1000;
    _controllerForFirstText = AnimationController(
        vsync: this, duration: Duration(milliseconds: _durationForFirstText));

    _beginForFirstText = 300.0;
    _endForFirstText = -10.0;
    _animationForFirstText =
        Tween<double>(begin: _beginForFirstText, end: _endForFirstText)
            .animate(_controllerForFirstText)
              ..addListener(() {
                setState(() {});
              })
              ..addStatusListener((AnimationStatus status) {
                if (status == AnimationStatus.completed) {
                  _beginForFirstText = -10.0;
                  _endForFirstText = 0.0;
                  _durationForFirstText = 200;

                  _controllerForFirstText = AnimationController(
                      vsync: this,
                      duration: Duration(milliseconds: _durationForFirstText));

                  _animationForFirstText = Tween<double>(
                          begin: _beginForFirstText, end: _endForFirstText)
                      .animate(_controllerForFirstText)
                        ..addListener(() {
                          setState(() {});
                        });

                  _controllerForFirstText.forward();
                }
              });

    _controllerForFirstText.forward();
  }

  // Hàm để khởi tạo animtion cho dòng text 2
  void _initAnimationForSecondText() {
    // Animation cho dòng chữ 2
    _durationForSecondText = 1000;
    _controllerForSecondText = AnimationController(
        vsync: this, duration: Duration(milliseconds: _durationForSecondText));

    _beginForSecondText = 300.0;
    _endForSecondText = -10.0;
    _animationForSecondText =
        Tween<double>(begin: _beginForSecondText, end: _endForSecondText)
            .animate(_controllerForSecondText)
              ..addListener(() {
                setState(() {});
              })
              ..addStatusListener((AnimationStatus status) {
                if (status == AnimationStatus.completed) {
                  _beginForSecondText = -10.0;
                  _endForSecondText = 0.0;
                  _durationForSecondText = 300;

                  _controllerForSecondText = AnimationController(
                      vsync: this,
                      duration: Duration(milliseconds: _durationForSecondText));

                  _animationForSecondText = Tween<double>(
                          begin: _beginForSecondText, end: _endForSecondText)
                      .animate(_controllerForSecondText)
                        ..addListener(() {
                          setState(() {});
                        });

                  _controllerForSecondText.forward();
                }
              });

    _controllerForSecondText.forward();
  }

  // Hàm để khởi tạo animation cho Button
  void _initAnimationForForwardButton() {
    _buttonWidth = 60.0;
    _buttonHeight = 60.0;
    _resetMarginBottom = -1;
    _buttonBorder = 360;
    _buttonOpacity = 1.0;

    // Animation cho button
    _beginForButtonAni = 0.0;
    _endForButtonAni = 1.07;
    _durationForButtonAni = 1000;
    _scaleButtonTween =
        Tween<double>(begin: _beginForButtonAni, end: _endForButtonAni);
  }

  // Hàm để bắt sự kiện khi người dùng ấn vào nút forward
  void _onTapDown(TapDownDetails details) {
    setState(() {
      _buttonWidth = MediaQuery.of(context).size.width;
      _buttonHeight = MediaQuery.of(context).size.height;
      _durationForButtonAni = 250;

      _resetMarginBottom = 0.0;
      _buttonBorder = 0.0;
      _buttonOpacity = 0.0;
    });
  }

  // Hàm để chuyển trang
  Future<Widget> buildPageAsync() async {
    return Future.microtask(() {
      MainScreenData data =
          MainScreenData(isBack: true, lastFocusedScreen: widget.lastFocusedScreen);
      return HomeScreen(
        data: data,
      );
    });
  }
}
