import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_app.dart';
import '../../../test_utils/tolerant_comparator.dart';
import '../../../test_utils/utils.dart';

void main() {
  const String componentName = 'ZetaTopAppbar';
  const String parentFolder = 'top_app_bar';

  const goldenFile = GoldenFiles(component: parentFolder);
  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });

  group('$componentName Accessibility Tests', () {
    testWidgets('$componentName meets accessibility  requirements', (WidgetTester tester) async {
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
              )
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

    testWidgets('$componentName passes semantic labels to the search actions', (WidgetTester tester) async {
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

  group('$componentName Content Tests', () {
    final debugFillProperties = {
      'titleTextStyle': 'null',
      'onSearch': 'null',
      'automaticallyImplyLeading': 'true',
      'onSearchMicrophoneIconPressed': 'null',
      'searchController': 'null',
      'searchHintText': 'null',
      'type': 'defaultAppBar',
      'shrinks': 'false',
    };
    debugFillPropertiesTest(
      const ZetaTopAppBar(),
      debugFillProperties,
    );
  });

  group('$componentName Dimensions Tests', () {});
  group('$componentName Styling Tests', () {});
  group('$componentName Interaction Tests', () {
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
      '$componentName Search opens and closes the search bar when the search/back icon is tapped',
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
      '$componentName Search allows text to be typed in the search field',
      (WidgetTester tester) async {
        await tester.pumpWidget(subject);

        searchController.startSearch();
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextField), 'Search text');
        expect(searchController.text, 'Search text');
      },
    );

    testWidgets(
      '$componentName Search gets cleared when the clear button is tapped',
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
      '$componentName Search submits the correct text when the search input is submitted',
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
  });

  group('$componentName Golden Tests', () {
    goldenTest(
      goldenFile,
      const ZetaTopAppBar(
        title: Text('Title'),
      ),
      ZetaTopAppBar,
      'top_app_bar_default',
    );
  });

  group('$componentName Performance Tests', () {});
}
