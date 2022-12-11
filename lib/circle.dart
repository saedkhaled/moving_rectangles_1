import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flame/extensions.dart';
import 'package:moving_rectangles_1/square.dart';

class Circle extends PositionComponent with CollisionCallbacks {
  // velocity is 0 here
  // var velocity = Vector2.random().normalized() * 200;

  var circleSize = 5.0;
  var rotationSpeed = 20.0;

  var color = BasicPalette.white.paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;

  //initialize the component
  @override
  Future<void>? onLoad() async {
    super.onLoad();

    add(RectangleHitbox());
    size.setValues(circleSize, circleSize);
    anchor = Anchor.center;
  }

  // update the inner state of the shape
  // in our case the position based on velocity
  @override
  void update(double dt) {
    super.update(dt);
    // speed is refresh frequency independent
    // position += velocity * dt;
    // var angleDelta = dt * rotationSpeed;
    // angle = (angle + angleDelta) % (2 * pi);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawCircle(const Offset(-15, -15), 5, color);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Circle) {
      var parentComponent = parent;
      if (parentComponent is Square) {
        parentComponent.rotationSpeed = -1 * parentComponent.rotationSpeed;
      }
    }
    // if (other is Square) {
    //   other.velocity.negate();
    // } else if (other is Polygon) {
    //   other.velocity.negate();
    // } else if (other is Circle) {
    //   var parentComponent = parent;
    //   if (parentComponent is Square) {
    //     parentComponent.rotationSpeed = -1 * parentComponent.rotationSpeed;
    //
    //   }
    // } else if (other is ScreenHitbox) {
    //   var parentComponent = parent;
    //   if (parentComponent is Square) {
    //     parentComponent.velocity.negate();
    //   }
    // }
    super.onCollisionStart(intersectionPoints, other);
  }
}
