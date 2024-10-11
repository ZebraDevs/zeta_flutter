import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_app.dart';
import '../../../test_utils/tolerant_comparator.dart';
import '../../../test_utils/utils.dart';

void main() {
  const String componentName = 'ZetaAvatar';
  const String parentFolder = 'avatar';

  const goldenFile = GoldenFiles(component: parentFolder);
  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });

  group('$componentName Accessibility Tests', () {
    testWidgets('ZetaAvatar meets accessibility  requirements', (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(
        const TestApp(
          home: ZetaAvatar.initials(
            initials: 'AB',
            backgroundColor: Colors.black,
            borderColor: Colors.white,
            lowerBadge: ZetaAvatarBadge(
              icon: Icons.abc,
            ),
            upperBadge: ZetaAvatarBadge(
              icon: Icons.abc,
            ),
            size: ZetaAvatarSize.l,
          ),
        ),
      );
      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
      await expectLater(tester, meetsGuideline(textContrastGuideline));

      handle.dispose();
    });
  });

  group('$componentName Content Tests', () {
    final debugFillProperties = {
      'size': 'ZetaAvatarSize.xl',
      'name': 'null',
      'specialStatus': 'null',
      'badge': 'null',
      'backgroundColor': 'null',
      'statusColor': 'null',
      'semanticUpperBadgeValue': '"upperBadge"',
      'semanticValue': '"avatar"',
      'semanticLowerBadgeValue': '"lowerBadge"',
      'initialTextStyle': 'null',
    };
    debugFillPropertiesTest(
      const ZetaAvatar(),
      debugFillProperties,
    );

    const names = [
      'John Doe',
      'Jane Doe',
      'John Jim Smith',
      'Jane Lane Smith',
      'Emily Bukowsik Johnson',
      'Michael John Brad Brown',
      'Emma Amy Davis',
      'William Charlie Wilson',
      'Olivia Johnston',
      'James Oliver',
      'Isabella Smith',
    ];

    // TODODE: We need options for which initials should be displayed. Could use a bitmask?
    for (final name in names) {
      testWidgets(
        'ZetaAvatar intiatls show the first letter of the first name and the last name $name',
        (WidgetTester tester) async {
          final nameParts = name.split(' ');
          final initials = nameParts[0][0].toUpperCase() + nameParts[nameParts.length - 1][0].toUpperCase();
          await tester.pumpWidget(
            TestApp(
              home: ZetaAvatar.fromName(
                name: name,
              ),
            ),
          );

          expect(find.text(initials), findsOneWidget);
        },
        skip: true,
      );
    }

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
    }
  });

  group('$componentName Dimensions Tests', () {
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

      testWidgets('ZetaAvatar size $size', (WidgetTester tester) async {
        await tester.pumpWidget(
          TestApp(
            home: ZetaAvatar(
              size: size,
            ),
          ),
        );

        final avatarSize = tester.getSize(find.byType(ZetaAvatar));
        final typeSize = ZetaAvatar.pixelSize(
          tester.element(find.byType(ZetaAvatar)),
          size,
        );

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

  group('$componentName Styling Tests', () {
    for (final size in ZetaAvatarSize.values) {
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
          ),
        ),
      );

      final avatarBackgroundColor =
          ((tester.firstWidget(find.byType(Container)) as Container).decoration! as BoxDecoration).color;

      expect(avatarBackgroundColor, equals(Colors.red));
    });

    for (final size in ZetaAvatarSize.values) {
      testWidgets('ZetaAvatar with border colour for $size', (WidgetTester tester) async {
        await tester.pumpWidget(
          TestApp(
            home: ZetaAvatar(
              borderColor: Colors.red,
              size: size,
            ),
          ),
        );

        final avatarBorderColor =
            (((tester.firstWidget(find.byType(Container)) as Container).decoration! as BoxDecoration).border! as Border)
                .top
                .color;
        expect(avatarBorderColor, equals(Colors.red));
      });
    }
  });

  group('$componentName Interaction Tests', () {});

  group('$componentName Golden Tests', () {
    for (final size in ZetaAvatarSize.values) {
      goldenTest(
        goldenFile,
        ZetaAvatar(
          size: size,
        ),
        ZetaAvatar,
        'avatar_default_${size.toString().split('.').last}',
      );
      goldenTest(
        goldenFile,
        ZetaAvatar.initials(
          initials: 'AB',
          size: size,
        ),
        ZetaAvatar,
        'avatar_initials_${size.toString().split('.').last}',
      );
      goldenTest(
        goldenFile,
        ZetaAvatar.image(
          image: Image.file(File('/assets/maxresdefault.jpg')),
          size: size,
        ),
        ZetaAvatar,
        'avatar_image_${size.toString().split('.').last}',
      );
      goldenTest(
        goldenFile,
        ZetaAvatar.fromName(
          name: 'John Doe',
          size: size,
        ),
        ZetaAvatar,
        'avatar_from_name_${size.toString().split('.').last}',
      );
      goldenTest(
        goldenFile,
        ZetaAvatar(
          upperBadge: const ZetaAvatarBadge.notification(value: 3),
          size: size,
        ),
        ZetaAvatar,
        'avatar_upper_badge_${size.toString().split('.').last}',
      );
      goldenTest(
        goldenFile,
        ZetaAvatar(
          lowerBadge: const ZetaAvatarBadge.icon(icon: Icons.star),
          size: size,
        ),
        ZetaAvatar,
        'avatar_lower_badge_${size.toString().split('.').last}',
      );
    }
  });

  group('$componentName Performance Tests', () {});
}
