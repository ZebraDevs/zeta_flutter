import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Breadcrumb',
  type: ZetaBreadCrumbs,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=21265-27106&t=6jmGZpLRLKTDIfJL-4',
)
Widget breadcrumb(BuildContext context) {
  int index = 1;

  List<ZetaBreadCrumb> children = [
    ZetaBreadCrumb(
      label: 'Icon before with seperator',
      onPressed: () {},
    ),
  ];

  return StatefulBuilder(
    builder: (context, setState) => SingleChildScrollView(
      child: SizedBox(
          width: double.infinity,
          child: Column(children: [
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
                child: const Text("Add Breadcrumb"))
          ])),
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
  return ZetaBreadCrumb(
    label: context.knobs.string(label: 'Label'),
    icon: iconKnob(context),
    onPressed: () {},
    isSelected: context.knobs.boolean(label: 'Selected'),
  );
}
