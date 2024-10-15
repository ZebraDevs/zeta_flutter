import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_app.dart';
import '../../../test_utils/tolerant_comparator.dart';
import '../../../test_utils/utils.dart';

void main() {
  const goldenFile = GoldenFiles(component: 'dialpad');

  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });

  group('ZetaDialPad Tests', () {
    testWidgets('Initializes with correct parameters and is enabled', (WidgetTester tester) async {
      String number = '';
      String text = '';

      Future<void> debounceWait() => tester.binding.delayed(const Duration(milliseconds: 500));

      await tester.pumpWidget(
        TestApp(
          screenSize: const Size(1000, 1000),
          home: ZetaDialPad(
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

      await expectLater(
        dialPadFinder,
        matchesGoldenFile(goldenFile.getFileUri('dialpad_enabled')),
      );
    });
  });
  testWidgets('Initializes with correct parameters and is disabled', (WidgetTester tester) async {
    const String number = '';
    const String text = '';

    Future<void> debounceWait() => tester.binding.delayed(const Duration(milliseconds: 500));

    await tester.pumpWidget(
      const TestApp(
        screenSize: Size(1000, 1000),
        home: ZetaDialPad(),
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
    expect(number, '');

    /// Tap button with number and text.
    await tester.tap(twoFinder);
    await tester.pump();
    await debounceWait();
    expect(number, '');
    expect(text, '');

    /// Tap different button.
    await tester.tap(threeFinder);
    await tester.pump();
    await debounceWait();
    expect(number, '');
    expect(text, '');

    /// Tap text button twice.
    await tester.tap(twoFinder);
    await tester.tap(twoFinder);
    await tester.pump();
    await debounceWait();
    expect(text, '');

    /// Tap text button thrice.
    await tester.tap(twoFinder);
    await tester.tap(twoFinder);
    await tester.tap(twoFinder);
    await tester.pump();
    await debounceWait();
    expect(text, '');

    /// Tap different text buttons to ensure debounce is cancelled.
    await tester.tap(twoFinder);
    await tester.tap(threeFinder);
    await tester.tap(twoFinder);
    await tester.pump();
    await debounceWait();
    expect(text, '');

    /// Tap text button more times than there is options to ensure it loops around correctly.
    await tester.tap(threeFinder);
    await tester.tap(threeFinder);
    await tester.tap(threeFinder);
    await tester.tap(threeFinder);
    await tester.tap(threeFinder);
    await tester.tap(threeFinder);
    await tester.tap(oneFinder);
    await tester.pump();
    expect(text, '');

    /// Tap buttons with symbols
    await tester.ensureVisible(starFinder);
    await tester.tap(starFinder);
    await tester.tap(hashFinder);
    await tester.pump();
    expect(number, '');

    /// Allow all timers to end in text debounce
    await debounceWait();

    await expectLater(
      dialPadFinder,
      matchesGoldenFile(goldenFile.getFileUri('dialpad_disabled')),
    );
  });
  testWidgets('ZetaDialPadButton interaction', (WidgetTester tester) async {
    await tester.pumpWidget(
      const TestApp(
        screenSize: Size(1000, 1000),
        home: ZetaDialPadButton(primary: '1'),
      ),
    );
    final buttonFinder = find.byType(ZetaDialPadButton);
    final inkwellFinder = find.byType(InkWell);
    final InkWell inkWell = tester.firstWidget(inkwellFinder);

    final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await gesture.addPointer(location: Offset.zero);
    await tester.pump();
    await gesture.moveTo(tester.getCenter(buttonFinder));
    await tester.pumpAndSettle();

    expect(inkWell.overlayColor?.resolve({WidgetState.hovered}), const ZetaPrimitivesLight().cool.shade20);

    await expectLater(
      buttonFinder,
      matchesGoldenFile(goldenFile.getFileUri('dialpadbutton')),
    );
  });

  testWidgets('debugFillProperties works correctly', (WidgetTester tester) async {
    final diagnostics = DiagnosticPropertiesBuilder();
    const ZetaDialPad().debugFillProperties(diagnostics);

    expect(diagnostics.finder('onNumber'), 'null');
    expect(diagnostics.finder('onText'), 'null');
    expect(diagnostics.finder('buttonsPerRow'), '3');
    expect(
      diagnostics.finder('buttonValues'),
      '{1: , 2: ABC, 3: DEF, 4: GHI, 5: JKL, 6: MNO, 7: PQRS, 8: TUV, 9: WXYZ, *: , 0: +, #: }',
    );

    final internalDiagnostics = DiagnosticPropertiesBuilder();
    const ZetaDialPadButton(primary: '1').debugFillProperties(internalDiagnostics);
    expect(internalDiagnostics.finder('primary'), '"1"');
    expect(internalDiagnostics.finder('secondary'), '""');
    expect(internalDiagnostics.finder('onTap'), 'null');
    expect(internalDiagnostics.finder('topPadding'), '3.0');
  });
}
