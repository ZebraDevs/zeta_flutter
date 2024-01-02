import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import 'test_components.dart';

void main() {
  testWidgets('ZetaPasswordInput initializes correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestWidget(
        widget: ZetaPasswordInput(),
      ),
    );
    expect(find.byType(ZetaPasswordInput), findsOneWidget);
  });

  testWidgets('Test password visibility', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestWidget(
        widget: ZetaPasswordInput(),
      ),
    );
    final obscureIconOff = find.byIcon(ZetaIcons.visibility_off_sharp);
    expect(obscureIconOff, findsOneWidget);
    await tester.tap(obscureIconOff);
    await tester.pump();

    final obscureIconOn = find.byIcon(ZetaIcons.visibility_sharp);
    expect(obscureIconOn, findsOneWidget);
  });

  testWidgets('Test error message visibility', (WidgetTester tester) async {
    String? testValidator(String? value) {
      final regExp = RegExp(r'\d');
      if (value != null && regExp.hasMatch(value)) return 'Error';
      return null;
    }

    await tester.pumpWidget(
      TestWidget(
        widget: ZetaPasswordInput(
          controller: TextEditingController(),
          validator: testValidator,
        ),
      ),
    );

    final passwordField = find.byType(TextFormField);
    await tester.enterText(passwordField, 'password12');
    await tester.pump();

    expect(find.text('Error'), findsOneWidget);
  });
}
