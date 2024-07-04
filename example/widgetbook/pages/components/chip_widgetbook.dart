import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';
import '../../utils/utils.dart';

Widget inputChipUseCase(BuildContext context) {
  final trailing = iconKnob(context);

  return WidgetBookScaffold(
    builder: (context, _) => ZetaInputChip(
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

Widget filterChipUseCase(BuildContext context) => WidgetBookScaffold(
      builder: (context, _) => ZetaFilterChip(
        label: context.knobs.string(label: 'Label', initialValue: 'Label'),
        selected: context.knobs.boolean(label: 'Selected', initialValue: true),
      ),
    );

Widget assistChipUseCase(BuildContext context) {
  return WidgetBookScaffold(
    builder: (context, _) => ZetaAssistChip(
      label: context.knobs.string(label: 'Label', initialValue: 'Label'),
      leading: ZetaIcon(iconKnob(context)),
    ),
  );
}
