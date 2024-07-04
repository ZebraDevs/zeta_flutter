import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';

Widget contactItemUseCase(BuildContext context) {
  final title = context.knobs.string(label: 'Title', initialValue: "Contact / Group Name");
  final subtitle = context.knobs.string(label: 'Subtitle', initialValue: "Store Associate - Bakery Dept.");
  final enabledDivider = context.knobs.boolean(label: 'Enabled Divider', initialValue: true);

  return WidgetBookScaffold(
    builder: (context, _) => ZetaContactItem(
      onTap: () {},
      leading: ZetaAvatar(size: ZetaAvatarSize.s),
      title: Text(title),
      subtitle: Text(subtitle),
      enabledDivider: enabledDivider,
    ),
  );
}
