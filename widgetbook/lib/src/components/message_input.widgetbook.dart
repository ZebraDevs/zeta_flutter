import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Message Input',
  type: MessageInput,
  path: '$componentsPath/MessageInput',
  designLink: 'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=18271-19682',
)
Widget defaultMessageInput(BuildContext context) {
  final controller = TextEditingController();

  final String? placeholder = context.knobs.stringOrNull(label: 'Placeholder');
  final bool allowsVoiceInput = context.knobs.boolean(label: 'Allows Voice Input', initialValue: true);
  final range = context.knobs.range(label: 'Range of lines', initialValue: const RangeValues(1, 100));
  final minLines = range.start.round();
  final maxLines = range.end.round();

  var messages = [];

  return StatefulBuilder(
      builder: (context, setState) => Column(
            children: [
              ...List.generate(
                messages.length,
                (index) => ListTile(title: Text(messages[index])),
              ),
              MessageInput.actionMenu(
                controller: controller,
                placeholder: placeholder,
                allowsVoiceInput: allowsVoiceInput,
                minLines: minLines,
                maxLines: maxLines,
                onSend: () {
                  final message = controller.text;
                  if (message.isNotEmpty) {
                    setState(() {
                      messages.add(message);
                    });
                    controller.clear();
                  }
                },
              ),
            ],
          ));

  // return Scaffold(
  //   body: Column(
  //     children: [
  //       Expanded(
  //         child: ListView.builder(
  //           itemCount: 10,
  //           itemBuilder: (context, index) {
  //             return ListTile(
  //               title: Text('Message $index'),
  //             );
  //           },
  //         ),
  //       ),
  //       MessageInput(
  //         controller: controller,
  //         placeholder: context.knobs.string(
  //           label: 'Placeholder',
  //           initialValue: 'Type your message here...',
  //         ),
  //         onSend: () {
  //           final message = controller.text;
  //           if (message.isNotEmpty) {
  //             print('Message sent: $message');
  //             controller.clear();
  //           }
  //         },
  //       ),
  //     ],
  //   ),
  // );
}

// @widgetbook.UseCase(
//   name: 'With Action Menu',
//   type: MessageInput,
//   path: '$componentsPath/MessageInput',
//   designLink:
//       'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=18271-19682',
// )
// Widget actionMenuMessageInput(BuildContext context) {
//   final controller = TextEditingController();
//   return Scaffold(
//     body: Column(
//       children: [
//         Expanded(
//           child: ListView.builder(
//             itemCount: 10,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text('Message $index'),
//               );
//             },
//           ),
//         ),
//         MessageInput.actionMenu(
//           controller: controller,
//           placeholder: context.knobs.string(
//             label: 'Placeholder',
//             initialValue: 'Type your message here...',
//           ),
//           onSend: () {
//             final message = controller.text;
//             if (message.isNotEmpty) {
//               print('Message sent: $message');
//               controller.clear();
//             }
//           },
//         ),
//       ],
//     ),
//   );
// }

// @widgetbook.UseCase(
//   name: 'Comment',
//   type: MessageInput,
//   path: '$componentsPath/MessageInput',
//   designLink:
//       'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=18271-19682',
// )
// Widget commentMessageInput(BuildContext context) {
//   final controller = TextEditingController();
//   return Scaffold(
//     body: Column(
//       children: [
//         Expanded(
//           child: ListView.builder(
//             itemCount: 10,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text('Message $index'),
//               );
//             },
//           ),
//         ),
//         MessageInput.comment(
//           controller: controller,
//           placeholder: context.knobs.string(
//             label: 'Placeholder',
//             initialValue: 'Type your message here...',
//           ),
//           onSend: () {
//             final message = controller.text;
//             if (message.isNotEmpty) {
//               print('Message sent: $message');
//               controller.clear();
//             }
//           },
//         ),
//       ],
//     ),
//   );
// }
