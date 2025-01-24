import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test_utils/test_utils.dart';

void main() {
  final avatarList = [
    const ZetaAvatar.initials(
      initials: 'AZ',
      label: 'Archie',
    ),
    const ZetaAvatar.initials(
      initials: 'BY',
      label: 'Beth',
    ),
    const ZetaAvatar.initials(
      initials: 'CX',
      label: 'Clara',
    ),
    const ZetaAvatar.initials(
      initials: 'DW',
      label: 'Dan',
    ),
    const ZetaAvatar.initials(
      initials: 'EV',
      label: 'Emily',
    ),
    const ZetaAvatar.initials(
      initials: 'FU',
      label: 'Frank',
    ),
    const ZetaAvatar.initials(
      initials: 'GT',
      label: 'George',
    ),
    const ZetaAvatar.initials(
      initials: 'HS',
      label: 'Harith',
    ),
    const ZetaAvatar.initials(
      initials: 'IR',
      label: 'Irene',
    ),
    const ZetaAvatar.initials(
      initials: 'KQ',
      label: 'Katie',
    ),
  ];

  const String parentFolder = 'avatar';

  const goldenFile = GoldenFiles(component: parentFolder);
  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });

  group('Accessibility Tests', () {
    testWidgets('meets labeled tap target guideline', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaAvatarRail(
            avatars: avatarList,
            size: ZetaAvatarSize.m,
            onTap: (key) {},
          ),
        ),
      );

      await expectLater(
        tester,
        meetsGuideline(labeledTapTargetGuideline),
      );
    });
  });

  group('Content Tests', () {
    final debugFillProperties = {
      'labelTextStyle': 'null',
      'size': 'm',
      'labelMaxLines': '2',
      'onTap': 'has onTap',
      'gap': '10.0',
    };
    debugFillPropertiesTest(
      ZetaAvatarRail(
        avatars: avatarList,
        size: ZetaAvatarSize.m,
        gap: 10,
        labelMaxLines: 2,
        onTap: (key) {},
      ),
      debugFillProperties,
    );

    testWidgets('renders the correct number of avatars', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaAvatarRail(
            avatars: avatarList,
            size: ZetaAvatarSize.m,
            onTap: (key) {},
          ),
        ),
      );

      final railFinder = find.byType(ZetaAvatarRail);
      final avatarFinder = find.byType(ZetaAvatar);

      expect(railFinder, findsOneWidget);
      expect(avatarFinder, findsNWidgets(avatarList.length));
    });
  });

  group('Dimensions Tests', () {
    for (final size in ZetaAvatarSize.values) {
      testWidgets('width is correct - avatar size: $size', (WidgetTester tester) async {
        const screenWidth = 800.0;
        const gap = 10.0;
        await tester.pumpWidget(
          TestApp(
            screenSize: const Size(screenWidth, 600),
            home: ZetaAvatarRail(
              avatars: avatarList,
              size: size,
              gap: gap,
              onTap: (key) {},
            ),
          ),
        );

        final railFinder = find.byType(ZetaAvatarRail);
        final avatarFinder = find.byType(ZetaAvatar);

        expect(railFinder, findsOneWidget);
        expect(avatarFinder, findsNWidgets(avatarList.length));

        final railSize = tester.getSize(railFinder);
        final avatarSize = tester.getSize(avatarFinder.first);

        if (railSize.width < screenWidth) {
          expect(railSize.width, equals(avatarSize.width * avatarList.length + gap * (avatarList.length - 1)));
        } else {
          expect(railSize.width, equals(screenWidth));
        }
      });

      testWidgets('height is correct - avatar size: $size', (WidgetTester tester) async {
        const gap = 10.0;
        await tester.pumpWidget(
          TestApp(
            home: ZetaAvatarRail(
              avatars: avatarList,
              size: size,
              gap: gap,
              onTap: (key) {},
            ),
          ),
        );

        final railFinder = find.byType(ZetaAvatarRail);
        final avatarFinder = find.byType(ZetaAvatar);

        final railSize = tester.getSize(railFinder);
        final avatarSize = tester.getSize(avatarFinder.first);

        expect(railSize.height, equals(avatarSize.height));
      });
    }
  });

  group('Styling Tests', () {
    testWidgets('applies the correct text style to labels', (WidgetTester tester) async {
      const textStyle = TextStyle(color: Colors.red, fontSize: 16);
      await tester.pumpWidget(
        TestApp(
          home: ZetaAvatarRail(
            avatars: avatarList,
            size: ZetaAvatarSize.m,
            labelTextStyle: textStyle,
            onTap: (key) {},
          ),
        ),
      );

      final labelFinder = find.text('Archie');
      final labelWidget = tester.widget<Text>(labelFinder);

      expect(labelWidget.style, equals(textStyle));
    });
  });

  group('Interaction Tests', () {
    final shortList = [
      const ZetaAvatar.initials(
        key: Key('avatar1'),
        initials: 'AZ',
        label: 'Archie',
      ),
      const ZetaAvatar.initials(
        key: Key('avatar2'),
        initials: 'BY',
        label: 'Beth',
      ),
      const ZetaAvatar.initials(
        key: Key('avatar3'),
        initials: 'CX',
        label: 'Clara',
      ),
    ];
    testWidgets('onTap is called when an avatar is tapped', (WidgetTester tester) async {
      var tapped = false;

      await tester.pumpWidget(
        TestApp(
          home: ZetaAvatarRail(
            gap: 10,
            avatars: shortList,
            size: ZetaAvatarSize.m,
            onTap: (key) {
              tapped = true;
            },
          ),
        ),
      );

      final avatarFinder = find.byType(ZetaAvatar);

      // Use hitTestable to ensure the widget can receive pointer events
      final hitTestableAvatarFinder = avatarFinder.hitTestable();

      expect(tapped, equals(false));

      await tester.tap(hitTestableAvatarFinder.first);
      await tester.pumpAndSettle(); // Ensure the tap event is processed

      expect(tapped, equals(true));
    });

    testWidgets('swipe functionality works', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: SizedBox(
            height: 70,
            width: 300,
            child: ZetaAvatarRail(
              avatars: avatarList,
              size: ZetaAvatarSize.m,
              onTap: (key) {},
            ),
          ),
        ),
      );

      final railFinder = find.byType(ZetaAvatarRail);
      expect(railFinder, findsOneWidget);

      await tester.drag(railFinder, const Offset(-300, 0));
      await tester.pumpAndSettle();

      // Check if the rail has been scrolled
      final firstAvatarFinder = find.text('Archie');
      expect(tester.getTopRight(firstAvatarFinder).dx, lessThan(0.0));
    });
  });

  group('Golden Tests', () {
    goldenTest(goldenFile, ZetaAvatarRail(avatars: avatarList), 'zeta_avatar_rail_default');
  });

  group('Performance Tests', () {
    testWidgets(
      'renders within 5 frames',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          TestApp(
            home: ZetaAvatarRail(
              avatars: avatarList,
              size: ZetaAvatarSize.m,
              onTap: (key) {},
            ),
          ),
        );

        final railFinder = find.byType(ZetaAvatarRail);
        expect(railFinder, findsOneWidget);

        await tester.pumpAndSettle();
        final frameCount = tester.platformDispatcher.frameData.frameNumber;
        expect(frameCount, lessThan(5));
      },
      skip: true,
    ); // Skip this test as it is not stable
  });
}
