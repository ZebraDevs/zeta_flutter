import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'System Banner',
  type: ZetaSystemBanner,
  path: '$componentsPath/System Banner',
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=22195-43965&t=eEOivHU9uV4K8qJq-4',
)
Widget banner(BuildContext context) {
  final banner = ZetaSystemBanner(
    context: context,
    title: context.knobs.string(label: 'Title', initialValue: 'Banner Title'),
    type: context.knobs.object.dropdown(
      label: 'Type',
      options: ZetaSystemBannerStatus.values,
      labelBuilder: enumLabelBuilder,
      initialOption: ZetaSystemBannerStatus.primary,
    ),
    leadingIcon: iconKnob(context, nullable: true),
    titleCenter: context.knobs.boolean(label: 'Center title'),
    trailing: Icon(iconKnob(context, nullable: true, name: 'trailing', initial: ZetaIcons.chevron_right)),
  );

  return Column(
    children: [
      banner,
      SizedBox(height: Zeta.of(context).spacing.xl_9),
      ZetaButton.text(
        label: 'Popup',
        onPressed: () {
          ScaffoldMessenger.of(context).showMaterialBanner(banner);
          Future.delayed(const Duration(seconds: 2)).then(
            (value) {
              if (context.mounted) ScaffoldMessenger.of(context).clearMaterialBanners();
            },
          );
        },
      ),
    ],
  );
}
