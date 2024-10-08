import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';
import '../../../test_utils/test_app.dart';
import '../../../test_utils/tolerant_comparator.dart';
import '../../../test_utils/utils.dart';

void main() {
  const goldenFile = GoldenFiles(component: 'badge');

  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });
  testWidgets('Initializes with correct parameters', (WidgetTester tester) async {
    await tester.pumpWidget(const TestApp(home: ZetaLabel(label: 'Test Label')));

    final zetaBadgeFinder = find.byType(ZetaLabel);
    final ZetaLabel label = tester.firstWidget(zetaBadgeFinder);

    expect(label.rounded, null);
    expect(label.label, 'Test Label');
    expect(label.status, ZetaWidgetStatus.info);

    await expectLater(find.byType(ZetaLabel), matchesGoldenFile(goldenFile.getFileUri('label_default')));
  });

  testWidgets('Positive status', (WidgetTester tester) async {
    await tester.pumpWidget(const TestApp(home: ZetaLabel(label: 'Test Label', status: ZetaWidgetStatus.positive)));

    final zetaBadgeFinder = find.byType(ZetaLabel);
    final ZetaLabel label = tester.firstWidget(zetaBadgeFinder);

    expect(label.status, ZetaWidgetStatus.positive);

    await expectLater(find.byType(ZetaLabel), matchesGoldenFile(goldenFile.getFileUri('label_positive')));
  });

  testWidgets('Warning status', (WidgetTester tester) async {
    await tester.pumpWidget(const TestApp(home: ZetaLabel(label: 'Test Label', status: ZetaWidgetStatus.warning)));

    final zetaBadgeFinder = find.byType(ZetaLabel);
    final ZetaLabel label = tester.firstWidget(zetaBadgeFinder);

    expect(label.status, ZetaWidgetStatus.warning);

    await expectLater(find.byType(ZetaLabel), matchesGoldenFile(goldenFile.getFileUri('label_warning')));
  });
  testWidgets('Negative status', (WidgetTester tester) async {
    await tester.pumpWidget(const TestApp(home: ZetaLabel(label: 'Test Label', status: ZetaWidgetStatus.negative)));

    final zetaBadgeFinder = find.byType(ZetaLabel);
    final ZetaLabel label = tester.firstWidget(zetaBadgeFinder);

    expect(label.status, ZetaWidgetStatus.negative);

    await expectLater(find.byType(ZetaLabel), matchesGoldenFile(goldenFile.getFileUri('label_negative')));
  });
  testWidgets('Neutral status', (WidgetTester tester) async {
    await tester.pumpWidget(const TestApp(home: ZetaLabel(label: 'Test Label', status: ZetaWidgetStatus.neutral)));

    final zetaBadgeFinder = find.byType(ZetaLabel);
    final ZetaLabel label = tester.firstWidget(zetaBadgeFinder);

    expect(label.status, ZetaWidgetStatus.neutral);

    await expectLater(find.byType(ZetaLabel), matchesGoldenFile(goldenFile.getFileUri('label_neutral')));
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

    await expectLater(find.byType(ZetaLabel), matchesGoldenFile(goldenFile.getFileUri('label_dark')));
  });

  testWidgets('Sharp', (WidgetTester tester) async {
    await tester.pumpWidget(
      const TestApp(home: ZetaLabel(label: 'Test Label', rounded: false)),
    );

    final zetaBadgeFinder = find.byType(ZetaLabel);
    final ZetaLabel label = tester.firstWidget(zetaBadgeFinder);

    expect(label.rounded, false);

    await expectLater(find.byType(ZetaLabel), matchesGoldenFile(goldenFile.getFileUri('label_sharp')));
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
