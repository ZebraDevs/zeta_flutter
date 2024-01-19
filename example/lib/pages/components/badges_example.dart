import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class BadgesExample extends StatelessWidget {
  static const String name = 'Badges';

  const BadgesExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: BadgesExample.name,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _DividingText('Status Label'),
            _StatusLabel(),
            _DividingText('Priority Pill'),
            _PriorityPill(),
            _DividingText('Badge'),
            _Badge(),
            _DividingText('Indicators'),
            _Indicators(),
            _DividingText('Tags'),
            _Tags(),
            _DividingText('WorkCloud indicators'),
            _WorkcloudIndicators(),
          ],
        ),
      ),
    );
  }
}

class _DividingText extends StatelessWidget {
  final String text;
  const _DividingText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: ZetaTextStyles.displayMedium,
    ).paddingVertical(Dimensions.l);
  }
}

class _StatusLabel extends StatelessWidget {
  const _StatusLabel();

  Widget statusLabelExampleRow(WidgetSeverity type, {ZetaWidgetColor? colors}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ZetaStatusLabel(label: 'Label', severity: type, isDefaultIcon: false, customColors: colors),
        ZetaStatusLabel(label: 'Label', severity: type, borderType: BorderType.rounded, customColors: colors),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        statusLabelExampleRow(WidgetSeverity.neutral),
        statusLabelExampleRow(WidgetSeverity.info),
        statusLabelExampleRow(WidgetSeverity.positive),
        statusLabelExampleRow(WidgetSeverity.warning),
        statusLabelExampleRow(WidgetSeverity.negative),
        statusLabelExampleRow(
          WidgetSeverity.custom,
          colors: ZetaWidgetColor(foregroundColor: Colors.blue, backgroundColor: Colors.blue.shade50),
        )
      ].divide(const SizedBox.square(dimension: Dimensions.m)).toList(),
    );
  }
}

class _PriorityPill extends StatelessWidget {
  const _PriorityPill();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ZetaPriorityPill(index: 1, priority: 'Rounded', borderType: BorderType.rounded),
        ZetaPriorityPill(index: 2, priority: 'Sharp'),
      ].divide(const SizedBox.square(dimension: Dimensions.m)).toList(),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge();

  Widget badgeExampleRow(WidgetSeverity type) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ZetaBadge(label: 'Label', severity: type, borderType: BorderType.sharp),
        ZetaBadge(label: 'Label', severity: type),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        badgeExampleRow(WidgetSeverity.info),
        badgeExampleRow(WidgetSeverity.positive),
        badgeExampleRow(WidgetSeverity.warning),
        badgeExampleRow(WidgetSeverity.negative),
        badgeExampleRow(WidgetSeverity.neutral),
      ].divide(const SizedBox(height: Dimensions.m)).toList(),
    );
  }
}

class _Indicators extends StatelessWidget {
  const _Indicators();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: [
            Text(
              'ZetaIndicator.icon',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ZetaIndicator.icon(),
                        ZetaIndicator.icon(size: ZetaIndicatorSize.medium),
                        ZetaIndicator.icon(size: ZetaIndicatorSize.small),
                      ].divide(const SizedBox.square(dimension: Dimensions.m)).toList(),
                    ),
                    Row(
                      children: [
                        ZetaIndicator.icon(inverseBorder: true),
                        ZetaIndicator.icon(size: ZetaIndicatorSize.medium, inverseBorder: true),
                        ZetaIndicator.icon(size: ZetaIndicatorSize.small, inverseBorder: true),
                      ].divide(const SizedBox.square(dimension: Dimensions.m)).toList(),
                    ),
                    Text('Rounded', style: TextStyle(fontWeight: FontWeight.bold)),
                  ].divide(const SizedBox.square(dimension: Dimensions.xs)).toList(),
                ),
                const SizedBox(width: 50),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ZetaIndicator.icon(rounded: false),
                        ZetaIndicator.icon(size: ZetaIndicatorSize.medium, rounded: false),
                        ZetaIndicator.icon(size: ZetaIndicatorSize.small),
                      ].divide(const SizedBox.square(dimension: Dimensions.m)).toList(),
                    ),
                    Row(
                      children: [
                        ZetaIndicator.icon(rounded: false, inverseBorder: true),
                        ZetaIndicator.icon(size: ZetaIndicatorSize.medium, rounded: false, inverseBorder: true),
                        ZetaIndicator.icon(size: ZetaIndicatorSize.small, inverseBorder: true),
                      ].divide(const SizedBox.square(dimension: Dimensions.m)).toList(),
                    ),
                    Text('Sharp', style: TextStyle(fontWeight: FontWeight.bold)),
                  ].divide(const SizedBox.square(dimension: Dimensions.s)).toList(),
                ),
              ],
            ),
          ],
        ),
        const SizedBox.square(dimension: Dimensions.xl),
        Column(
          children: [
            Text('ZetaIndicator.notification', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ZetaIndicator.notification(value: 3),
                        ZetaIndicator.notification(size: ZetaIndicatorSize.medium, value: 3),
                        ZetaIndicator.notification(size: ZetaIndicatorSize.small),
                      ].divide(const SizedBox.square(dimension: Dimensions.m)).toList(),
                    ),
                    Row(
                      children: [
                        ZetaIndicator.notification(value: 3, inverseBorder: true),
                        ZetaIndicator.notification(size: ZetaIndicatorSize.medium, value: 3, inverseBorder: true),
                        ZetaIndicator.notification(size: ZetaIndicatorSize.small, inverseBorder: true),
                      ].divide(const SizedBox.square(dimension: Dimensions.m)).toList(),
                    ),
                    Text('', style: TextStyle(fontWeight: FontWeight.bold)),
                  ].divide(const SizedBox.square(dimension: Dimensions.s)).toList(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _Tags extends StatelessWidget {
  const _Tags();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ZetaTag.left(label: 'Sharp', borderType: BorderType.sharp),
        ZetaTag.right(label: 'Sharp', borderType: BorderType.sharp),
        ZetaTag.left(label: 'Rounded', borderType: BorderType.sharp),
        ZetaTag.right(label: 'Rounded', borderType: BorderType.rounded),
      ].divide(SizedBox.square(dimension: Dimensions.m)).toList(),
    );
  }
}

class _WorkcloudIndicators extends StatelessWidget {
  const _WorkcloudIndicators();

  List<Widget> workcloudIndicatorStatusRow(String label) {
    return [
      Row(children: [ZetaWorkcloudIndicator.status(label: label)]),
      SizedBox(height: 10)
    ];
  }

  Widget workcloudIndicatorExampleRow(String label, String index, ZetaWorkcloudIndicatorType type,
      {ZetaWidgetColor? colors}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ZetaWorkcloudIndicator.priorityPill(
            index: index, label: label, priorityType: type, prioritySize: ZetaWidgetSize.large, customColors: colors),
        ZetaWorkcloudIndicator.priorityPill(
          index: index,
          label: label,
          prioritySize: ZetaWidgetSize.medium,
          priorityType: type,
          customColors: colors,
        ),
        ZetaWorkcloudIndicator.priorityPill(index: index, label: label, priorityType: type, customColors: colors),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ZetaWorkcloudIndicator(label: 'Test Status Badge'),
            ZetaWorkcloudIndicator.status(label: 'Status'),
            ZetaWorkcloudIndicator.status(label: 'In Progress'),
            ZetaWorkcloudIndicator.status(label: 'Reviewed'),
            ZetaWorkcloudIndicator.status(label: 'Resolved')
          ].divide(const SizedBox.square(dimension: Dimensions.s)).toList(),
        ),
        SizedBox(height: 30),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Medium'), Text('Small'), Text('X-Small')],
            ),
            workcloudIndicatorExampleRow('Urgent', 'U', ZetaWorkcloudIndicatorType.urgent),
            workcloudIndicatorExampleRow('High', '1', ZetaWorkcloudIndicatorType.high),
            workcloudIndicatorExampleRow('Medium', '2', ZetaWorkcloudIndicatorType.medium),
            workcloudIndicatorExampleRow('Low', '3', ZetaWorkcloudIndicatorType.low),
            workcloudIndicatorExampleRow(
              'Custom',
              '4',
              ZetaWorkcloudIndicatorType.custom,
              colors: ZetaWidgetColor(backgroundColor: Colors.purple, foregroundColor: Colors.purple.shade50),
            ),
          ].divide(const SizedBox.square(dimension: Dimensions.s)).toList(),
        ).paddingAll(Dimensions.m)
      ],
    );
  }
}
