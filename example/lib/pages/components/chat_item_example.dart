import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class ChatItemExample extends StatefulWidget {
  static const String name = 'ChatItem';

  const ChatItemExample({Key? key}) : super(key: key);

  @override
  State<ChatItemExample> createState() => _ChatItemExampleState();
}

class _ChatItemExampleState extends State<ChatItemExample> {
  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: 'Chat Item',
      child: SingleChildScrollView(
        child: Column(
          children: [
            ZetaChatItem(
              time: DateTime.now(),
              enabledWarningIcon: true,
              enabledNotificationIcon: true,
              leading: const ZetaAvatar(
                size: ZetaAvatarSize.l,
              ),
              count: 100,
              onTap: () {},
              onDeleteTap: () {},
              onCallTap: () {},
              onMenuMoreTap: () {},
              onPttTap: () {},
              title: Text("Chat name ID"),
              subtitle: Text(
                  "Dummy text to represent the first lines of most recent message dsadas dsa dsa ds dssd sd sdsd s ds"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: ZetaSpacing.large),
              child: ZetaChatItem(
                highlighted: true,
                count: 99,
                time: DateTime.now(),
                onTap: () {},
                starred: true,
                leading: const ZetaAvatar(
                  size: ZetaAvatarSize.l,
                ),
                title: Text("Chat name ID"),
                subtitle: Text(
                  "Dummy text to represent the first lines of most recent message",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
