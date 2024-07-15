import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class NotificationListItemExample extends StatelessWidget {
  const NotificationListItemExample({Key? key}) : super(key: key);
  static const String name = 'NotificationListItem';

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: name,
      child: Column(
        children: [
          ZetaNotificationListItem(
            body: Text(
              "New urgent" * 300,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            title: 'Urgent Message',
            leading: ZetaNotificationBadge.icon(icon: ZetaIcons.check_circle),
            notificationTime: "Just now",
            action: ZetaButton.negative(
              label: "Remove",
              onPressed: () {},
            ),
          ),
          ZetaNotificationListItem(
            body: Text(
              "New urgent",
            ),
            title: 'Urgent Message',
            leading: ZetaNotificationBadge.icon(icon: ZetaIcons.check_circle),
            notificationTime: "Just now",
            action: ZetaButton.negative(
              label: "Remove",
              onPressed: () {},
            ),
          ),
        ].gap(ZetaSpacing.xl_4),
      ),
    );
  }
}
