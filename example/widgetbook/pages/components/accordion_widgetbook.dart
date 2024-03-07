import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';
import '../../utils/utils.dart';

Widget accordionUseCase(BuildContext context) => WidgetbookTestWidget(
      widget: Padding(
        padding: const EdgeInsets.all(ZetaSpacing.x5),
        child: ZetaAccordion(
          child: context.knobs.boolean(label: 'Disabled')
              ? null
              : Column(
                  children: [
                    ListTile(title: Text('Item One')),
                    ListTile(title: Text('Item  two')),
                    ListTile(title: Text('Item three')),
                    ListTile(title: Text('Item four')),
                  ],
                ),
          title: context.knobs.string(label: 'Accordion Title', initialValue: 'Title'),
          contained: context.knobs.boolean(label: 'Contained', initialValue: false),
          rounded: roundedKnob(context),
        ),
      ),
    );
