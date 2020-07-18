import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todoapp/teddy_animation_files/teddy_controller.dart';
import 'package:todoapp/teddy_animation_files/tracking_text_input.dart';
import 'package:todoapp/ui/account_screen.dart';

class SignInOrCreateAccountScreen extends StatefulWidget {
  final int lastFocusedScreen;

  SignInOrCreateAccountScreen({this.lastFocusedScreen});

  @override
  _SignInOrCreateAccountScreenState createState() =>
      _SignInOrCreateAccountScreenState();
}

class _SignInOrCreateAccountScreenState
    extends State<SignInOrCreateAccountScreen> with TickerProviderStateMixin {
  // Các biến dùng cho animation của Button
  double _buttonScale;
  AnimationController _buttonAniController;

  // Teddy animation
  TeddyController _teddyController = TeddyController();

  // Biến để enable hoặc disable user name TextField và password TextField
  bool _isUserNameAndPasswordEnable;
  String _emailAddress, _userName, _password;

  // Các biến cho sign choice
  List<String> _signInChoiceTitles;
  List<String> _iconPath;
  List<Widget> _signInChoiceWidgets;
  List<Color> _signInTitleColors;

  Size _screenSize;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          SystemChrome.setEnabledSystemUIOverlays([]);
        },
      );
    });

    _teddyController = TeddyController();
    _isUserNameAndPasswordEnable = false;

    _signInChoiceTitles = ["Sign in with Google", "Sign in with Facebook"];
    _iconPath = ["images/google_logo.png", "images/facebook_logo.png"];
    _signInChoiceWidgets = [];
    _signInTitleColors = [Colors.black, Colors.black];
    _initSignInChoices();

    _buttonAniController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    _buttonScale = 1 - _buttonAniController.value;
    _screenSize = MediaQuery.of(context).size;

    return WillPopScope(
      // ignore: missing_return
      onWillPop: () async {
        _backToAccountScreen();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFFFE4D4),
        // backgroundColor: Colors.grey,
        body: Stack(
          children: <Widget>[
            _buildTeddyFlare(),
            _buildLoginScreenHeader(),
            _signinAccountForm(),
            _buildAccountSignInChoice(),
            _buildSigninScreenFooter(),
          ],
        ),
      ),
    );
  }

  // Hàm để chứa code để back về Account screen
  void _backToAccountScreen() {
    Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.leftToRightWithFade,
            child: AccountScreen(
              lastFocusedScreen: widget.lastFocusedScreen,
            ),
            duration: Duration(milliseconds: 400)));
  }

  // Close button
  Widget _buildLoginScreenHeader() => Container(
        height: 70.0,
        child: Container(
          child: IconButton(
            icon: Icon(
              Icons.close,
              size: 30.0,
              color: Colors.black,
            ),
            onPressed: _backToAccountScreen,
          ),
          alignment: Alignment.topLeft,
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 11.0),
        ),
      );

  // Sign in form
  Widget _signinAccountForm() => Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: _isUserNameAndPasswordEnable
                  ? MediaQuery.of(context).size.height * 0.102
                  : 0.0,
            ),
            Container(
              height: _isUserNameAndPasswordEnable ? 246 : 82.0,
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TrackingTextInput(
                    label: "Enter email address here",
                    hint: "User name",
                    onCaretMoved: (Offset caret) {
                      // Cập nhật giá trị của toạ độ để khi ng dùng thay đổi focus thì teddy sẽ chạy theo
                      caret = Offset(caret.dx, caret.dy);
                      _teddyController.lookAt(caret);
                    },
                    onTextChanged: (value) {
                      _emailAddress = value;
                      _teddyController.setEmailAddress(value);
                    },
                  ),
                  Divider(
                    height: 0.0,
                    thickness: 0.5,
                    color: _isUserNameAndPasswordEnable
                        ? Colors.grey
                        : Colors.transparent,
                  ),
                  Visibility(
                    visible: _isUserNameAndPasswordEnable,
                    child: TrackingTextInput(
                      label: "Enter first and last name here",
                      hint: "First and last name",
                      onCaretMoved: (Offset caret) {
                        // Cập nhật giá trị của toạ độ để khi ng dùng thay đổi focus thì teddy sẽ chạy theo
                        caret = Offset(caret.dx, caret.dy);
                        _teddyController.lookAt(caret);
                      },
                      onTextChanged: (value) {
                        _userName = value;
                        _teddyController.setUserName(value);
                      },
                    ),
                  ),
                  Divider(
                    height: 0.0,
                    thickness: 0.3,
                    color: _isUserNameAndPasswordEnable
                        ? Colors.grey
                        : Colors.transparent,
                  ),
                  Visibility(
                    visible: _isUserNameAndPasswordEnable,
                    child: TrackingTextInput(
                      label: "Enter password here",
                      hint: "Password",
                      isObscured: true,
                      onCaretMoved: (Offset caret) {
                        _teddyController.coverEyes(caret != null);
                        _teddyController.lookAt(null);
                      },
                      onTextChanged: (String value) {
                        _password = value;
                        _teddyController.setPassword(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            _buildSubmitButton(),
          ],
        ),
      );

  // Submit button
  Widget _buildSubmitButton() => GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: Transform.scale(
          scale: _buttonScale,
          child: Container(
            height: 60.0,
            decoration: BoxDecoration(
                color: Color(0xFFD34157),
                borderRadius: BorderRadius.circular(20.0)),
            width: MediaQuery.of(context).size.width - 45.0,
            child: Center(
              child: Text(
                "Submit",
                style: TextStyle(
                    fontSize: 20.0, fontFamily: 'Roboto', color: Colors.white),
              ),
            ),
          ),
        ),
      );

  // Teddy
  Widget _buildTeddyFlare() => Container(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.057),
        alignment: Alignment.topCenter,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: _isUserNameAndPasswordEnable
              ? _screenSize.width * 0.68
              : _screenSize.width * 0.8,
          height: _isUserNameAndPasswordEnable
              ? _screenSize.height * 0.383
              : _screenSize.height * 0.435,
          child: ClipOval(
            child: CircleAvatar(
              backgroundColor: Color(0xFFF883B8),
              // backgroundColor: Color(0xFF425195),
              child: FlareActor(
                "images/Teddy.flr",
                alignment: Alignment.center,
                fit: BoxFit.fitWidth,
                controller: _teddyController,
              ),
            ),
          ),
        ),
      );

  // Sign in choice
  Widget _buildAccountSignInChoice() => Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.06,
            left: MediaQuery.of(context).size.height * 0.03),
        alignment: Alignment.bottomCenter,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.65,
          height: 100.0,
          child: Column(
            children: <Widget>[
              InkWell(
                child: _signInChoiceWidgets[0],
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  _changeSignInMenuColor(0, false);
                },
                onTapCancel: () {
                  _changeSignInMenuColor(0, false);
                },
                onHighlightChanged: (isChanged) {
                  if (isChanged) _changeSignInMenuColor(0, true);
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              InkWell(
                child: _signInChoiceWidgets[1],
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  _changeSignInMenuColor(1, false);
                },
                onTapCancel: () {
                  _changeSignInMenuColor(1, false);
                },
                onHighlightChanged: (isChanged) {
                  if (isChanged) _changeSignInMenuColor(1, true);
                },
              ),
            ],
          ),
        ),
      );

  // Choice widget
  Widget _signInChoiceWidget(String title, Color titleColor, String icon) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            icon,
            height: 20.0,
            width: 20.0,
          ),
          SizedBox(
            width: 30.0,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 20.0, color: titleColor),
          ),
        ],
      );

  // Hàm khởi tạo các widget cho sign in choice
  void _initSignInChoices() {
    for (int i = 0; i < _signInChoiceTitles.length; i++) {
      _signInChoiceWidgets.add(_signInChoiceWidget(
          _signInChoiceTitles[i], _signInTitleColors[i], _iconPath[i]));
    }
  }

  // Sign in screen footer
  Widget _buildSigninScreenFooter() => Container(
        padding: EdgeInsets.only(bottom: 15.0),
        alignment: Alignment.bottomCenter,
        child: Text(
          "DOIT Account",
          style: TextStyle(
              fontSize: 25.0, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      );

  //-------------------------------Hàm sự kiện của Submit button-----------------------------//
  // Hàm sự kiện hi ng dùng bắt đầu ấn nút
  void _onTapDown(TapDownDetails details) {
    setState(() {
      _buttonAniController.forward();
    });
  }

  // Hàm sự kiện khi ng dùng hoàn thành thao tác ấn nút
  void _onTapUp(TapUpDetails details) {
    _buttonAniController.reverse();

    if (_isUserNameAndPasswordEnable == false) {
      var emailCheck = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

      if (emailCheck.hasMatch(_emailAddress))
        setState(() {
          _isUserNameAndPasswordEnable = true;
        });
    } else if (_isUserNameAndPasswordEnable &&
        _userName.isEmpty == false &&
        _password.isEmpty == false) {
      _teddyController.submitPassword();
    }
  }

  // Hàm để chạy animation theo chiều ngược lại
  void _onTapCancel() {
    _buttonAniController.reverse();
  }
  //-------------------------------------------------------------------------------------//

  //------------------------------------Sin in choice------------------------------------//
  // Hàm bắt sự kiện kkhi ng dùng hoàn thành ấn chọn sign in choice
  void _changeSignInMenuColor(int selectedIndex, bool isFocused) {
    setState(() {
      if (isFocused) {
        _signInTitleColors[selectedIndex] = Colors.grey;
        _signInChoiceWidgets[selectedIndex] = _signInChoiceWidget(
            _signInChoiceTitles[selectedIndex],
            _signInTitleColors[selectedIndex],
            _iconPath[selectedIndex]);
      } else {
        _signInTitleColors[selectedIndex] = Colors.black;
        _signInChoiceWidgets[selectedIndex] = _signInChoiceWidget(
            _signInChoiceTitles[selectedIndex],
            _signInTitleColors[selectedIndex],
            _iconPath[selectedIndex]);
      }
    });
  }

  //-------------------------------------------------------------------------------------//
}
