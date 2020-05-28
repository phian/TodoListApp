import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/presentation/forward_arrow_icon.dart';
import 'package:todoapp/ui/getting_started_screen.dart';

class GettingStartedSecondScreen extends StatefulWidget {
  final int lastFocusedScreen;

  GettingStartedSecondScreen({this.lastFocusedScreen});

  @override
  _GettingStartedSecondScreenState createState() =>
      _GettingStartedSecondScreenState();
}

class _GettingStartedSecondScreenState extends State<GettingStartedSecondScreen>
    with TickerProviderStateMixin {
  List<String> _cardTitles = [
    "Buy a new suitcase",
    "Book a hotel in Paris",
    "Ask Jordan about rental cars"
  ];
  List<String> _cardDeadlines = [
    "December 25, 8:00-9:00",
    "December 25, 11:00-11:30",
    "December 25, 14:00-15:00"
  ];
  List<String> _cardNotes = [
    "Buy to where in mom's birthday",
    "To live in holiday trip",
    "To pay rent money"
  ];
  List<Widget> _cardList = [];

  // Các biến để chạy animation cho button
  double _buttonWidth, _buttonHeight, _resetMarginBottom;
  static double _beginForButtonAni, _endForButtonAni;
  int _durationForButtonAni;
  Tween<double> _scaleButtonTween;
  double _buttonBorder, _buttonOpacity;

  // Các biến cần cho animation của 2 dòng text
  AnimationController _controllerForFirstText, _controllerForSecondText;
  Animation<double> _animationForFirstText, _animationForSecondText;
  int _durationForFirstText, _durationForSecondText;

  static double _beginForFirstText, _endForFirstText;
  static double _beginForSecondText, _endForSecondText;

  // Các biến dùng cho animation của column
  AnimationController _controllerForCardColumn;
  Animation<double> _animationForCardColumn;
  int _durationForCardColumn;
  static double _beginForCardColumn, _endForCardColumn;
  double _cardOpacity;

  // Các biến cho animation của 2 card thu nhỏ
  static double _beginForCardAni, _endForCardAni;
  int _durationForCardAni;
  Tween<double> _scaleCaredTween;
  static double _beginForCardAni1, _endForCardAni1;
  int _durationForCardAni1;
  Tween<double> _scaleCaredTween1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _initAnimationForCardColumn();
    _initFirstAnimationStateForCard();
    _initAnimationForForwardButton();
    _initAnimationForFirstText();
    _initAnimationForSecondText();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _controllerForCardColumn.dispose();
    _controllerForFirstText.dispose();
    _controllerForSecondText.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _initCards();
    final _marginBottom = MediaQuery.of(context).size.height * 0.09;

    return SafeArea(
      child: WillPopScope(
        // ignore: missing_return
        onWillPop: () async {
          Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                GettingStartedScreen(
              lastFocusedScreen: widget.lastFocusedScreen,
            ),
          ));
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Container(
            child: Stack(children: <Widget>[
              Align(
                alignment: AlignmentDirectional(0.0, 0.7),
                child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 7),
                  child: Transform.translate(
                    offset: Offset(0.0, _animationForCardColumn.value),
                    child: Column(
                      children: <Widget>[
                        TweenAnimationBuilder(
                          onEnd: () {
                            _updateCardsOpacity(0);
                          },
                          tween: _scaleCaredTween,
                          duration: Duration(milliseconds: _durationForCardAni),
                          builder: (context, scale, child) {
                            return Transform.scale(
                              scale: scale,
                              child: child,
                            );
                          },
                          child: _cardList[0],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        _cardList[1],
                        SizedBox(
                          height: 5.0,
                        ),
                        TweenAnimationBuilder(
                          onEnd: () {
                            _updateCardsOpacity(2);
                          },
                          duration:
                              Duration(milliseconds: _durationForCardAni1),
                          tween: _scaleCaredTween1,
                          builder: (context, scale, child) {
                            return Transform.scale(
                              scale: scale,
                              child: child,
                            );
                          },
                          child: _cardList[2],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.7),
                    child: Transform.translate(
                      offset: Offset(0.0, _animationForFirstText.value),
                      child: Text(
                        "DOIT Cards",
                        style: GoogleFonts.roboto(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
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
                        width: MediaQuery.of(context).size.width * (2 / 2.5),
                        child: Text(
                          "Remember things you want to do by creating a DOIT Card. You can add notes and reminders",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                              fontSize: 16.0, color: Colors.white),
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
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: _durationForButtonAni),
                      margin: EdgeInsets.only(bottom: _marginBottom),
                      width: _buttonWidth,
                      height: _buttonHeight,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(_buttonBorder)),
                        color: Colors.grey,
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
            ]),
          ),
        ),
      ),
    );
  }

  // Widget hiển thị card
  Widget _todoCard(
      String cardTitle, String cardDeadline, String cardNote, double opacity) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 300),
      opacity: opacity,
      child: Container(
        child: Stack(children: <Widget>[
          Container(
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 7,
                right: MediaQuery.of(context).size.width / 7),
            child: Stack(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Container(
                        width: 150,
                        child: Text(
                          "$cardTitle",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textDirection: TextDirection.ltr,
                          style: GoogleFonts.aclonica(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Container(
                        width: 150,
                        child: Text(
                          "$cardDeadline",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textDirection: TextDirection.ltr,
                          style: GoogleFonts.aclonica(
                              fontSize: 10.0, color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Container(
                        width: 150,
                        child: Text(
                          "$cardNote",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textDirection: TextDirection.ltr,
                          style: GoogleFonts.aclonica(
                              fontSize: 10.0, color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.only(right: MediaQuery.of(context).size.width / 30),
                    child: Icon(
                      Icons.more_horiz,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            height: 100,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
          ),
        ]),
      ),
    );
  }

  // Hàm để khởi tạo card widgets
  void _initCards() {
    for (int i = 0; i < 3; i++) {
      _cardList.add(
          _todoCard(_cardTitles[i], _cardDeadlines[i], _cardNotes[i], 1.0));
    }
  }

  // Hàm để khởi tạo animtion cho dòng text 1
  void _initAnimationForFirstText() {
    // Animation cho dòng chữ 1
    _durationForFirstText = 700;
    _controllerForFirstText = AnimationController(
        vsync: this, duration: Duration(milliseconds: _durationForFirstText));

    _beginForFirstText = 300.0;
    _endForFirstText = 150.0;
    _animationForFirstText =
        Tween<double>(begin: _beginForFirstText, end: _endForFirstText)
            .animate(_controllerForFirstText)
              ..addListener(() {
                setState(() {});
              })
              ..addStatusListener((AnimationStatus status) {
                if (status == AnimationStatus.completed) {
                  _beginForFirstText = 150.0;
                  _endForFirstText = 160.0;
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
    _durationForSecondText = 800;
    _controllerForSecondText = AnimationController(
        vsync: this, duration: Duration(milliseconds: _durationForSecondText));

    _beginForSecondText = 300.0;
    _endForSecondText = 150.0;
    _animationForSecondText =
        Tween<double>(begin: _beginForSecondText, end: _endForSecondText)
            .animate(_controllerForSecondText)
              ..addListener(() {
                setState(() {});
              })
              ..addStatusListener((AnimationStatus status) {
                if (status == AnimationStatus.completed) {
                  _beginForSecondText = 150.0;
                  _endForSecondText = 160.0;
                  _durationForSecondText = 200;

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

  // Hàm để khởi tạo animation cho card column
  void _initAnimationForCardColumn() {
    // Animation cho dòng chữ 1
    _durationForCardColumn = 700;
    _controllerForCardColumn = AnimationController(
        vsync: this, duration: Duration(milliseconds: _durationForCardColumn));

    _cardOpacity = 1.0;

    _beginForCardColumn = 300.0;
    _endForCardColumn = -20.0;
    _animationForCardColumn =
        Tween<double>(begin: _beginForCardColumn, end: _endForCardColumn)
            .animate(_controllerForCardColumn)
              ..addListener(() {
                setState(() {});
              })
              ..addStatusListener((AnimationStatus status) {
                if (status == AnimationStatus.completed) {
                  _beginForCardColumn = -20.0;
                  _endForCardColumn = 0.0;
                  _durationForCardColumn = 200;

                  _controllerForCardColumn = AnimationController(
                      vsync: this,
                      duration: Duration(milliseconds: _durationForCardColumn));

                  _animationForCardColumn = Tween<double>(
                          begin: _beginForCardColumn, end: _endForCardColumn)
                      .animate(_controllerForCardColumn)
                        ..addListener(() {
                          setState(() {});
                        });

                  _controllerForCardColumn.forward();

                  Future.delayed(Duration(milliseconds: 500), () {
                    _initAnimationForCards();
                  });
                }
              });

    _controllerForCardColumn.forward();
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

  // Hàm để khởi tạo state sơ khai cho 2 card sẽ thu nhỏ
  void _initFirstAnimationStateForCard() {
    // Animation cho card thứ 1
    _beginForCardAni = 1.0;
    _endForCardAni = 1.0;
    _durationForCardAni = 0;
    _scaleCaredTween =
        Tween<double>(begin: _beginForCardAni, end: _endForCardAni);

    // Animation cho card thứ 2
    _beginForCardAni1 = 1.0;
    _endForCardAni1 = 1.0;
    _durationForCardAni1 = 0;
    _scaleCaredTween1 =
        Tween<double>(begin: _beginForCardAni1, end: _endForCardAni1);
  }

  // Hàm để khởi tạo animation khi animation của column đã hoàn tất
  void _initAnimationForCards() {
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        // Animation cho button
        _beginForCardAni = 1.0;
        _endForCardAni = 0.92;
        _durationForCardAni = 1000;
        _scaleCaredTween =
            Tween<double>(begin: _beginForCardAni, end: _endForCardAni);

        // Animation cho button
        _beginForCardAni1 = 1.0;
        _endForCardAni1 = 0.92;
        _durationForCardAni1 = 1000;
        _scaleCaredTween1 =
            Tween<double>(begin: _beginForCardAni1, end: _endForCardAni1);
      });
    });
  }

  // Hàm đê thay đổi độ mờ của 2 card thu nhỏ hơn
  void _updateCardsOpacity(int changeIndex) {
    setState(() {
      _cardList[changeIndex] = _todoCard(_cardTitles[changeIndex],
          _cardDeadlines[changeIndex], _cardNotes[changeIndex], 0.5);
    });
  }
}
