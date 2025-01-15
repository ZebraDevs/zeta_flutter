import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

const String paginationPath = '$componentsPath/Pagination';

@widgetbook.UseCase(
  name: 'Pagination',
  type: ZetaPagination,
  path: paginationPath,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=23954-98355&t=AZEbv7Mm0mjIx0Or-4',
)
Widget paginationUseCase(BuildContext context) => ZetaPagination(
      pages: context.knobs.int.slider(label: 'Pages', min: 1, max: 20, initialValue: 5),
      onChange: disabledKnob(context) ? null : (_) {},
    );

@widgetbook.UseCase(
  name: 'Pagination Drop down',
  type: ZetaPagination,
  path: paginationPath,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=23971-98472&t=AZEbv7Mm0mjIx0Or-4',
)
Widget paginationDropdownUseCase(BuildContext context) => ZetaPagination(
      pages: context.knobs.int.slider(label: 'Pages', min: 1, max: 20, initialValue: 5),
      type: ZetaPaginationType.dropdown,
      onChange: disabledKnob(context) ? null : (_) {},
    );
