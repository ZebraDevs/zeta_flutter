import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class BreadcrumbExample extends StatefulWidget {
  static const String name = 'Breadcrumb';

  const BreadcrumbExample({super.key});

  @override
  State<BreadcrumbExample> createState() => _BreadcrumbExampleState();
}

class _BreadcrumbExampleState extends State<BreadcrumbExample> {
  List<ZetaBreadcrumbItem> _children = [];

  @override
  void initState() {
    super.initState();
    _children = [
      ZetaBreadcrumbItem(label: 'Breadcrumb', onPressed: () {}),
      ZetaBreadcrumbItem(label: 'Item 1', onPressed: () {}),
      ZetaBreadcrumbItem(label: 'Item 2', onPressed: () {}),
      ZetaBreadcrumbItem(label: 'Item 3', icon: ZetaIcons.star, onPressed: () {}),
      ZetaBreadcrumbItem(label: 'Item 4', onPressed: () {}),
      ZetaBreadcrumbItem(label: 'Item 5', onPressed: () {}),
      ZetaBreadcrumbItem(label: 'Item 6', onPressed: () {}),
      ZetaBreadcrumbItem(label: 'Item 7', onPressed: () {}),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: 'Breadcrumb',
      child: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                ZetaBreadcrumb(children: _children.sublist(0, 1)),
                ZetaBreadcrumb(children: _children.sublist(0, 2)),
                ZetaBreadcrumb(children: _children.sublist(0, 3)),
                ZetaBreadcrumb(children: _children.sublist(0, 4), maxItemsShown: 3),
                ZetaBreadcrumb(children: _children.sublist(0, 5), maxItemsShown: 5),
                ZetaBreadcrumb(children: _children.sublist(0, 6), maxItemsShown: 3),
                ZetaBreadcrumb(children: _children.sublist(0, 7)),
                ZetaBreadcrumb(children: _children, maxItemsShown: 1),
              ].gap(50),
            ),
          ),
        ),
      ),
    );
  }
}
