import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';
import '../../utils/utils.dart';

Widget bannerUseCase(BuildContext context) {
  final banner = ZetaBanner(
    context: context,
    title: context.knobs.string(label: 'Title', initialValue: 'Banner Title'),
    type: context.knobs.list(
      label: 'Type',
      options: ZetaBannerStatus.values,
      labelBuilder: enumLabelBuilder,
    ),
    leadingIcon: iconKnob(context, nullable: true),
    titleStart: context.knobs.boolean(label: 'Center title'),
    trailing: ZetaIcon(iconKnob(
      context,
      nullable: true,
      name: 'trailing',
      initial: ZetaIcons.chevron_right,
    )),
  );

  return WidgetBookScaffold(
    removeBody: true,
    builder: (context, _) => Column(
      children: [
        banner,
        const SizedBox(height: ZetaSpacing.xl_9),
        ZetaButton.text(
          label: 'Popup',
          onPressed: () {
            ScaffoldMessenger.of(context).showMaterialBanner(banner);
            Future.delayed(Duration(seconds: 2)).then(
              (value) => ScaffoldMessenger.of(context).clearMaterialBanners(),
            );
          },
        )
      ],
    ),
  );
}
