import 'dart:math';
import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flame/extensions.dart';

class Square extends PositionComponent with CollisionCallbacks {
  // velocity is 0 here
  var velocity = Vector2.random().normalized() * 200;

  var squareSize = 30.0;
  var rotationSpeed = 20.0;

  var color = BasicPalette.white.paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;

  //initialize the component
  @override
  Future<void>? onLoad() async {
    super.onLoad();

    add(RectangleHitbox());
    size.setValues(squareSize, squareSize);
    anchor = Anchor.center;
  }

  // update the inner state of the shape
  // in our case the position based on velocity
  @override
  void update(double dt) {
    super.update(dt);
    // speed is refresh frequency independent
    position += velocity * dt;
    var angleDelta = dt * rotationSpeed;
    angle = (angle + angleDelta) % (2 * pi);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), color);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Square) {
      other.velocity = Vector2.random().normalized() * 300;
    } else if (other is ScreenHitbox) {
      velocity.negate();
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
