import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/src/components/stepper_input/stepper_input.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_app.dart';
import '../../../test_utils/tolerant_comparator.dart';
import '../../../test_utils/utils.dart';

void main() {
  const String componentName = 'ZetaStepperInput';
  const String parentFolder = 'stepper_input';

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

    testWidgets('ZetaStepperInput increases value when programatically changed', (WidgetTester tester) async {
      int value = 0;
      StateSetter? setState;
      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState2) {
            setState = setState2;

            return TestApp(
              home: ZetaStepperInput(
                value: value,
                onChange: (newValue) {
                  value = newValue;
                },
              ),
            );
          },
        ),
      );

      final ZetaStepperInputState stepperInputState = tester.state(find.byType(ZetaStepperInput));

      expect(value, stepperInputState.value);

      setState?.call(() {
        value = 1;
      });

      await tester.pump();

      expect(value, stepperInputState.value);
    });
  });

  group('$componentName Dimensions Tests', () {});

  group('$componentName Styling Tests', () {});

  group('$componentName Interaction Tests', () {
    testWidgets('ZetaStepperInput increases value when increment button is pressed', (WidgetTester tester) async {
      int value = 0;
      await tester.pumpWidget(
        TestApp(
          home: ZetaStepperInput(
            value: value,
            onChange: (newValue) {
              value = newValue;
            },
          ),
        ),
      );

      expect(value, 0);

      await tester.tap(find.byIcon(ZetaIcons.add_round));
      await tester.pump();

      expect(value, 1);
    });
  });

  group('$componentName Golden Tests', () {
    // goldenTest(goldenFile, widget, widgetType, 'PNG_FILE_NAME');
  });

  group('$componentName Performance Tests', () {});
}
