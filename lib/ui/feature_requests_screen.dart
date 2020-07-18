import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todoapp/ui/help_screen.dart';

class FeatureRequestsScreen extends StatefulWidget {
  final int lastFocusedScreen;
  FeatureRequestsScreen({this.lastFocusedScreen});

  @override
  _FeatureRequestsScreenState createState() => _FeatureRequestsScreenState();
}

class _FeatureRequestsScreenState extends State<FeatureRequestsScreen> {
  List<int> _featureCountNumbers = [216, 790, 190, 150, 100];
  List<int> _commentCounts = [26, 10, 40, 50, 30];
  List<String> _featureTitles = [
    "Desktop version",
    "Sub tasks",
    "Set deadlines (Due date)",
    "LifeTime subscription",
    "Make repeating clearer"
  ];
  List<String> _featureState = [
    "In progress",
    "Planned",
    "Planning",
    "Waiting",
    "Planning"
  ];
  List<Color> _stateColors = [
    Colors.purple[300],
    Colors.blue[300],
    Colors.green[300],
    Colors.grey[300],
    Colors.green[300],
  ];
  List<Widget> _featureItemsList = [];
  double _featureItemsScreenOpacity;

  @override
  void initState() {
    super.initState();

    _featureItemsScreenOpacity = 1.0;
      _initItemsForFeatureList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        // ignore: missing_return
        onWillPop: () async {
          _backToHelpScreen();
        },
        child: Scaffold(
          body: Container(
            color: Color(0xFFFFE4D4),
            child: Stack(
              children: <Widget>[
                _buildFeatureRequestScreenHeaderText(),
                _buildCloseButton(),
                _buildFeatureRequestBoard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Header text
  Widget _buildFeatureRequestScreenHeaderText() => Container(
        padding: EdgeInsets.symmetric(vertical: 22.0),
        alignment: Alignment.topCenter,
        child: Text(
          "FEATURE REQUEST",
          style: TextStyle(
            fontSize: 27.0,
            color: Color(0xFF425195),
          ),
        ),
      );

  // Close buuton
  Widget _buildCloseButton() => Container(
        padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
        alignment: Alignment.topLeft,
        child: Container(
          width: 70.0,
          height: 70.0,
          child: FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(90.0)),
            child: Icon(
              Icons.close,
              size: 35.0,
            ),
            onPressed: _backToHelpScreen,
          ),
        ),
      );

  // Hàm quay để vể Help screen
  void _backToHelpScreen() {
    Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.leftToRight,
            child: HelpScreen(
              lastFocusedScreen: widget.lastFocusedScreen,
            ),
            duration: Duration(milliseconds: 300)));
  }

  // Feature Request board
  Widget _buildFeatureRequestBoard() => AnimatedOpacity(
        duration: Duration(milliseconds: 300),
        opacity: _featureItemsScreenOpacity,
        child: Container(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
          child: Container(
            color: Colors.white,
            child: ListView(
              physics: AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              children: <Widget>[
                _buildFRBoardHeader(),
                _buildSeparateBox(20.0),
                _buildFilterBox(),
                _buildSeparateBox(10.0),
                Divider(
                  thickness: 1.5,
                ),
                _buildSeparateBox(15.0),
                _buildHelpText(),
                _buildSeparateBox(25.0),
                _buildSearchRow(),
                _buildSeparateBox(10.0),
                _buildFeatureRequestList(),
              ],
            ),
          ),
        ),
      );

  // Separate box
  Widget _buildSeparateBox(double height) => SizedBox(
        height: height,
      );

  // Board header
  Widget _buildFRBoardHeader() => Container(
        padding: EdgeInsets.only(top: 15.0),
        alignment: Alignment.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              "DoFRBo",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              height: 50.0,
              width: 120.0,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(
                    30.0,
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Image.asset(
                    "images/pen.png",
                    width: 25.0,
                    height: 25.0,
                    color: Colors.white,
                  ),
                  Text(
                    "CREATE",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.white),
                  )
                ],
              ),
            ),
            Text(
              "LOG IN / SIGN UP",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );

  // Filter box
  Widget _buildFilterBox() => Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              child: Image.asset(
                "images/idea.png",
                width: 30.0,
                height: 30.0,
              ),
            ),
            Text(
              "DOIT FEATURE REQUEST",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            Container(
              width: 70.0,
              height: 40.0,
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(
                width: 1.0,
                color: Colors.grey,
              ))),
              child: FlatButton(
                splashColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(90.0)),
                child: Center(
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    size: 30.0,
                  ),
                ),
                onPressed: () {},
              ),
            )
          ],
        ),
      );

  // Help text
  Widget _buildHelpText() => Container(
        margin: EdgeInsets.only(
          left: 10.0,
          right: 10.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[400],
        ),
        padding: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
        ),
        alignment: Alignment.center,
        height: 130.0,
        child: Text(
          "Help shape the future of DOIT by posting your idea or feature request here",
          maxLines: 5,
          style: TextStyle(
            fontSize: 22.0,
          ),
        ),
      );

  // Search row
  Widget _buildSearchRow() => Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  "Showing",
                  style: TextStyle(fontSize: 25.0),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                      color: Colors.grey,
                    )),
                  ),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Trending",
                        style: TextStyle(fontSize: 25.0),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 2.0),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          size: 30.0,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  "posts",
                  style: TextStyle(fontSize: 25.0),
                ),
              ],
            ),
            Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0)),
              child: Center(
                child: Icon(
                  Icons.search,
                  size: 30.0,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      );

  // Feature Requests list
  Widget _buildFeatureRequestList() => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        child: ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _featureItemsList[index];
          },
          itemCount: _featureItemsList.length,
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 20.0,
            );
          },
        ),
      );

  // Hàm khởi tạo các item cho feature list
  void _initItemsForFeatureList() {
    for (int i = 0; i < _featureTitles.length; i++)
      _featureItemsList.add(_buildFeatureRequestListItem(
        commentCount: _commentCounts[i],
        countNumber: _featureCountNumbers[i],
        featureState: _featureState[i],
        featureTitle: _featureTitles[i],
        stateColor: _stateColors[i],
      ));
  }

  // Widget của các item trong Feature Request list
  Widget _buildFeatureRequestListItem({
    int countNumber,
    String featureTitle,
    String featureState,
    Color stateColor,
    int commentCount,
  }) =>
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: 70.0,
              height: 80.0,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.arrow_drop_up,
                    color: Colors.grey,
                    size: 45.0,
                  ),
                  Text(
                    "$countNumber",
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 200.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "$featureTitle",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "$featureState".toUpperCase(),
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: stateColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 80.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 3.0),
                    child: Icon(
                      Icons.message,
                      size: 30.0,
                    ),
                  ),
                  Text(
                    "$commentCount",
                    style: TextStyle(fontSize: 25.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
