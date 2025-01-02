import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_app.dart';
import '../../../test_utils/tolerant_comparator.dart';
import '../../../test_utils/utils.dart';

void main() {
  const String parentFolder = 'password';

  const goldenFile = GoldenFiles(component: parentFolder);
  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });

  group('Accessibility Tests', () {});
  group('Content Tests', () {
    final debugFillProperties = {
      'size': 'medium',
      'placeholder': 'null',
      'label': 'null',
      'hintText': 'null',
      'errorText': 'null',
      'semanticLabel': 'null',
      'showSemanticLabel': 'null',
      'obscureSemanticLabel': 'null',
    };
    debugFillPropertiesTest(
      ZetaPasswordInput(),
      debugFillProperties,
    );

    testWidgets('ZetaPasswordInput initializes correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaPasswordInput(),
        ),
      );
      expect(find.byType(ZetaPasswordInput), findsOneWidget);
    });

    testWidgets('obscure icon in rendered correctly', (WidgetTester tester) async {
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
    });
  });
  group('Dimensions Tests', () {});
  group('Styling Tests', () {});
  group('Interaction Tests', () {});
  group('Golden Tests', () {
    goldenTest(goldenFile, ZetaPasswordInput(), 'password_default');
    final formKey = GlobalKey<FormState>();
    goldenTest(
      goldenFile,
      Form(
        key: formKey,
        child: ZetaPasswordInput(
          controller: TextEditingController()..text = 'password123',
          validator: (String? value) {
            final regExp = RegExp(r'\d');
            if (value != null && regExp.hasMatch(value)) return 'Error';
            return null;
          },
          rounded: false,
        ),
      ),
      'password_error',
      beforeComparison: (tester) async {
        formKey.currentState?.validate();
        await tester.pump();
      },
    );
  });
  group('Performance Tests', () {});
}
