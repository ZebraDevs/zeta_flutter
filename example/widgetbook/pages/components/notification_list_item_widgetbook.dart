import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';

Widget notificationListItemUseCase(BuildContext context) => WidgetbookScaffold(
      builder: (context, _) => Padding(
        padding: EdgeInsets.symmetric(horizontal: context.knobs.list(label: "Size", options: [100, 200, 400])),
        child: ZetaNotificationListItem(
          body: Text(
            "New urgent message " * 300,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          attachment: context.knobs.boolean(label: "Attachment", initialValue: false)
              ? Text("Spring-Donation-Drive.pdf")
              : null,
          title: context.knobs.string(label: "Title", initialValue: "Urgent Notification"),
          notificationTime: context.knobs.stringOrNull(label: "Notification Time", initialValue: "Just Now"),
          notificationRead: context.knobs.boolean(label: "Notification Read", initialValue: false),
          leading: context.knobs.list(
            label: 'Badge',
            options: [
              ZetaNotificationBadge.avatar(avatar: ZetaAvatar.initials(initials: "JS")),
              ZetaNotificationBadge.icon(icon: ZetaIcons.check_circle),
              ZetaNotificationBadge.image(
                  image: Image.network(
                      "https://www.google.com/url?sa=i&url=https%3A%2F%2Fgithub.com%2Fzebratechnologies&psig=AOvVaw0fBPVE5gUkkpFw8mVf6B8G&ust=1717073069230000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCPCwn-XxsoYDFQAAAAAdAAAAABAE"))
            ],
            labelBuilder: (value) => value.avatar != null
                ? "Avatar"
                : value.icon != null
                    ? "Icon"
                    : "Image",
          ),
          action: context.knobs.boolean(label: "Show action", initialValue: true)
              ? ZetaButton.outline(
                  label: "User Action",
                  onPressed: () {},
                  size: ZetaWidgetSize.small,
                  borderType: ZetaWidgetBorder.rounded,
                )
              : null,
          showDivider: context.knobs.boolean(label: "Show Divider", initialValue: false),
          showBellIcon: context.knobs.boolean(label: "Show Bell Icon", initialValue: true),
        ),
      ),
    );
