import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:flutter/material.dart';

void main() {
  group('ZetaStatusLabel Tests', () {
    testWidgets('Initializes with correct properties', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestWidgetStatusLabel(
          widget: ZetaStatusLabel(label: 'Test Label'),
        ),
      );
      expect(find.text('Test Label'), findsOneWidget);
    });
  });

  testWidgets('Initializes with correct label and custom icon', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestWidgetStatusLabel(
        widget: ZetaStatusLabel(
          label: 'Custom Icon',
          isDefaultIcon: false,
          customIcon: Icons.person,
        ),
      ),
    );
    expect(find.text('Custom Icon'), findsOneWidget);
    expect(find.byIcon(Icons.person), findsOneWidget);
  });
}

class TestWidgetStatusLabel extends StatelessWidget {
  final Widget widget;

  const TestWidgetStatusLabel({Key? key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return ZetaProvider(
      builder: (context, theme, __) {
        return Builder(builder: (context) {
          return MaterialApp(
            theme: ThemeData(
              fontFamily: theme.fontFamily,
              textTheme: zetaTextTheme,
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
