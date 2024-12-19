import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';
import '../../utils/utils.dart';

Widget commsButtonUseCase(BuildContext context) {
  return WidgetbookScaffold(
    builder: (context, _) => ZetaCommsButton(
      label: context.knobs.string(
        label: 'Text',
        initialValue: 'Answer',
      ),
      size: context.knobs.list(
        label: 'Size',
        options: ZetaWidgetSize.values,
        labelBuilder: enumLabelBuilder,
        initialOption: ZetaWidgetSize.medium,
      ),
      type: context.knobs.list(
        label: 'Type',
        options: ZetaCommsButtonType.values,
        labelBuilder: enumLabelBuilder,
        initialOption: ZetaCommsButtonType.positive,
      ),
      icon: iconKnob(
        context,
        nullable: false,
        name: "Icon",
        initial: ZetaIcons.phone,
      ),
    ),
  );
}
