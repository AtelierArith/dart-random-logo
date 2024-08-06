import "package:vector_math/vector_math.dart";
import 'dart:math';

import "./affine.dart";
import "./ifs_sigma_factor.dart";

class SigmaFactorIFS {
  final List<Affine2> transforms;
  final List<double> catdist;

  SigmaFactorIFS(this.transforms, this.catdist);
}

Matrix2 randRotmat(Random rng) {
  double theta = rng.nextDouble() * 2 * pi;
  return Matrix2(cos(theta), -sin(theta), sin(theta), cos(theta));
}

Matrix2 diagm(double d1, double d2) {
  return Matrix2(d1, 0, 0, d2);
}

SigmaFactorIFS randSigmaFactorIFS(Random rng) {
  int N = rng.nextInt(3) + 2;
  // double alphaL = 0.5 * (5 + N);
  // double alphaU = 0.5 * (6 + N);
  // double sigmaFactor = uniform(rng, alphaL, alphaU);
  List<Affine2> transforms = [];
  List<double> probs = [];

  for (int k = 0; k < N; k++) {
    double sigma1 = uniform(rng, 0.1, 1.0); // Placeholder for sample_svs
    double sigma2 = uniform(rng, 0.1, 1.0); // Placeholder for sample_svs
    Matrix2 Rtheta = randRotmat(rng);
    Matrix2 Rphi = randRotmat(rng);
    Matrix2 Sigma = diagm(sigma1, sigma2);
    Matrix2 D =
        diagm(2 * (rng.nextInt(2) * 2 - 1), 2 * (rng.nextInt(2) * 2 - 1));
    Matrix2 W = Rtheta * Sigma * Rphi * D;
    double b1 = uniform(rng, -1.0, 1.0);
    double b2 = uniform(rng, -1.0, 1.0);
    Vector2 b = Vector2(b1, b2);
    probs.add(W.determinant().abs());
    transforms.add(Affine2(W, b));
  }

  return SigmaFactorIFS(transforms, probs);
}
