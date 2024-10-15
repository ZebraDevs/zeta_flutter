import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_app.dart';
import '../../../test_utils/tolerant_comparator.dart';
import '../../../test_utils/utils.dart';

void main() {
  const String componentName = 'ZetaSlider';
  const String parentFolder = 'slider';

  const goldenFile = GoldenFiles(component: parentFolder);
  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });

  group('$componentName Accessibility Tests', () {});

  group('$componentName Content Tests', () {
    // final debugFillProperties = {
    //   '': '',
    // };
    // debugFillPropertiesTest(
    //   widget,
    //   debugFillProperties,
    // );
  });

  group('$componentName Dimensions Tests', () {});

  group('$componentName Styling Tests', () {});

  group('$componentName Interaction Tests', () {
    testWidgets('ZetaSlider min/max values', (WidgetTester tester) async {
      const double sliderValue = 0.5;
      double? changedValue;

      await tester.pumpWidget(
        TestApp(
          home: ZetaSlider(
            value: sliderValue,
            onChange: (value) {
              changedValue = value;
            },
          ),
        ),
      );

      final slider = tester.widget<Slider>(find.byType(Slider));
      expect(slider.min, 0.0);
      expect(slider.max, 1.0);

      // Drag the slider to the minimum value
      await tester.drag(find.byType(Slider), const Offset(-400, 0));
      expect(changedValue, 0.0);

      // Drag the slider to the maximum value
      await tester.drag(find.byType(Slider), const Offset(400, 0));
      expect(changedValue, 1.0);
    });
  });

  group('$componentName Golden Tests', () {
    // goldenTest(goldenFile, widget, widgetType, 'PNG_FILE_NAME');
  });

  group('$componentName Performance Tests', () {});
}
