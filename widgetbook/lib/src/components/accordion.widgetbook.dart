import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Accordion',
  type: ZetaAccordion,
  path: '$componentsPath/Accordion',
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=38101-167213&t=6Gzuj7ryUE4323bM-4',
)
Widget accordion(BuildContext context) {
  final bool selectable = context.knobs.boolean(
    label: 'Selectable',
    initialValue: true,
  );
  final bool navigation = context.knobs.boolean(
    label: 'Navigation',
    initialValue: false,
  );
  return SmallContentWrapper(
    child: SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: SingleChildScrollView(
        child: ZetaAccordion(
          inCard: context.knobs.boolean(
            label: 'In Card',
            initialValue: false,
          ),
          expandMultiple: context.knobs.boolean(
            label: 'Multiple Open',
            initialValue: false,
          ),
          selectMultiple: context.knobs.boolean(
            label: 'Select Multiple',
            initialValue: false,
          ),
          children: [
            ZetaAccordionItem(
              title: 'Accordion Item 1',
              onTap: () => {},
              isSelectable: selectable && !navigation,
              isNavigation: navigation,
              child: navigation ? null : Placeholder(),
            ),
            ZetaAccordionItem(
              title: 'Accordion Item 1',
              onTap: () => {},
              isSelectable: selectable && !navigation,
              isNavigation: navigation,
              child: navigation ? null : Placeholder(),
            ),
            ZetaAccordionItem(
              title: 'Accordion Item 1',
              onTap: () => {},
              isSelectable: selectable && !navigation,
              isNavigation: navigation,
              child: navigation ? null : Placeholder(),
            ),
          ],
        ),
      ),
    ),
  );
}
