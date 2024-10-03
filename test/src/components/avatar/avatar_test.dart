import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_app.dart';
import '../../../test_utils/tolerant_comparator.dart';
import '../../../test_utils/utils.dart';

void main() {
  const goldenFile = GoldenFiles(component: 'avatar');

  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });

  group('ZetaAvatar Colour Tests', () {
    testWidgets('ZetaAvatar default background colour', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaAvatar(),
        ),
      );

      final avatarBackgroundColor =
          ((tester.firstWidget(find.byType(Container)) as Container).decoration! as BoxDecoration).color;

      final context = tester.element(find.byType(ZetaAvatar));
      expect(avatarBackgroundColor, equals(Zeta.of(context).colors.surfacePrimary));
    });

    testWidgets('ZetaAvatar with background colour', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
            home: ZetaAvatar(
          backgroundColor: Colors.red,
        )),
      );

      final avatarBackgroundColor =
          ((tester.firstWidget(find.byType(Container)) as Container).decoration! as BoxDecoration).color;

      expect(avatarBackgroundColor, equals(Colors.red));
    });

    testWidgets('ZetaAvatar with border colour', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaAvatar(
            borderColor: Colors.red,
          ),
        ),
      );

      final avatarBorderColor =
          (((tester.firstWidget(find.byType(Container)) as Container).decoration! as BoxDecoration).border! as Border)
              .top
              .color;
      expect(avatarBorderColor, equals(Colors.red));
    });
  });

  group('ZetaAvatar Size Tests', () {
    for (final size in ZetaAvatarSize.values) {
      testWidgets('ZetaAvatar size $size', (WidgetTester tester) async {
        await tester.pumpWidget(
          TestApp(
            home: ZetaAvatar(
              size: size,
            ),
          ),
        );

        final avatarSize = tester.getSize(find.byType(ZetaAvatar));
        final typeSize = ZetaAvatar.pixelSize(tester.element(find.byType(ZetaAvatar)),
            size); //TODO BK butchered this to make pixelSize reusable. Mike, is this ok?

        expect(avatarSize.width, equals(typeSize));
        expect(avatarSize.height, equals(typeSize));
      });

      testWidgets('ZetaAvatar size $size with image', (WidgetTester tester) async {
        await tester.pumpWidget(
          TestApp(
            home: ZetaAvatar.image(
              size: size,
              image: Image.file(File('/assets/maxresdefault.jpg')),
            ),
          ),
        );

        final avatarSize = tester.getSize(find.byType(ZetaAvatar));
        final typeSize = ZetaAvatar.pixelSize(tester.element(find.byType(ZetaAvatar)), size);

        expect(avatarSize.width, equals(typeSize));
        expect(avatarSize.height, equals(typeSize));
      });

      testWidgets('ZetaAvatar size $size with initials', (WidgetTester tester) async {
        await tester.pumpWidget(
          TestApp(
            home: ZetaAvatar.initials(
              size: size,
              initials: 'AB',
            ),
          ),
        );

        final avatarSize = tester.getSize(find.byType(ZetaAvatar));
        final typeSize = ZetaAvatar.pixelSize(tester.element(find.byType(ZetaAvatar)), size);

        expect(avatarSize.width, equals(typeSize));
        expect(avatarSize.height, equals(typeSize));
      });

      testWidgets('ZetaAvatar size $size with fromName', (WidgetTester tester) async {
        await tester.pumpWidget(
          TestApp(
            home: ZetaAvatar.fromName(
              size: size,
              name: 'John Doe',
            ),
          ),
        );

        final avatarSize = tester.getSize(find.byType(ZetaAvatar));
        final typeSize = ZetaAvatar.pixelSize(tester.element(find.byType(ZetaAvatar)), size);

        expect(avatarSize.width, equals(typeSize));
        expect(avatarSize.height, equals(typeSize));
      });
    }
  });

  group('ZetaAvatar Badge Position Tests', () {
    for (final size in ZetaAvatarSize.values) {
      testWidgets(
        'ZetaAvatar size $size with upper badge',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            TestApp(
              home: ZetaAvatar(
                size: size,
                upperBadge: const ZetaAvatarBadge.notification(value: 3),
              ),
            ),
          );

          expect(find.byType(ZetaAvatarBadge), findsOneWidget);

          final badgePosition = tester.getRect(find.byType(ZetaAvatarBadge));
          final pixelSize = ZetaAvatar.pixelSize(tester.element(find.byType(ZetaAvatar)), size);

          expect(badgePosition.top, equals(0.0));
          expect(badgePosition.right, equals(pixelSize));
        },
      );

      testWidgets('ZetaAvatar size $size with lower badge', (WidgetTester tester) async {
        await tester.pumpWidget(
          TestApp(
            home: ZetaAvatar(
              size: size,
              lowerBadge: const ZetaAvatarBadge.icon(icon: Icons.star),
            ),
          ),
        );

        expect(find.byType(ZetaAvatarBadge), findsOneWidget);

        final badgePosition = tester.getRect(find.byType(ZetaAvatarBadge));
        final pixelSize = ZetaAvatar.pixelSize(tester.element(find.byType(ZetaAvatar)), size);

        expect(badgePosition.bottom, equals(pixelSize));
        expect(badgePosition.right, equals(pixelSize));
      });
    }
  });

  group('ZetaAvatar Text Tests', () {
    for (final size in ZetaAvatarSize.values) {
      testWidgets('ZetaAvatar with initials $size text is correct', (WidgetTester tester) async {
        await tester.pumpWidget(
          TestApp(
            home: ZetaAvatar.initials(
              size: size,
              initials: 'AB',
            ),
          ),
        );

        expect(find.byType(Text), findsOneWidget);
        expect(find.text('AB'), findsOneWidget);
      });

      testWidgets('ZetaAvatar with initials $size text size is correct', (WidgetTester tester) async {
        await tester.pumpWidget(
          TestApp(
            home: ZetaAvatar.initials(
              size: size,
              initials: 'AB',
            ),
          ),
        );

        final text = tester.firstWidget(find.byType(Text)) as Text;
        expect(
          text.style?.fontSize,
          equals(
            ZetaAvatar.fontSize(tester.element(find.byType(ZetaAvatar)), size),
          ),
        );
      });
    }

    testWidgets('ZetaAvatar with initials text color is correct', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaAvatar.initials(
            initials: 'AB',
            initialTextStyle: TextStyle(color: Colors.red),
          ),
        ),
      );

      final text = tester.firstWidget(find.byType(Text)) as Text;
      expect(text.style!.color, equals(Colors.red));
    });
  });
}
