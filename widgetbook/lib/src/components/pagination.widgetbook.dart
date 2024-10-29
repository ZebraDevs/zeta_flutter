import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Pagination',
  type: ZetaPagination,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=23954-98355&m=dev',
)
Widget paginationUseCase(BuildContext context) => ZetaPagination(
      pages: 10,
      type: context.knobs.list<ZetaPaginationType>(
        label: 'Type',
        options: ZetaPaginationType.values,
        labelBuilder: (value) => value.name.split('.').last.toUpperCase(),
      ),
      onChange: disabledKnob(context) ? null : (_) {},
    );
