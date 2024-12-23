import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';
import '../../utils/utils.dart';

Widget inputChipUseCase(BuildContext context) {
  final trailing = iconKnob(context);

  return WidgetbookScaffold(
    builder: (context, _) => ZetaInputChip(
      onTap: context.knobs.boolean(label: 'Disabled', initialValue: false) ? null : () {},
      rounded: context.knobs.boolean(label: 'Rounded', initialValue: true),
      label: context.knobs.string(label: 'Label', initialValue: 'Label'),
      leading: context.knobs.boolean(label: 'Avatar', initialValue: true)
          ? ZetaAvatar(
              initials: 'AZ',
              image: context.knobs.boolean(label: 'Avatar Image')
                  ? Image.asset('assets/Omer.jpg', fit: BoxFit.cover)
                  : null,
            )
          : null,
      trailing: trailing != null ? ZetaIcon(trailing) : null,
    ),
  );
}

Widget filterChipUseCase(BuildContext context) => WidgetbookScaffold(
      builder: (context, _) => ZetaFilterChip(
        onTap: context.knobs.boolean(label: 'Disabled', initialValue: false) ? null : (i) {},
        rounded: context.knobs.boolean(label: 'Rounded', initialValue: true),
        label: context.knobs.string(label: 'Label', initialValue: 'Label'),
        selected: context.knobs.boolean(label: 'Selected', initialValue: true),
      ),
    );

Widget assistChipUseCase(BuildContext context) {
  return WidgetbookScaffold(
    builder: (context, _) => ZetaAssistChip(
      onTap: context.knobs.boolean(label: 'Disabled', initialValue: false) ? null : () {},
      rounded: context.knobs.boolean(label: 'Rounded', initialValue: true),
      label: context.knobs.string(label: 'Label', initialValue: 'Label'),
      leading: ZetaIcon(iconKnob(context)),
    ),
  );
}

Widget statusChipUseCase(BuildContext context) {
  return WidgetbookScaffold(
    builder: (context, _) => ZetaStatusChip(
      label: context.knobs.string(label: 'Label', initialValue: 'Label'),
      draggable: context.knobs.boolean(label: 'Draggable', initialValue: false),
      rounded: context.knobs.boolean(label: 'Rounded', initialValue: true),
      onDragCompleted: () => print('Drag completed'),
    ),
  );
}
