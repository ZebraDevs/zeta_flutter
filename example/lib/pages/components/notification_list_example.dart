import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class NotificationListItemExample extends StatelessWidget {
  const NotificationListItemExample({Key? key}) : super(key: key);
  static const String name = 'NotificationListItem';

  @override
  Widget build(BuildContext context) {
    final Image image = Image.network(
      "https://i.ytimg.com/vi/KItsWUzFUOs/maxresdefault.jpg",
    );
    final colors = Zeta.of(context).colors;

    return ExampleScaffold(
      name: name,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'ZetaNotificationListItem with avatar',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ZetaNotificationListItem(
              body: Text(
                "New urgent message from John Smith that spans multiple lines but line count caps at two",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              title: 'Urgent Message',
              leading: ZetaNotificationBadge.avatar(
                  avatar: ZetaAvatar.initials(
                initials: "JS",
                lowerBadge: ZetaAvatarBadge.icon(
                  color: colors.surfacePositive,
                  icon: Icons.check,
                ),
              )),
              notificationTime: "Just now",
              attachment: Text("Spring-Donation-Drive.pdf"),
              showBellIcon: true,
              action: ZetaButton.outline(
                label: "User Action",
                onPressed: () {},
                size: ZetaWidgetSize.small,
              ),
              slidableActions: [
                ZetaSlidableAction.menuMore(onPressed: () {}),
                ZetaSlidableAction.call(onPressed: () {}),
                ZetaSlidableAction.ptt(onPressed: () {}),
                ZetaSlidableAction.delete(onPressed: () {}),
              ],
              paleButtonColors: true,
            ),
            ZetaNotificationListItem(
              body: Text(
                "New urgent message from John Smith that spans multiple lines but line count caps at two",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              title: 'Urgent Message',
              leading: ZetaNotificationBadge.avatar(
                  avatar: ZetaAvatar.initials(
                initials: "JS",
                lowerBadge: ZetaAvatarBadge.icon(
                  color: colors.surfacePositive,
                  icon: Icons.check,
                ),
              )),
              showDivider: true,
              notificationTime: "10:32 AM",
              showBellIcon: true,
              attachment: Text("Spring-Donation-Drive.pdf"),
              slidableActions: [
                ZetaSlidableAction.menuMore(onPressed: () {}),
                ZetaSlidableAction.delete(onPressed: () {}),
              ],
            ),
            ZetaNotificationListItem(
              body: Text(
                "New urgent message from John Smith that spans multiple lines but line count caps at two",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              title: 'Urgent Message',
              leading: ZetaNotificationBadge.avatar(
                avatar: ZetaAvatar.initials(
                  initials: "JS",
                  semanticUpperBadgeLabel: 'Urgent',
                  lowerBadge: ZetaAvatarBadge.icon(
                    color: colors.surfacePositive,
                    icon: Icons.check,
                  ),
                ),
              ),
              notificationRead: true,
              notificationTime: "03/09/2024",
              slidableActions: [
                ZetaSlidableAction.call(onPressed: () {}),
                ZetaSlidableAction.ptt(onPressed: () {}),
              ],
              paleButtonColors: true,
            ),
            const SizedBox(height: 20),
            Text(
              'ZetaNotificationListItem with image',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ZetaNotificationListItem(
              body: Text(
                "New urgent message from John Smith that spans multiple lines but line count caps at two",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              title: 'Urgent Message',
              leading: ZetaNotificationBadge.image(
                image: image,
              ),
              notificationTime: "Just now",
              showBellIcon: true,
              action: ZetaButton.outline(
                label: "User Action",
                onPressed: () {},
                size: ZetaWidgetSize.small,
              ),
              attachment: Text("Spring-Donation-Drive.pdf"),
              slidableActions: [
                ZetaSlidableAction.menuMore(onPressed: () {}),
                ZetaSlidableAction.call(onPressed: () {}),
                ZetaSlidableAction.ptt(onPressed: () {}),
                ZetaSlidableAction.delete(onPressed: () {}),
              ],
              paleButtonColors: true,
            ),
            ZetaNotificationListItem(
              body: Text(
                "New urgent message from John Smith that spans multiple lines but line count caps at two",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              title: 'Urgent Message',
              leading: ZetaNotificationBadge.image(
                image: image,
              ),
              showDivider: true,
              notificationTime: "10:32 AM",
              showBellIcon: true,
              attachment: Text("Spring-Donation-Drive.pdf"),
              slidableActions: [
                ZetaSlidableAction.menuMore(onPressed: () {}),
                ZetaSlidableAction.delete(onPressed: () {}),
              ],
            ),
            ZetaNotificationListItem(
              body: Text(
                "New urgent message from John Smith that spans multiple lines but line count caps at two",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              title: 'Urgent Message',
              leading: ZetaNotificationBadge.image(
                image: image,
              ),
              notificationRead: true,
              notificationTime: "03/09/2024",
              slidableActions: [
                ZetaSlidableAction.call(onPressed: () {}),
                ZetaSlidableAction.ptt(onPressed: () {}),
              ],
              paleButtonColors: true,
            ),
            const SizedBox(height: 20),
            Text(
              'ZetaNotificationListItem with icon',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ZetaNotificationListItem(
              body: Text(
                "New urgent message from John Smith that spans multiple lines but line count caps at two",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              title: 'Urgent Message',
              leading: ZetaNotificationBadge.icon(icon: ZetaIcons.check_circle),
              notificationTime: "Just now",
              showBellIcon: true,
              action: ZetaButton.outline(
                label: "User Action",
                onPressed: () {},
                size: ZetaWidgetSize.small,
              ),
              attachment: Text("Spring-Donation-Drive.pdf"),
              slidableActions: [
                ZetaSlidableAction.menuMore(onPressed: () {}),
                ZetaSlidableAction.call(onPressed: () {}),
                ZetaSlidableAction.ptt(onPressed: () {}),
                ZetaSlidableAction.delete(onPressed: () {}),
              ],
              paleButtonColors: true,
            ),
            ZetaNotificationListItem(
              body: Text(
                "New urgent message from John Smith that spans multiple lines but line count caps at two",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              title: 'Urgent Message',
              leading: ZetaNotificationBadge.icon(icon: ZetaIcons.check_circle),
              showDivider: true,
              notificationTime: "10:32 AM",
              showBellIcon: true,
              attachment: Text("Spring-Donation-Drive.pdf"),
              slidableActions: [
                ZetaSlidableAction.menuMore(onPressed: () {}),
                ZetaSlidableAction.delete(onPressed: () {}),
              ],
            ),
            ZetaNotificationListItem(
              body: Text(
                "New urgent message from John Smith that spans multiple lines but line count caps at two",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              title: 'Urgent Message',
              leading: ZetaNotificationBadge.icon(icon: ZetaIcons.check_circle),
              notificationRead: true,
              notificationTime: "03/09/2024",
              slidableActions: [
                ZetaSlidableAction.call(onPressed: () {}),
                ZetaSlidableAction.ptt(onPressed: () {}),
              ],
              paleButtonColors: true,
            ),
          ].gap(Zeta.of(context).spacing.xl_4),
        ),
      ),
    );
  }
}
