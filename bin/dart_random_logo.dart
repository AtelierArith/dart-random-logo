import 'package:dart_random_logo/dart_random_logo.dart';

void main(List<String> arguments) {
  final stopwatch = Stopwatch();
  stopwatch.start();
  final (xs, ys) = generatePoints();
  stopwatch.stop();
  for (int i = 1; i < xs.length; i++) {
    double x = xs[i];
    double y = ys[i];
    print("$x, $y");
  }
  print("time: [ms]");
  print(stopwatch.elapsedMilliseconds); // milli seconds
}
