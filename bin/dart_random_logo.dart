import 'dart:math';
import 'package:vector_math/vector_math.dart';

import 'package:dart_random_logo/dart_random_logo.dart';

void main(List<String> arguments) {
  final (xs, ys) = generatePoints();
  for( int i = 1; i < xs.length; i ++ ){
    double x = xs[i];
    double y = ys[i];
    print("$x, $y");
  }
}
