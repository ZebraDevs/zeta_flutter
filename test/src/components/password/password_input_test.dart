import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_app.dart';
import '../../../test_utils/tolerant_comparator.dart';
import '../../../test_utils/utils.dart';

void main() {
  setUpAll(() {
    final testUri = Uri.parse(getCurrentPath('password'));
    goldenFileComparator = TolerantComparator(testUri, tolerance: 0.01);
  });

  testWidgets('ZetaPasswordInput initializes correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestApp(
        home: ZetaPasswordInput(),
      ),
    );
    expect(find.byType(ZetaPasswordInput), findsOneWidget);

    await expectLater(
      find.byType(ZetaPasswordInput),
      matchesGoldenFile(join(getCurrentPath('password'), 'password_default.png')),
    );
  });

  testWidgets('Test password visibility', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestApp(
        home: ZetaPasswordInput(),
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

    final controller = TextEditingController()..text = 'password123';
    final formKey = GlobalKey<FormState>();

    await tester.pumpWidget(
      TestApp(
        home: Form(
          key: formKey,
          child: ZetaPasswordInput(
            controller: controller,
            validator: testValidator,
            rounded: false,
          ),
        ),
      ),
    );
    formKey.currentState?.validate();
    await tester.pump();

    // There will be two matches for the error text as the form field itself contains a hidden one.
    expect(find.text('Error'), findsExactly(2));
    final obscureIconOn = find.byIcon(ZetaIcons.visibility_off_sharp);
    expect(obscureIconOn, findsOneWidget);

    await expectLater(
      find.byType(ZetaPasswordInput),
      matchesGoldenFile(join(getCurrentPath('password'), 'password_error.png')),
    );
  });

  testWidgets('debugFillProperties works correctly', (WidgetTester tester) async {
    final diagnostics = DiagnosticPropertiesBuilder();
    ZetaPasswordInput().debugFillProperties(diagnostics);

    expect(diagnostics.finder('controller'), 'null');
    expect(diagnostics.finder('obscureText'), 'true');
    expect(diagnostics.finder('hintText'), 'null');
    expect(diagnostics.finder('label'), 'null');
    expect(diagnostics.finder('footerText'), 'null');
    expect(diagnostics.finder('validator'), 'null');
    expect(diagnostics.finder('size'), 'large');
    expect(diagnostics.finder('placeholder'), 'null');
    expect(diagnostics.finder('onSubmit'), 'null');
    expect(diagnostics.finder('errorText'), 'null');
  });
}
