import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:path/path.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_app.dart';
import '../../../test_utils/tolerant_comparator.dart';
import '../../../test_utils/utils.dart';
import 'search_bar_test.mocks.dart';

abstract class ISearchBarEvents {
  // ignore: unreachable_from_main
  void onChange(String? text);

  // ignore: unreachable_from_main
  void onSubmit(String text);

  // ignore: unreachable_from_main
  Future<String?> onSpeech();
}

@GenerateNiceMocks([
  MockSpec<ISearchBarEvents>(),
])
void main() {
  late MockISearchBarEvents callbacks;

  setUpAll(() {
    final testUri = Uri.parse(getCurrentPath('search_bar'));
    goldenFileComparator = TolerantComparator(testUri, tolerance: 0.01);
  });

  setUp(() {
    callbacks = MockISearchBarEvents();
  });

  group('ZetaSearchBar', () {
    testWidgets('renders with default parameters', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: Scaffold(
            body: ZetaSearchBar(),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('golden: renders initializes correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaSearchBar(),
        ),
      );
      expect(find.byType(ZetaSearchBar), findsOneWidget);

      await expectLater(
        find.byType(ZetaSearchBar),
        matchesGoldenFile(join(getCurrentPath('search_bar'), 'search_bar_default.png')),
      );
    });

    testWidgets('golden: renders size medium correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaSearchBar(),
        ),
      );
      expect(find.byType(ZetaSearchBar), findsOneWidget);

      await expectLater(
        find.byType(ZetaSearchBar),
        matchesGoldenFile(join(getCurrentPath('search_bar'), 'search_bar_medium.png')),
      );
    });

    testWidgets('golden: renders size small correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaSearchBar(
            size: ZetaWidgetSize.small,
          ),
        ),
      );
      expect(find.byType(ZetaSearchBar), findsOneWidget);

      await expectLater(
        find.byType(ZetaSearchBar),
        matchesGoldenFile(join(getCurrentPath('search_bar'), 'search_bar_small.png')),
      );
    });

    testWidgets('golden: renders shape full correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaSearchBar(
            shape: ZetaWidgetBorder.full,
          ),
        ),
      );
      expect(find.byType(ZetaSearchBar), findsOneWidget);

      await expectLater(
        find.byType(ZetaSearchBar),
        matchesGoldenFile(join(getCurrentPath('search_bar'), 'search_bar_full.png')),
      );
    });

    testWidgets('golden: renders shape sharp correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaSearchBar(
            shape: ZetaWidgetBorder.sharp,
          ),
        ),
      );
      expect(find.byType(ZetaSearchBar), findsOneWidget);

      await expectLater(
        find.byType(ZetaSearchBar),
        matchesGoldenFile(join(getCurrentPath('search_bar'), 'search_bar_sharp.png')),
      );
    });

    testWidgets('sets initial value correctly', (WidgetTester tester) async {
      const initialValue = 'Initial value';

      await tester.pumpWidget(
        TestApp(
          home: Scaffold(
            body: ZetaSearchBar(initialValue: initialValue),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text(initialValue), findsOneWidget);
    });

    testWidgets('sets updated initial value correctly', (WidgetTester tester) async {
      const initialValue = 'Initial value';
      const updatedValue = 'Updated value';

      await tester.pumpWidget(
        TestApp(
          home: Scaffold(
            body: ZetaSearchBar(initialValue: initialValue),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text(initialValue), findsOneWidget);

      await tester.pumpWidget(
        TestApp(
          home: Scaffold(
            body: ZetaSearchBar(initialValue: updatedValue),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text(updatedValue), findsOneWidget);
    });

    testWidgets('triggers onChanged callback when text is entered', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: Scaffold(
            body: ZetaSearchBar(onChange: callbacks.onChange),
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField), 'New text');
      await tester.pump();

      verify(callbacks.onChange.call('New text')).called(1);
    });

    testWidgets('triggers onSubmit callback when submit action is performed', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: Scaffold(
            body: ZetaSearchBar(onFieldSubmitted: callbacks.onSubmit),
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField), 'Submit text');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      verify(callbacks.onSubmit.call('Submit text')).called(1);
    });

    testWidgets('triggers onSpeechToText callback when microphone button is pressed', (WidgetTester tester) async {
      when(callbacks.onSpeech.call()).thenAnswer((_) async => 'Speech to text result');

      await tester.pumpWidget(
        TestApp(
          home: Scaffold(
            body: ZetaSearchBar(
              onSpeechToText: callbacks.onSpeech,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('speech-to-text-btn')));
      await tester.pump();

      verify(callbacks.onSpeech.call()).called(1);
    });

    testWidgets('does not allow text input when disabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: Scaffold(
            body: ZetaSearchBar(disabled: true),
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField), 'Disabled input');
      await tester.pump();

      expect(find.text('Disabled input'), findsNothing);
    });

    testWidgets('speech-to-text button visibility', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: Scaffold(
            body: ZetaSearchBar(
              showSpeechToText: false,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byIcon(ZetaIcons.search), findsNothing);
      expect(find.byIcon(ZetaIcons.microphone), findsNothing);
    });

    testWidgets('clear button functionality', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: Scaffold(
            body: ZetaSearchBar(onChange: callbacks.onChange),
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField), 'New text');
      await tester.pump();

      verify(callbacks.onChange.call('New text')).called(1);

      await tester.tap(find.byKey(const ValueKey('search-clear-btn')));
      await tester.pump();

      verify(callbacks.onChange.call('')).called(1);
    });

    test('debugFillProperties', () {
      final searchBar = ZetaSearchBar();
      final properties = DiagnosticPropertiesBuilder();

      searchBar.debugFillProperties(properties);

      expect(properties.properties.length, 9);
      expect(properties.properties[0].name, 'size');
      expect(properties.properties[1].name, 'shape');
      expect(properties.properties[2].name, 'hintText');
      expect(properties.properties[3].name, 'initialValue');
      expect(properties.properties[4].name, 'onSpeechToText');
      expect(properties.properties[5].name, 'showSpeechToText');
      expect(properties.properties[6].name, 'focusNode');
      expect(properties.properties[7].name, 'textInputAction');
      expect(properties.properties[8].name, 'microphoneSemanticLabel');
    });
  });
}
