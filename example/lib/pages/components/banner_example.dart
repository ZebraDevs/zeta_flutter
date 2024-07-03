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
              ZetaBanner(
                type: ZetaBannerStatus.primary,
                title: 'Centered',
                context: context,
                titleStart: true,
                leadingIcon: ZetaIcons.info,
              ),
              ZetaBanner(
                type: ZetaBannerStatus.primary,
                context: context,
                title: 'Title Left',
              ),
              ZetaBanner(
                type: ZetaBannerStatus.primary,
                context: context,
                title: 'Title left with arrow',
                titleStart: true,
                trailing: ZetaIcon(ZetaIcons.chevron_right),
              ),
              ZetaBanner(
                type: ZetaBannerStatus.primary,
                title: 'Title left + Icon',
                titleStart: true,
                context: context,
                leadingIcon: ZetaIcons.info,
              ),
              ZetaBanner(
                type: ZetaBannerStatus.primary,
                context: context,
                title: 'Title left + Icon with Arrow',
                titleStart: true,
                leadingIcon: ZetaIcons.info,
                trailing: IconButton(
                  icon: ZetaIcon(ZetaIcons.chevron_right),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showMaterialBanner(ZetaBanner(
                      title: 'Title',
                      context: context,
                      type: ZetaBannerStatus.primary,
                      trailing: IconButton(
                        icon: ZetaIcon(ZetaIcons.close),
                        onPressed: () => ScaffoldMessenger.of(context).clearMaterialBanners(),
                      ),
                    ));
                  },
                ),
              ),
              _getTitle('Color variants'),
              ZetaBanner(
                type: ZetaBannerStatus.positive,
                context: context,
                title: 'Centered',
                titleStart: true,
                leadingIcon: ZetaIcons.info,
                trailing: IconButton(
                  icon: ZetaIcon(ZetaIcons.chevron_right),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showMaterialBanner(ZetaBanner(
                      title: 'Title',
                      context: context,
                      type: ZetaBannerStatus.positive,
                      trailing: IconButton(
                        icon: ZetaIcon(ZetaIcons.close),
                        onPressed: () => ScaffoldMessenger.of(context).clearMaterialBanners(),
                      ),
                    ));
                  },
                ),
              ),
              ZetaBanner(
                type: ZetaBannerStatus.warning,
                title: 'Centered',
                context: context,
                titleStart: true,
                leadingIcon: ZetaIcons.info,
                trailing: IconButton(
                  icon: ZetaIcon(ZetaIcons.chevron_right),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showMaterialBanner(ZetaBanner(
                      title: 'Title',
                      context: context,
                      type: ZetaBannerStatus.warning,
                      trailing: IconButton(
                        icon: ZetaIcon(ZetaIcons.close),
                        onPressed: () => ScaffoldMessenger.of(context).clearMaterialBanners(),
                      ),
                    ));
                  },
                ),
              ),
              ZetaBanner(
                type: ZetaBannerStatus.negative,
                title: 'Centered',
                context: context,
                titleStart: true,
                leadingIcon: ZetaIcons.info,
                trailing: IconButton(
                  icon: ZetaIcon(ZetaIcons.chevron_right),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showMaterialBanner(ZetaBanner(
                      title: 'Title',
                      context: context,
                      type: ZetaBannerStatus.negative,
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
