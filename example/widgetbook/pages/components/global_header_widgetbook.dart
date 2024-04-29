import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

Widget globalHeaderUseCase(BuildContext context) => WidgetbookTestWidget(
      widget: Center(
        child: GlobalHeaderExample(context),
      ),
    );

class GlobalHeaderExample extends StatefulWidget {
  const GlobalHeaderExample(this.c);
  final BuildContext c;

  @override
  State<GlobalHeaderExample> createState() => _GlobalHeaderExampleState();
}

class _GlobalHeaderExampleState extends State<GlobalHeaderExample> {
  List<ZetaTabItem> children = [];
  final childrenTwo = List.filled(10, ZetaTabItem());
  final utilityButtons = [
    IconButton(
      onPressed: () {},
      icon: const Icon(
        ZetaIcons.alert_round,
      ),
    ),
    IconButton(
      onPressed: () {},
      icon: const Icon(
        ZetaIcons.help_round,
      ),
    ),
    IconButton(
      onPressed: () {},
      icon: const Icon(
        ZetaIcons.apps_round,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            ZetaGlobalHeader(
              title:
                  widget.c.knobs.string(label: "Title", initialValue: "Title"),
              tabItems:
                  widget.c.knobs.boolean(label: "Children") ? childrenTwo : [],
              utilityButtons: widget.c.knobs.boolean(label: "Menu buttons")
                  ? utilityButtons
                  : [],
            )
          ],
        ),
      ),
    );
  }
}
