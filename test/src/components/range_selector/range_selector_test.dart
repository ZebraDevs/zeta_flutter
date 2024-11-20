import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

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
    goldenFileComparator = TolerantComparator(goldenFile.uri, tolerance: 0);
  });

  group('Accessibility Tests', () {
    meetsAccessbilityGuidelinesTest(
      ZetaRangeSelector(
        onChange: (value) {},
        initialValues: const RangeValues(20, 80),
        label: 'Range Selector',
      ),
    );
  });

  group('Content Tests', () {
    final debugFillProperties = {
      'label': '"Range Selector"',
      'divisions': 'null',
      'showValues': 'true',
      'rounded': 'null',
      'min': '0.0',
      'max': '100.0',
      'initialValues': 'RangeValues(20.0, 80.0)',
    };
    debugFillPropertiesTest(
      ZetaRangeSelector(
        label: 'Range Selector',
        initialValues: const RangeValues(20, 80),
        onChange: (value) {},
      ),
      debugFillProperties,
    );

    testWidgets('has the correct default values', (tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaRangeSelector(
            onChange: (value) {},
            initialValues: const RangeValues(20, 80),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final slider = find.byType(RangeSlider);
      final sliderWidget = tester.widget<RangeSlider>(slider);

      final zetaSelector = find.byType(ZetaRangeSelector);
      final zetaSelectorWidget = tester.widget<ZetaRangeSelector>(zetaSelector);

      final semantics = find.byType(Semantics).first;
      final semanticsWidget = tester.widget<Semantics>(semantics);

      expect(zetaSelectorWidget.rounded, null);
      expect(sliderWidget.values, const RangeValues(20, 80));
      expect(sliderWidget.min, 0);
      expect(sliderWidget.max, 100);
      expect(zetaSelectorWidget.label, null);
      expect(sliderWidget.divisions, null);
      expect(semanticsWidget.properties.label, null);
      expect(zetaSelectorWidget.showValues, true);
    });

    testWidgets('renders two TextFormFields', (tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaRangeSelector(
            onChange: (value) {},
            initialValues: const RangeValues(20, 80),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(TextFormField), findsNWidgets(2));
    });

    testWidgets('renders one range slider', (tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaRangeSelector(
            onChange: (value) {},
            initialValues: const RangeValues(20, 80),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(RangeSlider), findsOneWidget);
    });

    testWidgets('renders a Text widget with the correct label', (tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaRangeSelector(
            onChange: (value) {},
            initialValues: const RangeValues(20, 80),
            label: 'Range Selector',
          ),
        ),
      );

      await tester.pumpAndSettle();

      final label = find.text('Range Selector');
      expect(label, findsOneWidget);
    });
  });

  group('Dimensions Tests', () {
    testWidgets('TextFormFields have the correct dimenions', (tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaRangeSelector(
            onChange: (value) {},
            initialValues: const RangeValues(20, 80),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final textFields = find.byType(TextFormField);
      expect(textFields, findsNWidgets(2));

      expect(tester.getRect(textFields.first).width, 56);
      expect(tester.getRect(textFields.first).height, 48);

      expect(tester.getRect(textFields.last).width, 56);
      expect(tester.getRect(textFields.last).height, 48);
    });

    // slider has the correct height
    testWidgets('Slider has the correct height', (tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaRangeSelector(
            onChange: (value) {},
            initialValues: const RangeValues(20, 80),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final slider = find.byType(RangeSlider);
      expect(tester.getRect(slider).height, 20);
    });

    testWidgets('Padding between TextFormFields and slider', (tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaRangeSelector(
            onChange: (value) {},
            initialValues: const RangeValues(20, 80),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final textFields = find.byType(TextFormField);
      final slider = find.byType(RangeSlider);

      final textFieldRight = tester.getBottomRight(textFields.first);
      final sliderLeft = tester.getBottomLeft(slider);

      expect(sliderLeft.dx - textFieldRight.dx, 32);
    });
  });

  group('Styling Tests', () {
    testWidgets('Label has the correct font style', (tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaRangeSelector(
            onChange: (value) {},
            initialValues: const RangeValues(20, 80),
            label: 'Range Selector',
          ),
        ),
      );
      final colors = Zeta.of(tester.element(find.byType(ZetaRangeSelector))).colors;

      await tester.pumpAndSettle();

      final label = find.text('Range Selector');
      final labelWidget = tester.widget<Text>(label);

      expect(labelWidget.style!.color, colors.textDefault);
      expect(labelWidget.style!.fontSize, 14);
      expect(labelWidget.style!.fontWeight, FontWeight.w400);
    });

    testWidgets('TextFormField have the correct font style', (tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaRangeSelector(
            onChange: (value) {},
            initialValues: const RangeValues(20, 80),
          ),
        ),
      );
      final colors = Zeta.of(tester.element(find.byType(ZetaRangeSelector))).colors;

      await tester.pumpAndSettle();

      final textFields = find.byType(TextField);
      final firstTextFieldWidget = tester.widget<TextField>(textFields.first);

      expect(firstTextFieldWidget.style!.color, colors.textSubtle);
      expect(firstTextFieldWidget.style!.fontSize, 16);
      expect(firstTextFieldWidget.style!.fontWeight, FontWeight.w400);

      final lastTextFieldWidget = tester.widget<TextField>(textFields.last);

      expect(lastTextFieldWidget.style!.color, colors.textSubtle);
      expect(lastTextFieldWidget.style!.fontSize, 16);
      expect(lastTextFieldWidget.style!.fontWeight, FontWeight.w400);
    });

    testWidgets('TextFormFields have the correct border color and width', (tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaRangeSelector(
            onChange: (value) {},
            initialValues: const RangeValues(20, 80),
          ),
        ),
      );
      final colors = Zeta.of(tester.element(find.byType(ZetaRangeSelector))).colors;

      await tester.pumpAndSettle();

      final textFields = find.byType(TextField);
      final firstTextFieldWidget = tester.widget<TextField>(textFields.first);

      expect(firstTextFieldWidget.decoration!.border!.borderSide.color, colors.borderDefault);
      expect(firstTextFieldWidget.decoration!.border!.borderSide.width, 1);

      final lastTextFieldWidget = tester.widget<TextField>(textFields.last);

      expect(lastTextFieldWidget.decoration!.border!.borderSide.color, colors.borderDefault);
      expect(lastTextFieldWidget.decoration!.border!.borderSide.width, 1);
    });

    // slider has the correct color
    testWidgets('Slider has the correct color', (tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaRangeSelector(
            onChange: (value) {},
            initialValues: const RangeValues(20, 80),
          ),
        ),
      );
      final colors = Zeta.of(tester.element(find.byType(ZetaRangeSelector))).colors;

      final sliderTheme = find.byType(SliderTheme);
      final sliderThemeWidget = tester.widget<SliderTheme>(sliderTheme);

      expect(sliderThemeWidget.data.activeTrackColor, colors.surfaceDefaultInverse);
    });
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
              initialValues: const RangeValues(20, 80),
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

      final sliderTopLeft = tester.getTopLeft(slider);

      await tester.dragFrom(sliderTopLeft.translate(0, 0), const Offset(250, 0));

      await tester.pumpAndSettle();

      await tester.dragFrom(sliderTopLeft.translate(700, 0), const Offset(-250, 0));

      await tester.pumpAndSettle();

      expect(firstValue!.round(), 34);
      expect(secondValue!.round(), 61);
    });

    // input boxes set the value of the slider
    testWidgets('TextFormFields set the value of the slider', (tester) async {
      await tester.pumpWidget(
        TestApp(
          home: Padding(
            padding: const EdgeInsets.all(32),
            child: ZetaRangeSelector(
              label: 'Range Selector',
              initialValues: const RangeValues(20, 80),
              onChange: (value) => ,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final slider = find.byType(ZetaRangeSelector);
      final sliderWidget = tester.widget<ZetaRangeSelector>(slider);

      expect(slider.first., const RangeValues(20, 80));

      final textFields = find.byType(TextField);
      final firstTextField = textFields.first;
      final lastTextField = textFields.last;

      await tester.enterText(firstTextField, '50');

      await tester.tapAt(const Offset(100, 100));
      await tester.enterText(lastTextField, '70');
      await tester.tapAt(const Offset(100, 100));

      await tester.pumpAndSettle();

      expect(sliderWidget.values, const RangeValues(50, 70));
    });

        testWidgets('TextFormFields set the value of the slider', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Padding(
            padding: const EdgeInsets.all(32),
            child: ZetaRangeSelector(
              label: 'Range Selector',
              initialValues: const RangeValues(20, 80),
              onChange: (value) {},
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();


      final sliderFinder = find.byType(ZetaRangeSelector);
      expect(sliderFinder, findsOneWidget);

      final state = tester.;
      expect(state._values, const RangeValues(20, 80));

      final textFields = find.byType(TextField);
      final firstTextField = textFields.first;
      final lastTextField = textFields.last;

      await tester.enterText(firstTextField, '50');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      await tester.enterText(lastTextField, '70');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      expect(state._values, const RangeValues(50, 70));
    });
  });

  group('Golden Tests', () {
    goldenTest(
      goldenFile,
      ZetaRangeSelector(
        onChange: (value) {},
        initialValues: const RangeValues(20, 80),
        showValues: false,
      ),
      'range_slider_rounded_continuous',
    );
    goldenTest(
      goldenFile,
      ZetaRangeSelector(
        onChange: (value) {},
        initialValues: const RangeValues(20, 80),
        showValues: false,
        divisions: 10,
      ),
      'range_slider_rounded_stepped',
    );
    goldenTest(
      goldenFile,
      ZetaRangeSelector(
        initialValues: const RangeValues(20, 80),
        showValues: false,
      ),
      'range_slider_rounded_disabled',
    );

    goldenTest(
      goldenFile,
      ZetaRangeSelector(
        onChange: (value) {},
        initialValues: const RangeValues(20, 80),
        showValues: false,
        rounded: false,
      ),
      'range_slider_sharp_continuous',
    );
    goldenTest(
      goldenFile,
      ZetaRangeSelector(
        onChange: (value) {},
        initialValues: const RangeValues(20, 80),
        showValues: false,
        divisions: 10,
        rounded: false,
      ),
      'range_slider_sharp_stepped',
    );
    goldenTest(
      goldenFile,
      ZetaRangeSelector(
        initialValues: const RangeValues(20, 80),
        showValues: false,
        rounded: false,
      ),
      'range_slider_sharp_disabled',
    );

    goldenTest(
      goldenFile,
      ZetaRangeSelector(
        onChange: (value) {},
        initialValues: const RangeValues(20, 80),
        label: 'Label',
      ),
      'range_selector_rounded_continuous',
    );
    goldenTest(
      goldenFile,
      ZetaRangeSelector(
        onChange: (value) {},
        initialValues: const RangeValues(20, 80),
        label: 'Label',
        divisions: 10,
      ),
      'range_selector_rounded_stepped',
    );
    goldenTest(
      goldenFile,
      ZetaRangeSelector(
        initialValues: const RangeValues(20, 80),
        label: 'Label',
        divisions: 10,
      ),
      'range_selector_rounded_disabled',
    );

    goldenTest(
      goldenFile,
      ZetaRangeSelector(
        onChange: (value) {},
        initialValues: const RangeValues(20, 80),
        label: 'Label',
        rounded: false,
      ),
      'range_selector_sharp_continuous',
    );
    goldenTest(
      goldenFile,
      ZetaRangeSelector(
        onChange: (value) {},
        initialValues: const RangeValues(20, 80),
        label: 'Label',
        rounded: false,
        divisions: 10,
      ),
      'range_selector_sharp_stepped',
    );
    goldenTest(
      goldenFile,
      ZetaRangeSelector(
        initialValues: const RangeValues(20, 80),
        label: 'Label',
        rounded: false,
        divisions: 10,
      ),
      'range_selector_sharp_disabled',
    );
  });

  group('Performance Tests', () {});
}
