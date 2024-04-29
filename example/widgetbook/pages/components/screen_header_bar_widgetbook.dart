import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

Widget screenHeaderBarUseCase(BuildContext context) {
  final title = context.knobs.string(
    label: 'Title',
    initialValue: 'Add Subscribers',
  );
  final rounded = context.knobs.boolean(label: 'Rounded', initialValue: true);

  return WidgetbookTestWidget(
    widget: ZetaScreenHeaderBar(
      title: Text(title),
      actionButtonLabel: 'Done',
      onActionButtonPressed: () {},
      rounded: rounded,
    ),
  );
}
