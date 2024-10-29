import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_app.dart';
import '../../../test_utils/tolerant_comparator.dart';
import '../../../test_utils/utils.dart';

void main() {
  const String parentFolder = 'top_app_bar';

  const goldenFile = GoldenFiles(component: parentFolder);
  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });

  group('ZetaTopAppBar Accessibility Tests', () {
    testWidgets('ZetaTopAppBar meets accessibility  requirements', (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(
        TestApp(
          home: ZetaTopAppBar(
            title: const Text('Title'),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                tooltip: 'Search',
                onPressed: () {},
              ),
            ],
            leading: IconButton(
              icon: const Icon(Icons.menu),
              tooltip: 'Menu',
              onPressed: () {},
            ),
          ),
        ),
      );
      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
      await expectLater(tester, meetsGuideline(textContrastGuideline));

      handle.dispose();
    });

    testWidgets('ZetaTopAppBar passes semantic labels to the search actions', (WidgetTester tester) async {
      const microphoneSemanticLabel = 'Search with voice';
      const clearSemanticLabel = 'Clear search';
      const searchBackSemanticLabel = 'Back';
      const searchSemanticLabel = 'Search';
      final ZetaSearchController searchController = ZetaSearchController();
      await tester.pumpWidget(
        TestApp(
          home: ZetaTopAppBar.search(
            title: const Text('Title'),
            microphoneSemanticLabel: microphoneSemanticLabel,
            clearSemanticLabel: clearSemanticLabel,
            searchController: searchController,
            searchSemanticLabel: searchSemanticLabel,
            searchBackSemanticLabel: searchBackSemanticLabel,
            onSearchMicrophoneIconPressed: () {},
          ),
        ),
      );

      expect(
        find.bySemanticsLabel(searchSemanticLabel),
        findsOneWidget,
      );

      searchController.startSearch();
      await tester.pumpAndSettle();

      expect(
        find.bySemanticsLabel(microphoneSemanticLabel),
        findsOneWidget,
      );
      expect(
        find.bySemanticsLabel(clearSemanticLabel),
        findsOneWidget,
      );
      expect(
        find.bySemanticsLabel(searchBackSemanticLabel),
        findsOneWidget,
      );
    });
  });

  group('ZetaTopAppBar Content Tests', () {
    final debugFillProperties = {
      'titleTextStyle': 'null',
      'onSearch': 'null',
      'automaticallyImplyLeading': 'true',
      'onSearchMicrophoneIconPressed': 'null',
      'searchController': 'null',
      'searchHintText': 'null',
      'type': 'defaultAppBar',
      'shrinks': 'false',
      'clearSemanticLabel': 'null',
      'microphoneSemanticLabel': 'null',
      'searchSemanticLabel': 'null',
      'searchBackSemanticLabel': 'null',
    };
    debugFillPropertiesTest(
      const ZetaTopAppBar(),
      debugFillProperties,
    );

    test(
      'ZetaTopAppBar Search throws an assertion error if its type is set to extended',
      () {
        expect(
          () => ZetaTopAppBar.search(
            title: const Text('Title'),
            type: ZetaTopAppBarType.extended,
          ),
          throwsA(isA<AssertionError>()),
        );
      },
    );

    testWidgets('ZetaTopAppBar displays the title correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaTopAppBar(
            title: Text('Title'),
          ),
        ),
      );

      expect(find.text('Title'), findsOneWidget);
    });

    testWidgets('ZetaTopAppBar displays the leading widget correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaTopAppBar(
            title: const Text('Title'),
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.menu), findsOneWidget);
    });

    testWidgets('ZetaTopAppBar displays the actions correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaTopAppBar(
            title: const Text('Title'),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
            ],
          ),
        ),
      );

      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('ZetaExtendedAppBarDelegate builds correctly', (WidgetTester tester) async {
      const title = Text('Title');
      final actions = [IconButton(icon: const Icon(Icons.search), onPressed: () {})];
      final leading = IconButton(icon: const Icon(Icons.menu), onPressed: () {});
      const boxKey = Key('box');

      await tester.pumpWidget(
        TestApp(
          home: Builder(
            builder: (context) {
              return SizedBox(
                child: CustomScrollView(
                  slivers: [
                    ZetaTopAppBar.extended(leading: leading, title: title, actions: actions),
                    SliverToBoxAdapter(
                      child: Container(
                        width: 800,
                        height: 700,
                        color: Zeta.of(context).colors.surfaceSelectedHover,
                        key: boxKey,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );

      final boxFinder = find.byKey(boxKey);
      expect(boxFinder, findsOneWidget);

      await tester.drag(boxFinder.first, const Offset(0, -100));
      await tester.pumpAndSettle();

      final appBarFinder = find.byType(ZetaTopAppBar);
      expect(appBarFinder, findsOneWidget);

      final titleFinder = find.descendant(of: appBarFinder, matching: find.byWidget(title));
      expect(titleFinder, findsOneWidget);

      final actionsFinder = find.descendant(of: appBarFinder, matching: find.byWidget(actions[0]));
      expect(actionsFinder, findsOneWidget);

      final leadingFinder = find.descendant(of: appBarFinder, matching: find.byWidget(leading));
      expect(leadingFinder, findsOneWidget);
    });
  });

  group('ZetaTopAppBar Dimensions Tests', () {
    testWidgets('ZetaTopAppBar has the correct height', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaTopAppBar(
            title: Text('Title'),
          ),
        ),
      );

      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.preferredSize.height, 64);
    });
  });

  group('ZetaTopAppBar Styling Tests', () {
    testWidgets('ZetaTopAppBar has the correct background color', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaTopAppBar(
            title: Text('Title'),
          ),
        ),
      );

      final BuildContext context = tester.element(find.byType(MaterialApp));
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.backgroundColor, Zeta.of(context).colors.surfaceDefault);
    });
  });

  group('ZetaTopAppBar Interaction Tests', () {
    late ZetaSearchController searchController;
    const searchLabel = 'Search';
    const clearLabel = 'Clear';
    const backLabel = 'Back';

    late Widget subject;

    setUp(() {
      searchController = ZetaSearchController();
      subject = TestApp(
        home: ZetaTopAppBar.search(
          title: const Text('Title'),
          searchController: searchController,
          searchSemanticLabel: searchLabel,
          clearSemanticLabel: clearLabel,
          searchBackSemanticLabel: backLabel,
        ),
      );
    });

    testWidgets(
      'ZetaTopAppBar Search opens and closes the search bar when the search/back icon is tapped',
      (WidgetTester tester) async {
        await tester.pumpWidget(subject);

        expect(searchController.isEnabled, isFalse);
        await tester.tap(find.bySemanticsLabel(searchLabel));
        await tester.pumpAndSettle();

        expect(searchController.isEnabled, isTrue);

        await tester.tap(find.bySemanticsLabel(backLabel));
        await tester.pumpAndSettle();

        expect(searchController.isEnabled, isFalse);
      },
    );

    testWidgets(
      'ZetaTopAppBar Search allows text to be typed in the search field',
      (WidgetTester tester) async {
        await tester.pumpWidget(subject);

        searchController.startSearch();
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextField), 'Search text');
        expect(searchController.text, 'Search text');
      },
    );

    testWidgets(
      'ZetaTopAppBar Search gets cleared when the clear button is tapped',
      (WidgetTester tester) async {
        await tester.pumpWidget(subject);

        searchController.startSearch();
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextField), 'Search text');
        await tester.tap(find.bySemanticsLabel(clearLabel));
        expect(searchController.text, '');
      },
    );

    testWidgets(
      'ZetaTopAppBar Search submits the correct text when the search input is submitted',
      (WidgetTester tester) async {
        String inputtedText = '';
        await tester.pumpWidget(
          TestApp(
            home: ZetaTopAppBar.search(
              title: const Text('Title'),
              searchController: searchController,
              onSearch: (String text) {
                inputtedText = text;
              },
            ),
          ),
        );

        searchController.startSearch();
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextField), 'Search text');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        expect(inputtedText, 'Search text');
      },
    );

    testWidgets('ZetaExtendedAppBarDelegate shrinks correctly with padding', (WidgetTester tester) async {
      const title = Text('Title');
      final actions = [IconButton(icon: const Icon(Icons.search), onPressed: () {})];
      final leading = IconButton(icon: const Icon(Icons.menu), onPressed: () {});
      const boxKey = Key('box');

      await tester.pumpWidget(
        TestApp(
          home: Builder(
            builder: (context) {
              return SizedBox(
                child: CustomScrollView(
                  slivers: [
                    ZetaTopAppBar.extended(leading: leading, title: title, actions: actions),
                    SliverToBoxAdapter(
                      child: Container(
                        width: 800,
                        height: 700,
                        color: Zeta.of(context).colors.surfaceSelectedHover,
                        key: boxKey,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );

      final boxFinder = find.byKey(boxKey);
      expect(boxFinder, findsOneWidget);

      await tester.drag(boxFinder.first, const Offset(0, -100));
      await tester.pumpAndSettle();

      final appBarFinder = find.byType(ZetaTopAppBar);
      expect(appBarFinder, findsOneWidget);

      final positionedFinder = find.descendant(of: appBarFinder, matching: find.byType(Positioned));

      final positionedWidget = tester.widget<Positioned>(positionedFinder.first);
      expect(positionedWidget.left, 64);
    });

    testWidgets('ZetaExtendedAppBarDelegate shrinks correctly with padding and no leading',
        (WidgetTester tester) async {
      const title = Text('Title');
      final actions = [IconButton(icon: const Icon(Icons.search), onPressed: () {})];

      const boxKey = Key('box');

      await tester.pumpWidget(
        TestApp(
          home: Builder(
            builder: (context) {
              return SizedBox(
                child: CustomScrollView(
                  slivers: [
                    ZetaTopAppBar.extended(title: title, actions: actions),
                    SliverToBoxAdapter(
                      child: Container(
                        width: 800,
                        height: 700,
                        color: Zeta.of(context).colors.surfaceSelectedHover,
                        key: boxKey,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );

      final boxFinder = find.byKey(boxKey);
      expect(boxFinder, findsOneWidget);

      await tester.drag(boxFinder.first, const Offset(0, -100));
      await tester.pumpAndSettle();

      final appBarFinder = find.byType(ZetaTopAppBar);
      expect(appBarFinder, findsOneWidget);

      final positionedFinder = find.descendant(of: appBarFinder, matching: find.byType(Positioned));

      final positionedWidget = tester.widget<Positioned>(positionedFinder.first);
      expect(positionedWidget.left, 16);
    });
  });

  group('ZetaTopAppBar Golden Tests', () {
    goldenTest(
      goldenFile,
      const ZetaTopAppBar(
        title: Text('Title'),
      ),
      'top_app_bar_default',
    );

    goldenTest(
      goldenFile,
      ZetaTopAppBar(
        title: const Text('Title'),
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () {},
          ),
        ],
      ),
      'top_app_bar_default_actions',
    );

    goldenTest(
      goldenFile,
      const ZetaTopAppBar.centered(
        title: Text('Title'),
      ),
      'top_app_bar_centered',
    );

    goldenTest(
      goldenFile,
      ZetaTopAppBar.centered(
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () {},
          ),
        ],
        title: const Text('Title'),
      ),
      'top_app_bar_centered_actions',
    );

    goldenTest(
      goldenFile,
      const ZetaTopAppBar.search(
        title: Text('Search'),
      ),
      'top_app_bar_search',
    );

    goldenTest(
      goldenFile,
      const ZetaTopAppBar.search(
        title: Text('Search'),
        type: ZetaTopAppBarType.centered,
      ),
      'top_app_bar_search_centered',
    );

    final searchController = ZetaSearchController();
    goldenTest(
      goldenFile,
      ZetaTopAppBar.search(
        title: const Text('Search'),
        type: ZetaTopAppBarType.centered,
        searchController: searchController,
      ),
      beforeComparison: (tester) async {
        searchController.startSearch();
        await tester.pumpAndSettle();
      },
      'top_app_bar_search_active',
    );

    goldenTest(
      goldenFile,
      const CustomScrollView(
        slivers: [
          ZetaTopAppBar.extended(
            title: Text('Title'),
          ),
        ],
      ),
      widgetType: ZetaTopAppBar,
      beforeComparison: (tester) async {
        searchController.startSearch();
        await tester.pumpAndSettle();
      },
      'top_app_bar_extended',
    );

    goldenTest(
      goldenFile,
      CustomScrollView(
        slivers: [
          ZetaTopAppBar.extended(
            title: const Text('Title'),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                tooltip: 'Search',
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
      widgetType: ZetaTopAppBar,
      beforeComparison: (tester) async {
        searchController.startSearch();
        await tester.pumpAndSettle();
      },
      'top_app_bar_extended_actions',
    );
  });

  group('ZetaTopAppBar Performance Tests', () {});
}
