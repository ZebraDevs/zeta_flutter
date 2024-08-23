import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class ChatItemExample extends StatelessWidget {
  static const String name = 'ChatItem';

  const ChatItemExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: name,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ZetaChatItem(
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
              title: Text('title'),
              subtitle: Text('subtitle'),
            ),
            ZetaChatItem(
              explicitChildNodes: false,
              time: DateTime.now(),
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
              title: Text("Chat name ID"),
              subtitle: Text(
                  "Dummy text to represent the first lines of most recent message dsadas dsa dsa ds dssd sd sdsd s ds"),
            ),
            ZetaChatItem(
              highlighted: true,
              time: DateTime.now(),
              count: 99,
              onTap: () {},
              slidableActions: [
                ZetaSlidableAction.menuMore(onPressed: () {}),
                ZetaSlidableAction.call(onPressed: () {}),
                ZetaSlidableAction.ptt(onPressed: () {}),
                ZetaSlidableAction.delete(onPressed: () {}),
              ],
              starred: true,
              leading: const ZetaAvatar(initials: 'ZA'),
              title: Text("Chat name ID"),
              subtitle: Text(
                "Dummy text to represent the first lines of most recent message",
              ),
            ),
          ].gap(Zeta.of(context).spacing.large),
        ),
      ),
    );
  }
}
