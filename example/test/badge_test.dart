import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import 'test_components.dart';

void main() {
  testWidgets('Initializes with correct parameters', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestWidget(
        widget: ZetaBadge(
          label: 'Test Label',
          status: ZetaWidgetStatus.warning,
        ),
      ),
    );

    final zetaBadgeFinder = find.byType(ZetaBadge);
    final ZetaBadge badge = tester.firstWidget(zetaBadgeFinder);

    expect(badge.rounded, true);
    expect(badge.label, 'Test Label');
    expect(badge.status, ZetaWidgetStatus.warning);
  });
}
