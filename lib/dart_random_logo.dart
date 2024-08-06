import 'package:vector_math/vector_math.dart';

class Affine2 {
  final Matrix2 W;
  final Vector2 b;

  Affine2(this.W, this.b);

  Vector2 call(Vector2 point) {
     return W * point + b;
  }
}

