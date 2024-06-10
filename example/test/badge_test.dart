import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import 'test_components.dart';

void main() {
  testWidgets('Initializes with correct parameters', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestWidget(
        widget: ZetaLabel(
          label: 'Test Label',
          status: ZetaWidgetStatus.warning,
        ),
      ),
    );

    final zetaBadgeFinder = find.byType(ZetaLabel);
    final ZetaLabel badge = tester.firstWidget(zetaBadgeFinder);

    expect(badge.rounded, true);
    expect(badge.label, 'Test Label');
    expect(badge.status, ZetaWidgetStatus.warning);
  });
}
