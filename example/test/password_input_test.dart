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
    final obscureIconOff = find.byIcon(ZetaIcons.visibility_off_round);
    expect(obscureIconOff, findsOneWidget);
    await tester.tap(obscureIconOff);
    await tester.pump();

    final obscureIconOn = find.byIcon(ZetaIcons.visibility_round);
    expect(obscureIconOn, findsOneWidget);
  });

  testWidgets('Test error message visibility', (WidgetTester tester) async {
    String? testValidator(String? value) {
      final regExp = RegExp(r'\d');
      if (value != null && regExp.hasMatch(value)) return 'Error';
      return null;
    }

    final controller = TextEditingController();
    controller.text = 'password123';
    final formKey = GlobalKey<FormState>();

    await tester.pumpWidget(
      TestWidget(
        widget: Form(
          key: formKey,
          child: ZetaPasswordInput(
            controller: controller,
            validator: testValidator,
          ),
        ),
      ),
    );
    formKey.currentState?.validate();
    await tester.pump();

    // There will be two matches for the error text as the form field itself contains a hidden one.
    expect(find.text('Error'), findsExactly(2));
  });
}
