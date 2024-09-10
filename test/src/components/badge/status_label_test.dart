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
  group('ZetaStatusLabel Tests', () {
    testWidgets('Initializes with correct properties', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaStatusLabel(label: 'Test Label'),
        ),
      );
      expect(find.text('Test Label'), findsOneWidget);

      await expectLater(
        find.byType(ZetaStatusLabel),
        matchesGoldenFile(goldenFile.getFileUri('status_label_default')),
      );
    });
  });

  testWidgets('Initializes with correct label and custom icon', (WidgetTester tester) async {
    await tester.pumpWidget(
      const TestApp(
        home: ZetaStatusLabel(
          label: 'Custom Icon',
          customIcon: Icons.person,
        ),
      ),
    );
    expect(find.text('Custom Icon'), findsOneWidget);
    expect(find.byIcon(Icons.person), findsOneWidget);

    await expectLater(
      find.byType(ZetaStatusLabel),
      matchesGoldenFile(goldenFile.getFileUri('status_label_custom')),
    );
  });
  testWidgets('debugFillProperties works correctly', (WidgetTester tester) async {
    final diagnostics = DiagnosticPropertiesBuilder();
    const ZetaStatusLabel(
      label: 'Test label',
      rounded: false,
      customIcon: Icons.abc,
    ).debugFillProperties(diagnostics);

    expect(diagnostics.finder('label'), '"Test label"');
    expect(diagnostics.finder('rounded'), 'false');
    expect(diagnostics.finder('customIcon'), 'IconData(U+F04B6)');
    expect(diagnostics.finder('status'), 'info');
  });
}
