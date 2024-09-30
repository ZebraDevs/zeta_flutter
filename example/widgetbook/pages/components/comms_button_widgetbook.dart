import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';
import '../../utils/utils.dart';

Widget commsButtonUseCase(BuildContext context) {
  return WidgetbookScaffold(
    builder: (context, _) => ZetaCommsButton(
      label: context.knobs.string(label: 'Text', initialValue: 'Button'),
      onPressed: context.knobs.boolean(label: 'Disabled') ? null : () {},
      size: context.knobs.list(
        label: 'Size',
        options: ZetaWidgetSize.values,
        labelBuilder: enumLabelBuilder,
      ),
      type: context.knobs.list(
        label: 'Type',
        options: ZetaCommsButtonType.values,
        labelBuilder: enumLabelBuilder,
      ),
      icon: iconKnob(context, nullable: false, name: "Icon"),
    ),
  );
}
