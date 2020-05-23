import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../presentation/forward_arrow_icon.dart';

class GettingStartedScreen extends StatefulWidget {
  @override
  _GettingStartedScreenState createState() => _GettingStartedScreenState();
}

class _GettingStartedScreenState extends State<GettingStartedScreen> with TickerProviderStateMixin {
  // Các biến để chạy animation cho button
  static double _begin, _end;
  static RelativeRect _relativeBegin, _relativeEnd;
  int _duration;
  Tween<double> _scaleButtonTween;

  AnimationController _controller;
  Animation<Offset> _offset;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _begin = 0.0;
    _end = 1.07;
    _duration = 1000;
    _scaleButtonTween= Tween<double>(begin: _begin, end: _end);

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    _offset = Tween<Offset>(begin: Offset(0.0, 1.5), end: Offset.zero).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _marginBottom = MediaQuery.of(context).size.height * 0.09;

    return Scaffold(
      backgroundColor: Colors.cyanAccent.shade400,
      body: Container(
        child: Stack(
          children: <Widget>[
            SlideTransition(
              position: _offset,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Welcome to DOIT",
                      style: GoogleFonts.roboto(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * (2 / 2.5),
                      child: Text(
                        "Keep on top of everything in your head, whether it's movies to watch or the details of your next big project",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            fontSize: 16.0, color: Colors.brown),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                child: TweenAnimationBuilder(
                  onEnd: _onEnd,
                  tween: _scaleButtonTween,
                  duration: Duration(milliseconds: _duration),
                  builder: (context, scale, child) {
                    return Transform.scale(scale: scale, child: child,);
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: _marginBottom),
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(360)),
                      color: Colors.black,
                    ),
                    alignment: Alignment.bottomCenter,
                    child: Center(
                      child: Icon(
                        ForwardArrow.arrow_forward,
                        size: 25.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Hàm để reset kích thước của widget khi animation trc đó hoàn tất
  void _onEnd() {
    setState(() {
      _begin = 1.07;
      _end = 1.0;
      _duration = 200;

      _scaleButtonTween = Tween<double>(begin: _begin, end: _end);
    });
  }
}
