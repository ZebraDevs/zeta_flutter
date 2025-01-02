import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Breadcrumbs',
  type: ZetaBreadCrumb,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=21265-27106&t=6jmGZpLRLKTDIfJL-4',
)
Widget breadcrumb(BuildContext context) {
  var index = 1;

  final children = <ZetaBreadCrumb>[
    ZetaBreadCrumb(
      label: 'Icon before with separator',
      onPressed: () {},
    ),
  ];

  return StatefulBuilder(
    builder: (context, setState) => SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            ZetaBreadCrumbs(
              activeIcon: iconKnob(context),
              children: children,
            ),
            const SizedBox(
              height: 50,
            ),
            FilledButton(
              onPressed: () {
                setState(() {
                  children.add(
                    ZetaBreadCrumb(
                      label: 'Icon before with seperator',
                      onPressed: () {},
                    ),
                  );
                  index = index + 1;
                });
              },
              child: const Text('Add Breadcrumb'),
            ),
          ],
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Breadcrumb Item',
  type: ZetaBreadCrumb,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=21265-27106&t=6jmGZpLRLKTDIfJL-4',
)
Widget breadCrumbs(BuildContext context) {
  final icon = iconKnob(context, initial: ZetaIcons.star);
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      ZetaBreadCrumb(
        label: context.knobs.string(label: 'Label', initialValue: 'Label'),
        icon: icon,
        activeIcon: icon,
        onPressed: () {},
        isSelected: context.knobs.boolean(label: 'Selected', initialValue: true),
      ),
    ],
  );
}
