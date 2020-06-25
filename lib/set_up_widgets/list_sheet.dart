import 'package:flutter/material.dart';

class ListSheet extends StatefulWidget {
  int choseListIndex = 0;
  List<String> listTitles = ['No list', 'Add new list'];
  List<Widget> listWidgets = [];
  List<Color> listColors = [Colors.white, Colors.blue[300]];

  @override
  _ListSheetState createState() => _ListSheetState();
}

class _ListSheetState extends State<ListSheet> with TickerProviderStateMixin {
  double _chooseListSheetHeight;

  List<Widget> _listWidgets;
  List<String> _listTitles;
  List<Color> _listColors;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller;
  String _newListTile;

  @override
  void initState() {
    super.initState();

    _chooseListSheetHeight = 205;

    _listWidgets = widget.listWidgets;
    _listTitles = widget.listTitles;
    _listColors = widget.listColors;

    if (_listWidgets.length == 0) _initListChoices();

    _controller = TextEditingController();
    _newListTile = "";
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
          _choooseListSheetHeader(),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                itemCount: _listWidgets.length,
                itemBuilder: (context, index) {
                  if (index < _listWidgets.length) {
                    return GestureDetector(
                      child: _listWidgets[index],
                      onTap: () {
                        widget.choseListIndex = index;

                        if (index == 0) {
                          Navigator.of(context).pop();
                        } else if (index == 1) {
                          _createNewTask();
                        }
                      },
                    );
                  }
                  return null;
                }),
          ),
        ],
      ),
    );
  }

  // Widget hiển thị Header của choose list sheet
  Widget _choooseListSheetHeader() => Row(
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
      );

  // Widget để tạo ra UI cho list
  Widget _listWidget(String listTitle, Color listColor) => Column(
        children: <Widget>[
          Container(
            height: 60,
            child: Center(
              child: Text("$listTitle"),
            ),
            decoration: BoxDecoration(
              color: listColor,
            ),
          ),
          SizedBox(
            height: 3.0,
          )
        ],
      );

  // Hàm để khởi tạo các list cho người dùng chọn lựa
  void _initListChoices() {
    for (int i = 0; i < _listTitles.length; i++) {
      _listWidgets.add(_listWidget(
        _listTitles[i],
        _listColors[i],
      ));
    }
  }

  // Hàm để show dialog cho người dùng add tên task mới
  void _createNewTask() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Positioned(
                  right: -40.0,
                  top: -40.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.close),
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.isEmpty == false) _newListTile = value;
                          },
                          autofocus: true,
                          controller: _controller,
                          style: TextStyle(fontSize: 20.0),
                          decoration: InputDecoration(
                              hintText: "New name",
                              labelText: "Your list's name",
                              border: OutlineInputBorder(
                                  gapPadding: 8.0,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)))),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          child: Text("OK"),
                          onPressed: () {
                            if (_newListTile.isEmpty == false) {
                              setState(() {
                                widget.listTitles.add(_newListTile);
                                widget.listColors.add(Colors.white);
                                widget.listWidgets.add(_listWidget(
                                    widget.listTitles[
                                        widget.listTitles.length - 1],
                                    widget.listColors[
                                        widget.listColors.length - 1]));

                                if (_chooseListSheetHeight <
                                    MediaQuery.of(context).size.height *
                                        (2 / 3)) _chooseListSheetHeight += 60;

                                _newListTile = "";
                              });
                            }

                            Navigator.of(context).pop();
                            _formKey.currentState.reset();
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
