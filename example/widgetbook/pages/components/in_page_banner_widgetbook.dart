import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';
import '../../utils/utils.dart';

Widget inPageBannerUseCase(BuildContext context) => WidgetbookScaffold(
      builder: (context, _) => Padding(
        padding: EdgeInsets.all(Zeta.of(context).spacing.xl),
        child: ZetaInPageBanner(
          content: Text(
            context.knobs.string(
              label: 'content',
              initialValue: 'Lorem ipsum dolor sit amet, conse ctetur  cididunt ut labore et do lore magna aliqua.',
            ),
          ),
          status: context.knobs.list(
            label: 'Severity',
            options: ZetaWidgetStatus.values,
            labelBuilder: enumLabelBuilder,
          ),
          onClose: context.knobs.boolean(label: 'Show Close icon') ? () {} : null,
          title: context.knobs.string(label: 'Title', initialValue: 'Title'),
          actions: () {
            final x = context.knobs.list(label: 'Show Buttons', options: [0, 1, 2]);

            if (x == 1) {
              return [
                ZetaButton(label: 'Button 1', onPressed: () {}),
              ];
            }
            if (x == 2) {
              return [ZetaButton(label: 'Button 1', onPressed: () {}), ZetaButton(label: 'Button 2', onPressed: () {})];
            }
            return <ZetaButton>[];
          }(),
          customIcon: iconKnob(context, nullable: true),
        ),
      ),
    );
