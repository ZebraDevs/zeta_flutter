import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class SystemBannerExample extends StatelessWidget {
  static const String name = 'SystemBanner';

  const SystemBannerExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: SystemBannerExample.name,
      paddingAll: 0,
      children: [
        ZetaSystemBanner(
          type: ZetaSystemBannerStatus.primary,
          title: 'Centered',
          context: context,
          titleCenter: true,
          leadingIcon: ZetaIcons.info,
          key: Key('docs-system-banner'),
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
          trailing: ZetaIcon(ZetaIcons.close),
        ),
        _getTitle('Color variants'),
        ZetaSystemBanner(
          type: ZetaSystemBannerStatus.positive,
          key: Key('docs-system-banner-positive'),
          context: context,
          title: 'Banner Title',
          titleCenter: true,
          leadingIcon: ZetaIcons.info,
          trailing: IconButton(
            icon: ZetaIcon(ZetaIcons.chevron_right),
            onPressed: () {
              ScaffoldMessenger.of(context).showMaterialBanner(ZetaSystemBanner(
                title: 'Title',
                context: context,
                type: ZetaSystemBannerStatus.positive,
                trailing: ZetaIcon(ZetaIcons.close),
              ));
            },
          ),
        ),
        ZetaSystemBanner(
          type: ZetaSystemBannerStatus.warning,
          key: Key('docs-system-banner-warning'),
          title: 'Left Aligned',
          context: context,
          leadingIcon: ZetaIcons.info,
          trailing: ZetaIcon(ZetaIcons.chevron_right),
        ),
        ZetaSystemBanner(
          type: ZetaSystemBannerStatus.negative,
          key: Key('docs-system-banner-negative'),
          title: 'Centered',
          context: context,
          titleCenter: true,
          leadingIcon: ZetaIcons.info,
          trailing: ZetaIcon(ZetaIcons.chevron_right),
        ),
      ].divide(const SizedBox(height: 10)).toList(),
    );
  }

  Widget _getTitle(String title) => Container(height: 50, child: Center(child: Text(title)));
}

class InPageBannerExample extends StatelessWidget {
  final _content = 'Lorem ipsum dolor sit amet, conse ctetur  cididunt ut'
      'labore et do lore magna aliqua.';

  static const String name = 'InPageBanner';
  const InPageBannerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: name,
      children: [
        ZetaInPageBanner(
          key: Key('docs-in-page-banner'),
          content: Text(_content),
          status: ZetaWidgetStatus.info,
          title: 'Banner Title',
          actions: [
            ZetaButton(label: 'Button', onPressed: () {}),
            ZetaButton(label: 'Button', onPressed: () {}),
          ],
        ),
        ZetaInPageBanner(
          content: Text(_content + _content + _content),
          key: Key('docs-in-page-banner-2'),
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
      ].gap(16),
    );
  }
}
