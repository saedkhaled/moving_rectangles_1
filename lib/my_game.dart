import 'dart:math';
import 'dart:ui' as ui;
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:moving_rectangles_1/square.dart';

class MyGame extends FlameGame
    with TapDetector, DoubleTapDetector, HasCollisionDetection {
  bool isRunning = true;
  var colors = [
    BasicPalette.red,
    BasicPalette.green,
    BasicPalette.white,
    BasicPalette.cyan,
    BasicPalette.yellow,
    BasicPalette.pink,
  ];

  @override
  bool get debugMode => false;

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    addAll([
      ScreenHitbox(),
      FpsTextComponent()..position = Vector2(20, 20),
    ]);
  }

  @override
  void render(ui.Canvas canvas) {
    TextPaint()
        .render(canvas, "Objects Active: ${children.length}", Vector2(20, 50));
    super.render(canvas);
  }

  @override
  void onTapUp(TapUpInfo info) {
    // location of the user's tap
    final touchPoint = info.eventPosition.game;

    //check if the tap location is within any of the shapes on the screen
    // and if so remove the shape from the screen
    final handled = children.any((component) {
      if (component is Square && component.containsPoint(touchPoint)) {
        // remove(component);
        component.velocity.negate();
        return true;
      }
      return false;
    });

    // this is a clean location with no squares
    // create and add a new shape to the component tree under the FlameGame
    if (!handled) {
      add(Square()
        ..position = touchPoint
        ..squareSize = 30
        ..velocity = Vector2.random().normalized() * 300
        ..color = (colors[Random().nextInt(6)].paint()
          ..style = ui.PaintingStyle.stroke
          ..strokeWidth = 2));
    }

    super.onTapUp(info);
  }

  @override
  void onDoubleTap() {
    if (isRunning) {
      pauseEngine();
    } else {
      resumeEngine();
    }
    isRunning = !isRunning;
    super.onDoubleTap();
  }
}
