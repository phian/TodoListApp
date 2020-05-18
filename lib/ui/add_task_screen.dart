import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/ui/main_screen.dart';

int _lastFocusScreen;

class AddTaskScreen extends StatefulWidget {
  AddTaskScreen([int lastFocusScreen]) {
    _lastFocusScreen = lastFocusScreen;
  }

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: 60,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 11.0, top: 15.0),
                      child: FlatButton(
                        onPressed: _onWillPop,
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Center(
                      child: Text(
                        "Add Task",
                        style: GoogleFonts.roboto(
                          fontSize: 35,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Hàm để detect xem ng dùng có ấn back button ko để đưa ra thông báo
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Alert!'),
        content: new Text('Are you sure you want to cancel adding task?'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => HomeScreen(_lastFocusScreen),
            )),
            child: new Text('Yes'),
          ),
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
        ],
      ),
    )) ?? false;
  }
}
