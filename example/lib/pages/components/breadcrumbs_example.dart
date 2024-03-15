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
  List<ZetaBreadCrumb> _children = [
    ZetaBreadCrumb(
      label: 'Icon before with seperator',
      onPressed: () {
        print("Breadcrumb " + 0.toString() + "Clicked");
      },
    ),
  ];
  int index = 1;

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: 'Breadcrumbs',
      child: Center(
        child: SingleChildScrollView(
          child: SizedBox(
              width: double.infinity,
              child: Column(children: [
                ZetaBreadCrumbs(children: _children),
                SizedBox(
                  height: 50,
                ),
                FilledButton(
                    onPressed: () {
                      setState(() {
                        _children.add(
                          ZetaBreadCrumb(
                            label: 'Icon before with seperator',
                            onPressed: () {
                              print("Breadcrumb clicked");
                            },
                          ),
                        );
                        index++;
                      });
                    },
                    child: Text("Add Breadcrumb"))
              ])),
        ),
      ),
    );
  }
}
