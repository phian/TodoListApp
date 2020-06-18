import 'package:flutter/material.dart';

final state = ["Very Bad", "Bad", "Good", "Very Good", "Perfect"];

var currText = [
  Text(
    state[0],
    key: Key(state[0]),
    style: TextStyle(
        color: Colors.black, fontSize: 40.0, fontFamily: "RobotoSlab"),
  ),
  Text(
    state[1],
    key: Key(state[1]),
    style: TextStyle(
        color: Colors.black, fontSize: 40.0, fontFamily: "RobotoSlab"),
  ),
  Text(
    state[2],
    key: Key(state[2]),
    style: TextStyle(
        color: Colors.black, fontSize: 40.0, fontFamily: "RobotoSlab"),
  ),
  Text(
    state[3],
    key: Key(state[3]),
    style: TextStyle(
        color: Colors.black, fontSize: 40.0, fontFamily: "RobotoSlab"),
  ),
  Text(
    state[4],
    key: Key(state[4]),
    style: TextStyle(
        color: Colors.black, fontSize: 40.0, fontFamily: "RobotoSlab"),
  ),
];
