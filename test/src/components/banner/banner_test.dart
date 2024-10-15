import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_app.dart';
import '../../../test_utils/tolerant_comparator.dart';
import '../../../test_utils/utils.dart';

ZetaColorSwatch _colorFromType(BuildContext context, ZetaBannerStatus type) {
  final zeta = Zeta.of(context);

  switch (type) {
    case ZetaBannerStatus.primary:
      return zeta.colors.primitives.primary;
    case ZetaBannerStatus.positive:
      return zeta.colors.primitives.green;
    case ZetaBannerStatus.warning:
      return zeta.colors.primitives.orange;
    case ZetaBannerStatus.negative:
      return zeta.colors.primitives.red;
  }
}

void main() {
  const goldenFile = GoldenFiles(component: 'banner');

  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });

  group('ZetaBanner Accessibility Tests', () {
    for (final type in ZetaBannerStatus.values) {
      testWidgets('meets contrast ratio guideline for $type', (WidgetTester tester) async {
        await tester.pumpWidget(
          TestApp(
            home: Builder(
              builder: (context) {
                return ZetaBanner(
                  context: context,
                  title: 'Banner Title',
                  leadingIcon: Icons.info,
                  trailing: const ZetaIconButton(icon: Icons.close),
                  type: type,
                );
              },
            ),
          ),
        );

        await expectLater(tester, meetsGuideline(textContrastGuideline));
      });
    }

    testWidgets('semantic label works correctly', (WidgetTester tester) async {
      String semanticLabelText = 'Banner Title';
      StateSetter? setState;

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState2) {
            setState = setState2;
            return TestApp(
              home: Builder(
                builder: (context) {
                  return ZetaBanner(
                    context: context,
                    title: 'Banner Title',
                    semanticLabel: semanticLabelText,
                  );
                },
              ),
            );
          },
        ),
      );

      final Semantics titleSematicLabel = tester.widgetList<Semantics>(find.byType(Semantics)).last;
      expect(titleSematicLabel.properties.label, equals('Banner Title'));

      setState?.call(() => semanticLabelText = '');
      await tester.pumpAndSettle();

      final Semantics titleSematicLabel2 = tester.widgetList<Semantics>(find.byType(Semantics)).last;
      expect(titleSematicLabel2.properties.label, equals(''));
    });

    testWidgets('uses title for sematic label if nessaccary', (WidgetTester tester) async {
      String titleText = 'Banner Title';
      StateSetter? setState;

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState2) {
            setState = setState2;
            return TestApp(
              home: Builder(
                builder: (context) {
                  return ZetaBanner(
                    context: context,
                    title: titleText,
                  );
                },
              ),
            );
          },
        ),
      );

      final Semantics titleSematicLabel = tester.widgetList<Semantics>(find.byType(Semantics)).last;
      expect(titleSematicLabel.properties.label, equals('Banner Title'));

      setState?.call(() => titleText = '');
      await tester.pumpAndSettle();

      final Semantics titleSematicLabel2 = tester.widgetList<Semantics>(find.byType(Semantics)).last;
      expect(titleSematicLabel2.properties.label, equals(''));
    });
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

    testWidgets('ZetaBanner leading icon is correct', (WidgetTester tester) async {
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

    testWidgets('trailing widget is correct', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: Builder(
            builder: (context) {
              return ZetaBanner(
                context: context,
                title: 'Banner Title',
                trailing: const ZetaIconButton(icon: ZetaIcons.close),
              );
            },
          ),
        ),
      );

      final Finder iconButtonFinder = find.byType(ZetaIconButton);
      expect(iconButtonFinder, findsOneWidget);

      final ZetaIconButton button = tester.widget(iconButtonFinder);
      expect(button.icon, equals(ZetaIcons.close));
    });

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
  });

  group('ZetaBanner Dimension Tests', () {
    testWidgets('icon is the correct size', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: Builder(
            builder: (context) {
              return ZetaBanner(
                context: context,
                title: 'Banner Title',
                leadingIcon: ZetaIcons.info,
              );
            },
          ),
        ),
      );
      final Finder iconFinder = find.byIcon(ZetaIcons.info);

      final Icon iconWidget = tester.widget(iconFinder);

      expect(iconWidget.size, Zeta.of(tester.element(iconFinder)).spacing.xl_2);
    });

    testWidgets('icon padding is correct', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: Builder(
            builder: (context) {
              return ZetaBanner(
                context: context,
                title: 'Banner Title',
                leadingIcon: ZetaIcons.info,
              );
            },
          ),
        ),
      );
      final Finder paddingFinder = find.widgetWithIcon(Padding, ZetaIcons.info);

      final Padding paddingWidget = tester.firstWidget(paddingFinder);

      expect(paddingWidget.padding, equals(const EdgeInsets.only(right: 8)));
    });

    testWidgets('banner padding is correct', (WidgetTester tester) async {
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
      final Finder paddingFinder = find.byType(Padding);

      final Padding paddingWidget = tester.widgetList<Padding>(paddingFinder).elementAt(1);

      expect(paddingWidget.padding, equals(const EdgeInsetsDirectional.only(start: 16, top: 2)));
    });
  });

  group('ZetaBanner Styling Tests', () {
    for (final type in ZetaBannerStatus.values) {
      testWidgets('title styles are correct for $type', (WidgetTester tester) async {
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
              color: Zeta.of(tester.element(textFinder)).colors.mainInverse,
            ),
          ),
        );
      });

      testWidgets('icon color is correct for $type', (WidgetTester tester) async {
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

        final Icon iconWidget = tester.widget(iconFinder);
        expect(iconWidget.color, const ZetaSemanticColorsAA(primitives: ZetaPrimitivesLight()).mainInverse);
      });

      testWidgets('background colors are correct for $type', (WidgetTester tester) async {
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
        final Finder finder = find.byType(ZetaBanner);
        final ZetaBanner widget = tester.firstWidget(finder);

        expect(widget.backgroundColor, equals(_colorFromType(tester.element(finder), type).shade60));
      });
    }
  });

  group('ZetaBanner Interaction Tests', () {});

  group('ZetaBanner Golden Tests', () {
    for (final type in ZetaBannerStatus.values) {
      testWidgets('ZetaBanner ${type.toString().split('.').last} golden', (WidgetTester tester) async {
        await tester.pumpWidget(
          TestApp(
            home: Builder(
              builder: (context) {
                return ZetaBanner(
                  context: context,
                  title: 'Banner Title',
                  leadingIcon: Icons.info,
                  trailing: const ZetaIcon(Icons.chevron_right),
                  type: type,
                );
              },
            ),
          ),
        );

        await expectLater(
          find.byType(ZetaBanner),
          matchesGoldenFile(goldenFile.getFileUri('banner_${type.toString().split('.').last}')),
        );
      });
    }
  });
}
