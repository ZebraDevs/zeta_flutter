import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_app.dart';
import '../../../test_utils/utils.dart';

void main() {
  testWidgets('ZetaBanner title is correct', (WidgetTester tester) async {
    final BuildContext context = tester.element(find.byType(TestApp));
    await tester.pumpWidget(
      TestApp(
        home: ZetaBanner(
          context: context,
          title: 'Banner Title',
        ),
      ),
    );

    expect(find.text('Banner Title'), findsOneWidget);
  });

  testWidgets('debugFillProperties works correctly', (WidgetTester tester) async {
    final diagnostics = DiagnosticPropertiesBuilder();
    const ZetaAccordion(
      title: 'Title',
    ).debugFillProperties(diagnostics);

    expect(diagnostics.finder('title'), '"Title"');
    expect(diagnostics.finder('rounded'), 'null');
    expect(diagnostics.finder('contained'), 'false');
    expect(diagnostics.finder('isOpen'), 'false');
  });
}
