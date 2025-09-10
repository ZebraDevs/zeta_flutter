import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/src/components/message_input/actions/action_button.dart';
import 'package:zeta_flutter/src/components/message_input/actions/image_button.dart';
import 'package:zeta_flutter/src/components/message_input/actions/send_button.dart';
import 'package:zeta_flutter/src/components/message_input/actions/voice_button.dart';
import 'package:zeta_flutter/src/components/message_input/panels/attachments_panel.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_utils.dart';

void main() {
  group('Accessibility Tests', () {
    testWidgets('Input has correct semantics/aria-label', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: ZetaMessageInput(placeholder: 'Type a message', onSend: (_) {})),
        ),
      );
      final textField = find.byType(TextField);
      expect(textField, findsOneWidget);
      final semantics = tester.getSemantics(textField);
      // Check that the semantics label contains the placeholder
      expect(semantics.label, contains('Type a message'));
    });

    testWidgets('Image button has correct semantics', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: ZetaMessageInput(cameraTrailingButton: true, onSend: (_) {})),
        ),
      );
      final imageButton = find.byType(ImageButton);
      expect(imageButton, findsOneWidget);
      final semantics = tester.getSemantics(imageButton);
      expect(semantics.label, contains('capture an image'));
    });

    testWidgets('Action menu button has correct semantics', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: ZetaMessageInput.actionMenu(onSend: (_) {})),
        ),
      );
      final actionMenuButton = find.widgetWithIcon(ActionButton, ZetaIcons.add);
      expect(actionMenuButton, findsOneWidget);
      final semantics = tester.getSemantics(actionMenuButton);
      expect(semantics.label, contains('open action menu'));
    });

    testWidgets('voice button has correct semantics', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZetaMessageInput(
              onSend: (_) {},
              allowsVoiceInput: true,
            ),
          ),
        ),
      );
      final voiceButton = find.byType(VoiceButton);
      expect(voiceButton, findsOneWidget);
      final semantics = tester.getSemantics(voiceButton);
      expect(semantics.label, contains('voice input'));
    });
  });

  group('Content Tests', () {
    testWidgets('Attachments bar opens when attachments are added', (WidgetTester tester) async {
      final controller = TextEditingController();
      final attachments = <File>[File('test1.png')];
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZetaMessageInput(
              controller: controller,
              attachments: attachments,
              onSend: (_) {},
            ),
          ),
        ),
      );
      // AttachmentsPanel should be present
      expect(find.byType(AttachmentsPanel), findsOneWidget);
    });

    testWidgets('Attachments bar closes when all attachments are removed', (WidgetTester tester) async {
      final controller = TextEditingController();
      final attachments = <File>[File('test1.png')];
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return ZetaMessageInput(
                  controller: controller,
                  attachments: attachments,
                  onSend: (_) {},
                  onSendAttachments: (files) {
                    setState(attachments.clear);
                  },
                );
              },
            ),
          ),
        ),
      );
      // Initially, AttachmentsPanel should be present
      expect(find.byType(AttachmentsPanel), findsOneWidget);
      // Remove attachments
      attachments.clear();
      await tester.pump();
      // AttachmentsPanel should not be present
      expect(find.byType(AttachmentsPanel), findsNothing);
    });

    testWidgets('entire component can be disabled', (WidgetTester tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(
        MaterialApp(
          home: TestApp(
            home: ZetaMessageInput(
              controller: controller,
              disabled: true,
              allowsVoiceInput: true,
              cameraTrailingButton: true,
              hasActionMenu: true,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Input should be disabled
      final textField = find.byType(TextField);
      expect(textField, findsOneWidget);
      expect(tester.widget<TextField>(textField).enabled, isFalse);

      // Action menu button should be disabled
      final actionMenuButton = find.widgetWithIcon(ActionButton, ZetaIcons.add);
      expect(actionMenuButton, findsOneWidget);
      final actionMenuIconButton = find.descendant(
        of: actionMenuButton,
        matching: find.byType(IconButton),
      );
      expect(actionMenuIconButton, findsOneWidget);
      expect(tester.widget<IconButton>(actionMenuIconButton).onPressed, isNull);

      // Main bar camera button should be disabled
      final imageButton = find.byType(ImageButton);
      expect(imageButton, findsOneWidget);
      final imageButtonIconButton = find.descendant(
        of: imageButton,
        matching: find.byType(IconButton),
      );
      expect(imageButtonIconButton, findsOneWidget);
      expect(tester.widget<IconButton>(imageButtonIconButton).onPressed, isNull);
    });

    testWidgets('input accepts newline characters when maxLines > 1', (WidgetTester tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(
        MaterialApp(
          home: TestApp(
            home: ZetaMessageInput(
              controller: controller,
              minLines: 1,
              maxLines: 5,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final textField = find.byType(TextField);
      expect(textField, findsOneWidget);

      // Enter multiline text
      const multilineText = 'Line 1\nLine 2\nLine 3';
      await tester.enterText(textField, multilineText);
      await tester.pumpAndSettle();
      expect(controller.text, multilineText);
    });
    testWidgets('input does not accept newline characters when maxLines = 1', (WidgetTester tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(
        MaterialApp(
          home: TestApp(
            home: ZetaMessageInput(
              controller: controller,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final textField = find.byType(TextField);
      expect(textField, findsOneWidget);

      // Enter multiline text
      const multilineText = 'Line 1\nLine 2\nLine 3';
      const singleText = 'Line 1Line 2Line 3';
      await tester.enterText(textField, multilineText);
      await tester.pumpAndSettle();
      expect(controller.text, singleText);
    });

    testWidgets('placeholder is displayed when input is empty', (WidgetTester tester) async {
      final controller = TextEditingController();
      const placeholderText = 'Type your message...';
      await tester.pumpWidget(
        MaterialApp(
          home: TestApp(
            home: ZetaMessageInput(
              controller: controller,
              placeholder: placeholderText,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Find the placeholder text
      expect(find.text(placeholderText), findsOneWidget);
    });

    testWidgets('controller and input are empty with initial state', (WidgetTester tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(
        MaterialApp(
          home: TestApp(
            home: ZetaMessageInput(
              controller: controller,
              attachments: const [],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Controller is empty
      expect(controller.text, '');

      // Find the TextField and verify it's empty
      final textField = find.byType(TextField);
      expect(textField, findsOneWidget);
      expect(tester.widget<TextField>(textField).controller?.text ?? '', '');
    });

    /* TODO: Implement maxLength for message input */
    // testWidgets('input accepts up to maxLength characters', (WidgetTester tester) async {
    //   final controller = TextEditingController();
    //   await tester.pumpWidget(MaterialApp(
    //     home: Scaffold(
    //       body: ZetaMessageInput(
    //         controller: controller,
    //         maxLength: 10,
    //       ),
    //     ),
    //   ));

    //   final inputFinder = find.byType(TextField);
    //   expect(inputFinder, findsOneWidget);

    //   // Enter exactly maxLength characters
    //   await tester.enterText(inputFinder, '1234567890');
    //   await tester.pump();
    //   expect(controller.text, '1234567890');
    //   expect(controller.text.length, 10);
    // });

    // testWidgets('additional characters beyond maxLength are ignored', (WidgetTester tester) async {
    //   final controller = TextEditingController();
    //   await tester.pumpWidget(MaterialApp(
    //     home: Scaffold(
    //       body: ZetaMessageInput(
    //         controller: controller,
    //         maxLength: 10,
    //       ),
    //     ),
    //   ));

    //   final inputFinder = find.byType(TextField);
    //   expect(inputFinder, findsOneWidget);

    //   // Enter more than maxLength characters
    //   await tester.enterText(inputFinder, '123456789012345');
    //   await tester.pump();
    //   expect(controller.text, '1234567890');
    //   expect(controller.text.length, 10);
    // });

    testWidgets('send button onPressed is null with initialState', (WidgetTester tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(
        MaterialApp(
          home: TestApp(
            home: ZetaMessageInput(
              controller: controller,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Find the send button and verify it's disabled
      final sendButton = find.byType(SendButton);
      expect(sendButton, findsOneWidget);
      expect(tester.widget<SendButton>(sendButton).onPressed, isNull);
    });
  });

  group('Dimensions Tests', () {});

  group('Styling Tests', () {
    testWidgets('send button is colors.mainDisabled with initialState', (WidgetTester tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(
        MaterialApp(
          home: TestApp(
            home: ZetaMessageInput(
              controller: controller,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final context = getBuildContext(tester, ZetaMessageInput);
      final colors = Zeta.of(context).colors;

      final sendButton = find.byType(SendButton);
      expect(sendButton, findsOneWidget);

      // Check color is mainDisabled
      final icon = tester.widget<Icon>(find.descendant(of: sendButton, matching: find.byType(Icon)));
      expect(icon.color, colors.mainDisabled);
    });
  });

  group('Interaction Tests', () {
    testWidgets('clicking send with text invokes onSend callback with correct message', (WidgetTester tester) async {
      final controller = TextEditingController();
      String? sentMessage;
      await tester.pumpWidget(
        MaterialApp(
          home: TestApp(
            home: ZetaMessageInput(
              controller: controller,
              onSend: (msg) => sentMessage = msg,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final textField = find.byType(TextField);
      await tester.enterText(textField, 'Hello world');
      await tester.pump();

      final sendButton = find.byType(SendButton);
      await tester.tap(sendButton);
      await tester.pump();

      expect(sentMessage, 'Hello world');
    });

    testWidgets('send button becomes default color when input has valid non-whitespace text and onSend is provided',
        (WidgetTester tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(
        MaterialApp(
          home: TestApp(
            home: ZetaMessageInput(
              controller: controller,
              onSend: (value) {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final context = getBuildContext(tester, ZetaMessageInput);
      final colors = Zeta.of(context).colors;

      final textField = find.byType(TextField);
      expect(textField, findsOneWidget);

      await tester.enterText(textField, 'Hello');
      await tester.pump();

      final sendButton = find.byType(SendButton);
      expect(sendButton, findsOneWidget);

      // Check color is mainDefault
      final icon = tester.widget<Icon>(find.descendant(of: sendButton, matching: find.byType(Icon)));
      expect(icon.color, colors.mainDefault);
    });

    testWidgets('send button remains as disabled color for whitespace-only input', (WidgetTester tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(
        MaterialApp(
          home: TestApp(
            home: ZetaMessageInput(controller: controller),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final context = getBuildContext(tester, ZetaMessageInput);
      final colors = Zeta.of(context).colors;

      final textField = find.byType(TextField);
      expect(textField, findsOneWidget);

      await tester.enterText(textField, '   ');
      await tester.pump();

      final sendButton = find.byType(SendButton);
      expect(sendButton, findsOneWidget);

      // Check color is mainDisabled
      final icon = tester.widget<Icon>(find.descendant(of: sendButton, matching: find.byType(Icon)));
      expect(icon.color, colors.mainDisabled);
    });
    testWidgets('typing a character updates the input value', (WidgetTester tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(
        MaterialApp(
          home: TestApp(
            home: ZetaMessageInput(controller: controller),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final textField = find.byType(TextField);
      expect(textField, findsOneWidget);

      await tester.enterText(textField, 'A');
      await tester.pump();
      expect(controller.text, 'A');
    });

    testWidgets('typing multiple characters updates accordingly', (WidgetTester tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(
        MaterialApp(
          home: TestApp(
            home: ZetaMessageInput(controller: controller),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final textField = find.byType(TextField);
      expect(textField, findsOneWidget);

      await tester.enterText(textField, 'Hello, world!');
      await tester.pump();
      expect(controller.text, 'Hello, world!');
    });

    testWidgets('pasting text into the field updates the input value', (WidgetTester tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(
        MaterialApp(
          home: TestApp(
            home: ZetaMessageInput(controller: controller),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final textField = find.byType(TextField);
      expect(textField, findsOneWidget);

      // Simulate pasting by setting the controller text directly
      controller.text = 'Pasted text';
      await tester.pump();
      expect(controller.text, 'Pasted text');
    });

    testWidgets('input gains focus on tap/click', (WidgetTester tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(
        MaterialApp(
          home: TestApp(
            home: ZetaMessageInput(controller: controller),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final textField = find.byType(TextField);
      expect(textField, findsOneWidget);

      // Tap the input field
      await tester.tap(textField);
      await tester.pumpAndSettle();

      // The input should have focus
      final textFieldWidget = tester.widget<TextField>(textField);
      expect(textFieldWidget.focusNode?.hasFocus ?? false, isTrue);
    });
  });

  group('Performance Tests', () {});
}
