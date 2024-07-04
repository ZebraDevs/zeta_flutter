import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';
import '../../utils/utils.dart';

Widget paginationUseCase(BuildContext context) => WidgetBookScaffold(
      builder: (context, _) => ZetaPagination(
        pages: 10,
        type: context.knobs.list<ZetaPaginationType>(
          label: 'Type',
          options: ZetaPaginationType.values,
          labelBuilder: (value) => value.name.split('.').last.toUpperCase(),
        ),
        onChange: disabledKnob(context) ? null : (_) {},
      ),
    );
