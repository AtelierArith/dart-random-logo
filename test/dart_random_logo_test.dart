import 'package:dart_random_logo/dart_random_logo.dart';
import 'dart:math' show Random;

import 'package:vector_math/vector_math.dart';
import 'package:test/test.dart';

void main() {
  group('Affine2D', () {
    test('constructor', () {
      final W = Matrix2.identity();
      final b = Vector2(2, 3);

      final aff = Affine2(W, b);

      expect(aff.W, isA<Matrix2>());
      expect(aff.b, isA<Vector2>());

      final x = Vector2(-1, -2);
      final y = aff(x);

      expect(y, equals(Vector2(1, 1)));
    });
  });

  group('Affine2D', () {
    test('randSigmaFactorIFS generates valid SigmaFactorIFS', () {
      Random rng = Random();
      SigmaFactorIFS sigmaFactorIFS = randSigmaFactorIFS(rng);

      // Check that transforms list is not empty
      expect(sigmaFactorIFS.transforms, isNotEmpty);

      // Check that catdist list is not empty
      expect(sigmaFactorIFS.catdist, isNotEmpty);

      // Check each transform
      for (var transform in sigmaFactorIFS.transforms) {
        expect(transform.W, isA<Matrix2>());
        expect(transform.b, isA<Vector2>());
      }
    });
  });

  group("ifs_sigma_factor_factor", () {
    test('sampleSvs generates valid singular values', () {
    Random rng = Random();
    double alpha = 10.0;
    int N = 5;

    Matrix2 singularValues = sampleSvs(rng, alpha, N);

    // Check that the matrix has the correct dimensions
    //expect(singularValues.rowStride, equals(N));
    //expect(singularValues.columnStride, equals(2));

    // Check that the values are within the expected range
    for (int i = 0; i < N; i++) {
      double sigma1 = singularValues.entry(i, 0);
      double sigma2 = singularValues.entry(i, 1);
      expect(sigma1, inInclusiveRange(0.0, alpha));
      expect(sigma2, inInclusiveRange(0.0, alpha));
    }
  });
  }) ;
}
