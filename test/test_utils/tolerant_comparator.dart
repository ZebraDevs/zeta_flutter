import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

class TolerantComparator extends LocalFileComparator {
  TolerantComparator(super.testFile, {this.tolerance = 0.0});

  final double tolerance;

  @override
  Future<bool> compare(Uint8List imageBytes, Uri golden) async {
    final goldenFile = File.fromUri(golden);
    if (!goldenFile.existsSync()) {
      goldenFile
        ..createSync(recursive: true)
        ..writeAsBytesSync(imageBytes);
      return true;
    }

    final goldenBytes = goldenFile.readAsBytesSync();
    final testImage = img.decodeImage(imageBytes);
    final goldenImage = img.decodeImage(goldenBytes);

    if (testImage == null || goldenImage == null) {
      return false;
    }

    return _compareImages(testImage, goldenImage);
  }

  bool _compareImages(img.Image testImage, img.Image goldenImage) {
    if (testImage.width != goldenImage.width || testImage.height != goldenImage.height) {
      return false;
    }

    int diffPixels = 0;
    for (int y = 0; y < testImage.height; y++) {
      for (int x = 0; x < testImage.width; x++) {
        final testPixel = testImage.getPixel(x, y);
        final goldenPixel = goldenImage.getPixel(x, y);

        if (!_isPixelWithinTolerance(testPixel, goldenPixel)) {
          diffPixels++;
        }
      }
    }

    final diffPercentage = diffPixels / (testImage.width * testImage.height);
    return diffPercentage <= tolerance;
  }

  bool _isPixelWithinTolerance(img.Pixel testPixel, img.Pixel goldenPixel) {
    final tr = testPixel.r;
    final tg = testPixel.g;
    final tb = testPixel.b;

    final gr = goldenPixel.r;
    final gg = goldenPixel.g;
    final gb = goldenPixel.b;

    return (tr - gr).abs() <= 255 * tolerance &&
        (tg - gg).abs() <= 255 * tolerance &&
        (tb - gb).abs() <= 255 * tolerance;
  }
}
