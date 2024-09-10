import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_app.dart';
import '../../../test_utils/tolerant_comparator.dart';
import '../../../test_utils/utils.dart';

void main() {
  const goldenFile = GoldenFiles(component: 'password');

  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
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
      matchesGoldenFile(goldenFile.getFileUri('password_default')),
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
      matchesGoldenFile(goldenFile.getFileUri('password_error')),
    );
  });
  testWidgets('Test debugFillProperties', (WidgetTester tester) async {
    final diagnostics = DiagnosticPropertiesBuilder();
    ZetaPasswordInput().debugFillProperties(diagnostics);

    expect(diagnostics.finder('size'), 'medium');
    expect(diagnostics.finder('placeholder'), 'null');
    expect(diagnostics.finder('label'), 'null');
    expect(diagnostics.finder('hintText'), 'null');
    expect(diagnostics.finder('errorText'), 'null');
    expect(diagnostics.finder('semanticLabel'), 'null');
    expect(diagnostics.finder('showSemanticLabel'), 'null');
    expect(diagnostics.finder('obscureSemanticLabel'), 'null');
  });
}
