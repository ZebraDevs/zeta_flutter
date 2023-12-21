import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../widgets.dart';

class InPageBannerExample extends StatelessWidget {
  static const String name = 'InPageBanner';

  const InPageBannerExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: InPageBannerExample.name,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _getTitle(String title) => Container(
        height: 50,
        child: Center(child: Text(title, style: ZetaText.zetaTitleLarge)),
      );
}

const _content = 'Lorem ipsum dolor sit amet, conse ctetur  cididunt ut'
    'labore et do lore magna aliqua.';

ZetaInPageBanner _getExampleBanner(
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
        customIcon: customIcon);

Column buildExampleBannerColumn(WidgetSeverity severity,
    {ZetaWidgetColor? customColors, BorderType border = BorderType.rounded, IconData? customIcon}) {
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
      //Rounded (Icon + Title + Close + Buttons)
      Divider(color: Colors.transparent),
      _getExampleBanner(severity, border, title: _title, customColors: customColors, customIcon: customIcon),
      //Rounded (Icon + Title + Close )
      Divider(color: Colors.transparent),
      _getExampleBanner(severity, border, customColors: customColors, customIcon: customIcon),
      //Rounded (Icon + Close)
      Divider(color: Colors.transparent),
      _getExampleBanner(severity, border,
          showCloseBtn: false, title: _title, customColors: customColors, customIcon: customIcon),
      //Rounded (Icon + Title)
      Divider(color: Colors.transparent),
      _getExampleBanner(severity, border, showCloseBtn: false, customColors: customColors, customIcon: customIcon),
      //Rounded (Icon)
      Divider(),
      //Rounded (Icon + Title + Close)
    ],
  );
}
