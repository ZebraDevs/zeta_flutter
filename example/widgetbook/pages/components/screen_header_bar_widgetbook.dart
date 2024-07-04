import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';

Widget screenHeaderBarUseCase(BuildContext context) {
  final title = context.knobs.string(
    label: 'Title',
    initialValue: 'Add Subscribers',
  );

  return WidgetBookScaffold(
    builder: (context, _) => ZetaScreenHeaderBar(
      title: Text(title),
      actionButtonLabel: 'Done',
      onActionButtonPressed: () {},
    ),
  );
}
