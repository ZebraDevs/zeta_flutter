import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';
import '../../utils/utils.dart';

Widget breadCrumbsUseCase(BuildContext context) => WidgetbookScaffold(
      builder: (context, _) => Center(
        child: BreadCrumbExample(context),
      ),
    );

class BreadCrumbExample extends StatefulWidget {
  const BreadCrumbExample(this.c);
  final BuildContext c;

  @override
  State<BreadCrumbExample> createState() => _BreadCrumbExampleState();
}

class _BreadCrumbExampleState extends State<BreadCrumbExample> {
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
  Widget build(BuildContext _) {
    return SingleChildScrollView(
      child: SizedBox(
          width: double.infinity,
          child: Column(children: [
            ZetaBreadCrumbs(
              children: _children,
              activeIcon: iconKnob(context),
            ),
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
    );
  }
}
