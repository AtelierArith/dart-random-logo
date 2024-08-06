import 'dart:math';
import 'package:vector_math/vector_math.dart';
import './ifs.dart';

int categoricalSample(Random rng, List<double> p) {
  int n = p.length;
  int i = 0;
  double c = p[0];
  double u = rng.nextDouble();
  while (c < u && i < n) {
    c += p[i += 1];
  }
  return i;
}

void generatePointsCore(List<double> xs, List<double> ys) {
  final N = xs.length;
  final rng = Random();
  final ifs = randSigmaFactorIFS(rng);

  double x = 0.0;
  double y = 0.0;

  List<double> probs = ifs.probs;

  for (int i = 0; i < N; i++) {
    int c = categoricalSample(rng, probs);
    final aff = ifs.transforms[c];
    Vector2 xy = Vector2(x, y);
    //print(xy);
    xy = aff(xy);
    xs[i] = xy.x;
    ys[i] = xy.y;
    x = xy.x;
    y = xy.y;
    // print(x);
  }
}

(List<double>, List<double>) generatePoints() {
  List<double> xs = List.filled(100000, 0);
  List<double> ys = List.filled(100000, 0);
  generatePointsCore(xs, ys);
  return (xs, ys);
}
