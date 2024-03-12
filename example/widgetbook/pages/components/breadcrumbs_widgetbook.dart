import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

Widget breadCrumbsUseCase(BuildContext context) => WidgetbookTestWidget(
        widget: Center(
      child: BreadCrumbExample(context),
    ));

class BreadCrumbExample extends StatefulWidget {
  const BreadCrumbExample(this.c);
  final BuildContext c;

  @override
  State<BreadCrumbExample> createState() => _BreadCrumbExampleState();
}

class _BreadCrumbExampleState extends State<BreadCrumbExample> {
  List<String> _children = [
    'Icon before with seperator',
  ];

  @override
  Widget build(BuildContext _) {
    return SingleChildScrollView(
      child: SizedBox(
          width: double.infinity,
          child: Column(children: [
            ZetaBreadCrumbs(
              children: _children,
              rounded: widget.c.knobs.boolean(label: 'Rounded'),
              activeIcon: widget.c.knobs.list(
                label: 'ActiveIcon',
                options: [
                  ZetaIcons.star_round,
                  ZetaIcons.add_alert_round,
                  ZetaIcons.add_box_round,
                  ZetaIcons.barcode_round,
                ],
                labelBuilder: (value) {
                  if (value == ZetaIcons.star_round)
                    return 'ZetaIcons.star_round';
                  if (value == ZetaIcons.add_alert_round)
                    return 'ZetaIcons.add_alert_round';
                  if (value == ZetaIcons.add_box_round)
                    return 'ZetaIcons.add_box_round';
                  if (value == ZetaIcons.barcode_round)
                    return 'ZetaIcons.barcode_round';
                  return '';
                },
              ),
            ),
            SizedBox(
              height: 50,
            ),
            FilledButton(
                onPressed: () {
                  setState(() {
                    _children.add('Icon before with seperator');
                  });
                },
                child: Text("Add Breadcrumb"))
          ])),
    );
  }
}
