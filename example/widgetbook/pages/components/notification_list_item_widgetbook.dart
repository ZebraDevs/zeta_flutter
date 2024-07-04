import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';

Widget notificationListItemUseCase(BuildContext context) => WidgetbookScaffold(
      builder: (context, _) => Padding(
        padding: EdgeInsets.symmetric(horizontal: context.knobs.list(label: "Size", options: [100, 200, 400])),
        child: ZetaNotificationListItem(
          body: context.knobs.boolean(label: "Include Link")
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "New urgent" * 300,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    ZetaButton.text(label: "label")
                  ],
                )
              : Text(
                  "New urgent" * 300,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
          title: context.knobs.string(label: "Title", initialValue: "Urgent Notification"),
          notificationTime: context.knobs.stringOrNull(label: "Notification Time", initialValue: "Just Now"),
          notificationRead: context.knobs.boolean(label: "Notification Read", initialValue: false),
          leading: context.knobs.list(
            label: 'Badge',
            options: [
              ZetaNotificationBadge.avatar(avatar: ZetaAvatar.initials(initials: "AO")),
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
          action: context.knobs.list(
            label: "Action Buttons",
            options: [
              ZetaButton.negative(label: "Remove"),
              ZetaButton.positive(label: "Add"),
              ZetaButton.outline(label: "Action"),
            ],
            labelBuilder: (value) {
              final button = (value as ZetaButton);
              return button.label == "Remove"
                  ? "Negative"
                  : button.label == "Add"
                      ? "Positive"
                      : "Netutral";
            },
          ),
          showDivider: context.knobs.booleanOrNull(label: "Has More"),
        ),
      ),
    );
