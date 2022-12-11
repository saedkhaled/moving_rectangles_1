import 'dart:math';
import 'dart:ui' as ui;
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:moving_rectangles_1/astroid.dart';
import 'package:moving_rectangles_1/square.dart';
import 'package:moving_rectangles_1/utils.dart';

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
    var isSquare = true;
    final handled = children.any((component) {
      if (component is Square && component.containsPoint(touchPoint)) {
        // remove(component);
        component.velocity.negate();
      } else if (component is Asteroid && component.containsPoint(touchPoint)) {
        component.velocity.negate();
      } else if (info.eventPosition.game.x < (size.x / 2)) {
        isSquare = true;
      } else if (info.eventPosition.game.x >= (size.x / 2)) {
        isSquare = false;
      }
      return false;
    });

    // this is a clean location with no squares
    // create and add a new shape to the component tree under the FlameGame
    if (!handled && isSquare) {
      add(Square()
        ..position = Utils.generateRandomPosition(size, Vector2(200, 200))
        ..squareSize = 30
        ..velocity = Utils.generateRandomVelocity(size, 100, 1000)
        ..color = (colors[Random().nextInt(6)].paint()
          ..style = ui.PaintingStyle.stroke
          ..strokeWidth = 2));
    } else if (!handled && !isSquare) {
      add(Asteroid()
        ..position = Utils.generateRandomPosition(size, Vector2(200, 200))
        ..size = Vector2.all(100)
        ..velocity = Utils.generateRandomVelocity(size, 100, 1000)
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
