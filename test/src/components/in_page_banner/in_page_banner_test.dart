import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_app.dart';
import '../../../test_utils/tolerant_comparator.dart';
import '../../../test_utils/utils.dart';

void main() {
  const String parentFolder = 'in_page_banner';

  const goldenFile = GoldenFiles(component: parentFolder);
  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });

  group('Accessibility Tests', () {});
  group('Content Tests', () {
    final debugFillProperties = {
      'onClose': 'null',
      'status': 'info',
      'title': 'null',
      'customIcon': 'null',
    };
    debugFillPropertiesTest(
      const ZetaInPageBanner(content: Placeholder()),
      debugFillProperties,
    );

    testWidgets('renders correct icon and text', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaInPageBanner(content: Text('Test'), title: 'Title'),
        ),
      );
      expect(find.byType(ZetaInPageBanner), findsOneWidget);
      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets("ZetaInPageBanner shows 'close icon' correctly", (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(home: ZetaInPageBanner(content: const Text('Test'), onClose: () {}, status: ZetaWidgetStatus.negative)),
      );

      expect(find.byIcon(ZetaIcons.close_round), findsOneWidget);
    });

    testWidgets("ZetaInPageBanner hides 'close icon' correctly", (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(home: ZetaInPageBanner(content: Text('Test'), status: ZetaWidgetStatus.positive)),
      );
      expect(find.byIcon(ZetaIcons.close_round), findsNothing);
    });
  });
  group('Dimensions Tests', () {});
  group('Styling Tests', () {
    testWidgets('default background colour is correct', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaInPageBanner(content: Text('Test'), title: 'Title'),
        ),
      );
      final Finder decoratedBoxFinder = find.byType(DecoratedBox);
      final DecoratedBox box = tester.firstWidget(decoratedBoxFinder);

      expect(box.decoration.runtimeType, BoxDecoration);
      final BoxDecoration decoration = box.decoration as BoxDecoration;
      expect(decoration.color, const ZetaPrimitivesLight().purple.shade10);
    });

    testWidgets('negative background colour is correct', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(home: ZetaInPageBanner(content: const Text('Test'), onClose: () {}, status: ZetaWidgetStatus.negative)),
      );

      final Finder decoratedBoxFinder = find.byType(DecoratedBox);
      final DecoratedBox box = tester.firstWidget(decoratedBoxFinder);
      expect(box.decoration.runtimeType, BoxDecoration);
      final BoxDecoration decoration = box.decoration as BoxDecoration;
      expect(decoration.color, const ZetaPrimitivesLight().red.shade10);
    });

    testWidgets('positive background colour is correct', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(home: ZetaInPageBanner(content: Text('Test'), status: ZetaWidgetStatus.positive)),
      );

      final Finder decoratedBoxFinder = find.byType(DecoratedBox);
      final DecoratedBox box = tester.firstWidget(decoratedBoxFinder);
      expect(box.decoration.runtimeType, BoxDecoration);
      final BoxDecoration decoration = box.decoration as BoxDecoration;
      expect(decoration.color, const ZetaPrimitivesLight().green.shade10);
    });

    testWidgets('neutral background colour is correct', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(home: ZetaInPageBanner(content: Text('Test'), status: ZetaWidgetStatus.neutral)),
      );

      final Finder decoratedBoxFinder = find.byType(DecoratedBox);
      final DecoratedBox box = tester.firstWidget(decoratedBoxFinder);
      expect(box.decoration.runtimeType, BoxDecoration);
      final BoxDecoration decoration = box.decoration as BoxDecoration;
      expect(decoration.color, const ZetaPrimitivesLight().pure.shade0);
    });
  });
  group('Interaction Tests', () {
    testWidgets('button callback works', (WidgetTester tester) async {
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

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();
      expect(onPressed, isTrue);
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
  });

  group('Golden Tests', () {
    goldenTest(
      goldenFile,
      const ZetaInPageBanner(content: Text('Test'), title: 'Title'),
      'in_page_banner_default',
    );
    goldenTest(
      goldenFile,
      ZetaInPageBanner(content: const Text('Test'), onClose: () {}, status: ZetaWidgetStatus.negative),
      'in_page_banner_negative',
    );
    goldenTest(
      goldenFile,
      const ZetaInPageBanner(content: Text('Test'), status: ZetaWidgetStatus.positive),
      'in_page_banner_positive',
    );
    goldenTest(
      goldenFile,
      ZetaInPageBanner(
        content: const Text('Test'),
        status: ZetaWidgetStatus.neutral,
        actions: [
          ZetaButton(
            label: 'Test button',
            onPressed: () {},
          ),
        ],
      ),
      'in_page_banner_buttons',
    );
  });
  group('Performance Tests', () {});
}
