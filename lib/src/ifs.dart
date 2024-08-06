import "package:ml_linalg/linalg.dart";
import "package:scidart/numdart.dart";
import "package:vector_math/vector_math.dart";
import 'dart:math';

import "./affine.dart";
import "./ifs_sigma_factor.dart";

class SigmaFactorIFS {
  final List<Affine2> transforms;
  final List<double> probs;

  SigmaFactorIFS(this.transforms, this.probs);
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
  double alphaL = 0.5 * (5 + N);
  double alphaU = 0.5 * (6 + N);
  double alpha = uniform(rng, alphaL, alphaU);

  List<List<double>> singularValues = sampleSvs(rng, alpha, N);

  List<Affine2> transforms = [];
  List<double> probs = [];

  for (int k = 0; k < N; k++) {
    double sigma1 = singularValues[k][0];
    double sigma2 = singularValues[k][1];
    Matrix2 rotTheta = randRotmat(rng);
    Matrix2 rotPhi = randRotmat(rng);
    Matrix2 sgmMat = diagm(sigma1, sigma2);
    double d1 = rng.nextInt(2) * 2 - 1;
    double d2 = rng.nextInt(2) * 2 - 1;
    Matrix2 D = diagm(d1, d2);
    Matrix2 W = rotTheta * sgmMat * rotPhi * D;
    /*
    // print("W=$W");
    final a11 = W.entry(0, 0);
    final a12 = W.entry(0, 1);
    final a21 = W.entry(1, 0);
    final a22 = W.entry(1, 1);

    final svd = SVD(Array2d([
      Array([a11, a12]),
      Array([a21, a22])
    ]));
    print("svd=${svd.S()}");
    print(sigma1);
    print(sigma2);
    */
    double b1 = uniform(rng, -1.0, 1.0);
    double b2 = uniform(rng, -1.0, 1.0);
    Vector2 b = Vector2(b1, b2);
    probs.add(W.determinant().abs());
    transforms.add(Affine2(W, b));
  }

  double s = 0;
  for (double p in probs){
    s += p;
  }
  for (int i=0; i < probs.length; i++){
    probs[i] = probs[i]/s;
  }
  return SigmaFactorIFS(transforms, probs);
}
