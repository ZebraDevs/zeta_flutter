import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';
import '../../../test_utils/test_app.dart';
import '../../../test_utils/tolerant_comparator.dart';
import '../../../test_utils/utils.dart';

void main() {
  const goldenFile = GoldenFiles(component: 'comms_button');

  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });

  group('ZetaCommsButton Tests', () {
    testWidgets('Initializes with correct label', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaCommsButton(label: 'Label', icon: ZetaIcons.phone, type: ZetaCommsButtonType.answer),
        ),
      );

      expect(find.text('Label'), findsOneWidget);

      await expectLater(
        find.byType(ZetaCommsButton),
        matchesGoldenFile(goldenFile.getFileUri('CommsButton_default')),
      );
    });

    testWidgets('Initializes with correct icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaCommsButton(label: 'Label', icon: ZetaIcons.phone, type: ZetaCommsButtonType.answer),
        ),
      );

      expect(find.widgetWithIcon(ZetaCommsButton, ZetaIcons.phone), findsOneWidget);
    });

    testWidgets('Initializes with correct type', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaCommsButton(label: 'Label', icon: ZetaIcons.phone, type: ZetaCommsButtonType.answer),
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
            type: ZetaCommsButtonType.answer,
            toggledLabel: 'Toggled Label',
            toggledIcon: ZetaIcons.end_call,
            toggledType: ZetaCommsButtonType.reject,
            onToggle: () {},
          ),
        ),
      );

      expect(find.text('Label'), findsOneWidget);
      expect(find.widgetWithIcon(ZetaCommsButton, ZetaIcons.phone), findsOneWidget);
      expect(tester.widget<ZetaCommsButton>(find.byType(ZetaCommsButton)).type, ZetaCommsButtonType.answer);
      var iconButton = tester.widget<IconButton>(find.byType(IconButton));
      final context = tester.element(find.byType(ZetaCommsButton));
      expect(iconButton.style?.backgroundColor?.resolve({}), Zeta.of(context).colors.surfacePositive);

      await tester.tap(find.byType(ZetaCommsButton));
      await tester.pumpAndSettle();

      expect(find.text('Toggled Label'), findsOneWidget);
      expect(find.widgetWithIcon(ZetaCommsButton, ZetaIcons.end_call), findsOneWidget);
      expect(tester.widget<ZetaCommsButton>(find.byType(ZetaCommsButton)).toggledType, ZetaCommsButtonType.reject);
      iconButton = tester.widget<IconButton>(find.byType(IconButton));
      expect(iconButton.style?.backgroundColor?.resolve({}), Zeta.of(context).colors.surfaceNegative);
    });

    testWidgets('Button is not toggleable when onToggle is null', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaCommsButton(
            label: 'Label',
            icon: ZetaIcons.phone,
            type: ZetaCommsButtonType.answer,
            toggledLabel: 'Toggled Label',
            toggledIcon: ZetaIcons.end_call,
            toggledType: ZetaCommsButtonType.reject,
          ),
        ),
      );

      expect(find.text('Label'), findsOneWidget);
      expect(find.widgetWithIcon(ZetaCommsButton, ZetaIcons.phone), findsOneWidget);
      expect(tester.widget<ZetaCommsButton>(find.byType(ZetaCommsButton)).type, ZetaCommsButtonType.answer);
      var iconButton = tester.widget<IconButton>(find.byType(IconButton));
      final context = tester.element(find.byType(ZetaCommsButton));
      expect(iconButton.style?.backgroundColor?.resolve({}), Zeta.of(context).colors.surfacePositive);

      await tester.tap(find.byType(ZetaCommsButton));
      await tester.pumpAndSettle();

      expect(find.text('Label'), findsOneWidget);
      expect(find.widgetWithIcon(ZetaCommsButton, ZetaIcons.phone), findsOneWidget);
      expect(tester.widget<ZetaCommsButton>(find.byType(ZetaCommsButton)).type, ZetaCommsButtonType.answer);
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
            type: ZetaCommsButtonType.answer,
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

    testWidgets('debugFillProperties Test', (WidgetTester tester) async {
      final diagnostic = DiagnosticPropertiesBuilder();
      const ZetaCommsButton(
        label: 'Label',
        icon: ZetaIcons.phone,
        type: ZetaCommsButtonType.answer,
      ).debugFillProperties(diagnostic);

      expect(diagnostic.finder('label'), '"Label"');
      expect(diagnostic.finder('onPressed'), 'null');
      expect(diagnostic.finder('onToggle'), 'null');
      expect(diagnostic.finder('toggledIcon'), 'null');
      expect(diagnostic.finder('toggledLabel'), 'null');
      expect(diagnostic.finder('toggleType'), null);
      expect(diagnostic.finder('focusNode'), 'null');
      expect(diagnostic.finder('semanticLabel'), 'null');
      expect(diagnostic.finder('type'), 'answer');
      expect(diagnostic.finder('size'), 'medium');
      expect(diagnostic.finder('icon'), 'IconData(U+0E16B)');
    });

    testWidgets('Button meets accessibility  requirements', (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(
        const TestApp(
          home: ZetaCommsButton(
            label: 'Label',
            semanticLabel: 'Phone',
            icon: ZetaIcons.phone,
            type: ZetaCommsButtonType.answer,
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
            type: ZetaCommsButtonType.answer,
            toggledLabel: 'Toggled Label',
            toggledIcon: ZetaIcons.end_call,
            toggledType: ZetaCommsButtonType.reject,
            onToggle: () {},
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

  group('ZetaCommsButton Golden Tests', () {
    for (final type in ZetaCommsButtonType.values) {
      testWidgets('ZetaCommsButton with type $type', (WidgetTester tester) async {
        await tester.pumpWidget(
          TestApp(
            home: ZetaCommsButton(
              label: 'Label',
              icon: ZetaIcons.phone,
              type: type,
            ),
          ),
        );

        await expectLater(
          find.byType(ZetaCommsButton),
          matchesGoldenFile(goldenFile.getFileUri('CommsButton_${type.name}')),
        );
      });
    }
  });
}
