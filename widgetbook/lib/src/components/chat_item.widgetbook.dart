import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

const String chatItemPath = '$componentsPath/Chat Item';

@widgetbook.UseCase(
  name: 'Chat Item',
  type: ZetaChatItem,
  path: chatItemPath,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=24820-42180&t=N8coJ9AFu6DS3mOF-4',
)
Widget chatItem(BuildContext context) {
  return SmallContentWrapper(
    child: ZetaChatItem(
      time: context.knobs.dateTime(
        label: 'Date',
        initialValue: DateTime.now(),
        start: DateTime.now().subtract(Duration(days: 1000)),
        end: DateTime.now().add(Duration(days: 1000)),
      ),
      highlighted: context.knobs.boolean(label: 'Highlighted'),
      paleButtonColors: context.knobs.boolean(label: 'Pale Button Colors'),
      enabledWarningIcon: context.knobs.boolean(label: 'Warning Icon'),
      enabledNotificationIcon: context.knobs.boolean(label: 'Notification Icon'),
      count: context.knobs.int.input(label: 'Count', initialValue: 3),
      onTap: context.knobs.boolean(label: 'Enabled Tap', initialValue: true) ? () {} : null,
      slidableActions: context.knobs.boolean(label: 'Slidable actions', initialValue: true)
          ? [
              ZetaSlidableAction.delete(onPressed: () {}),
              ZetaSlidableAction.menuMore(onPressed: () {}),
              ZetaSlidableAction.call(onPressed: () {}),
              ZetaSlidableAction.ptt(onPressed: () {}),
            ]
          : [],
      starred: context.knobs.booleanOrNull(label: 'Starred', initialValue: false),
      leading: const ZetaAvatar.initials(initials: 'AZ', size: ZetaAvatarSize.m),
      title: Text(context.knobs.string(label: 'Title', initialValue: 'Chat name ID')),
      subtitle: Text(
        context.knobs.string(
          label: 'Subtitle',
          initialValue: 'Dummy text to represent the first lines of most recent message',
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Contact Item',
  type: ZetaContactItem,
  path: chatItemPath,
  designLink: 'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=24860-79147',
)
Widget contactItemUseCase(BuildContext context) {
  return SmallContentWrapper(
    child: ZetaContactItem(
      onTap: disabledKnob(context) ? null : () {},
      leading: const ZetaAvatar.initials(initials: 'AZ', size: ZetaAvatarSize.s),
      title: Text(context.knobs.string(label: 'Title', initialValue: "Contact / Group Name")),
      subtitle: Text(context.knobs.string(label: 'Subtitle', initialValue: "Store Associate - Bakery Dept.")),
      enabledDivider: context.knobs.boolean(label: 'Divider', initialValue: true),
    ),
  );
}
