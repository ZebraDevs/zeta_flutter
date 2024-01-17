import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_example/pages/in_page_banner_example.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

WidgetbookComponent inPageBannerWidgetBook() {
  Widget _getTitle(String title) => Container(
        height: 50,
        child: Center(child: Text(title, style: ZetaTextStyles.titleLarge)),
      );

  ZetaWidgetColor _getCustomColors() =>
      ZetaWidgetColor(backgroundColor: Colors.blue.shade50, foregroundColor: Colors.blue);

  return WidgetbookComponent(
    name: 'InPageBanner',
    useCases: [
      WidgetbookUseCase(
        name: 'Default In Page Banner',
        builder: (context) => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _getTitle('Banner Rounded'),
                buildExampleBannerColumn(WidgetSeverity.neutral),
                _getTitle('Banner Sharp'),
                buildExampleBannerColumn(WidgetSeverity.neutral, border: BorderType.sharp),
              ],
            ),
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'Info In Page Banner',
        builder: (context) => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _getTitle('Banner Rounded'),
                buildExampleBannerColumn(WidgetSeverity.info),
                _getTitle('Banner Sharp'),
                buildExampleBannerColumn(WidgetSeverity.info, border: BorderType.sharp),
              ],
            ),
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'Positive In Page Banner',
        builder: (context) => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _getTitle('Banner Rounded'),
                buildExampleBannerColumn(WidgetSeverity.positive),
                _getTitle('Banner Sharp'),
                buildExampleBannerColumn(WidgetSeverity.positive, border: BorderType.sharp),
              ],
            ),
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'Warning In Page Banner',
        builder: (context) => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _getTitle('Banner Rounded'),
                buildExampleBannerColumn(WidgetSeverity.warning),
                _getTitle('Banner Sharp'),
                buildExampleBannerColumn(WidgetSeverity.warning, border: BorderType.sharp),
              ],
            ),
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'Negative In Page Banner',
        builder: (context) => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _getTitle('Banner Rounded'),
                buildExampleBannerColumn(WidgetSeverity.negative),
                _getTitle('Banner Sharp'),
                buildExampleBannerColumn(WidgetSeverity.negative, border: BorderType.sharp),
              ],
            ),
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'Custom In Page Banner',
        builder: (context) => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _getTitle('Banner Rounded'),
                buildExampleBannerColumn(WidgetSeverity.custom,
                    customColors: _getCustomColors(), customIcon: ZetaIcons.alert_round),
                _getTitle('Banner Sharp'),
                buildExampleBannerColumn(WidgetSeverity.custom,
                    customColors: _getCustomColors(), border: BorderType.sharp, customIcon: ZetaIcons.alert_sharp),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
