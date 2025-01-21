import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

@GenerateNiceMocks([
  MockSpec<BuildContext>(),
  MockSpec<ZetaColors>(),
  MockSpec<Zeta>(),
])
void main() {
  group('ListDivider extension', () {
    testWidgets('divide adds separator between widgets', (WidgetTester tester) async {
      final widgets = [
        const Text('Widget1'),
        const Text('Widget2'),
        const Text('Widget3'),
      ];

      final dividedWidgets = widgets.divide(const Divider()).toList();

      await tester.pumpWidget(
        Column(
          children: dividedWidgets,
        ),
      );

      expect(find.byType(Text), findsNWidgets(3));
      expect(find.byType(Divider), findsNWidgets(2));
    });

    testWidgets('gap adds SizedBox of fixed width between widgets', (WidgetTester tester) async {
      final widgets = [
        const Text('Widget1'),
        const Text('Widget2'),
        const Text('Widget3'),
      ];

      final gappedWidgets = widgets.gap(10);

      await tester.pumpWidget(
        Column(
          children: gappedWidgets,
        ),
      );

      expect(find.byType(Text), findsNWidgets(3));
      expect(find.byType(SizedBox), findsNWidgets(2));
      expect(tester.widget<SizedBox>(find.byType(SizedBox).first).width, 10.0);
    });
  });

  group('SpacingWidget extension', () {
    testWidgets('paddingAll adds padding to all sides', (WidgetTester tester) async {
      final widget = const Text('Test').paddingAll(10);

      await tester.pumpWidget(
        widget,
      );

      final padding = tester.widget<Padding>(find.byType(Padding)).padding as EdgeInsets;
      expect(padding, const EdgeInsets.all(10));
    });

    testWidgets('paddingStart adds padding to the start', (WidgetTester tester) async {
      final widget = const Text('Test').paddingStart(10);

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: widget,
        ),
      );

      final padding = tester.widget<Padding>(find.byType(Padding)).padding as EdgeInsetsDirectional;
      expect(padding.start, 10.0);
      expect(padding.end, 0.0);
      expect(padding.top, 0.0);
      expect(padding.bottom, 0.0);
    });

    testWidgets('paddingEnd adds padding to the end', (WidgetTester tester) async {
      final widget = const Text('Test').paddingEnd(10);

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: widget,
        ),
      );

      final padding = tester.widget<Padding>(find.byType(Padding)).padding as EdgeInsetsDirectional;
      expect(padding.end, 10.0);
      expect(padding.start, 0.0);
      expect(padding.top, 0.0);
      expect(padding.bottom, 0.0);
    });

    testWidgets('paddingTop adds padding to the top', (WidgetTester tester) async {
      final widget = const Text('Test').paddingTop(10);

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: widget,
        ),
      );

      final padding = tester.widget<Padding>(find.byType(Padding)).padding as EdgeInsets;
      expect(padding.top, 10.0);
      expect(padding.left, 0.0);
      expect(padding.right, 0.0);
      expect(padding.bottom, 0.0);
    });

    testWidgets('paddingBottom adds padding to the bottom', (WidgetTester tester) async {
      final widget = const Text('Test').paddingBottom(10);

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: widget,
        ),
      );

      final padding = tester.widget<Padding>(find.byType(Padding)).padding as EdgeInsets;
      expect(padding.bottom, 10.0);
      expect(padding.left, 0.0);
      expect(padding.right, 0.0);
      expect(padding.top, 0.0);
    });

    testWidgets('paddingVertical adds padding to the top & bottom', (WidgetTester tester) async {
      final widget = const Text('Test').paddingVertical(10);

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: widget,
        ),
      );

      final padding = tester.widget<Padding>(find.byType(Padding)).padding as EdgeInsets;
      expect(padding.bottom, 10.0);
      expect(padding.top, 10.0);
      expect(padding.left, 0.0);
      expect(padding.right, 0.0);
    });

    testWidgets('paddingHorizontal adds padding to the left & right', (WidgetTester tester) async {
      final widget = const Text('Test').paddingHorizontal(10);

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: widget,
        ),
      );

      final padding = tester.widget<Padding>(find.byType(Padding)).padding as EdgeInsets;
      expect(padding.left, 10.0);
      expect(padding.right, 10.0);
      expect(padding.bottom, 0.0);
      expect(padding.top, 0.0);
    });
  });

  group('NumExtensions extension', () {
    test('formatMaxChars formats numbers correctly', () {
      expect(123.formatMaxChars(2), '99+');
      expect(9.formatMaxChars(2), '9');
      expect(null.formatMaxChars(2), '');
    });
  });

  group('StringExtensions extension', () {
    test('initials returns correct initials', () {
      expect('John Doe'.initials, 'JD');
      expect('A B C'.initials, 'AC');
      expect('Single'.initials, 'SI');
      expect('A'.initials, 'A');
      expect('a'.initials, 'A');
      expect(''.initials, '');
      expect(null.initials, '');
    });

    test('capitalize capitalizes first letter', () {
      expect('hello'.capitalize(), 'Hello');
      expect('HELLO'.capitalize(), 'Hello');
      expect('a'.capitalize(), 'A');
      expect(''.capitalize(), '');
      expect(null.capitalize(), '');
    });
  });
}
