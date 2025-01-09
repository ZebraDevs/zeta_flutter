import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class BannerExample extends StatelessWidget {
  static const String name = 'Banner';

  const BannerExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: BannerExample.name,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('System Banner', style: ZetaTextStyles.displayMedium),
              _getTitle('Style variants'),
              ZetaSystemBanner(
                type: ZetaSystemBannerStatus.primary,
                title: 'Centered',
                context: context,
                titleCenter: true,
                leadingIcon: ZetaIcons.info,
              ),
              ZetaSystemBanner(
                type: ZetaSystemBannerStatus.primary,
                context: context,
                title: 'Title Left',
              ),
              ZetaSystemBanner(
                type: ZetaSystemBannerStatus.primary,
                context: context,
                title: 'Title left with arrow',
                titleCenter: true,
                trailing: ZetaIcon(ZetaIcons.chevron_right),
              ),
              ZetaSystemBanner(
                type: ZetaSystemBannerStatus.primary,
                title: 'Title left + Icon',
                titleCenter: true,
                context: context,
                leadingIcon: ZetaIcons.info,
              ),
              ZetaSystemBanner(
                type: ZetaSystemBannerStatus.primary,
                context: context,
                title: 'Title left + Icon with Arrow',
                titleCenter: true,
                leadingIcon: ZetaIcons.info,
                trailing: IconButton(
                  icon: ZetaIcon(ZetaIcons.chevron_right),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showMaterialBanner(ZetaSystemBanner(
                      title: 'Title',
                      context: context,
                      type: ZetaSystemBannerStatus.primary,
                      trailing: IconButton(
                        icon: ZetaIcon(ZetaIcons.close),
                        onPressed: () => ScaffoldMessenger.of(context).clearMaterialBanners(),
                      ),
                    ));
                  },
                ),
              ),
              _getTitle('Color variants'),
              ZetaSystemBanner(
                type: ZetaSystemBannerStatus.positive,
                context: context,
                title: 'Centered',
                titleCenter: true,
                leadingIcon: ZetaIcons.info,
                trailing: IconButton(
                  icon: ZetaIcon(ZetaIcons.chevron_right),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showMaterialBanner(ZetaSystemBanner(
                      title: 'Title',
                      context: context,
                      type: ZetaSystemBannerStatus.positive,
                      trailing: IconButton(
                        icon: ZetaIcon(ZetaIcons.close),
                        onPressed: () => ScaffoldMessenger.of(context).clearMaterialBanners(),
                      ),
                    ));
                  },
                ),
              ),
              ZetaSystemBanner(
                type: ZetaSystemBannerStatus.warning,
                title: 'Centered',
                context: context,
                titleCenter: true,
                leadingIcon: ZetaIcons.info,
                trailing: IconButton(
                  icon: ZetaIcon(ZetaIcons.chevron_right),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showMaterialBanner(ZetaSystemBanner(
                      title: 'Title',
                      context: context,
                      type: ZetaSystemBannerStatus.warning,
                      trailing: IconButton(
                        icon: ZetaIcon(ZetaIcons.close),
                        onPressed: () => ScaffoldMessenger.of(context).clearMaterialBanners(),
                      ),
                    ));
                  },
                ),
              ),
              ZetaSystemBanner(
                type: ZetaSystemBannerStatus.negative,
                title: 'Centered',
                context: context,
                titleCenter: true,
                leadingIcon: ZetaIcons.info,
                trailing: IconButton(
                  icon: ZetaIcon(ZetaIcons.chevron_right),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showMaterialBanner(ZetaSystemBanner(
                      title: 'Title',
                      context: context,
                      type: ZetaSystemBannerStatus.negative,
                      trailing: IconButton(
                        icon: ZetaIcon(ZetaIcons.close),
                        onPressed: () => ScaffoldMessenger.of(context).clearMaterialBanners(),
                      ),
                    ));
                  },
                ),
              ),
              const Divider(),
              Text('In-Page Banner', style: ZetaTextStyles.displayMedium),
              ZetaInPageBanner(
                content: Text(_content),
                status: ZetaWidgetStatus.info,
              ),
              ZetaInPageBanner(
                content: Text(_content),
                onClose: () {},
                status: ZetaWidgetStatus.positive,
                title: 'Banner Title',
              ),
              ZetaInPageBanner(
                content: Text(_content),
                onClose: () {},
                status: ZetaWidgetStatus.warning,
                title: 'Banner Title',
                actions: [ZetaButton(label: 'Button', onPressed: () {})],
              ),
              ZetaInPageBanner(
                content: Text(_content),
                onClose: () {},
                status: ZetaWidgetStatus.negative,
                title: 'Banner Title Banner Title Banner Title Banner Title',
              ),
              ZetaInPageBanner(
                content: Text(_content),
                onClose: () {},
                status: ZetaWidgetStatus.neutral,
                title: 'Banner Title',
              )
            ].divide(const SizedBox(height: 10)).toList(),
          ),
        ),
      ),
    );
  }

  final _content = 'Lorem ipsum dolor sit amet, conse ctetur  cididunt ut'
      'labore et do lore magna aliqua.';

  Widget _getTitle(String title) => Container(height: 50, child: Center(child: Text(title)));

  Column buildExampleBannerColumn(
    ZetaWidgetStatus status, {
    IconData? customIcon,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: [
        ZetaInPageBanner(
          content: Text(_content),
          onClose: () {},
          status: status,
          title: 'Banner Title',
          customIcon: customIcon,
        ),
      ],
    );
  }
}
