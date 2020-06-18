import 'package:flare_dart/math/mat2d.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'dart:math' as math;

class FlareRateController extends FlareController {
  // Các biến để cài đặt animation cho Flare
  FlutterActorArtboard _ratingArtBoard;
  ActorAnimation _rateAnimation;

  // Các biến để chạy animation của Flare
  double _slidePercent = 0.0;
  double _currentSlide = 0.0;
  double _smoothTime = 5.0;

  @override
  void initialize(FlutterActorArtboard artboard) {
    if (artboard.name.compareTo("Artboard") == 0) {
      _ratingArtBoard = artboard;
      _rateAnimation = artboard.getAnimation("slide");
    }
  }

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    if (artboard.name.compareTo("Artboard") == 0) {
      _currentSlide +=
          (_slidePercent - _currentSlide) * math.min(1, elapsed * _smoothTime);
      _rateAnimation.apply(
          _currentSlide * _rateAnimation.duration, artboard, 1);
    }

    return true;
  }

  @override
  void setViewTransform(Mat2D viewTransform) {}

  // Hàm để update % khi ng dùng slide
  void updateSlidePercent(double slideValue) {
    _slidePercent = slideValue;
  }
}
