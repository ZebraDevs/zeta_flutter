import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_app.dart';
import '../../../test_utils/tolerant_comparator.dart';
import '../../../test_utils/utils.dart';

void main() {
  const String parentFolder = 'comms_button';

  const goldenFile = GoldenFiles(component: parentFolder);
  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });

  group('Accessibility Tests', () {
    testWidgets('Button meets accessibility  requirements', (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(
        const TestApp(
          home: ZetaCommsButton(
            label: 'Label',
            semanticLabel: 'Phone',
            icon: ZetaIcons.phone,
            type: ZetaCommsButtonType.positive,
          ),
        ),
      );
      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
      await expectLater(tester, meetsGuideline(textContrastGuideline));

      handle.dispose();
    });

    testWidgets('Button meets accessibility requirements when toggled', (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(
        TestApp(
          home: ZetaCommsButton(
            label: 'Label',
            semanticLabel: 'Phone',
            icon: ZetaIcons.phone,
            type: ZetaCommsButtonType.positive,
            toggledLabel: 'Toggled Label',
            toggledIcon: ZetaIcons.end_call,
            toggledType: ZetaCommsButtonType.negative,
            onToggle: (isToggled) {},
          ),
        ),
      );
      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
      await expectLater(tester, meetsGuideline(textContrastGuideline));

      await tester.tap(find.byType(ZetaCommsButton));
      await tester.pumpAndSettle();

      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
      await expectLater(tester, meetsGuideline(textContrastGuideline));

      handle.dispose();
    });
  });
  group('Content Tests', () {
    final debugFillProperties = {
      'label': '"Label"',
      'onPressed': 'null',
      'onToggle': 'null',
      'toggledIcon': 'null',
      'toggledLabel': 'null',
      'toggleType': null,
      'focusNode': 'null',
      'semanticLabel': 'null',
      'type': 'positive',
      'size': 'medium',
      'icon': 'IconData(U+0E16E)',
    };
    debugFillPropertiesTest(
      const ZetaCommsButton(
        label: 'Label',
        icon: ZetaIcons.phone,
        type: ZetaCommsButtonType.positive,
      ),
      debugFillProperties,
    );

    testWidgets('Initializes with correct label', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaCommsButton(label: 'Label', icon: ZetaIcons.phone, type: ZetaCommsButtonType.positive),
        ),
      );

      expect(find.text('Label'), findsOneWidget);
    });

    testWidgets('Initializes with correct icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaCommsButton(label: 'Label', icon: ZetaIcons.phone, type: ZetaCommsButtonType.positive),
        ),
      );

      expect(find.widgetWithIcon(ZetaCommsButton, ZetaIcons.phone), findsOneWidget);
    });

    testWidgets('Initializes with correct type', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaCommsButton(label: 'Label', icon: ZetaIcons.phone, type: ZetaCommsButtonType.positive),
        ),
      );

      expect(find.byType(ZetaCommsButton), findsOneWidget);
    });

    testWidgets('Changes label, icon, and type when toggled', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaCommsButton(
            label: 'Label',
            icon: ZetaIcons.phone,
            type: ZetaCommsButtonType.positive,
            toggledLabel: 'Toggled Label',
            toggledIcon: ZetaIcons.end_call,
            toggledType: ZetaCommsButtonType.negative,
            onToggle: (isToggled) {},
          ),
        ),
      );

      expect(find.text('Label'), findsOneWidget);
      expect(find.widgetWithIcon(ZetaCommsButton, ZetaIcons.phone), findsOneWidget);
      expect(tester.widget<ZetaCommsButton>(find.byType(ZetaCommsButton)).type, ZetaCommsButtonType.positive);
      var iconButton = tester.widget<IconButton>(find.byType(IconButton));
      final context = tester.element(find.byType(ZetaCommsButton));
      expect(iconButton.style?.backgroundColor?.resolve({}), Zeta.of(context).colors.surfacePositive);

      await tester.tap(find.byType(ZetaCommsButton));
      await tester.pumpAndSettle();

      expect(find.text('Toggled Label'), findsOneWidget);
      expect(find.widgetWithIcon(ZetaCommsButton, ZetaIcons.end_call), findsOneWidget);
      expect(tester.widget<ZetaCommsButton>(find.byType(ZetaCommsButton)).toggledType, ZetaCommsButtonType.negative);
      iconButton = tester.widget<IconButton>(find.byType(IconButton));
      expect(iconButton.style?.backgroundColor?.resolve({}), Zeta.of(context).colors.surfaceNegative);
    });

    testWidgets('Button is not toggleable when onToggle is null', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaCommsButton(
            label: 'Label',
            icon: ZetaIcons.phone,
            type: ZetaCommsButtonType.positive,
            toggledLabel: 'Toggled Label',
            toggledIcon: ZetaIcons.end_call,
            toggledType: ZetaCommsButtonType.negative,
          ),
        ),
      );

      expect(find.text('Label'), findsOneWidget);
      expect(find.widgetWithIcon(ZetaCommsButton, ZetaIcons.phone), findsOneWidget);
      expect(tester.widget<ZetaCommsButton>(find.byType(ZetaCommsButton)).type, ZetaCommsButtonType.positive);
      var iconButton = tester.widget<IconButton>(find.byType(IconButton));
      final context = tester.element(find.byType(ZetaCommsButton));
      expect(iconButton.style?.backgroundColor?.resolve({}), Zeta.of(context).colors.surfacePositive);

      await tester.tap(find.byType(ZetaCommsButton));
      await tester.pumpAndSettle();

      expect(find.text('Label'), findsOneWidget);
      expect(find.widgetWithIcon(ZetaCommsButton, ZetaIcons.phone), findsOneWidget);
      expect(tester.widget<ZetaCommsButton>(find.byType(ZetaCommsButton)).type, ZetaCommsButtonType.positive);
      iconButton = tester.widget<IconButton>(find.byType(IconButton));
      expect(iconButton.style?.backgroundColor?.resolve({}), Zeta.of(context).colors.surfacePositive);
    });

    testWidgets('Button calls onPressed callback when pressed', (WidgetTester tester) async {
      var pressed = false;

      await tester.pumpWidget(
        TestApp(
          home: ZetaCommsButton(
            label: 'Label',
            icon: ZetaIcons.phone,
            type: ZetaCommsButtonType.positive,
            onPressed: () {
              pressed = true;
            },
          ),
        ),
      );

      await tester.tap(find.byType(ZetaCommsButton));
      await tester.pumpAndSettle();

      expect(pressed, isTrue);
    });
  });
  group('Dimensions Tests', () {});
  group('Styling Tests', () {});
  group('Interaction Tests', () {});
  group('Golden Tests', () {
    for (final type in ZetaCommsButtonType.values) {
      goldenTest(
        goldenFile,
        ZetaCommsButton(
          label: 'Label',
          icon: ZetaIcons.phone,
          type: type,
        ),
        'CommsButton_${type.name}',
      );
    }
  });
  group('Performance Tests', () {});
}
