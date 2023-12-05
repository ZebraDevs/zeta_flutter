import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:flutter/material.dart';

void main() {
  group('ZetaCheckbox Tests', () {
    testWidgets('Initializes with correct parameters',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        TestWidgetCB(
            widget: ZetaCheckbox(
          value: true,
          onChanged: (value) {},
          borderType: BorderType.rounded,
          label: 'Test Checkbox',
          checkboxSize: Size(30, 30),
        )),
      );

      final checkboxFinder = find.byType(ZetaCheckbox);
      final ZetaCheckbox checkbox = tester.firstWidget(checkboxFinder);

      expect(checkbox.value, true);
      expect(checkbox.borderType, BorderType.rounded);
      expect(checkbox.label, 'Test Checkbox');
      expect(checkbox.checkboxSize, Size(30, 30));
    });

    testWidgets('ZetaCheckbox changes state on tap', (WidgetTester tester) async {
      bool? checkboxValue = true;

      await tester.pumpWidget(
        TestWidgetCB(
            widget: ZetaCheckbox(
          value: checkboxValue,
          onChanged: (value) {
            checkboxValue = value;
          },
        )),
      );

      await tester.tap(find.byType(ZetaCheckbox));
      await tester.pump();

      expect(checkboxValue, false);
    });
  });
}

class TestWidgetCB extends StatelessWidget {
  final Widget widget;

  const TestWidgetCB({Key? key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return ZetaProvider(
      builder: (context, theme, __) {
        return Builder(builder: (context) {
          return MaterialApp(
            theme: ThemeData(
              fontFamily: theme.fontFamily,
              textTheme: ZetaText.textTheme,
            ),
            home: Scaffold(
              body: widget,
            ),
          );
        });
      },
    );
  }
}
