import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_app.dart';
import '../../../test_utils/tolerant_comparator.dart';
import '../../../test_utils/utils.dart';

void main() {
  const String parentFolder = 'range_selector';

  const goldenFile = GoldenFiles(component: parentFolder);
  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });

  group('Accessibility Tests', () {});

  group('Content Tests', () {
    final debugFillProperties = {
      'label': '"Range Selector"',
      'lowerValue': '20.0',
      'upperValue': '80.0',
      'divisions': 'null',
      'showValues': 'true',
      'rounded': 'null',
      'min': '0.0',
      'max': '100.0',
    };
    debugFillPropertiesTest(
      ZetaRangeSelector(
        label: 'Range Selector',
        lowerValue: 20,
        upperValue: 80,
        onChange: (value) {},
      ),
      debugFillProperties,
    );
  });

  group('Dimensions Tests', () {
    //
  });

  group('Styling Tests', () {
    // has correct default style
  });

  group('Interaction Tests', () {
    testWidgets('onChange callback is called when value is changed', (tester) async {
      double? firstValue;
      double? secondValue;
      await tester.pumpWidget(
        TestApp(
          home: Padding(
            padding: const EdgeInsets.all(32),
            child: ZetaRangeSelector(
              label: 'Range Selector',
              lowerValue: 20,
              upperValue: 80,
              showValues: false,
              onChange: (newValue) {
                secondValue = newValue.end;
                firstValue = newValue.start;
              },
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      final slider = find.byType(RangeSlider);

      final sliderTopLeft = tester.getTopLeft(slider, warnIfMissed: true);

      await tester.dragFrom(sliderTopLeft.translate(0, 0), const Offset(250, 0));

      await tester.pumpAndSettle();

      await tester.dragFrom(sliderTopLeft.translate(700, 0), const Offset(-250, 0));

      await tester.pumpAndSettle();

      expect(firstValue!.round(), 33);
      expect(secondValue!.round(), 62);
    });
  });

  group('Golden Tests', () {
    // goldenTest(goldenFile, widget, 'PNG_FILE_NAME');
  });

  group('Performance Tests', () {});
}
