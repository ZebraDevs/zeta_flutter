import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_app.dart';
import '../../../test_utils/tolerant_comparator.dart';
import '../../../test_utils/utils.dart';
import 'chat_item_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<ZetaSemanticColors>(),
])
void main() {
  const goldenFile = GoldenFiles(component: 'chat_item');
  late MockZetaSemanticColors mockZetaColors;

  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);

    mockZetaColors = MockZetaSemanticColors();
    when(mockZetaColors.primitives).thenReturn(const ZetaPrimitivesLight());
  });

  group('ZetaChatItem Tests', () {
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

      await expectLater(
        chatItemFinder,
        matchesGoldenFile(goldenFile.getFileUri('chat_item_default')),
      );
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

      await expectLater(
        chatItemFinder,
        matchesGoldenFile(goldenFile.getFileUri('chat_item_highlighted')),
      );
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
      expect(find.byIcon(ZetaIcons.more_vertical_round), findsOneWidget);
      expect(find.byIcon(ZetaIcons.phone_round), findsOneWidget);
      expect(find.byIcon(ZetaIcons.ptt_round), findsOneWidget);
      expect(find.byIcon(ZetaIcons.delete_round), findsOneWidget);

      // Verify that tapping on the slidable actions triggers the corresponding callbacks
      await tester.tap(find.byIcon(ZetaIcons.more_vertical_round));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.tap(find.byIcon(ZetaIcons.phone_round));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.tap(find.byIcon(ZetaIcons.ptt_round));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.tap(find.byIcon(ZetaIcons.delete_round));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await expectLater(
        chatItemFinder,
        matchesGoldenFile(goldenFile.getFileUri('chat_item_slidable_actions')),
      );
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
      expect(find.byIcon(ZetaIcons.more_vertical_round), findsOneWidget);
      expect(find.byIcon(ZetaIcons.phone_round), findsOneWidget);
      expect(find.byIcon(ZetaIcons.ptt_round), findsOneWidget);
      expect(find.byIcon(ZetaIcons.delete_round), findsOneWidget);

      await expectLater(
        chatItemFinder,
        matchesGoldenFile(goldenFile.getFileUri('chat_item_pale_slidable_buttons')),
      );
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

      await expectLater(
        chatItemFinder,
        matchesGoldenFile(goldenFile.getFileUri('chat_item_pale_and_regular_buttons')),
      );
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

      final chatItemFinder = find.byType(ZetaChatItem);

      // Verify that the custom leading widget is displayed correctly
      expect(find.byType(Container), findsOneWidget);
      expect(find.byWidgetPredicate((widget) => widget is Container && widget.color == Colors.blue), findsOneWidget);

      await expectLater(
        chatItemFinder,
        matchesGoldenFile(goldenFile.getFileUri('chat_item_custom_leading')),
      );
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
                    color: ZetaColorBase.orange,
                    icon: Icons.star,
                  ),
                  ZetaSlidableAction(
                    onPressed: () {},
                    color: ZetaColorBase.red,
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

    testWidgets('debugFillProperties works correctly', (WidgetTester tester) async {
      final diagnosticsZetaChatItem = DiagnosticPropertiesBuilder();
      final time = DateTime.now();
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
      ).debugFillProperties(diagnosticsZetaChatItem);

      expect(diagnosticsZetaChatItem.finder('rounded'), 'null');
      expect(diagnosticsZetaChatItem.finder('highlighted'), 'true');
      expect(diagnosticsZetaChatItem.finder('time'), time.toString());
      expect(diagnosticsZetaChatItem.finder('timeFormat'), 'null');
      expect(diagnosticsZetaChatItem.finder('enabledWarningIcon'), 'true');
      expect(diagnosticsZetaChatItem.finder('enabledNotificationIcon'), 'true');
      expect(diagnosticsZetaChatItem.finder('count'), '1');
      expect(diagnosticsZetaChatItem.finder('onTap'), 'null');
      expect(diagnosticsZetaChatItem.finder('starred'), 'true');
      expect(diagnosticsZetaChatItem.finder('onMenuMoreTap'), 'null');
      expect(diagnosticsZetaChatItem.finder('onCallTap'), 'null');
      expect(diagnosticsZetaChatItem.finder('onDeleteTap'), 'null');
      expect(diagnosticsZetaChatItem.finder('onPttTap'), 'null');
      expect(diagnosticsZetaChatItem.finder('explicitChildNodes'), 'true');
      expect(diagnosticsZetaChatItem.finder('paleButtonColors'), 'null');

      final diagnosticsZetaSlidableAction = DiagnosticPropertiesBuilder();
      const ZetaSlidableAction(icon: Icons.star).debugFillProperties(diagnosticsZetaSlidableAction);

      expect(diagnosticsZetaSlidableAction.finder('onPressed'), 'null');
      expect(diagnosticsZetaSlidableAction.finder('icon'), 'IconData(U+0E5F9)');
      expect(diagnosticsZetaSlidableAction.finder('foregroundColor'), null);
      expect(diagnosticsZetaSlidableAction.finder('backgroundColor'), null);
      expect(diagnosticsZetaSlidableAction.finder('color'), ZetaColorBase.blue.toString());
      expect(diagnosticsZetaSlidableAction.finder('semanticLabel'), 'null');
      expect(diagnosticsZetaSlidableAction.finder('paleColor'), 'false');
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
      expect(find.byIcon(ZetaIcons.more_vertical_round), findsOneWidget);
      expect(find.byIcon(ZetaIcons.phone_round), findsOneWidget);
      expect(find.byIcon(ZetaIcons.ptt_round), findsOneWidget);
      expect(find.byIcon(ZetaIcons.delete_round), findsOneWidget);

      // Verify that tapping on the slidable actions triggers the corresponding callbacks
      await tester.tap(find.byIcon(ZetaIcons.more_vertical_round));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.tap(find.byIcon(ZetaIcons.phone_round));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.tap(find.byIcon(ZetaIcons.ptt_round));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.tap(find.byIcon(ZetaIcons.delete_round));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await expectLater(
        chatItemFinder,
        matchesGoldenFile(goldenFile.getFileUri('chat_item_small_screen_slidable_button')),
      );
    });
  });
}
