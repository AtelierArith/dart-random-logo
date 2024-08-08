import 'dart:math';
import 'dart:io';

import 'package:dart_random_logo/dart_random_logo.dart';
import 'package:image/image.dart' as img;

void main(List<String> arguments) {
  final (xs, ys) = generatePoints();

  final H = 386;
  final W = 386;
  //xs を 0 から H のはばで正規化
  // xs の最小値を求めたい
  final xsMin =
      xs.reduce((value, element) => value < element ? value : element);
  final xsMax =
      xs.reduce((value, element) => value > element ? value : element);
  final ysMin =
      ys.reduce((value, element) => value < element ? value : element);
  final ysMax =
      ys.reduce((value, element) => value > element ? value : element);
  final normalizedXs = xs
      .map((e) => (1 + ((W - 1 - 1) / (xsMax - xsMin)) * (e - xsMin)))
      .toList();
  final normalizedYs = ys
      .map((e) => (1 + ((H - 1 - 1) / (ysMax - ysMin)) * (e - ysMin)))
      .toList();
  final image = img.Image(width: W, height: H);

  final red = img.ColorRgb8(
      (0.796 * 255).toInt(), (0.235 * 255).toInt(), (0.2 * 255).toInt());
  final green = img.ColorRgb8(
      (0.22 * 255).toInt(), (0.596 * 255).toInt(), (0.149 * 255).toInt());
  final blue = img.ColorRgb8(
      (0.251 * 255).toInt(), (0.388 * 255).toInt(), (0.847 * 255).toInt());
  final purple = img.ColorRgb8(
      (0.584 * 255).toInt(), (0.345 * 255).toInt(), (0.698 * 255).toInt());

  final colors = [red, green, blue, purple];
  final rng = Random();
  final i = categoricalSample(rng, [0.25, 0.25, 0.25, 0.25]);
  final c = colors[i];
  for (int i = 0; i < xs.length; i++) {
    final x = normalizedXs[i].toInt();
    final y = normalizedYs[i].toInt();
    image.setPixelRgb(
      x,
      y,
      c.r,
      c.g,
      c.b,
    );
  }
  final png = img.encodePng(image);
  File('image.png').writeAsBytes(png);
}
