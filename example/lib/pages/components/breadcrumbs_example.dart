import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class BreadCrumbsExample extends StatefulWidget {
  static const String name = 'Breadcrumbs';

  const BreadCrumbsExample({super.key});

  @override
  State<BreadCrumbsExample> createState() => _BreadCrumbsExampleState();
}

class _BreadCrumbsExampleState extends State<BreadCrumbsExample> {
  List<ZetaBreadcrumbItem> _children = [];
  int index = 3;

  @override
  void initState() {
    super.initState();
    _children = [
      ZetaBreadcrumbItem(
        label: 'Breadcrumb',
        onPressed: () {
          print("Breadcrumb clicked");
        },
      ),
      ZetaBreadcrumbItem(
        label: 'Item 1',
        onPressed: () {
          print("Breadcrumb clicked");
        },
      ),
      ZetaBreadcrumbItem(
        label: 'Item 2',
        onPressed: () {
          print("Breadcrumb clicked");
        },
      ),
      ZetaBreadcrumbItem(
        label: 'Item 3',
        onPressed: () {
          print("Breadcrumb clicked");
        },
      ),
      ZetaBreadcrumbItem(
        label: 'Item 4',
        onPressed: () {
          print("Breadcrumb clicked");
        },
      ),
      ZetaBreadcrumbItem(
        label: 'Item 5',
        onPressed: () {
          print("Breadcrumb clicked");
        },
      ),
      ZetaBreadcrumbItem(
        label: 'Item 6',
        onPressed: () {
          print("Breadcrumb clicked");
        },
      ),
      ZetaBreadcrumbItem(
        label: 'Item 7',
        onPressed: () {
          print("Breadcrumb clicked");
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: 'Breadcrumbs',
      child: Center(
        child: SingleChildScrollView(
          child: SizedBox(
              width: double.infinity,
              child: Column(children: [
                ZetaBreadcrumb(children: _children.sublist(0, 1)),
                SizedBox(
                  height: 50,
                ),
                ZetaBreadcrumb(children: _children.sublist(0, 2)),
                SizedBox(
                  height: 50,
                ),
                ZetaBreadcrumb(children: _children.sublist(0, 3)),
                SizedBox(
                  height: 50,
                ),
                ZetaBreadcrumb(children: _children.sublist(0, 4)),
                SizedBox(
                  height: 50,
                ),
                ZetaBreadcrumb(children: _children.sublist(0, 5)),
                SizedBox(
                  height: 50,
                ),
                ZetaBreadcrumb(children: _children.sublist(0, 6)),
                SizedBox(
                  height: 50,
                ),
                ZetaBreadcrumb(children: _children.sublist(0, 7)),
                SizedBox(
                  height: 50,
                ),
                ZetaBreadcrumb(children: _children),
              ])),
        ),
      ),
    );
  }
}
