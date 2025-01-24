import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'test_utils.dart';

/// A comparator that compares images with a tolerance.
///
///  Used with [goldenTest] to compare images with a tolerance.
@visibleForTesting
class TolerantComparator extends LocalFileComparator {
  /// Constructs a [TolerantComparator] instance with default tolerance of 0.01.
  TolerantComparator(Uri testFile, {this.tolerance = 0.01}) : super(testFile.replace(scheme: 'file'));

  /// Tolerance used to compare images.
  ///
  /// Defaults to 0.01 but should be changed to ensure no false positives.
  final double tolerance;

  @override
  Future<bool> compare(Uint8List imageBytes, Uri golden) async {
    final goldenFile = File.fromUri(golden.replace(scheme: 'file'));
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
