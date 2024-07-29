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
  testWidgets('Test debugFillProperties', (WidgetTester tester) async {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();

    await tester.pumpWidget(
      TestApp(
        home: Form(
          key: formKey,
          child: ZetaPasswordInput(
            controller: controller,
            rounded: true,
            hintText: 'Enter password',
            label: 'Password',
            size: ZetaWidgetSize.medium,
            onSubmit: (value) {},
            errorText: 'Invalid password',
            semanticLabel: 'Password input',
            obscureSemanticLabel: 'Show password',
            showSemanticLabel: 'Hide password',
          ),
        ),
      ),
    );

    final zetaPasswordInput = find.byType(ZetaPasswordInput).evaluate().first.widget as ZetaPasswordInput;
    final properties = DiagnosticPropertiesBuilder();

    zetaPasswordInput.debugFillProperties(properties);

    expect(properties.properties.length, 15);
    expect(properties.properties[0].name, 'controller');
    expect(properties.properties[0].value, controller);
    expect(properties.properties[1].name, 'hintText');
    expect(properties.properties[1].value, 'Enter password');
    expect(properties.properties[2].name, 'label');
    expect(properties.properties[2].value, 'Password');
    expect(properties.properties[3].name, 'footerText');
    expect(properties.properties[3].value, null);
    expect(properties.properties[4].name, 'validator');
    expect(properties.properties[4].value, null);
    expect(properties.properties[5].name, 'size');
    expect(properties.properties[5].value, ZetaWidgetSize.medium);
    expect(properties.properties[6].name, 'placeholder');
    expect(properties.properties[6].value, null);
    expect(properties.properties[7].name, 'onSubmit');
    expect(properties.properties[7].value, isA<void Function(String?)>());
    expect(properties.properties[8].name, 'errorText');
    expect(properties.properties[8].value, 'Invalid password');
    expect(properties.properties[9].name, 'semanticLabel');
    expect(properties.properties[9].value, 'Password input');
    expect(properties.properties[10].name, 'showSemanticLabel');
    expect(properties.properties[10].value, 'Hide password');
    expect(properties.properties[11].name, 'obscureSemanticLabel');
    expect(properties.properties[11].value, 'Show password');
  });
}
