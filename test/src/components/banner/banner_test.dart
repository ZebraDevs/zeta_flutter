import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_app.dart';
import '../../../test_utils/utils.dart';

ZetaColorSwatch _backgroundColorFromType(BuildContext context, ZetaBannerStatus type) {
  final zeta = Zeta.of(context);

  switch (type) {
    case ZetaBannerStatus.primary:
      return zeta.colors.primary;
    case ZetaBannerStatus.positive:
      return zeta.colors.surfacePositive;
    case ZetaBannerStatus.warning:
      return zeta.colors.orange;
    case ZetaBannerStatus.negative:
      return zeta.colors.surfaceNegative;
  }
}

void main() {
  group('ZetaBanner Styling Tests', () {
    for (final type in ZetaBannerStatus.values) {
      testWidgets('ZetaBanner title styles are correct for $type', (WidgetTester tester) async {
        await tester.pumpWidget(
          TestApp(
            home: Builder(
              builder: (context) {
                return ZetaBanner(
                  context: context,
                  title: 'Banner Title',
                  type: type,
                );
              },
            ),
          ),
        );
        final Finder textFinder = find.text('Banner Title');
        final Text textWidget = tester.widget(find.byType(Text));
        expect(
          textWidget.style,
          equals(
            ZetaTextStyles.labelLarge.copyWith(
              color: Zeta.of(tester.element(textFinder)).colors.textInverse,
            ),
          ),
        );
      });
    }

    for (final type in ZetaBannerStatus.values) {
      testWidgets('ZetaBanner icon color is correct for $type', (WidgetTester tester) async {
        await tester.pumpWidget(
          TestApp(
            home: Builder(
              builder: (context) {
                return ZetaBanner(
                  context: context,
                  title: 'Banner Title',
                  leadingIcon: Icons.info,
                  type: type,
                );
              },
            ),
          ),
        );
        final Finder iconFinder = find.byIcon(Icons.info);

        // Color
        final Icon iconWidget = tester.widget(iconFinder);
        expect(iconWidget.color, _backgroundColorFromType(tester.element(iconFinder), type).onColor);
      });
    }
  });

  group('ZetaBanner Content Tests', () {
    testWidgets('ZetaBanner title is correct', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: Builder(
            builder: (context) {
              return ZetaBanner(
                context: context,
                title: 'Banner Title',
              );
            },
          ),
        ),
      );
      final Finder textFinder = find.text('Banner Title');
      expect(textFinder, findsOneWidget);
    });

    testWidgets('ZetaBanner icon is correct', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: Builder(
            builder: (context) {
              return ZetaBanner(
                context: context,
                title: 'Banner Title',
                leadingIcon: Icons.info,
              );
            },
          ),
        ),
      );
      final Finder iconFinder = find.byIcon(Icons.info);
      expect(iconFinder, findsOneWidget);

      final Icon iconWidget = tester.widget(iconFinder);
      expect(iconWidget.icon, equals(Icons.info));
    });
  });

  group('ZetaBanner Dimension Tests', () {
    testWidgets('ZetaBanner icon is the correct size', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: Builder(
            builder: (context) {
              return ZetaBanner(
                context: context,
                title: 'Banner Title',
                leadingIcon: Icons.info,
              );
            },
          ),
        ),
      );
      final Finder iconFinder = find.byIcon(Icons.info);

      final Icon iconWidget = tester.widget(iconFinder);

      expect(iconWidget.size, Zeta.of(tester.element(iconFinder)).spacing.xl_2);
    });
  });

  group('ZetaBanner Interaction Tests', () {});

  testWidgets('debugFillProperties works correctly', (WidgetTester tester) async {
    final diagnostics = DiagnosticPropertiesBuilder();
    const ZetaAccordion(
      title: 'Title',
    ).debugFillProperties(diagnostics);

    expect(diagnostics.finder('title'), '"Title"');
    expect(diagnostics.finder('rounded'), 'null');
    expect(diagnostics.finder('contained'), 'false');
    expect(diagnostics.finder('isOpen'), 'false');
  });
}
