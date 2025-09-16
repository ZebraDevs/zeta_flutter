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

  Widget renderGlobalHeader() => MediaQuery(
        data: const MediaQueryData(size: Size(1920, 1024)),
        child: SizedBox(
          width: 1920,
          child: ZetaGlobalHeader(
            platformName: 'Platform Name',
            name: 'Name',
            navItems: [
              ZetaButton(
                label: 'Nav item',
                type: ZetaButtonType.subtle,
                onPressed: () {},
                semanticLabel: 'Nav Item Button',
              ),
              ZetaButton(
                label: 'Nav item',
                type: ZetaButtonType.subtle,
                onPressed: () {},
                semanticLabel: 'Nav Item Button',
              ),
            ],
            searchBar: true,
            actionItems: [
              ZetaIconButton(
                icon: ZetaIcons.star,
                type: ZetaButtonType.subtle,
                size: ZetaWidgetSize.small,
                onPressed: () {},
                semanticLabel: 'Action Item Button',
              ),
              ZetaIconButton(
                icon: ZetaIcons.star,
                type: ZetaButtonType.subtle,
                size: ZetaWidgetSize.small,
                onPressed: () {},
                semanticLabel: 'Action Item Button',
              ),
            ],
            appSwitcher: true,
            avatar: const ZetaAvatar(label: 'Name', size: ZetaAvatarSize.xxxs),
          ),
        ),
      );

  group('Accessibility Tests', () {
    // meetsAccessibilityGuidelinesTest(
    //   renderGlobalHeader(),
    // );
  });

  group('Content Tests', () {
    //Renders leading icon button correctly
    //Renders Zebra Logo correctly
    //Renders platform name correctly
    //Renders nav items correctly
    //Renders search bar correctly
    //Renders action items correctly
    //Renders avatar button correctly
    //Renders app switcher button correctly
  });

  group('Dimensions Tests', () {
    //Global header has a height of 52px
    //Search bar has width of 240px and height of 32px
    //Logo has width of 80px and height of 32px
    //Trailing icon button is 24x24px
    //App switcher button is 24x24px
  });

  group('Styling Tests', () {
    //Background color is surface default
    //Leading icon button has subtle style
    //Platform name colour is main default
    //App switcher button has subtle style
    //Avatar button has subtle style
  });

  group('Interaction Tests', () {
    //Leading icon button triggers callback when tapped
    //Nav items trigger callback when tapped
    //Search bar focuses when tapped
    //Action items trigger callback when tapped
    //Avatar button triggers callback when tapped
    //App switcher button triggers callback when tapped
    //Divider appears only if action items are present
    //Divider appears only if nav items are present
  });

  group('Golden Tests', () {
    //Default
    //Rounded
  });

  group('Performance Tests', () {});
}
