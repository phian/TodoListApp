import 'dart:io';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todoapp/animation/flare_controller.dart';
import 'package:todoapp/animation/rating_background_color.dart';
import 'package:todoapp/slider_widgets/rating_slider_painter.dart';
import 'package:todoapp/slider_widgets/rating_title.dart';
import 'package:todoapp/ui/about_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart' as vector;

enum SlideState { VeryBad, Bad, Good, VeryGood, Perfect }

class RatingScreen extends StatefulWidget {
  final int lastFocusedScreen;

  RatingScreen({this.lastFocusedScreen});

  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen>
    with TickerProviderStateMixin {
  // Các biến cho animation của Flare
  FlareRateController _flareController;
  double _sliderWidth = 340.0;
  double _sliderHeight = 50.0;

  double _dragPercent = 0.0;

  SlideState _slideState;
  AnimationController _ratingAnimatonController;

  // Các biến dùng cho animation của Button
  double _buttonScale;
  AnimationController _buttonAniController;

  double _transitionForRatingScreen = 0.0;

  @override
  void initState() {
    super.initState();

    _flareController = FlareRateController();
    _slideState = SlideState.VeryBad;
    // SystemChrome.setEnabledSystemUIOverlays([]);

    _ratingAnimatonController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 750))
          ..addListener(() => setState(() {}));

    _buttonAniController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();

    _buttonAniController.dispose();
    _ratingAnimatonController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _buttonScale = 1 - _buttonAniController.value;

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          _backToAboutScreen();
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          transform:
              Matrix4.translationValues(0.0, _transitionForRatingScreen, 0.0),
          child: Scaffold(
            backgroundColor: ratingBackgroundTween
                .evaluate(AlwaysStoppedAnimation(_dragPercent)),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildRatingScreenTitle(),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  transform: Matrix4.translationValues(0.0, 50.0, 0.0),
                  child: _ratingEmotionTitle(),
                ),
                Container(
                  child: _buildFlareActor(),
                ),
                Container(
                  child: _buildSlider(),
                  transform: Matrix4.translationValues(0.0, -60.0, .0),
                ),
                _buildBottomWidgets(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget để hiển thị title của màn hình
  Widget _buildRatingScreenTitle() => Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                transform: Matrix4.translationValues(15.0, 5.0, 0.0),
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Container(
                    transform: Matrix4.translationValues(-2.0, -1.0, 0.0),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.close,
                      size: 35.0,
                    ),
                  ),
                  onPressed: _backToAboutScreen,
                ),
              ),
            ],
          ),
          Container(
            transform: Matrix4.translationValues(0.0, 5.0, 0.0),
            child: Text(
              "How do you feel about DOIT?",
              style: TextStyle(
                fontSize: 45.0,
                fontWeight: FontWeight.w900,
                fontFamily: "RobotoSlab",
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );

  // Hàm khởi tạo slider cho flare
  Widget _buildSlider() => GestureDetector(
        onHorizontalDragStart: (DragStartDetails details) =>
            _onDragStart(context, details),
        onHorizontalDragUpdate: (DragUpdateDetails details) =>
            _onDragUpdate(context, details),
        child: Container(
          width: _sliderWidth,
          height: _sliderHeight,
          child: CustomPaint(
            painter: RatingSliderPainter(progress: _dragPercent),
          ),
        ),
      );

  // Hàm khởi tạo Flare Actor
  Widget _buildFlareActor() => Transform(
        transform: Matrix4.translation(_shake()),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.5,
          child: FlareActor(
            'images/rating.flr',
            artboard: "Artboard",
            controller: _flareController,
          ),
        ),
      );

  // Widget hiển thị text mô tả trạng thái rating
  Widget _displayEmotionRatingTitle() {
    switch (_slideState) {
      case SlideState.VeryBad:
        return currText[0];
        break;
      case SlideState.Bad:
        return currText[1];
        break;
      case SlideState.Good:
        return currText[2];
        break;
      case SlideState.VeryGood:
        return currText[3];
        break;
      default:
        return currText[4];
        break;
    }
  }

  // Hàm để tạo animation cho chữ mô tả trạng thái rating
  Widget _ratingEmotionTitle() => AnimatedSwitcher(
        child: _displayEmotionRatingTitle(),
        duration: Duration(milliseconds: 200),
        transitionBuilder: (child, textAnimation) {
          var textSlideAnimation =
              Tween<Offset>(begin: Offset(0.0, -1.5), end: Offset(0.0, 0.0))
                  .animate(textAnimation);

          return ClipRect(
            child: SlideTransition(
              position: textSlideAnimation,
              child: child,
            ),
          );
        },
      );

  // Nút submit
  Widget _buildBottomWidgets() => Container(
        transform: Matrix4.translationValues(0.0, -15.0, 0.0),
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          onTapCancel: _onTapCancel,
          child: Transform.scale(
            scale: _buttonScale,
            child: Container(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "This is how I feel",
                style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: "RobotoSlab",
                ),
              ),
              decoration: BoxDecoration(
                  color: Color(0xFF425195),
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
            ),
          ),
        ),
      );

  // Hàm bắt sự kiện khi người dùng kéo thanh slider
  void _onDragStart(BuildContext context, DragStartDetails details) {
    RenderBox renderBox = context.findRenderObject();
    Offset localOffset = renderBox.localToGlobal(details.globalPosition);

    _updateDragPosition(localOffset);
  }

  // Hàm bắt sự kiện và update cho slider khi người dùng kéo thanh slider
  void _onDragUpdate(BuildContext context, DragUpdateDetails details) {
    RenderBox renderBox = context.findRenderObject();
    Offset localOffset = renderBox.localToGlobal(details.globalPosition);

    _updateDragPosition(localOffset);
  }

  // Hàm để update vị trí khi người dùng kéo thanh slider
  void _updateDragPosition(Offset offset) {
    setState(() {
      _dragPercent = (offset.dx / _sliderWidth).clamp(0.0, 1.0);
      _flareController.updateSlidePercent(_dragPercent);

      _updateRatingText();
    });
  }

  // Hàm để update rating text
  void _updateRatingText() {
    setState(() {
      if (_dragPercent >= 0 && _dragPercent < .2) {
        _slideState = SlideState.VeryBad;

        _ratingAnimatonController.forward(from: 0.0);
      } else if (_dragPercent >= .2 && _dragPercent < .4) {
        _slideState = SlideState.Bad;
      } else if (_dragPercent >= .4 && _dragPercent < .6) {
        _slideState = SlideState.Good;
      } else if (_dragPercent >= .6 && _dragPercent < .8) {
        _slideState = SlideState.VeryGood;

        _ratingAnimatonController.stop();
      } else if (_dragPercent >= .8) {
        _slideState = SlideState.Perfect;
      }
    });
  }

  // Hàm tạo hiệu ứng rung cho face khi người dùng rate thấp
  _shake() {
    double offset = math.sin(_ratingAnimatonController.value * math.pi * 60.0);
    return vector.Vector3(offset * 2, offset * 2, 0.0);
  }

  // Hàm để chạy animation của button theo chiều thuận
  void _onTapDown(TapDownDetails details) {
    _buttonAniController.forward();
  }

  // Hàm để chạy animation theo chiều ngược lại
  void _onTapUp(TapUpDetails details) {
    _buttonAniController.reverse();

    showDialog(
        context: context,
        builder: (_) => AssetGiffyDialog(
              image: Image.asset(
                "images/thank_you.gif",
                fit: BoxFit.fitHeight,
              ),
              title: Text(
                "Thank you for your rating!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w100,
                    fontFamily: "RobotoSlab"),
              ),
              entryAnimation: EntryAnimation.BOTTOM,
              buttonOkText: Text(
                "OK",
                style: TextStyle(color: Colors.white, fontFamily: "RobotoSlab"),
              ),
              buttonOkColor: Color(0xFF425195),
              onOkButtonPressed: () {
                setState(() {
                  _transitionForRatingScreen =
                      MediaQuery.of(context).size.height;

                  _checkSlideStateAndSendToEmail();
                });

                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.upToDown,
                        child: AboutScreen(
                          lastFocusedScreen: widget.lastFocusedScreen,
                        ),
                        duration: Duration(milliseconds: 300)));
              },
              onCancelButtonPressed: () {
                Navigator.of(context).pop(false);
              },
              buttonCancelColor: Colors.red,
              buttonCancelText: Text(
                "Rate again",
                style: TextStyle(color: Colors.white, fontFamily: "RobotoSlab"),
              ),
              cornerRadius: 30.0,
            ));
  }

  // Hàm để chạy animation theo chiều ngược lại
  void _onTapCancel() {
    _buttonAniController.reverse();
  }

  // Hàm để gọi lệnh back về About screen
  void _backToAboutScreen() {
    setState(() {
      _transitionForRatingScreen = MediaQuery.of(context).size.height;
    });

    Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.upToDown,
            child: AboutScreen(
              lastFocusedScreen: widget.lastFocusedScreen,
            ),
            duration: Duration(milliseconds: 300)));
  }

  // Hàm để mở email trong máy của ng dùng và chuyển phần rating vào đó
  _launchURL(String toMailAddress, String subject, String body) async {
    var url = 'mailto:$toMailAddress?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Hàm để check xem trạng thái rating là gì và gọi hàm tương ứng
  void _checkSlideStateAndSendToEmail() {
    String address = "phiannguyen1806@gmail.com",
        address1 = "",
        subject = "[Rating for DOIT]",
        body = "Your app is ";

    switch (_slideState) {
      case SlideState.VeryBad:
        body += "very bad 😠";
        break;
      case SlideState.Bad:
        body += "bad 😔";
        break;
      case SlideState.Good:
        body += "good 😉";
        break;
      case SlideState.VeryGood:
        body += "very good 😜";
        break;
      case SlideState.Perfect:
        body += "very perfect ❤";
        break;
    }

    _launchURL("$address", "$subject", "$body");
    _launchURL("$address1", "$subject", "$body");
  }
}
