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
        const TestApp(
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
        const TestApp(
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
        const TestApp(
          home: ZetaSearchBar(
            size: ZetaWidgetSize.medium,
          ),
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
        const TestApp(
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
        const TestApp(
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
        const TestApp(
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
        const TestApp(
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
        const TestApp(
          home: Scaffold(
            body: ZetaSearchBar(initialValue: initialValue),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text(initialValue), findsOneWidget);

      await tester.pumpWidget(
        const TestApp(
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
            body: ZetaSearchBar(onChanged: callbacks.onChange),
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
            body: ZetaSearchBar(onSubmit: callbacks.onSubmit),
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
        const TestApp(
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

    testWidgets('leading icon and speech-to-text button visibility', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: Scaffold(
            body: ZetaSearchBar(
              showLeadingIcon: false,
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
            body: ZetaSearchBar(onChanged: callbacks.onChange),
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

    test('debugFillProperties sets the correct properties', () {
      const size = ZetaWidgetSize.medium;
      const shape = ZetaWidgetBorder.rounded;
      const hint = 'Search here';
      const initialValue = 'Initial value';
      const disabled = true;
      const showLeadingIcon = false;
      const showSpeechToText = false;
      const textInputAction = TextInputAction.search;

      final widget = ZetaSearchBar(
        size: size,
        shape: shape,
        hint: hint,
        initialValue: initialValue,
        onChanged: callbacks.onChange,
        onSubmit: callbacks.onSubmit,
        onSpeechToText: callbacks.onSpeech,
        disabled: disabled,
        showLeadingIcon: showLeadingIcon,
        showSpeechToText: showSpeechToText,
        textInputAction: textInputAction,
      );

      final DiagnosticPropertiesBuilder builder = DiagnosticPropertiesBuilder();
      widget.debugFillProperties(builder);

      expect(builder.findProperty('size'), size);
      expect(builder.findProperty('shape'), shape);
      expect(builder.findProperty('hint'), hint);
      expect(builder.findProperty('enabled'), disabled);
      expect(builder.findProperty('initialValue'), initialValue);
      expect(builder.findProperty('showLeadingIcon'), showLeadingIcon);
      expect(builder.findProperty('showSpeechToText'), showSpeechToText);
      expect(builder.findProperty('textInputAction'), textInputAction);
      expect(builder.findProperty('focusNode'), null);
      expect(builder.findProperty('onChanged'), callbacks.onChange);
      expect(builder.findProperty('onSpeechToText'), callbacks.onSpeech);
      expect(builder.findProperty('onSubmit'), callbacks.onSubmit);
    });
  });
}
