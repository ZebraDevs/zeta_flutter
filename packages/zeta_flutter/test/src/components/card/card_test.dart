import 'package:flutter/widgets.dart';
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
      const ZetaCard(title: 'Title', description: 'Description'),
      'card',
    );
    goldenTest(
      goldenFile,
      const ZetaCard(title: 'Title', description: 'Description', isRequired: true),
      'card_required',
    );
    goldenTest(
      goldenFile,
      const ZetaCard(title: 'Title', description: 'Description', isAi: true),
      'card_ai',
    );
    goldenTest(
      goldenFile,
      const ZetaCard(title: 'Title', description: 'Description', content: Placeholder()),
      'card_placeholder',
    );
    goldenTest(
      goldenFile,
      const ZetaCard(title: 'Title', description: 'Description', content: Placeholder(), isAi: true),
      'card_placeholder_ai',
    );
    goldenTest(
      goldenFile,
      const ZetaCard(
        title:
            'Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title',
        description: 'Description',
      ),
      'card_long_title',
    );
    goldenTest(
      goldenFile,
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 528),
        child: const ZetaCard(
          title:
              'Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title',
          description: 'Description',
          headerMaxLines: 1,
        ),
      ),
      'card_long_title_1_line',
      widgetType: ZetaCard,
    );
    goldenTest(
      goldenFile,
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 528),
        child: const ZetaCard(
          title: 'Title',
          description: 'Description Description Description Description Description Description Description',
        ),
      ),
      'card_long_description',
      widgetType: ZetaCard,
    );
  });

  group('Accessibility Tests', () {
    meetsAccessibilityGuidelinesTest(
      const ZetaCard(
        title: 'Title',
        description: 'Description',
        isRequired: true,
      ),
    );
  });

  group('Content Tests', () {
    final debugFillProperties = {
      'title': '"Title"',
      'description': '"Description"',
      'rounded': 'null',
      'isAi': 'false',
      'isRequired': 'false',
      'headerMaxLines': null,
    };

    debugFillPropertiesTest(
      const ZetaCard(
        title: 'Title',
        description: 'Description',
      ),
      debugFillProperties,
    );

    testWidgets('renders title and description', (WidgetTester tester) async {
      await loadFonts();
      await tester.pumpWidget(
        const TestApp(
          home: ZetaCard(
            title: 'Title',
            description: 'Description',
          ),
        ),
      );

      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
    });
  });

  group('Dimensions Tests', () {
    testWidgets('sets dimensions correctly', (WidgetTester tester) async {
      await loadFonts();
      await tester.pumpWidget(
        TestApp(
          home: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 528),
            child: const ZetaCard(
              title: 'Title',
              description: 'Description',
              isAi: true,
            ),
          ),
        ),
      );

      final RenderBox renderBox = tester.renderObject(find.byType(ZetaCard));

      expect(renderBox.size.width, equals(528));
      expect(renderBox.size.height, equals(93));
    });
    testWidgets('sets dimensions correctly with content', (WidgetTester tester) async {
      await loadFonts();
      await tester.pumpWidget(
        TestApp(
          home: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 528),
            child: const ZetaCard(
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

      final RenderBox renderBox = tester.renderObject(find.byType(ZetaCard));

      expect(renderBox.size.width, equals(528));
      expect(renderBox.size.height, equals(349));
    });
  });

  group('Styling Tests', () {
    testWidgets('isRequired adds a red asterisk', (tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaCard(
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
          home: ZetaCard(
            title: 'Title',
            description: 'Description',
            isAi: true,
          ),
        ),
      );

      final Finder cardFinder = find.byType(ZetaCard);

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
  });

  group('Interaction Tests', () {});

  group('Performance Tests', () {});
}
