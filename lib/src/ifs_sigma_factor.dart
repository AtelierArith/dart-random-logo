import 'dart:math';
import 'package:vector_math/vector_math.dart';


double uniform(Random rng, double min, double max) {
  return min + rng.nextDouble() * (max - min);
}

List<List<double>> sampleSvs(Random rng, double alpha, int N) {
  List<List<double>> singularValues = List.generate(N, (_) => List.filled(2, 0.0));

  double bl = alpha - 3 * N + 3;
  double bu = alpha;
  double half = 0.5;
  double third = 3.0;

  for (int k = 0; k < N - 1; k++) {
    double sigmaK1 = uniform(rng, max(0.0, bl / third), min(1.0, bu));
    bl = bl - sigmaK1;
    bu = bu - sigmaK1;
    double sigmaK2 = uniform(rng, max(0.0, half * bl), min(sigmaK1, half * bu));
    bl = bl - 2 * sigmaK2 + 3;
    bu = bu - 2 * sigmaK2;
    singularValues[k][0] = sigmaK1;
    singularValues[k][1] = sigmaK2;
  }

  double sigma2 = uniform(rng, max(0.0, half * (bu - 1.0)), bu / third);
  double sigma1 = bu - 2 * sigma2;
  singularValues[N - 1][0] = sigma1;
  singularValues[N - 1][1] = sigma2;

  return singularValues;
}
