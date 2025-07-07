import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_utils.dart';

void main() {
  const String parentFolder = 'card';

  const goldenFile = GoldenFiles(component: parentFolder);
  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });

  group('Golden Tests', () {
    goldenTest(
      goldenFile,
      const ZetaCollapsibleCardContainer(title: 'Title', description: 'Description'),
      'collapsible_card_closed',
    );
    goldenTest(
      goldenFile,
      const ZetaCollapsibleCardContainer(title: 'Title', description: 'Description', isRequired: true),
      'collapsible_card_closed_required',
    );
    goldenTest(
      goldenFile,
      const ZetaCollapsibleCardContainer(title: 'Title', description: 'Description', isAi: true),
      'collapsible_card_closed_ai',
    );
    goldenTest(
      goldenFile,
      const ZetaCollapsibleCardContainer(
        title:
            'Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title',
        description: 'Description',
      ),
      'collapsible_card_long_title',
    );
    goldenTest(
      goldenFile,
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 528),
        child: const ZetaCollapsibleCardContainer(
          title:
              'Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title',
          description: 'Description',
          headerMaxLines: 1,
        ),
      ),
      'collapsible_card_long_title_1_line',
      widgetType: ZetaCollapsibleCardContainer,
    );
    goldenTest(
      goldenFile,
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 528),
        child: const ZetaCollapsibleCardContainer(
          title: 'Title',
          description: 'Description Description Description Description Description Description Description',
        ),
      ),
      'collapsible_card_long_description',
      widgetType: ZetaCollapsibleCardContainer,
    );
    goldenTest(
      goldenFile,
      const ZetaCollapsibleCardContainer(
        title: 'Title',
        description: 'Description',
        content: Placeholder(),
        isExpanded: true,
      ),
      'collapsible_card_open_placeholder',
    );
  });

  group('Accessibility Tests', () {
    for (final val in [true, false]) {
      meetsAccessibilityGuidelinesTest(
        ZetaCollapsibleCardContainer(
          title: 'Title',
          description: 'Description',
          isRequired: true,
          isExpanded: val,
        ),
      );
    }
  });

  group('Content Tests', () {
    final debugFillProperties = {
      'rounded': 'null',
    };

    debugFillPropertiesTest(
      const ZetaCollapsibleCardContainer(
        title: 'Title',
        description: 'Description',
      ),
      debugFillProperties,
    );

    testWidgets('renders title and description', (WidgetTester tester) async {
      await loadFonts();
      await tester.pumpWidget(
        const TestApp(
          home: ZetaCollapsibleCardContainer(
            title: 'Title',
            description: 'Description',
          ),
        ),
      );

      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
    });
    testWidgets('defaults to collapsed, hides content', (WidgetTester tester) async {
      await loadFonts();
      await tester.pumpWidget(
        const TestApp(
          home: ZetaCollapsibleCardContainer(
            title: 'Title',
            description: 'Description',
            content: Placeholder(),
          ),
        ),
      );

      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);

      // The Placeholder widget exists in the widget tree but is not rendered (offstage) when collapsed.
      final placeholderFinder = find.byType(Placeholder);
      expect(placeholderFinder, findsOneWidget);
      final RenderBox placeholderBox = tester.renderObject(placeholderFinder);
      expect(placeholderBox.size.height, equals(0));
    });

    testWidgets('isExpanded shows content', (WidgetTester tester) async {
      await loadFonts();
      await tester.pumpWidget(
        const TestApp(
          home: ZetaCollapsibleCardContainer(
            title: 'Title',
            description: 'Description',
            content: Placeholder(),
            isExpanded: true,
          ),
        ),
      );

      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);

      final placeholderFinder = find.byType(Placeholder);
      expect(placeholderFinder, findsOneWidget);
      final RenderBox placeholderBox = tester.renderObject(placeholderFinder);
      expect(placeholderBox.size.height, greaterThan(0));
    });
  });

  group('Dimensions Tests', () {
    testWidgets('sets dimensions correctly', (WidgetTester tester) async {
      await loadFonts();
      await tester.pumpWidget(
        TestApp(
          home: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 528),
            child: const ZetaCollapsibleCardContainer(
              title: 'Title',
              description: 'Description',
              isAi: true,
              content: SizedBox(
                width: 480,
                height: 240,
                child: Placeholder(),
              ),
            ),
          ),
        ),
      );

      final RenderBox renderBox = tester.renderObject(find.byType(ZetaCollapsibleCardContainer));

      expect(renderBox.size.width, equals(528));
      expect(renderBox.size.height, equals(93));
    });
    testWidgets('sets dimensions correctly with content', (WidgetTester tester) async {
      await loadFonts();
      await tester.pumpWidget(
        TestApp(
          home: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 528),
            child: const ZetaCollapsibleCardContainer(
              title: 'Title',
              description: 'Description',
              isAi: true,
              isExpanded: true,
              content: SizedBox(
                width: 480,
                height: 240,
                child: Placeholder(),
              ),
            ),
          ),
        ),
      );

      final RenderBox renderBox = tester.renderObject(find.byType(ZetaCollapsibleCardContainer));

      expect(renderBox.size.width, equals(528));
      expect(renderBox.size.height, equals(349));
    });
  });

  group('Styling Tests', () {
    testWidgets('isRequired adds a red asterisk', (tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaCardContainer(
            title: 'Title',
            description: 'Description',
            isRequired: true,
          ),
        ),
      );

      final Finder asteriskFinder = find.text(' *');
      expect(asteriskFinder, findsOneWidget);
      final Text asterisk = tester.widget<Text>(asteriskFinder);
      expect(asterisk.style?.color, equals(const ZetaPrimitivesLight().red.shade60));
    });

    testWidgets('isAI adds AI border', (tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaCardContainer(
            title: 'Title',
            description: 'Description',
            isAi: true,
          ),
        ),
      );

      final Finder cardFinder = find.byType(ZetaCardContainer);

      final decoratedBoxFinder = find.descendant(
        of: cardFinder,
        matching: find.byWidgetPredicate(
          (widget) =>
              widget is DecoratedBox &&
              widget.decoration is BoxDecoration &&
              (widget.decoration as BoxDecoration).gradient != null,
        ),
      );

      final DecoratedBox decoratedBox = tester.widget<DecoratedBox>(decoratedBoxFinder);
      expect(decoratedBoxFinder, findsOneWidget);

      final BoxDecoration boxDecoration = decoratedBox.decoration as BoxDecoration;
      expect(boxDecoration.gradient, isNotNull);
      expect(boxDecoration.gradient, isA<LinearGradient>());

      final LinearGradient gradient = boxDecoration.gradient! as LinearGradient;
      expect(gradient.colors, containsAllInOrder([const Color(0xFFFF40FC), const Color(0xFF1F6AFF)]));
      expect(gradient.stops, containsAllInOrder([0.23, 1.0]));
    });

    testWidgets('when collapsed, the icon points right', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaCollapsibleCardContainer(
            title: 'Title',
            description: 'Description',
          ),
        ),
      );

      final Finder iconFinder = find.byIcon(ZetaIcons.expand_more);
      expect(iconFinder, findsOneWidget);

      final animatedRotationFinder = find.byType(AnimatedRotation);
      expect(animatedRotationFinder, findsOneWidget);

      final AnimatedRotation animatedRotation = tester.widget<AnimatedRotation>(animatedRotationFinder);
      expect(animatedRotation.turns, equals(-0.25));
    });

    testWidgets('when expanded, the icon points down', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaCollapsibleCardContainer(
            title: 'Title',
            description: 'Description',
            isExpanded: true,
          ),
        ),
      );

      final Finder iconFinder = find.byIcon(ZetaIcons.expand_more);
      expect(iconFinder, findsOneWidget);

      final animatedRotationFinder = find.byType(AnimatedRotation);
      expect(animatedRotationFinder, findsOneWidget);

      final AnimatedRotation animatedRotation = tester.widget<AnimatedRotation>(animatedRotationFinder);
      expect(animatedRotation.turns, equals(0));
    });
  });

  group('Interaction Tests', () {
    testWidgets('tapping the header toggles expansion', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaCollapsibleCardContainer(
            title: 'Title',
            description: 'Description',
            content: Placeholder(),
          ),
        ),
      );

      final Finder inkWell = find.byType(InkWell);
      expect(inkWell, findsOneWidget);

      // Initially, the card is collapsed, so the content is not visible.
      // The Placeholder widget exists in the widget tree but is not rendered (offstage) when collapsed.
      final placeholderFinder = find.byType(Placeholder);
      expect(placeholderFinder, findsOneWidget);
      final RenderBox placeholderBox = tester.renderObject(placeholderFinder);
      expect(placeholderBox.size.height, equals(0));

      // Tap to expand
      await tester.tap(inkWell);
      await tester.pumpAndSettle();

      // The Placeholder widget exists in the widget tree but is not rendered (offstage) when collapsed.
      final RenderBox placeholderBox2 = tester.renderObject(placeholderFinder);
      expect(placeholderBox2.size.height, greaterThan(0));

      // Tap to collapse again
      await tester.tap(inkWell);
      await tester.pumpAndSettle();

      final RenderBox placeholderBox3 = tester.renderObject(placeholderFinder);
      expect(placeholderBox3.size.height, equals(0));
    });
  });

  group('Performance Tests', () {});
}
