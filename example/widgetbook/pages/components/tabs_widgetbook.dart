import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';
import '../../utils/utils.dart';

Widget tabsUseCase(BuildContext context) {
  return WidgetbookTestWidget(
    widget: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: ZetaSpacing.xl_4),
            child: DefaultTabController(
              length: 2,
              child: ZetaTabBar(
                context: context,
                onTap: context.knobs.boolean(
                  label: "Disabled",
                  initialValue: false,
                )
                    ? null
                    : (_) {},
                tabs: [
                  ZetaTab(icon: Icon(ZetaIcons.star_round), text: "Tab Item"),
                  ZetaTab(icon: Icon(ZetaIcons.star_round), text: "Tab Item"),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: ZetaSpacing.xl_4),
            child: DefaultTabController(
              length: 5,
              child: ZetaTabBar(
                context: context,
                onTap: disabledKnob(context) ? null : (_) {},
                isScrollable: true,
                tabs: [
                  ZetaTab(text: "Tab Item"),
                  ZetaTab(text: "Tab Item"),
                  ZetaTab(text: "Tab Item"),
                  ZetaTab(text: "Tab Item"),
                  ZetaTab(text: "Tab Item"),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
