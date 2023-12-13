import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import 'test_components.dart';

void main() {
  testWidgets('Initializes with correct parameters', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestWidget(
        widget: ZetaBadge(
          label: 'Test Label',
          severity: WidgetSeverity.warning,
        ),
      ),
    );

    final zetaBadgeFinder = find.byType(ZetaBadge);
    final ZetaBadge badge = tester.firstWidget(zetaBadgeFinder);

    expect(badge.borderType, BorderType.rounded);
    expect(badge.label, 'Test Label');
    expect(badge.severity, WidgetSeverity.warning);
  });
}
