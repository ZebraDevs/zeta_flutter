import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../utils/utils.dart';

final List<ZetaBreadcrumbItem> children = [
  ZetaBreadcrumbItem(label: 'Breadcrumb', onPressed: () {}),
  ZetaBreadcrumbItem(label: 'Item 1', onPressed: () {}),
  ZetaBreadcrumbItem(label: 'Item 2', onPressed: () {}),
  ZetaBreadcrumbItem(label: 'Item 3', onPressed: () {}),
  ZetaBreadcrumbItem(label: 'Item 4', onPressed: () {}),
  ZetaBreadcrumbItem(label: 'Item 5', onPressed: () {}),
  ZetaBreadcrumbItem(label: 'Item 6', onPressed: () {})
];

Widget breadCrumbUseCase(BuildContext context) => WidgetbookScaffold(
      builder: (context, _) => Center(
        child: BreadCrumbExample(context, children),
      ),
    );

class BreadCrumbExample extends StatelessWidget {
  BreadCrumbExample(this.context, this.children);
  final BuildContext context;
  final List<ZetaBreadcrumbItem> children;

  @override
  Widget build(BuildContext _) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            ZetaBreadcrumb(
              children: context.knobs.list(
                label: 'Items',
                labelBuilder: (value) => value.length.toString(),
                initialOption: children.sublist(0, 2),
                options: List.generate(
                  children.length,
                  (index) => children.sublist(0, index + 1),
                ),
              ),
              activeIcon: iconKnob(context),
            ),
          ],
        ),
      ),
    );
  }
}
