import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

Widget paginationUseCase(BuildContext context) => WidgetbookTestWidget(
      widget: ZetaPagination(
        pages: 10,
        type: context.knobs.list<ZetaPaginationType>(
          label: 'Type',
          options: ZetaPaginationType.values,
          labelBuilder: (value) => value.name.split('.').last.toUpperCase(),
        ),
        rounded: context.knobs.boolean(label: 'Rounded'),
        onChange: context.knobs.boolean(label: 'Disabled') ? null : (_) {},
      ),
    );
