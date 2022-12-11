import 'dart:math';
import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flame/extensions.dart';
import 'package:moving_rectangles_1/utils.dart';

class Asteroid extends PositionComponent with CollisionCallbacks, HasGameRef {
  // velocity is 0 here
  var velocity = Vector2.random().normalized() * 200;
  var rotationSpeed = 10.0;

  var color = BasicPalette.white.paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;

  late PolygonComponent asteroid;

  var vectors = [
    Vector2(0.2, 0.8), // v1
    Vector2(-0.6, 0.6), // v2
    Vector2(-0.8, 0.2), // v3
    Vector2(-0.6, -0.4), // v4
    Vector2(-0.4, -0.8), // v5
    Vector2(0.0, -1.0), // v6
    Vector2(0.4, -0.6), // v7
    Vector2(0.8, -0.8), // v8
    Vector2(1.0, 0.0), // v9
    Vector2(0.4, 0.2), // v10
    Vector2(0.7, 0.6), // v11
  ];

  //initialize the component
  @override
  Future<void>? onLoad() async {
    super.onLoad();
    asteroid = PolygonComponent.relative(vectors, parentSize: size, position: position, paint: color);
    add(PolygonHitbox(vectors));
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

    if (Utils.isPositionOutOfBounds(gameRef.size, position)) {
      gameRef.remove(this);
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    asteroid.render(canvas);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    velocity.negate();
    // if (other is Square) {
    //   velocity.negate();
    //   other.velocity.negate();
    // } else if (other is Polygon) {
    //   velocity.negate();
    //   other.velocity.negate();
    // } else if (other is Circle) {
    //   velocity.negate();
    //   if(other.parent is Square) {
    //     (other.parent as Square).rotationSpeed *=  -1;
    //   }
    // } else if (other is ScreenHitbox) {
    //   velocity.negate();
    // }
    super.onCollisionStart(intersectionPoints, other);
  }
}
