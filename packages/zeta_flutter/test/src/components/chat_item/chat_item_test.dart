import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_utils.dart';

void main() {
  const goldenFile = GoldenFiles(component: 'chat_item');

  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });

  group('Accessibility Tests', () {});
  group('Content Tests', () {
    final time = DateTime.now();
    final debugFillPropertiesChatItem = {
      'rounded': 'null',
      'highlighted': 'true',
      'time': time.toString(),
      'timeFormat': 'null',
      'enabledWarningIcon': 'true',
      'enabledNotificationIcon': 'true',
      'count': '1',
      'onTap': 'null',
      'starred': 'true',
      'explicitChildNodes': 'true',
      'paleButtonColors': 'null',
    };
    debugFillPropertiesTest(
      ZetaChatItem(
        title: const Text('Title'),
        subtitle: const Text('Subtitle'),
        time: time,
        leading: const ZetaAvatar(initials: 'AZ'),
        slidableActions: [
          ZetaSlidableAction.menuMore(onPressed: () {}),
          ZetaSlidableAction.call(onPressed: () {}),
          ZetaSlidableAction.ptt(onPressed: () {}),
          ZetaSlidableAction.delete(onPressed: () {}),
        ],
        count: 1,
        enabledNotificationIcon: true,
        highlighted: true,
        enabledWarningIcon: true,
        starred: true,
      ),
      debugFillPropertiesChatItem,
    );
    final debugFillPropertiesSlidableAction = {
      'onPressed': 'null',
      'icon': 'IconData(U+0E5F9)',
      'foregroundColor': null,
      'backgroundColor': null,
      'color': 'null',
      'semanticLabel': 'null',
      'paleColor': 'false',
    };
    debugFillPropertiesTest(
      const ZetaSlidableAction(icon: Icons.star),
      debugFillPropertiesSlidableAction,
    );

    testWidgets('ZetaChatItem displays correctly', (WidgetTester tester) async {
      tester.view.devicePixelRatio = 1.0;
      tester.view.physicalSize = const Size(481, 480);
      const title = Text('John Doe');
      const subtitle = Text('Hello, how are you?');
      final time = DateTime.now();
      final timeFormat = DateFormat('hh:mm a');

      await tester.pumpWidget(
        TestApp(
          home: Scaffold(
            body: Column(
              children: [
                ZetaChatItem(
                  explicitChildNodes: false,
                  time: time,
                  enabledWarningIcon: true,
                  enabledNotificationIcon: true,
                  leading: const ZetaAvatar(initials: 'AZ'),
                  count: 100,
                  onTap: () {},
                  paleButtonColors: true,
                  slidableActions: [
                    ZetaSlidableAction.menuMore(onPressed: () {}),
                    ZetaSlidableAction.call(onPressed: () {}),
                    ZetaSlidableAction.ptt(onPressed: () {}),
                    ZetaSlidableAction.delete(onPressed: () {}),
                  ],
                  title: title,
                  subtitle: subtitle,
                ),
              ],
            ),
          ),
        ),
      );

      // Verify that the title, subtitle, and time are displayed correctly
      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('Hello, how are you?'), findsOneWidget);
      expect(find.text(timeFormat.format(time)), findsOneWidget);

      final chatItemFinder = find.byType(ZetaChatItem);

      // Verify that the widget is tappable
      await tester.tap(chatItemFinder);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });

    testWidgets('ZetaChatItem highlighted', (WidgetTester tester) async {
      tester.view.devicePixelRatio = 1.0;
      tester.view.physicalSize = const Size(481, 480);
      const title = Text('John Doe');
      const subtitle = Text('Hello, how are you?');
      final time = DateTime.now();
      final timeFormat = DateFormat('hh:mm a');

      await tester.pumpWidget(
        TestApp(
          home: Column(
            children: [
              ZetaChatItem(
                explicitChildNodes: false,
                time: time,
                enabledWarningIcon: true,
                enabledNotificationIcon: true,
                leading: const ZetaAvatar(initials: 'AZ'),
                count: 100,
                onTap: () {},
                paleButtonColors: false,
                starred: true,
                slidableActions: [
                  ZetaSlidableAction.menuMore(onPressed: () {}),
                  ZetaSlidableAction.call(onPressed: () {}),
                  ZetaSlidableAction.ptt(onPressed: () {}),
                  ZetaSlidableAction.delete(onPressed: () {}),
                ],
                highlighted: true,
                title: title,
                subtitle: subtitle,
              ),
            ],
          ),
        ),
      );

      // Verify that the title, subtitle, and time are displayed correctly
      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('Hello, how are you?'), findsOneWidget);
      expect(find.text(timeFormat.format(time)), findsOneWidget);

      final chatItemFinder = find.byType(ZetaChatItem);

      // Verify that the widget is tappable
      await tester.tap(chatItemFinder);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });

    testWidgets('ZetaChatItem slidable actions', (WidgetTester tester) async {
      tester.view.devicePixelRatio = 1.0;
      tester.view.physicalSize = const Size(481, 480);
      const title = Text('John Doe');
      const subtitle = Text('Hello, how are you?');
      final time = DateTime.now();

      await tester.pumpWidget(
        TestApp(
          home: Column(
            children: [
              ZetaChatItem(
                time: time,
                leading: const ZetaAvatar(initials: 'AZ'),
                slidableActions: [
                  ZetaSlidableAction.menuMore(onPressed: () {}),
                  ZetaSlidableAction.call(onPressed: () {}),
                  ZetaSlidableAction.ptt(onPressed: () {}),
                  ZetaSlidableAction.delete(onPressed: () {}),
                ],
                title: title,
                subtitle: subtitle,
              ),
            ],
          ),
        ),
      );

      final chatItemFinder = find.byType(ZetaChatItem);

      await tester.drag(chatItemFinder, const Offset(-200, 0));
      await tester.pumpAndSettle();

      // Verify that the slidable actions are displayed correctly
      expect(find.byIcon(ZetaIcons.more_vertical), findsOneWidget);
      expect(find.byIcon(ZetaIcons.phone), findsOneWidget);
      expect(find.byIcon(ZetaIcons.ptt), findsOneWidget);
      expect(find.byIcon(ZetaIcons.delete), findsOneWidget);

      // Verify that tapping on the slidable actions triggers the corresponding callbacks
      await tester.tap(find.byIcon(ZetaIcons.more_vertical));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.tap(find.byIcon(ZetaIcons.phone));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.tap(find.byIcon(ZetaIcons.ptt));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.tap(find.byIcon(ZetaIcons.delete));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });

    testWidgets('ZetaChatItem with pale slidable button colors', (WidgetTester tester) async {
      tester.view.devicePixelRatio = 1.0;
      tester.view.physicalSize = const Size(481, 480);
      const title = Text('John Doe');
      const subtitle = Text('Hello, how are you?');
      final time = DateTime.now();

      await tester.pumpWidget(
        TestApp(
          home: Column(
            children: [
              ZetaChatItem(
                time: time,
                leading: const ZetaAvatar(initials: 'AZ'),
                paleButtonColors: true,
                slidableActions: [
                  ZetaSlidableAction.menuMore(
                    onPressed: () {},
                  ),
                  ZetaSlidableAction.call(
                    onPressed: () {},
                  ),
                  ZetaSlidableAction.ptt(
                    onPressed: () {},
                  ),
                  ZetaSlidableAction.delete(
                    onPressed: () {},
                  ),
                ],
                title: title,
                subtitle: subtitle,
              ),
            ],
          ),
        ),
      );

      final chatItemFinder = find.byType(ZetaChatItem);

      await tester.drag(chatItemFinder, const Offset(-200, 0));
      await tester.pumpAndSettle();

      // Verify that the slidable actions have pale button colors
      expect(find.byIcon(ZetaIcons.more_vertical), findsOneWidget);
      expect(find.byIcon(ZetaIcons.phone), findsOneWidget);
      expect(find.byIcon(ZetaIcons.ptt), findsOneWidget);
      expect(find.byIcon(ZetaIcons.delete), findsOneWidget);
    });

    testWidgets('ZetaChatItem with 2 pale buttons and 2 regular buttons', (WidgetTester tester) async {
      tester.view.devicePixelRatio = 1.0;
      tester.view.physicalSize = const Size(481, 480);
      const title = Text('John Doe');
      const subtitle = Text('Hello, how are you?');
      final time = DateTime.now();

      await tester.pumpWidget(
        TestApp(
          home: Column(
            children: [
              ZetaChatItem(
                time: time,
                leading: const ZetaAvatar(initials: 'AZ'),
                slidableActions: [
                  ZetaSlidableAction(
                    onPressed: () {},
                    paleColor: true,
                    icon: Icons.star,
                  ),
                  ZetaSlidableAction(
                    onPressed: () {},
                    paleColor: true,
                    icon: Icons.delete,
                  ),
                  ZetaSlidableAction(
                    onPressed: () {},
                    icon: Icons.call,
                  ),
                  ZetaSlidableAction(
                    onPressed: () {},
                    icon: Icons.message,
                  ),
                ],
                title: title,
                subtitle: subtitle,
              ),
            ],
          ),
        ),
      );

      final chatItemFinder = find.byType(ZetaChatItem);

      await tester.drag(chatItemFinder, const Offset(-200, 0));
      await tester.pumpAndSettle();

      // Verify that the slidable actions are displayed correctly
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.byIcon(Icons.delete), findsOneWidget);
      expect(find.byIcon(Icons.call), findsOneWidget);
      expect(find.byIcon(Icons.message), findsOneWidget);

      // Verify that the pale buttons have the correct color
      final paleButtons = tester.widgetList<ZetaSlidableAction>(
        find.byWidgetPredicate((widget) => widget is ZetaSlidableAction && widget.paleColor),
      );
      expect(paleButtons.length, 2);

      // Verify that the non-pale buttons have the correct color
      final nonPaleButtons = tester.widgetList<ZetaSlidableAction>(
        find.byWidgetPredicate((widget) => widget is ZetaSlidableAction && !widget.paleColor),
      );
      expect(nonPaleButtons.length, 2);

      // Verify that tapping on the slidable actions triggers the corresponding callbacks
      await tester.tap(find.byIcon(Icons.star));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.tap(find.byIcon(Icons.call));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.tap(find.byIcon(Icons.message));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });

    testWidgets('ZetaChatItem with custom leading widget', (WidgetTester tester) async {
      tester.view.devicePixelRatio = 1.0;
      tester.view.physicalSize = const Size(481, 480);
      const title = Text('John Doe');
      const subtitle = Text('Hello, how are you?');
      final time = DateTime.now();

      await tester.pumpWidget(
        TestApp(
          home: Column(
            children: [
              ZetaChatItem(
                time: time,
                leading: Container(
                  width: 40,
                  height: 40,
                  color: Colors.blue,
                ),
                slidableActions: [
                  ZetaSlidableAction.menuMore(onPressed: () {}),
                  ZetaSlidableAction.call(onPressed: () {}),
                  ZetaSlidableAction.ptt(onPressed: () {}),
                  ZetaSlidableAction.delete(onPressed: () {}),
                ],
                title: title,
                subtitle: subtitle,
              ),
            ],
          ),
        ),
      );

      // Verify that the custom leading widget is displayed correctly
      expect(find.byType(Container), findsOneWidget);
      expect(find.byWidgetPredicate((widget) => widget is Container && widget.color == Colors.blue), findsOneWidget);
    });

    testWidgets('ZetaChatItem with custom slidable buttons', (WidgetTester tester) async {
      tester.view.devicePixelRatio = 1.0;
      tester.view.physicalSize = const Size(481, 480);
      const title = Text('John Doe');
      const subtitle = Text('Hello, how are you?');
      final time = DateTime.now();

      await tester.pumpWidget(
        TestApp(
          home: Column(
            children: [
              ZetaChatItem(
                time: time,
                leading: const ZetaAvatar(initials: 'AZ'),
                slidableActions: [
                  ZetaSlidableAction(
                    onPressed: () {},
                    color: const ZetaPrimitivesLight().orange,
                    icon: Icons.star,
                  ),
                  ZetaSlidableAction(
                    onPressed: () {},
                    color: const ZetaPrimitivesLight().red,
                    icon: Icons.delete,
                  ),
                ],
                title: title,
                subtitle: subtitle,
              ),
            ],
          ),
        ),
      );

      final chatItemFinder = find.byType(ZetaChatItem);

      await tester.drag(chatItemFinder, const Offset(-200, 0));
      await tester.pumpAndSettle();

      // Verify that the slidable actions are displayed correctly
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.byIcon(Icons.delete), findsOneWidget);

      // Verify that tapping on the slidable actions triggers the corresponding callbacks
      await tester.tap(find.byIcon(Icons.star));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await expectLater(
        chatItemFinder,
        matchesGoldenFile(goldenFile.getFileUri('chat_item_custom_slidable_buttons')),
      );
    });

    testWidgets('ZetaChatItem displays correctly', (WidgetTester tester) async {
      tester.view.devicePixelRatio = 1.0;
      tester.view.physicalSize = const Size(315, 480);
      const title = Text('John Doe');
      const subtitle = Text('Hello, how are you?');
      final time = DateTime.now();

      await tester.pumpWidget(
        TestApp(
          home: Column(
            children: [
              ZetaChatItem(
                time: time,
                leading: const ZetaAvatar(initials: 'AZ'),
                slidableActions: [
                  ZetaSlidableAction.menuMore(onPressed: () {}),
                  ZetaSlidableAction.call(onPressed: () {}),
                  ZetaSlidableAction.ptt(onPressed: () {}),
                  ZetaSlidableAction.delete(onPressed: () {}),
                ],
                title: title,
                count: 1,
                subtitle: subtitle,
              ),
            ],
          ),
        ),
      );

      final chatItemFinder = find.byType(ZetaChatItem);
      final chatItem = tester.firstWidget(chatItemFinder) as ZetaChatItem;
      final avatarFinder = find.byType(ZetaAvatar);
      final avatar = tester.firstWidget(avatarFinder) as ZetaAvatar;
      expect(chatItem.count, 1);
      expect(avatar.initials, 'AZ');
      await tester.drag(chatItemFinder, const Offset(-200, 0));
      await tester.pumpAndSettle();

      // Verify that the slidable actions are displayed correctly
      expect(find.byIcon(ZetaIcons.more_vertical), findsOneWidget);
      expect(find.byIcon(ZetaIcons.phone), findsOneWidget);
      expect(find.byIcon(ZetaIcons.ptt), findsOneWidget);
      expect(find.byIcon(ZetaIcons.delete), findsOneWidget);

      // Verify that tapping on the slidable actions triggers the corresponding callbacks
      await tester.tap(find.byIcon(ZetaIcons.more_vertical));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.tap(find.byIcon(ZetaIcons.phone));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.tap(find.byIcon(ZetaIcons.ptt));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.tap(find.byIcon(ZetaIcons.delete));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  });
  group('Dimensions Tests', () {});
  group('Styling Tests', () {});
  group('Interaction Tests', () {});
  group('Golden Tests', () {
    const title = Text('John Doe');
    const subtitle = Text('Hello, how are you?');
    final time = DateTime.now();

    goldenTest(
      goldenFile,
      Scaffold(
        body: Column(
          children: [
            ZetaChatItem(
              explicitChildNodes: false,
              time: time,
              enabledWarningIcon: true,
              enabledNotificationIcon: true,
              leading: const ZetaAvatar(initials: 'AZ'),
              count: 100,
              onTap: () {},
              paleButtonColors: true,
              slidableActions: [
                ZetaSlidableAction.menuMore(onPressed: () {}),
                ZetaSlidableAction.call(onPressed: () {}),
                ZetaSlidableAction.ptt(onPressed: () {}),
                ZetaSlidableAction.delete(onPressed: () {}),
              ],
              title: title,
              subtitle: subtitle,
            ),
          ],
        ),
      ),
      'chat_item_default',
      widgetType: ZetaChatItem,
      setUp: (tester) async {
        tester.view.devicePixelRatio = 1.0;
        tester.view.physicalSize = const Size(481, 480);
      },
    );

    goldenTest(
      goldenFile,
      Column(
        children: [
          ZetaChatItem(
            explicitChildNodes: false,
            time: time,
            enabledWarningIcon: true,
            enabledNotificationIcon: true,
            leading: const ZetaAvatar(initials: 'AZ'),
            count: 100,
            onTap: () {},
            paleButtonColors: false,
            starred: true,
            slidableActions: [
              ZetaSlidableAction.menuMore(onPressed: () {}),
              ZetaSlidableAction.call(onPressed: () {}),
              ZetaSlidableAction.ptt(onPressed: () {}),
              ZetaSlidableAction.delete(onPressed: () {}),
            ],
            highlighted: true,
            title: title,
            subtitle: subtitle,
          ),
        ],
      ),
      'chat_item_highlighted',
      widgetType: ZetaChatItem,
      setUp: (tester) async {
        tester.view.devicePixelRatio = 1.0;
        tester.view.physicalSize = const Size(481, 480);
      },
    );

    goldenTest(
      goldenFile,
      Column(
        children: [
          ZetaChatItem(
            time: time,
            leading: const ZetaAvatar(initials: 'AZ'),
            slidableActions: [
              ZetaSlidableAction.menuMore(onPressed: () {}),
              ZetaSlidableAction.call(onPressed: () {}),
              ZetaSlidableAction.ptt(onPressed: () {}),
              ZetaSlidableAction.delete(onPressed: () {}),
            ],
            title: title,
            subtitle: subtitle,
          ),
        ],
      ),
      'chat_item_slidable_actions',
      widgetType: ZetaChatItem,
      setUp: (tester) async {
        tester.view.devicePixelRatio = 1.0;
        tester.view.physicalSize = const Size(481, 480);
      },
      beforeComparison: (tester) async {
        final chatItemFinder = find.byType(ZetaChatItem);
        await tester.drag(chatItemFinder, const Offset(-200, 0));
        await tester.pumpAndSettle();
      },
    );

    goldenTest(
      goldenFile,
      Column(
        children: [
          ZetaChatItem(
            time: time,
            leading: const ZetaAvatar(initials: 'AZ'),
            paleButtonColors: true,
            slidableActions: [
              ZetaSlidableAction.menuMore(
                onPressed: () {},
              ),
              ZetaSlidableAction.call(
                onPressed: () {},
              ),
              ZetaSlidableAction.ptt(
                onPressed: () {},
              ),
              ZetaSlidableAction.delete(
                onPressed: () {},
              ),
            ],
            title: title,
            subtitle: subtitle,
          ),
        ],
      ),
      'chat_item_pale_slidable_buttons',
      widgetType: ZetaChatItem,
      setUp: (tester) async {
        tester.view.devicePixelRatio = 1.0;
        tester.view.physicalSize = const Size(481, 480);
      },
      beforeComparison: (tester) async {
        final chatItemFinder = find.byType(ZetaChatItem);
        await tester.drag(chatItemFinder, const Offset(-200, 0));
        await tester.pumpAndSettle();
      },
    );

    goldenTest(
      goldenFile,
      Column(
        children: [
          ZetaChatItem(
            time: time,
            leading: const ZetaAvatar(initials: 'AZ'),
            slidableActions: [
              ZetaSlidableAction(
                onPressed: () {},
                paleColor: true,
                icon: Icons.star,
              ),
              ZetaSlidableAction(
                onPressed: () {},
                paleColor: true,
                icon: Icons.delete,
              ),
              ZetaSlidableAction(
                onPressed: () {},
                icon: Icons.call,
              ),
              ZetaSlidableAction(
                onPressed: () {},
                icon: Icons.message,
              ),
            ],
            title: title,
            subtitle: subtitle,
          ),
        ],
      ),
      'chat_item_pale_and_regular_buttons',
      widgetType: ZetaChatItem,
      setUp: (tester) async {
        tester.view.devicePixelRatio = 1.0;
        tester.view.physicalSize = const Size(481, 480);
      },
      beforeComparison: (tester) async {
        final chatItemFinder = find.byType(ZetaChatItem);
        await tester.drag(chatItemFinder, const Offset(-200, 0));
        await tester.pumpAndSettle();
      },
    );

    goldenTest(
      goldenFile,
      Column(
        children: [
          ZetaChatItem(
            time: time,
            leading: Container(
              width: 40,
              height: 40,
              color: Colors.blue,
            ),
            slidableActions: [
              ZetaSlidableAction.menuMore(onPressed: () {}),
              ZetaSlidableAction.call(onPressed: () {}),
              ZetaSlidableAction.ptt(onPressed: () {}),
              ZetaSlidableAction.delete(onPressed: () {}),
            ],
            title: title,
            subtitle: subtitle,
          ),
        ],
      ),
      'chat_item_custom_leading',
      widgetType: ZetaChatItem,
      setUp: (tester) async {
        tester.view.devicePixelRatio = 1.0;
        tester.view.physicalSize = const Size(481, 480);
      },
    );

    goldenTest(
      goldenFile,
      Column(
        children: [
          ZetaChatItem(
            time: time,
            leading: const ZetaAvatar(initials: 'AZ'),
            slidableActions: [
              ZetaSlidableAction(
                onPressed: () {},
                color: const ZetaPrimitivesLight().orange,
                icon: Icons.star,
              ),
              ZetaSlidableAction(
                onPressed: () {},
                color: const ZetaPrimitivesLight().red,
                icon: Icons.delete,
              ),
            ],
            title: title,
            subtitle: subtitle,
          ),
        ],
      ),
      'chat_item_custom_slidable_buttons',
      widgetType: ZetaChatItem,
      setUp: (tester) async {
        tester.view.devicePixelRatio = 1.0;
        tester.view.physicalSize = const Size(481, 480);
      },
      beforeComparison: (tester) async {
        final chatItemFinder = find.byType(ZetaChatItem);
        await tester.drag(chatItemFinder, const Offset(-200, 0));
        await tester.pumpAndSettle();
      },
    );

    goldenTest(
      goldenFile,
      Column(
        children: [
          ZetaChatItem(
            time: time,
            leading: const ZetaAvatar(initials: 'AZ'),
            slidableActions: [
              ZetaSlidableAction.menuMore(onPressed: () {}),
              ZetaSlidableAction.call(onPressed: () {}),
              ZetaSlidableAction.ptt(onPressed: () {}),
              ZetaSlidableAction.delete(onPressed: () {}),
            ],
            title: title,
            count: 1,
            subtitle: subtitle,
          ),
        ],
      ),
      'chat_item_small_screen_slidable_button',
      widgetType: ZetaChatItem,
      setUp: (tester) async {
        tester.view.devicePixelRatio = 1.0;
        tester.view.physicalSize = const Size(315, 480);
      },
      beforeComparison: (tester) async {
        final chatItemFinder = find.byType(ZetaChatItem);
        await tester.drag(chatItemFinder, const Offset(-200, 0));
        await tester.pumpAndSettle();
      },
    );
  });
  group('Performance Tests', () {});
}
