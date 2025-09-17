import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_utils.dart';

void main() {
  const String parentFolder = 'global_header';

  const goldenFile = GoldenFiles(component: parentFolder);
  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });

  group('Accessibility Tests', () {
    // meetsAccessibilityGuidelinesTest(
    //
    // );
  });

  group('Content Tests', () {
    testWidgets('Renders leading icon button correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaGlobalHeader(
            platformName: 'Platform Name',
          ),
        ),
      );
      expect(find.bySemanticsLabel('Hamburger Menu Button'), findsOneWidget);
    });
    testWidgets('Renders Zebra Logo correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaGlobalHeader(
            platformName: 'Platform Name',
          ),
        ),
      );
      expect(find.bySemanticsLabel('Zebra Logo'), findsOneWidget);
    });
    testWidgets('Renders platform name correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaGlobalHeader(
            platformName: 'Platform Name',
          ),
        ),
      );
      expect(find.text('Platform Name'), findsOneWidget);
    });
    //Renders nav items correctly
    //Overflow issue
    // testWidgets('Renders nav items correctly', (WidgetTester tester) async {
    //   await tester.pumpWidget(
    //     TestApp(
    //       home: ZetaGlobalHeader(
    //         platformName: 'Platform Name',
    //         navItems: [
    //           ZetaDropdown(
    //             onChange: (value) {},
    //             value: 'Nav item',
    //             items: [
    //               ZetaDropdownItem(value: 'Nav item', label: 'Nav item'),
    //               ZetaDropdownItem(value: 'Nav item', label: 'Nav item'),
    //             ],
    //           ),
    //           const ZetaButton(
    //             label: 'Nav item',
    //             type: ZetaButtonType.subtle,
    //             semanticLabel: 'Nav Item Button',
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    //   expect(find.bySemanticsLabel('Nav Item Button'), findsNWidgets(2));
    // });
    //TODO(thelukewalton): Fix overflow issue 4px on the bottom
    testWidgets('Renders search bar correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          screenSize: Size(1920, 1020),
          home: ZetaGlobalHeader(
            platformName: 'Platform Name',
            searchBar: true,
          ),
        ),
      );
      expect(find.byType(ZetaSearchBar), findsOneWidget);
    });
    testWidgets('Renders action items correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaGlobalHeader(
            platformName: 'Platform Name',
            actionItems: [
              ZetaIconButton(
                icon: ZetaIcons.star,
                type: ZetaButtonType.subtle,
                size: ZetaWidgetSize.small,
                semanticLabel: 'Action Item Button',
              ),
              ZetaIconButton(
                icon: ZetaIcons.star,
                type: ZetaButtonType.subtle,
                size: ZetaWidgetSize.small,
                semanticLabel: 'Action Item Button',
              ),
            ],
          ),
        ),
      );
      expect(find.bySemanticsLabel('Action Item Button'), findsNWidgets(2));
    });
    testWidgets('Renders avatar button correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaGlobalHeader(
            platformName: 'Platform Name',
            name: 'Name',
          ),
        ),
      );
      expect(find.bySemanticsLabel('User Avatar Button'), findsOneWidget);
    });
    testWidgets('Renders app switcher button correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaGlobalHeader(
            platformName: 'Platform Name',
            appSwitcher: true,
          ),
        ),
      );
      expect(find.bySemanticsLabel('App Switcher Button'), findsOneWidget);
    });
  });

  group('Dimensions Tests', () {
    //TODO(thelukewalton): Fix wrong width and height in tester
    testWidgets('Leading icon button is 28x28px', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaGlobalHeader(
            platformName: 'Platform Name',
          ),
        ),
      );
      final leadingFinder = find.bySemanticsLabel('Hamburger Menu Button');
      final leadingSize = tester.getSize(leadingFinder);
      expect(leadingSize.width, 28); //getting 48
      expect(leadingSize.height, 28); //getting 36
    });
    //Global header has a height of 52px
    testWidgets('Global header has a height of 52px', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaGlobalHeader(
            platformName: 'Platform Name',
          ),
        ),
      );
      final headerFinder = find.byType(ZetaGlobalHeader);
      final headerSize = tester.getSize(headerFinder);
      expect(headerSize.height, 52);
    });
    //Search bar has width of 240px and height of 32px
    //TODO(thelukewalton): Fix overflow issue 4px on the bottom
    testWidgets('Search bar has width of 240px and height of 32px', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: SingleChildScrollView(
            child: ZetaGlobalHeader(
              platformName: 'Platform Name',
              searchBar: true,
            ),
          ),
        ),
      );
      final searchBarFinder = find.byType(ZetaSearchBar);
      final searchBarSize = tester.getSize(searchBarFinder);
      expect(searchBarSize.width, 240);
      expect(searchBarSize.height, 32);
    });
    //Logo has width of 80px and height of 32px
    testWidgets('Logo has width of 80px and height of 32px', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaGlobalHeader(
            platformName: 'Platform Name',
          ),
        ),
      );
      final logoFinder = find.bySemanticsLabel('Zebra Logo');
      final logoSize = tester.getSize(logoFinder);
      expect(logoSize.width, 80);
      expect(logoSize.height, 32);
    });
    //App switcher button is 28x28px
    testWidgets('App switcher button is 28x28px', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaGlobalHeader(
            platformName: 'Platform Name',
            appSwitcher: true,
          ),
        ),
      );
      final appSwitcherFinder = find.bySemanticsLabel('App Switcher Button');
      final appSwitcherSize = tester.getSize(appSwitcherFinder);
      expect(appSwitcherSize.width, 28);
      expect(appSwitcherSize.height, 28);
    });
  });

  group('Styling Tests', () {
    //Background color is surface default
    testWidgets('Background color is surface default', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaGlobalHeader(
            platformName: 'Platform Name',
          ),
        ),
      );
      final containerFinder = find.descendant(
        of: find.byType(ZetaGlobalHeader),
        matching: find.byType(Container),
      );
      final container = tester.widget<Container>(containerFinder.first);
      final BoxDecoration? decoration = container.decoration as BoxDecoration?;
      expect(decoration?.color, Zeta.of(tester.element(find.byType(ZetaGlobalHeader))).colors.surfaceDefault);
    });
    //Leading icon button has subtle style
    testWidgets('Leading icon button has subtle style', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaGlobalHeader(
            platformName: 'Platform Name',
          ),
        ),
      );
      final leadingFinder = find.bySemanticsLabel('Hamburger Menu Button');
      final leading = tester.widget<ZetaIconButton>(leadingFinder);
      expect(leading.type, ZetaButtonType.subtle);
    });
    //Platform name colour is main default
    testWidgets('Platform name colour is main default', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaGlobalHeader(
            platformName: 'Platform Name',
          ),
        ),
      );
      final platformNameFinder = find.text('Platform Name');
      final platformName = tester.widget<Text>(platformNameFinder);
      expect(platformName.style?.color, Zeta.of(tester.element(find.byType(ZetaGlobalHeader))).colors.mainDefault);
    });
    //App switcher button has subtle style
    testWidgets('App switcher button has subtle style', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaGlobalHeader(
            platformName: 'Platform Name',
            appSwitcher: true,
          ),
        ),
      );
      final appSwitcherFinder = find.bySemanticsLabel('App Switcher Button');
      final appSwitcher = tester.widget<ZetaIconButton>(appSwitcherFinder);
      expect(appSwitcher.type, ZetaButtonType.subtle);
    });
    //Avatar button has subtle style
    testWidgets('Avatar button has subtle style', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaGlobalHeader(
            platformName: 'Platform Name',
            avatar: ZetaAvatar(),
          ),
        ),
      );
      final avatarFinder = find.bySemanticsLabel('User Avatar Button');
      final avatar = tester.widget<ZetaButton>(avatarFinder);
      expect(avatar.type, ZetaButtonType.subtle);
    });
  });

  group('Interaction Tests', () {
    //Leading icon button triggers callback when tapped
    testWidgets('Leading icon button triggers callback when tapped', (WidgetTester tester) async {
      bool wasPressed = false;
      await tester.pumpWidget(
        TestApp(
          home: ZetaGlobalHeader(
            platformName: 'Platform Name',
            onHamburgerMenuPressed: () {
              wasPressed = true;
            },
          ),
        ),
      );
      final leadingFinder = find.bySemanticsLabel('Hamburger Menu Button');
      await tester.tap(leadingFinder);
      expect(wasPressed, isTrue);
    });
    //Nav items trigger callback when tapped
    testWidgets('Nav items trigger callback when tapped', (WidgetTester tester) async {
      bool wasPressed = false;
      await tester.pumpWidget(
        TestApp(
          home: ZetaGlobalHeader(
            platformName: 'Platform Name',
            navItems: [
              ZetaButton(
                label: 'Nav item',
                type: ZetaButtonType.subtle,
                onPressed: () {
                  wasPressed = true;
                },
                semanticLabel: 'Nav Item Button',
              ),
            ],
          ),
        ),
      );
      final navItemFinder = find.bySemanticsLabel('Nav Item Button');
      await tester.tap(navItemFinder);
      expect(wasPressed, isTrue);
    });
    //Action items trigger callback when tapped
    testWidgets('Action items trigger callback when tapped', (WidgetTester tester) async {
      bool wasPressed = false;
      await tester.pumpWidget(
        TestApp(
          home: ZetaGlobalHeader(
            platformName: 'Platform Name',
            actionItems: [
              ZetaIconButton(
                icon: ZetaIcons.add,
                onPressed: () {
                  wasPressed = true;
                },
                semanticLabel: 'Action Item Button',
              ),
            ],
          ),
        ),
      );
      final actionItemFinder = find.bySemanticsLabel('Action Item Button');
      await tester.tap(actionItemFinder);
      expect(wasPressed, isTrue);
    });
    //Avatar button triggers callback when tapped
    testWidgets('Avatar button triggers callback when tapped', (WidgetTester tester) async {
      bool wasPressed = false;
      await tester.pumpWidget(
        TestApp(
          home: ZetaGlobalHeader(
            platformName: 'Platform Name',
            avatar: ZetaAvatar(),
            onAvatarButtonPressed: () {
              wasPressed = true;
            },
          ),
        ),
      );
      final avatarFinder = find.bySemanticsLabel('User Avatar Button');
      await tester.tap(avatarFinder);
      expect(wasPressed, isTrue);
    });
    //App switcher button triggers callback when tapped
    testWidgets('App switcher button triggers callback when tapped', (WidgetTester tester) async {
      bool wasPressed = false;
      await tester.pumpWidget(
        TestApp(
          home: ZetaGlobalHeader(
            platformName: 'Platform Name',
            appSwitcher: true,
            onAppsButtonPressed: () {
              wasPressed = true;
            },
          ),
        ),
      );
      final appSwitcherFinder = find.bySemanticsLabel('App Switcher Button');
      await tester.tap(appSwitcherFinder);
      expect(wasPressed, isTrue);
    });
    //Divider appears only if action items are present
    testWidgets('Divider appears only if action items are present', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaGlobalHeader(
            platformName: 'Platform Name',
            actionItems: [
              ZetaIconButton(
                icon: ZetaIcons.add,
                onPressed: () {},
                semanticLabel: 'Action Item Button',
              ),
            ],
          ),
        ),
      );
      expect(find.byType(Divider), findsOneWidget);
    });
    //Divider appears only if nav items are present
    testWidgets('Divider appears only if nav items are present', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaGlobalHeader(
            platformName: 'Platform Name',
            navItems: [
              ZetaButton(
                label: 'Nav item',
                type: ZetaButtonType.subtle,
                onPressed: () {},
                semanticLabel: 'Nav Item Button',
              ),
            ],
          ),
        ),
      );
      expect(find.byType(Divider), findsOneWidget);
    });
    //Check divider does not appear when no action or nav items
    testWidgets('Divider does not appear when no action or nav items', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaGlobalHeader(
            platformName: 'Platform Name',
          ),
        ),
      );
      expect(find.byType(Divider), findsNothing);
    });
  });

  group('Golden Tests', () {
    //Default
    goldenTest(
      goldenFile,
      const ZetaGlobalHeader(platformName: 'Platform Name'),
      'global_header_default',
    );
    //Rounded
    goldenTest(
      goldenFile,
      const ZetaGlobalHeader(platformName: 'Platform Name', rounded: true),
      'global_header_rounded',
    );
  });

  group('Performance Tests', () {});
}
