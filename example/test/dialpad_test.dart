import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import 'test_components.dart';

void main() {
  group('ZetaDialPad Tests', () {
    testWidgets('Initializes with correct parameters', (WidgetTester tester) async {
      String number = '', text = '';

      Future<void> debounceWait() => tester.binding.delayed(const Duration(milliseconds: 500));

      await tester.pumpWidget(
        TestWidget(
          screenSize: Size(1000, 1000),
          widget: ZetaDialPad(
            onNumber: (value) => number += value,
            onText: (value) => text += value,
          ),
        ),
      );
      final dialPadFinder = find.byType(ZetaDialPad);
      final buttonFinder = find.byType(ZetaDialPadButton);

      final oneFinder = find.byWidgetPredicate((widget) => widget is ZetaDialPadButton && widget.primary == '1');
      final twoFinder = find.byWidgetPredicate((widget) => widget is ZetaDialPadButton && widget.primary == '2');
      final threeFinder = find.byWidgetPredicate((widget) => widget is ZetaDialPadButton && widget.primary == '3');
      final starFinder = find.byWidgetPredicate((widget) => widget is ZetaDialPadButton && widget.primary == '*');
      final hashFinder = find.byWidgetPredicate((widget) => widget is ZetaDialPadButton && widget.primary == '#');

      final ZetaDialPad dialPad = tester.firstWidget(dialPadFinder);
      final List<Widget> dialPadButtons = tester.widgetList(buttonFinder).toList();

      final ZetaDialPadButton one = tester.firstWidget(oneFinder);
      final ZetaDialPadButton two = tester.firstWidget(twoFinder);
      final ZetaDialPadButton three = tester.firstWidget(threeFinder);

      /// Dial Pad built correctly.
      expect(dialPad.buttonsPerRow, 3);
      expect(dialPadButtons.length, 12);

      /// Dial Pad buttons built correctly.
      expect(one.primary, '1');
      expect(one.secondary, '');
      expect(two.primary, '2');
      expect(two.secondary, 'ABC');
      expect(three.primary, '3');
      expect(three.secondary, 'DEF');

      /// Tap button with only number.
      await tester.tap(oneFinder);
      await tester.pump();
      expect(number, '1');

      /// Tap button with number and text.
      await tester.tap(twoFinder);
      await tester.pump();
      await debounceWait();
      expect(number, '12');
      expect(text, 'A');

      /// Tap different button.
      await tester.tap(threeFinder);
      await tester.pump();
      await debounceWait();
      expect(number, '123');
      expect(text, 'AD');

      /// Tap text button twice.
      await tester.tap(twoFinder);
      await tester.tap(twoFinder);
      await tester.pump();
      await debounceWait();
      expect(text, 'ADB');

      /// Tap text button thrice.
      await tester.tap(twoFinder);
      await tester.tap(twoFinder);
      await tester.tap(twoFinder);
      await tester.pump();
      await debounceWait();
      expect(text, 'ADBC');

      /// Tap different text buttons to ensure debounce is cancelled.
      await tester.tap(twoFinder);
      await tester.tap(threeFinder);
      await tester.tap(twoFinder);
      await tester.pump();
      await debounceWait();
      expect(text, 'ADBCADA');

      /// Tap text button more times than there is options to ensure it loops around correctly.
      await tester.tap(threeFinder);
      await tester.tap(threeFinder);
      await tester.tap(threeFinder);
      await tester.tap(threeFinder);
      await tester.tap(threeFinder);
      await tester.tap(threeFinder);
      await tester.tap(oneFinder);
      await tester.pump();
      expect(text, 'ADBCADAF');
      number = '';

      /// Tap buttons with symbols
      await tester.ensureVisible(starFinder);
      await tester.tap(starFinder);
      await tester.tap(hashFinder);
      await tester.pump();
      expect(number, '*#');

      /// Allow all timers to end in text debounce
      await debounceWait();
    });
  });
}
