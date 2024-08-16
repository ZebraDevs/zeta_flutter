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
    final testUri = Uri.parse(getCurrentPath('in_page_banner'));
    goldenFileComparator = TolerantComparator(testUri, tolerance: 0.01);
  });

  group('ZetaInPageBanner Tests', () {
    testWidgets('ZetaInPageBanner creation', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaInPageBanner(content: Text('Test'), title: 'Title'),
        ),
      );
      final Finder decoratedBoxFinder = find.byType(DecoratedBox);
      final DecoratedBox box = tester.firstWidget(decoratedBoxFinder);

      expect(find.byType(ZetaInPageBanner), findsOneWidget);
      expect(find.text('Test'), findsOneWidget);

      expect(box.decoration.runtimeType, BoxDecoration);
      final BoxDecoration decoration = box.decoration as BoxDecoration;
      expect(decoration.color, ZetaLightPrimitive().purple.shade10);

      await expectLater(
        find.byType(ZetaInPageBanner),
        matchesGoldenFile(join(getCurrentPath('in_page_banner'), 'in_page_banner_default.png')),
      );
    });
  });

  testWidgets("ZetaInPageBanner shows 'close icon' correctly", (WidgetTester tester) async {
    await tester.pumpWidget(
      TestApp(home: ZetaInPageBanner(content: const Text('Test'), onClose: () {}, status: ZetaWidgetStatus.negative)),
    );

    expect(find.byIcon(ZetaIcons.close_round), findsOneWidget);
    final Finder decoratedBoxFinder = find.byType(DecoratedBox);
    final DecoratedBox box = tester.firstWidget(decoratedBoxFinder);
    expect(box.decoration.runtimeType, BoxDecoration);
    final BoxDecoration decoration = box.decoration as BoxDecoration;
    expect(decoration.color, ZetaLightPrimitive().red.shade10);
    await expectLater(
      find.byType(ZetaInPageBanner),
      matchesGoldenFile(join(getCurrentPath('in_page_banner'), 'in_page_banner_negative.png')),
    );
  });

  testWidgets("ZetaInPageBanner hides 'close icon' correctly", (WidgetTester tester) async {
    await tester.pumpWidget(
      const TestApp(home: ZetaInPageBanner(content: Text('Test'), status: ZetaWidgetStatus.positive)),
    );
    expect(find.byIcon(ZetaIcons.close_round), findsNothing);
    final Finder decoratedBoxFinder = find.byType(DecoratedBox);
    final DecoratedBox box = tester.firstWidget(decoratedBoxFinder);
    expect(box.decoration.runtimeType, BoxDecoration);
    final BoxDecoration decoration = box.decoration as BoxDecoration;
    expect(decoration.color, ZetaLightPrimitive().green.shade10);
    await expectLater(
      find.byType(ZetaInPageBanner),
      matchesGoldenFile(join(getCurrentPath('in_page_banner'), 'in_page_banner_positive.png')),
    );
  });

  testWidgets('ZetaInPageBanner button callbacks work', (WidgetTester tester) async {
    bool onPressed = false;
    final key = GlobalKey();
    await tester.pumpWidget(
      TestApp(
        home: ZetaInPageBanner(
          content: const Text('Test'),
          status: ZetaWidgetStatus.neutral,
          actions: [
            ZetaButton(
              label: 'Test button',
              onPressed: () => onPressed = true,
              key: key,
            ),
          ],
        ),
      ),
    );

    final Finder decoratedBoxFinder = find.byType(DecoratedBox);
    final DecoratedBox box = tester.firstWidget(decoratedBoxFinder);
    expect(box.decoration.runtimeType, BoxDecoration);
    final BoxDecoration decoration = box.decoration as BoxDecoration;
    expect(decoration.color, ZetaLightPrimitive().pure.shade0);

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();
    expect(onPressed, isTrue);

    await expectLater(
      find.byType(ZetaInPageBanner),
      matchesGoldenFile(join(getCurrentPath('in_page_banner'), 'in_page_banner_buttons.png')),
    );
  });
  testWidgets("ZetaInPageBanner 'close' icon tap test", (WidgetTester tester) async {
    bool closeIconIsTapped = false;
    await tester.pumpWidget(
      TestApp(home: ZetaInPageBanner(onClose: () => closeIconIsTapped = true, content: const Text('Test'))),
    );
    final closeIcon = find.byIcon(ZetaIcons.close_round);
    await tester.tap(closeIcon);
    await tester.pump();
    expect(closeIconIsTapped, isTrue);
  });
  testWidgets('debugFillProperties works correctly', (WidgetTester tester) async {
    final diagnostics = DiagnosticPropertiesBuilder();
    const ZetaInPageBanner(content: Placeholder()).debugFillProperties(diagnostics);

    expect(diagnostics.finder('onClose'), 'null');
    expect(diagnostics.finder('status'), 'info');
    expect(diagnostics.finder('title'), 'null');
    expect(diagnostics.finder('customIcon'), 'null');
  });
}
