import 'package:dart_random_logo/dart_random_logo.dart' as dart_random_logo;
import 'package:vector_math/vector_math.dart';

void main(List<String> arguments) {
  final aff = dart_random_logo.Affine2(Matrix2.identity(), Vector2(2, 3));
  final point = Vector2(1, 1);
  final transformedPoint = aff(point); // Using the call operator
  print(transformedPoint); // Output: (3.0, 4.0)
}
