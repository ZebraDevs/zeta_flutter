import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  const String parentFolder = 'empty_state';

  const goldenFile = GoldenFiles(component: parentFolder);
  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });

  group('Accessibility Tests', () {
    meetsAccessibilityGuidelinesTest(
      ZetaEmptyState(
        title: 'Title',
        subtitle: 'This is a placeholder description. It explains what this view is for and what to do next.',
        illustration: ZetaIllustrations.serverDisconnect,
        primaryAction: ZetaButton(
          label: 'Button',
          onPressed: () {},
        ),
        secondaryAction: ZetaButton.outlineSubtle(
          label: 'Button',
          onPressed: () {},
        ),
      ),
    );
  });

  group('Content Tests', () {
    final debugFillProperties = {
      'title': '"Title"',
      'subtitle': '"This is a placeholder description. It explains what this view is for and what to do next."',
    };
    debugFillPropertiesTest(
      const ZetaEmptyState(
        title: 'Title',
        subtitle: 'This is a placeholder description. It explains what this view is for and what to do next.',
      ),
      debugFillProperties,
    );
  });

  group('Dimensions Tests', () {
    testWidgets('ZetaEmptyState has expected dimensions', (WidgetTester tester) async {
      await loadFonts();
      await tester.pumpWidget(
        TestApp(
          home: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 375, maxHeight: 1000),
            child: ZetaEmptyState(
              title: 'Title',
              subtitle: 'This is a placeholder description. It explains what this view is for and what to do next.',
              illustration: ZetaIllustrations.serverDisconnect,
              primaryAction: ZetaButton(
                label: 'Button',
                onPressed: () {},
              ),
              secondaryAction: ZetaButton.outlineSubtle(
                label: 'Button',
                onPressed: () {},
              ),
            ),
          ),
        ),
      );
      final size = tester.getSize(find.byType(ZetaEmptyState));

      expect(size.width, 375);
      expect(size.height, 292);
    });
  });

  group('Styling Tests', () {
    testWidgets('ZetaEmptyState has correct default styles', (WidgetTester tester) async {
      await loadFonts();
      await tester.pumpWidget(
        const TestApp(
          home: ZetaEmptyState(
            title: 'Title',
            subtitle: 'This is a placeholder description. It explains what this view is for and what to do next.',
          ),
        ),
      );

      final textFinder = find.text('Title');
      expect(textFinder, findsOneWidget);
      final textWidget = tester.widget<Text>(textFinder);
      expect(textWidget.style?.fontSize, 20.0); // Assuming h4 style is 20.0
    });
    testWidgets('Buttons are shown in the correct order', (WidgetTester tester) async {
      const Key primaryButtonKey = Key('primaryButton');
      const Key secondaryButtonKey = Key('secondaryButton');

      await tester.pumpWidget(
        TestApp(
          home: ZetaEmptyState(
            title: 'Title',
            subtitle: 'This is a placeholder description. It explains what this view is for and what to do next.',
            primaryAction: ZetaButton(
              label: 'Primary Button',
              onPressed: () {},
              key: primaryButtonKey,
            ),
            secondaryAction: ZetaButton.outlineSubtle(
              label: 'Secondary Button',
              onPressed: () {},
              key: secondaryButtonKey,
            ),
          ),
        ),
      );

      // Check that the primary button is on the right of the secondary button
      final primaryButtonRect = tester.getRect(find.byKey(primaryButtonKey));
      final secondaryButtonRect = tester.getRect(find.byKey(secondaryButtonKey));
      expect(primaryButtonRect.left, greaterThan(secondaryButtonRect.left));
    });
  });

  group('Interaction Tests', () {});

  group('Golden Tests', () {
    goldenTest(
      goldenFile,
      const ZetaEmptyState(
        title: 'Title',
        subtitle: 'This is a placeholder description. It explains what this view is for and what to do next.',
      ),
      'empty_text_only',
    );
    goldenTest(
      goldenFile,
      ZetaEmptyState(
        title: 'Title',
        subtitle: 'This is a placeholder description. It explains what this view is for and what to do next.',
        illustration: ZetaIllustrations.serverDisconnect,
      ),
      'empty_illustration_only',
    );
    goldenTest(
      goldenFile,
      ZetaEmptyState(
        title: 'Title',
        subtitle: 'This is a placeholder description. It explains what this view is for and what to do next.',
        primaryAction: ZetaButton.outlineSubtle(
          label: 'Button',
          onPressed: () {},
        ),
      ),
      'empty_1_button_only',
    );
    goldenTest(
      goldenFile,
      ZetaEmptyState(
        title: 'Title',
        subtitle: 'This is a placeholder description. It explains what this view is for and what to do next.',
        primaryAction: ZetaButton.outlineSubtle(
          label: 'Button',
          onPressed: () {},
        ),
        secondaryAction: ZetaButton(
          label: 'Button',
          onPressed: () {},
        ),
      ),
      'empty_2_buttons_only',
    );

    goldenTest(
      goldenFile,
      ZetaEmptyState(
        title: 'Title',
        subtitle: 'This is a placeholder description. It explains what this view is for and what to do next.',
        illustration: ZetaIllustrations.serverDisconnect,
        primaryAction: ZetaButton.outlineSubtle(
          label: 'Button',
          onPressed: () {},
        ),
        secondaryAction: ZetaButton(
          label: 'Button',
          onPressed: () {},
        ),
      ),
      'empty_2_buttons_with_illustration',
    );
  });

  group('Performance Tests', () {});
}
