import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:zeta_flutter/zeta_flutter.dart';
import '../../../test_utils/test_app.dart';
import '../../../test_utils/tolerant_comparator.dart';
import '../../../test_utils/utils.dart';

void main() {
  setUpAll(() {
    final testUri = Uri.parse(getCurrentPath('badge'));
    goldenFileComparator = TolerantComparator(testUri, tolerance: 0.01);
  });
  testWidgets('Initializes with correct parameters', (WidgetTester tester) async {
    await tester.pumpWidget(const TestApp(home: ZetaLabel(label: 'Test Label')));

    final zetaBadgeFinder = find.byType(ZetaLabel);
    final ZetaLabel label = tester.firstWidget(zetaBadgeFinder);

    expect(label.rounded, null);
    expect(label.label, 'Test Label');
    expect(label.status, ZetaWidgetStatus.info);

    await expectLater(find.byType(ZetaLabel), matchesGoldenFile(join(getCurrentPath('badge'), 'label_default.png')));
  });

  testWidgets('Positive status', (WidgetTester tester) async {
    await tester.pumpWidget(const TestApp(home: ZetaLabel(label: 'Test Label', status: ZetaWidgetStatus.positive)));

    final zetaBadgeFinder = find.byType(ZetaLabel);
    final ZetaLabel label = tester.firstWidget(zetaBadgeFinder);

    expect(label.status, ZetaWidgetStatus.positive);

    await expectLater(find.byType(ZetaLabel), matchesGoldenFile(join(getCurrentPath('badge'), 'label_positive.png')));
  });

  testWidgets('Warning status', (WidgetTester tester) async {
    await tester.pumpWidget(const TestApp(home: ZetaLabel(label: 'Test Label', status: ZetaWidgetStatus.warning)));

    final zetaBadgeFinder = find.byType(ZetaLabel);
    final ZetaLabel label = tester.firstWidget(zetaBadgeFinder);

    expect(label.status, ZetaWidgetStatus.warning);

    await expectLater(find.byType(ZetaLabel), matchesGoldenFile(join(getCurrentPath('badge'), 'label_warning.png')));
  });
  testWidgets('Negative status', (WidgetTester tester) async {
    await tester.pumpWidget(const TestApp(home: ZetaLabel(label: 'Test Label', status: ZetaWidgetStatus.negative)));

    final zetaBadgeFinder = find.byType(ZetaLabel);
    final ZetaLabel label = tester.firstWidget(zetaBadgeFinder);

    expect(label.status, ZetaWidgetStatus.negative);

    await expectLater(find.byType(ZetaLabel), matchesGoldenFile(join(getCurrentPath('badge'), 'label_negative.png')));
  });
  testWidgets('Neutral status', (WidgetTester tester) async {
    await tester.pumpWidget(const TestApp(home: ZetaLabel(label: 'Test Label', status: ZetaWidgetStatus.neutral)));

    final zetaBadgeFinder = find.byType(ZetaLabel);
    final ZetaLabel label = tester.firstWidget(zetaBadgeFinder);

    expect(label.status, ZetaWidgetStatus.neutral);

    await expectLater(find.byType(ZetaLabel), matchesGoldenFile(join(getCurrentPath('badge'), 'label_neutral.png')));
  });

  testWidgets('Dark mode', (WidgetTester tester) async {
    await tester.pumpWidget(
      const TestApp(
        themeMode: ThemeMode.dark,
        home: ZetaLabel(label: 'Test Label'),
      ),
    );

    final zetaBadgeFinder = find.byType(ZetaLabel);
    final ZetaLabel label = tester.firstWidget(zetaBadgeFinder);

    expect(label.status, ZetaWidgetStatus.info);

    await expectLater(find.byType(ZetaLabel), matchesGoldenFile(join(getCurrentPath('badge'), 'label_dark.png')));
  });

  testWidgets('Sharp', (WidgetTester tester) async {
    await tester.pumpWidget(
      const TestApp(home: ZetaLabel(label: 'Test Label', rounded: false)),
    );

    final zetaBadgeFinder = find.byType(ZetaLabel);
    final ZetaLabel label = tester.firstWidget(zetaBadgeFinder);

    expect(label.rounded, false);

    await expectLater(find.byType(ZetaLabel), matchesGoldenFile(join(getCurrentPath('badge'), 'label_sharp.png')));
  });

  testWidgets('debugFillProperties works correctly', (WidgetTester tester) async {
    final diagnostics = DiagnosticPropertiesBuilder();
    const ZetaLabel(
      label: 'Test label',
      rounded: false,
      status: ZetaWidgetStatus.positive,
    ).debugFillProperties(diagnostics);

    expect(diagnostics.finder('label'), '"Test label"');
    expect(diagnostics.finder('status'), 'positive');
    expect(diagnostics.finder('rounded'), 'false');
  });
}
