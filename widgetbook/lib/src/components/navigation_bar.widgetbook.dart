import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Navigation Bar',
  type: ZetaNavigationBar,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=21186-40498&t=6jmGZpLRLKTDIfJL-4',
)
Widget navigationBar(BuildContext context) {
  final items = List<ZetaNavigationBarItem>.generate(
    context.knobs.int.slider(label: 'Items', min: 2, max: 6, initialValue: 2),
    (index) => ZetaNavigationBarItem(icon: iconKnob(context)!, label: 'Label $index'),
  );
  var currIndex = 0;
  final showButton = context.knobs.boolean(label: 'Button');
  final dividerIndex = context.knobs.intOrNull.slider(label: 'Divider', max: 6);
  final showSplit = context.knobs.boolean(label: 'Split Items');
  return StatefulBuilder(
    builder: (context, setState) => ZetaNavigationBar(
      items: items,
      action: showButton ? ZetaButton.primary(label: 'Button', onPressed: () {}) : null,
      onTap: (i) => setState(() => currIndex = i),
      currentIndex: currIndex,
      splitItems: showSplit,
      dividerIndex: dividerIndex,
    ),
  );
}