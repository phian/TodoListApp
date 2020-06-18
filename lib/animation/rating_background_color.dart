import 'package:flutter/material.dart';

Animatable<Color> ratingBackgroundTween = TweenSequence<Color>([
  TweenSequenceItem(
      tween: ColorTween(
        begin: Color(0xFFFCBDE9),
        end: Color(0xFFF8ECBD),
      ),
      weight: 1.0),
      TweenSequenceItem(
      tween: ColorTween(
        begin: Color(0xFFF8ECBD),
        end: Color(0xFFF8ECBD),
      ),
      weight: 1.0),
      TweenSequenceItem(
      tween: ColorTween(
        begin: Color(0xFFF8ECBD),
        end: Color(0xFFBCFBE4),
      ),
      weight: 1.0),
]);
