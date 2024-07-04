import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';

Widget accordionUseCase(BuildContext context) => WidgetbookScaffold(
      builder: (context, _) => Padding(
        padding: const EdgeInsets.all(ZetaSpacing.xl_1),
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
        ),
      ),
    );
