import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';
import 'package:widgetbook/widgetbook.dart';

final List<ZetaBreadcrumbItem> children = [
  ZetaBreadcrumbItem(label: 'Breadcrumb', onPressed: () {}),
  ZetaBreadcrumbItem(label: 'Item 1', onPressed: () {}),
  ZetaBreadcrumbItem(label: 'Item 2', onPressed: () {}),
  ZetaBreadcrumbItem(label: 'Item 3', onPressed: () {}),
  ZetaBreadcrumbItem(label: 'Item 4', onPressed: () {}),
  ZetaBreadcrumbItem(label: 'Item 5', onPressed: () {}),
  ZetaBreadcrumbItem(label: 'Item 6', onPressed: () {})
];

Widget breadcrumbUseCase(BuildContext context) => WidgetbookScaffold(
      builder: (context, _) => Center(
        child: BreadcrumbExample(context, children),
      ),
    );

class BreadcrumbExample extends StatelessWidget {
  BreadcrumbExample(this.context, this.children);
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
              rounded: context.knobs.boolean(label: 'Rounded', initialValue: true),
              children: context.knobs.list(
                label: 'Items',
                labelBuilder: (value) => value.length.toString(),
                initialOption: children.sublist(0, 4),
                options: List.generate(
                  children.length,
                  (index) => children.sublist(0, index + 1),
                ),
              ),
              maxItemsShown: context.knobs.int.slider(
                label: 'Max Items Shown',
                initialValue: 2,
                min: 1,
                max: children.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
