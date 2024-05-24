import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

void main() {
  testWidgets('Dark mode value', (tester) async {
    final ZetaColors light = ZetaColors();
    final ZetaColors dark = ZetaColors(brightness: Brightness.dark);

    expect(light.primary.shade10, dark.primary.shade100);
    expect(light.primary.shade20, dark.primary.shade90);
    expect(light.primary.shade30, dark.primary.shade80);
    expect(light.primary.shade40, dark.primary.shade70);
    expect(light.primary.shade50, dark.primary.shade60);
  });

  testWidgets('AAA mode value', (tester) async {
    final ZetaColors aa = ZetaColors();
    final ZetaColors aaa = ZetaColors(brightness: Brightness.dark, contrast: ZetaContrast.aaa);

    expect(aa.primary.value, aa.primary.shade60.value);
    expect(aaa.primary.value, aaa.primary.shade80.value);
  });

  testWidgets('Scheme generator', (tester) async {
    final blueSwatch = ZetaColorSwatch.fromColor(ZetaColorBase.blue);
    final greySwatch = ZetaColorSwatch.fromColor(ZetaColorBase.cool);
    final blackSwatch = ZetaColorSwatch.fromColor(ZetaColorBase.black);

    expect(blueSwatch.shade10 != blueSwatch.shade20, true);
    expect(blueSwatch.shade20 != blueSwatch.shade30, true);
    expect(blueSwatch.shade30 != blueSwatch.shade40, true);
    expect(blueSwatch.shade40 != blueSwatch.shade50, true);
    expect(blueSwatch.shade50 != blueSwatch.shade60, true);
    expect(blueSwatch.shade60 != blueSwatch.shade70, true);
    expect(blueSwatch.shade70 != blueSwatch.shade80, true);
    expect(blueSwatch.shade80 != blueSwatch.shade90, true);
    expect(blueSwatch.shade90 != blueSwatch.shade100, true);

    expect(greySwatch.shade10 != greySwatch.shade20, true);
    expect(greySwatch.shade20 != greySwatch.shade30, true);
    expect(greySwatch.shade30 != greySwatch.shade40, true);
    expect(greySwatch.shade40 != greySwatch.shade50, true);
    expect(greySwatch.shade50 != greySwatch.shade60, true);
    expect(greySwatch.shade60 != greySwatch.shade70, true);
    expect(greySwatch.shade70 != greySwatch.shade80, true);
    expect(greySwatch.shade80 != greySwatch.shade90, true);
    expect(greySwatch.shade90 != greySwatch.shade100, true);

    expect(blackSwatch.shade10 != blackSwatch.shade20, true);
    expect(blackSwatch.shade20 != blackSwatch.shade30, true);
    expect(blackSwatch.shade30 != blackSwatch.shade40, true);
    expect(blackSwatch.shade40 != blackSwatch.shade50, true);
    expect(blackSwatch.shade50 != blackSwatch.shade60, true);
    expect(blackSwatch.shade60 != blackSwatch.shade70, true);
    expect(blackSwatch.shade70 != blackSwatch.shade80, true);
    expect(blackSwatch.shade80 != blackSwatch.shade90, true);
    expect(blackSwatch.shade90 != blackSwatch.shade100, true);
  });
}
