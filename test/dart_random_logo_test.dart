import 'package:dart_random_logo/dart_random_logo.dart';
import 'package:vector_math/vector_math.dart';
import 'package:test/test.dart';

void main() {
  group('Affine2D', () {
    test('constructor', () {
      final W = Matrix2.identity();
      final b = Vector2(2, 3);

      final aff = Affine2(W, b);
      final x = Vector2(-1, -2);
      final y = aff(x);

      expect(y, equals(Vector2(1, 1)));
    });
  });
}