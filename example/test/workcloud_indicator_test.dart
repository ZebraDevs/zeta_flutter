import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import 'test_components.dart';

void main() {
  testWidgets('ZetaWorkcloud creates priority pill', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestWidget(
        widget: ZetaWorkcloudIndicator(index: '1'),
      ),
    );
    expect(find.text('1'), findsOneWidget);
  });
}
