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
                type: ZetaSystemBannerType.defaultAppBar,
                title: Text('Centered'),
                centerTitle: true,
                titleIcon: Icon(ZetaIcons.info_round),
              ),
              ZetaSystemBanner(
                type: ZetaSystemBannerType.defaultAppBar,
                title: Text('Title Left'),
              ),
              ZetaSystemBanner(
                type: ZetaSystemBannerType.defaultAppBar,
                title: Text('Title left with arrow'),
                centerTitle: true,
                actions: [Icon(ZetaIcons.chevron_right_round)],
              ),
              ZetaSystemBanner(
                type: ZetaSystemBannerType.defaultAppBar,
                title: Text('Title left + Icon'),
                centerTitle: true,
                titleIcon: Icon(ZetaIcons.info_round),
              ),
              ZetaSystemBanner(
                type: ZetaSystemBannerType.defaultAppBar,
                title: Text('Title left + Icon with Arrow'),
                centerTitle: true,
                titleIcon: Icon(ZetaIcons.info_round),
                actions: [Icon(ZetaIcons.chevron_right_round)],
              ),
              _getTitle('Color variants'),
              ZetaSystemBanner(
                type: ZetaSystemBannerType.positiveAppBar,
                title: Text('Centered'),
                centerTitle: true,
                titleIcon: Icon(ZetaIcons.info_round),
              ),
              ZetaSystemBanner(
                type: ZetaSystemBannerType.warningAppBar,
                title: Text('Centered'),
                centerTitle: true,
                titleIcon: Icon(ZetaIcons.info_round),
              ),
              ZetaSystemBanner(
                type: ZetaSystemBannerType.negativeAppBar,
                title: Text('Centered'),
                centerTitle: true,
                titleIcon: Icon(ZetaIcons.info_round),
              ),
              const SizedBox(height: Dimensions.m),
              const Divider(),
              Text('In-Page Banner', style: ZetaTextStyles.displayMedium),
              _getTitle('Default Banner Rounded'),
              buildExampleBannerColumn(WidgetSeverity.neutral),
              _getTitle('Info Banner Rounded'),
              buildExampleBannerColumn(WidgetSeverity.info),
              _getTitle('Positive Banner Rounded'),
              buildExampleBannerColumn(WidgetSeverity.positive),
              _getTitle('Warning Banner Rounded'),
              buildExampleBannerColumn(WidgetSeverity.warning),
              _getTitle('Negative Banner Rounded'),
              buildExampleBannerColumn(WidgetSeverity.negative),
              _getTitle('Custom Banner Rounded'),
              buildExampleBannerColumn(WidgetSeverity.custom,
                  customColors: ZetaWidgetColor(backgroundColor: Colors.blue.shade50, foregroundColor: Colors.blue)),
              Divider(
                height: 50,
                color: Colors.transparent,
              ),
              _getTitle('Default Banner Sharp'),
              buildExampleBannerColumn(WidgetSeverity.neutral, border: BorderType.sharp),
              _getTitle('Info Banner Sharp'),
              buildExampleBannerColumn(WidgetSeverity.info, border: BorderType.sharp),
              _getTitle('Positive Banner Sharp'),
              buildExampleBannerColumn(WidgetSeverity.positive, border: BorderType.sharp),
              _getTitle('Warning Banner Sharp'),
              buildExampleBannerColumn(WidgetSeverity.warning, border: BorderType.sharp),
              _getTitle('Negative Banner Sharp'),
              buildExampleBannerColumn(WidgetSeverity.negative, border: BorderType.sharp),
              _getTitle('Custom Banner Sharp'),
              buildExampleBannerColumn(WidgetSeverity.custom,
                  border: BorderType.sharp,
                  customColors: ZetaWidgetColor(backgroundColor: Colors.blue.shade50, foregroundColor: Colors.blue)),
            ]
                .divide(const SizedBox(
                  height: 10,
                ))
                .toList(),
          ),
        ),
      ),
    );
  }

  final _content = 'Lorem ipsum dolor sit amet, conse ctetur  cididunt ut'
      'labore et do lore magna aliqua.';

  Widget _getTitle(String title) => Container(height: 50, child: Center(child: Text(title)));

  _getExampleBanner(
    WidgetSeverity severity,
    BorderType type, {
    String? title,
    bool showCloseBtn = true,
    bool showFirstButton = false,
    bool showSecondButton = false,
    ZetaWidgetColor? customColors,
    IconData? customIcon,
  }) =>
      ZetaInPageBanner(
        content: Text(_content),
        onClose: () {},
        borderType: type,
        severity: severity,
        showIconClose: showCloseBtn,
        title: title,
        firstButton: showFirstButton ? ZetaPageBannerButton(label: 'Button', onPressed: () {}) : null,
        secondButton: showSecondButton ? ZetaPageBannerButton(label: 'Button', onPressed: () {}) : null,
        customColors: customColors,
        customIcon: customIcon,
      );

  Column buildExampleBannerColumn(
    WidgetSeverity severity, {
    ZetaWidgetColor? customColors,
    BorderType border = BorderType.rounded,
    IconData? customIcon,
  }) {
    const _title = 'Banner Title';
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: [
        _getExampleBanner(severity, border,
            title: _title,
            showFirstButton: true,
            showSecondButton: true,
            customColors: customColors,
            customIcon: customIcon),
        _getExampleBanner(severity, border, title: _title, customColors: customColors, customIcon: customIcon),
        Divider(color: Colors.transparent),
        _getExampleBanner(severity, border, customColors: customColors, customIcon: customIcon),
        Divider(color: Colors.transparent),
        _getExampleBanner(
          severity,
          border,
          showCloseBtn: false,
          title: _title,
          customColors: customColors,
          customIcon: customIcon,
        ),
        Divider(color: Colors.transparent),
        _getExampleBanner(severity, border, showCloseBtn: false, customColors: customColors, customIcon: customIcon),
        Divider(),
      ],
    );
  }
}
