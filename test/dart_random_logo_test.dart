import 'package:dart_random_logo/dart_random_logo.dart';
import 'dart:math' show Random;

import 'package:vector_math/vector_math.dart';
import 'package:test/test.dart';

void main() {
  group('Affine2D', () {
    test('constructor', () {
      final W = Matrix2(1, 0, 0, 1);
      final b = Vector2(2, 3);

      final aff = Affine2(W, b);

      expect(aff.W, isA<Matrix2>());
      expect(aff.b, isA<Vector2>());

      final x = Vector2(-1, -2);
      final y = aff(x);

      expect(y, equals(Vector2(1, 1)));
    });
  });

  group('SigmaFactorIFS', () {
    test('randSigmaFactorIFS generates valid SigmaFactorIFS', () {
      Random rng = Random();
      SigmaFactorIFS sigmaFactorIFS = randSigmaFactorIFS(rng);

      // Check that transforms list is not empty
      expect(sigmaFactorIFS.transforms, isNotEmpty);

      // Check that catdist list is not empty
      expect(sigmaFactorIFS.probs, isNotEmpty);

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
      int N = 4;
      double alpha = 0.5 * (N + 5.5);
      List<List<double>> singularValues = sampleSvs(rng, alpha, N);

      // Check that the matrix has the correct dimensions
      expect(singularValues.length, equals(N));
      expect(singularValues[0].length, equals(2));

      double sigmaFactor = 0.0;
      // Check that the values are within the expected range
      for (int i = 0; i < N; i++) {
        double sigma1 = singularValues[i][0];
        double sigma2 = singularValues[i][1];
        sigmaFactor += sigma1 + 2 * sigma2;
      }
      expect((sigmaFactor - alpha).abs() < 1e-7, true);
    });

    group("ifs", () {
      test("randSigmaFactorIFS", () {
        final rng = Random();
        final ifs = randSigmaFactorIFS(rng);
        double s = 0;
        for (double p in ifs.probs) {
          s += p;
        }
        expect((s - 1.0).abs() < 1e-7, true);
      });
    });

    group("point_generation", () {
      test("categoricalSample", () {
        final rng = Random();
        int c = categoricalSample(rng, [0.01, 0.01, 0.98]);
        print(c);
      });
      test("pointGeneration", () {
        final (xs, ys) = generatePoints();
        expect(xs.length, equals(ys.length));
      });
    });
  });
}
