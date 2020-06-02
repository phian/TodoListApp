import 'package:flutter/material.dart';

class ScheduleSheet extends StatefulWidget {
  @override
  _ScheduleSheetState createState() => _ScheduleSheetState();
}

class _ScheduleSheetState extends State<ScheduleSheet> {
  List<String> _scheduleTittle = [
    'Today',
    'Tomorrow',
    'This week',
    'Later',
    'Choose date'
  ];
  int _selectedScheduleIndex = 0;
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
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _scheduleTittle.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  child: ListTile(
                    leading: _selectedScheduleIndex == index
                        ? Opacity(opacity: 1.0, child: Icon(Icons.check),)
                        : Opacity(opacity: 0.0, child: Icon(Icons.check),),
                    title: Text(_scheduleTittle[index]),
                    selected: _selectedScheduleIndex == index,
                    onTap: () {
                      setState(() {
                        _selectedScheduleIndex = index;
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
