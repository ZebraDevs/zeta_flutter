import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_app.dart';

void main() {
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
}
