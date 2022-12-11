import 'dart:math';

import 'package:flame/components.dart';

class Utils {
  static Vector2 generateRandomPosition(Vector2 screenSize, Vector2 margins) {
    var result = Vector2.zero();
    var x = Random()
            .nextInt(screenSize.x.round() - 2 * margins.x.toInt())
            .toDouble() +
        margins.x.toInt();
    var y = Random()
            .nextInt(screenSize.y.round() - 2 * margins.y.toInt())
            .toDouble() +
        margins.y.toInt();
    result = Vector2(x, y);
    return result;
  }

  static Vector2 generateRandomVelocity(Vector2 screenSize, int min, int max) {
    var result = Vector2.zero();
    double velocity;

    while (result == Vector2.zero()) {
      var x = (Random().nextInt(3) - 1) * Random().nextDouble();
      var y = (Random().nextInt(3) - 1) * Random().nextDouble();
      result = Vector2(x, y);
    }
    result.normalize();
    velocity = (Random().nextInt(max - min) + min).toDouble();
    return result * velocity;
  }

  static bool isPositionOutOfBounds(Vector2 bounds, Vector2 position) {
    if (position.x >= bounds.x ||
        position.x <= 0 ||
        position.y <= 0 ||
        position.y >= bounds.y) {
      return true;
    }
    return false;
  }
}
