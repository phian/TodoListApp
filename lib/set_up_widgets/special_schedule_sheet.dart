import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/data/repeat_choice_data.dart';
import 'package:todoapp/set_up_widgets/repeat_sheet.dart';
import 'package:todoapp/set_up_widgets/special_repeat_sheet.dart';
import 'package:todoapp/data/special_repeat_data.dart';

class SpecialScheduleSheet extends StatefulWidget {
  DateTime schedulePickedDate;
  final DateTime initTime;
  SpecialRepeatChoiceData specialRepeatChoiceData = SpecialRepeatChoiceData();

  SpecialScheduleSheet({this.initTime, SpecialRepeatChoiceData data}) {
    schedulePickedDate = initTime;
    specialRepeatChoiceData = data;
  }

  @override
  _SpecialScheduleSheetState createState() => _SpecialScheduleSheetState();
}

class _SpecialScheduleSheetState extends State<SpecialScheduleSheet> {
  
  String _scheduleChoseDateText;
  DateTime _scheduleChoseDateTime;

  RepeatSheet _repeatSheet;
  SpecialRepeatSheet _specialRepeatSheet;

  @override
  void initState() {
    super.initState();

    _scheduleChoseDateTime = widget.schedulePickedDate == DateTime.now()
        ? DateTime.now()
        : widget.schedulePickedDate;
    _scheduleChoseDateText =
        DateFormat("EEEEEEEE dd MMMM yyyy").format(_scheduleChoseDateTime);

    _specialRepeatSheet = SpecialRepeatSheet(
      initChoiceData: widget.specialRepeatChoiceData,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: Color(0xFFECEFF1),
      ),
      height: MediaQuery.of(context).size.height * 0.9,
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Schedule",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.check),
            title: Text('Choose date'),
            trailing: Text(_scheduleChoseDateText),
            onTap: () {
              setState(() {
                
                _scheduleChoseDateText = DateFormat("EEEEEEEE dd MMMM yyyy")
                    .format(_scheduleChoseDateTime);
              });

              
                showRoundedDatePicker(
                  theme: ThemeData.dark(),
                  context: context,
                  initialDate: _scheduleChoseDateTime,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                ).then((value) {
                  setState(() {
                    if (value != null) {
                      _scheduleChoseDateTime = value;
                      widget.schedulePickedDate = _scheduleChoseDateTime;
                    }

                    _scheduleChoseDateText = DateFormat("EEEEEEEE dd MMMM yyyy")
                        .format(_scheduleChoseDateTime);
                    
                  });
                });
              } 
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Repeats",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          ListTile(
            onTap: _onRepeatTap,
            title: Text("Open repeats set up"),
            leading: Opacity(
              opacity: 0.0,
              child: Icon(Icons.check),
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
          Expanded(child: SizedBox()),
        ],
      ),
    );
  }

  void _onRepeatTap() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => _specialRepeatSheet).whenComplete(() {
      widget.specialRepeatChoiceData = _specialRepeatSheet.specialRepeatChoiceData;
    });
  }

  
  
}
