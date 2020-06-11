import 'package:flutter/material.dart';

class ListSheet extends StatefulWidget {
  @override
  _ListSheetState createState() => _ListSheetState();
}

class _ListSheetState extends State<ListSheet> {
  double _chooseListSheetHeight;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _chooseListSheetHeight = 205;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: Color(0xFFECEFF1),
      ),
      height: _chooseListSheetHeight,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Choose list",
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
            child: ListView(
              physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              padding: EdgeInsets.all(MediaQuery.of(context).size.width / 12),
              children: <Widget>[
                Container(
                  height: 60,
                  child: Center(
                    child: Text("No list"),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  height: 60,
                  child: Center(
                    child: Text("Add new list"),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
