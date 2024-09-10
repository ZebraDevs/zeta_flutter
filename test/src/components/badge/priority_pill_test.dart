// ignore_for_file: avoid_dynamic_calls
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_app.dart';
import '../../../test_utils/tolerant_comparator.dart';
import '../../../test_utils/utils.dart';

void main() {
  const goldenFile = GoldenFinder(component: 'badge');

  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });
  testWidgets('Initializes with correct label and index', (WidgetTester tester) async {
    await tester.pumpWidget(
      const TestApp(
        home: ZetaPriorityPill(),
      ),
    );

    final zetaPriorityPillFinder = find.byType(ZetaPriorityPill);
    final ZetaPriorityPill zetaPriorityPill = tester.firstWidget(zetaPriorityPillFinder);
    expect(zetaPriorityPill.rounded, null);
    expect(zetaPriorityPill.index, null);
    expect(zetaPriorityPill.isBadge, false);
    expect(zetaPriorityPill.customColor, null);
    expect(zetaPriorityPill.label, null);
    expect(zetaPriorityPill.size, ZetaPriorityPillSize.large);
    expect(zetaPriorityPill.type, ZetaPriorityPillType.urgent);

    expect(find.text('Urgent'), findsOneWidget);
    expect(find.text('U'), findsOneWidget);

    await expectLater(
      find.byType(ZetaPriorityPill),
      matchesGoldenFile(goldenFile.getFileUri('priority_pill_default.png')),
    );
  });
  testWidgets('High priority pill', (WidgetTester tester) async {
    await tester.pumpWidget(
      const TestApp(
        home: ZetaPriorityPill(
          type: ZetaPriorityPillType.high,
          index: '10',
          label: 'test label',
          rounded: false,
          size: ZetaPriorityPillSize.small,
        ),
      ),
    );

    final zetaPriorityPillFinder = find.byType(ZetaPriorityPill);
    final ZetaPriorityPill zetaPriorityPill = tester.firstWidget(zetaPriorityPillFinder);
    expect(zetaPriorityPill.rounded, false);
    expect(zetaPriorityPill.index, '10');
    expect(zetaPriorityPill.isBadge, false);
    expect(zetaPriorityPill.type, ZetaPriorityPillType.high);
    expect(zetaPriorityPill.size, ZetaPriorityPillSize.small);

    expect(find.text('test label'), findsOneWidget);

    await expectLater(
      find.byType(ZetaPriorityPill),
      matchesGoldenFile(goldenFile.getFileUri('priority_pill_high.png')),
    );
  });
  testWidgets('Medium priority pill', (WidgetTester tester) async {
    await tester.pumpWidget(
      const TestApp(
        home: ZetaPriorityPill(
          type: ZetaPriorityPillType.medium,
          isBadge: true,
        ),
      ),
    );

    final zetaPriorityPillFinder = find.byType(ZetaPriorityPill);
    final ZetaPriorityPill zetaPriorityPill = tester.firstWidget(zetaPriorityPillFinder);
    expect(zetaPriorityPill.type, ZetaPriorityPillType.medium);
    expect(zetaPriorityPill.isBadge, true);

    await expectLater(
      find.byType(ZetaPriorityPill),
      matchesGoldenFile(goldenFile.getFileUri('priority_pill_medium.png')),
    );
  });
  testWidgets('Low priority pill', (WidgetTester tester) async {
    await tester.pumpWidget(
      const TestApp(
        home: ZetaPriorityPill(
          type: ZetaPriorityPillType.low,
          size: ZetaPriorityPillSize.small,
          isBadge: true,
        ),
      ),
    );

    final zetaPriorityPillFinder = find.byType(ZetaPriorityPill);
    final ZetaPriorityPill zetaPriorityPill = tester.firstWidget(zetaPriorityPillFinder);
    expect(zetaPriorityPill.type, ZetaPriorityPillType.low);
    expect(zetaPriorityPill.isBadge, true);
    expect(zetaPriorityPill.size, ZetaPriorityPillSize.small);

    await expectLater(
      find.byType(ZetaPriorityPill),
      matchesGoldenFile(goldenFile.getFileUri('priority_pill_low.png')),
    );
  });
  testWidgets('debugFillProperties works correctly', (WidgetTester tester) async {
    final diagnostics = DiagnosticPropertiesBuilder();
    const ZetaPriorityPill(
      label: 'Test label',
      rounded: false,
      customColor: ZetaColorBase.blue,
      index: '1',
    ).debugFillProperties(diagnostics);

    expect(diagnostics.finder('label'), '"Test label"');
    expect(diagnostics.finder('rounded'), 'false');
    expect(diagnostics.finder('isBadge'), 'false');
    expect(diagnostics.finder('index'), '"1"');
    expect(diagnostics.finder('customColor').split('(').first, 'ZetaColorSwatch');
    expect(diagnostics.finder('type'), 'urgent');
    expect(diagnostics.finder('size'), 'large');
  });
}
