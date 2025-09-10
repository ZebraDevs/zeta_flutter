import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class MessageInputExample extends StatefulWidget {
  static const String name = 'MessageInput';

  const MessageInputExample({super.key});

  @override
  State<MessageInputExample> createState() => _MessageInputExampleState();
}

class _MessageInputExampleState extends State<MessageInputExample> {
  late TextEditingController controller;
  List<String> messages = [];
  List<File> attachments = [];

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    messages = [for (var i = 0; i < 3; i++) 'Message $i'];
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: MessageInputExample.name,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index]),
                );
              },
            ),
          ),
          ZetaMessageInput(
            controller: controller,
            disabled: false,
            allowsVoiceInput: true,
            cameraTrailingButton: true,
            hasActionMenu: true,
            onSendLocation: (location) => setState(() => messages.add('Location: $location')),
            onSendVoiceMemo: (file, bytes) => setState(() {
              messages.add('Voice memo: ${file.path}');
            }),
            attachments: attachments,
            onSendAttachments: (fileList) {
              fileList.forEach((file) {
                setState(() {
                  messages.add('File attachment: ${file.path}');
                });
              });
              attachments.clear();
            },
            onSend: (message) {
              if (message.isNotEmpty) {
                setState(() {
                  messages.add(message);
                });
                print('Message sent: $message');
                controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
