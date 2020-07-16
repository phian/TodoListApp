import 'package:flutter/material.dart';
import 'package:todoapp/set_up_widgets/habit_set_up_sheet.dart';

class HabitScheduleSettingScreen extends StatefulWidget {
  final int imageTag;
  final String imagePath;
  final String imageTitle;
  final String imageHabitType;

  HabitScheduleSettingScreen({
    this.imageTag,
    this.imagePath,
    this.imageTitle,
    this.imageHabitType,
  });

  @override
  _HabitScheduleSettingScreenState createState() =>
      _HabitScheduleSettingScreenState();
}

class _HabitScheduleSettingScreenState
    extends State<HabitScheduleSettingScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 300), () {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _showHabitSetUpSheet(context),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        // ignore: missing_return
        onWillPop: () async {
          Navigator.pop(context);
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: <Widget>[
              _buildHabitImage(),
              _buildImageHabitType(),
            ],
          ),
        ),
      ),
    );
  }

  // Habit image
  Widget _buildHabitImage() => Hero(
        tag: widget.imageTag,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color(0xFF425195),
          child: Container(
            alignment: Alignment.center,
            child: Image.asset(
              widget.imagePath,
              fit: BoxFit.cover,
            ),
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.5,
          ),
        ),
      );

  // Image habit type
  Widget _buildImageHabitType() => Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 20.0),
        child: Text(
          widget.imageHabitType,
          style: TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none,
            color: Color(0xFFFAB992),
          ),
        ),
      );

  // Hàm để show botton sheet hiển thị các tuỳ chọn set up
  void _showHabitSetUpSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.45,
          color: Colors.transparent,
          child: HabitSetUpSheet(
            imageTitle: widget.imageTitle,
          ),
        );
      },
    ).whenComplete(() {
      Navigator.pop(context);
    });
  }
}
