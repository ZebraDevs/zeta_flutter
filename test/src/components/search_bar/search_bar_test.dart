import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
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
  const String parentFolder = 'search_bar';

  const goldenFile = GoldenFiles(component: parentFolder);
  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });

  setUp(() {
    callbacks = MockISearchBarEvents();
  });

  group('Accessibility Tests', () {});
  group('Content Tests', () {
    final debugFillProperties = {
      'size': 'medium',
      'shape': 'rounded',
      'placeholder': 'null',
      'textInputAction': 'null',
      'onSpeechToText': 'null',
      'showSpeechToText': 'true',
      'focusNode': 'null',
      'microphoneSemanticLabel': 'null',
      'clearSemanticLabel': 'null',
    };
    debugFillPropertiesTest(
      ZetaSearchBar(),
      debugFillProperties,
    );

    testWidgets('renders text field', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: Scaffold(
            body: ZetaSearchBar(),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(TextField), findsOneWidget);
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
  });
  group('Dimensions Tests', () {});
  group('Styling Tests', () {});
  group('Interaction Tests', () {
    testWidgets('triggers onChanged callback when text is entered', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: Scaffold(
            body: ZetaSearchBar(onChange: callbacks.onChange),
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'New text');
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
      await tester.enterText(find.byType(TextField), 'Submit text');
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
      await tester.enterText(find.byType(TextField), 'Disabled input');
      await tester.pump();

      expect(find.text('Disabled input'), findsNothing);
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
      await tester.enterText(find.byType(TextField), 'New text');
      await tester.pump();

      verify(callbacks.onChange.call('New text')).called(1);

      await tester.tap(find.byKey(const ValueKey('search-clear-btn')));
      await tester.pump();

      verify(callbacks.onChange.call('')).called(1);
    });
  });
  group('Golden Tests', () {
    goldenTest(goldenFile, ZetaSearchBar(), 'search_bar_default');
    goldenTest(goldenFile, ZetaSearchBar(), 'search_bar_medium');
    goldenTest(
      goldenFile,
      ZetaSearchBar(
        size: ZetaWidgetSize.small,
      ),
      'search_bar_small',
    );
    goldenTest(
      goldenFile,
      ZetaSearchBar(
        shape: ZetaWidgetBorder.full,
      ),
      'search_bar_full',
    );
    goldenTest(
      goldenFile,
      ZetaSearchBar(
        shape: ZetaWidgetBorder.sharp,
      ),
      'search_bar_sharp',
    );
  });
  group('Performance Tests', () {});
}
