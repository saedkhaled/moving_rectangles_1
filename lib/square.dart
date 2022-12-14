import 'dart:math';
import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flame/extensions.dart';
import 'package:moving_rectangles_1/circle.dart';
import 'package:moving_rectangles_1/utils.dart';

class Square extends PositionComponent with CollisionCallbacks, HasGameRef {
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
    add(Circle()..color = color);
    anchor = Anchor.center;
  }

  // update the inner state of the shape
  // in our case the position based on velocity
  @override
  void update(double dt) {
    super.update(dt);
    // equation for circle movement still need work
    // position = Vector2(cos(lastAngle / pi) * position.length ,
    //     sin(lastAngle / pi) * position.length);
    // speed is refresh frequency independent
    position += velocity * dt;
    var angleDelta = dt * rotationSpeed;
    angle = (angle + angleDelta) % (2 * pi);
    if (Utils.isPositionOutOfBounds(gameRef.size, position)) {
      gameRef.remove(this);
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), color);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    velocity.negate();
    // if (other is Square) {
    //   other.velocity.negate();
    // } else if (other is Circle) {
    //   var parentComponent = parent;
    //   if (parentComponent is Square) {
    //     parentComponent.velocity.negate();
    //   }
    // } else if (other is Polygon) {
    //   other.velocity.negate();
    // } else if (other is ScreenHitbox) {
    //   velocity.negate();
    // }
    super.onCollisionStart(intersectionPoints, other);
  }
}
