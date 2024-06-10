import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class NotificationListItemExample extends StatefulWidget {
  static const String name = 'NotificationListItem';

  const NotificationListItemExample({super.key});

  @override
  State<NotificationListItemExample> createState() => _NotificationListItemExampleState();
}

class _NotificationListItemExampleState extends State<NotificationListItemExample> {
  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: "NotificationListItem",
      child: SingleChildScrollView(
          child: Column(
              children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 400),
          child: ZetaNotificationListItem(
            body: Text(
              "New urgent" * 300,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            title: 'Urgent Message',
            leading: ZetaNotificationBadge.icon(icon: ZetaIcons.check_circle_round),
            notificationTime: "Just now",
            action: ZetaButton.negative(
              label: "Remove",
              onPressed: () {},
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 200),
          child: ZetaNotificationListItem(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "New urgent" * 300,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                ZetaButton.text(label: "label")
              ],
            ),
            title: 'Urgent Message',
            leading: ZetaNotificationBadge.icon(icon: ZetaIcons.check_circle_round),
            notificationTime: "Just now",
            action: ZetaButton.negative(
              label: "Remove",
              onPressed: () {},
            ),
          ),
        ),
      ].gap(ZetaSpacing.xl_4))),
    );
  }
}
