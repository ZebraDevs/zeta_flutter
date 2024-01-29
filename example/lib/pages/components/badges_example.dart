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
    ).paddingVertical(ZetaSpacing.l);
  }
}

class _StatusLabel extends StatelessWidget {
  const _StatusLabel();

  Widget statusLabelExampleRow(ZetaWidgetStatus type, {ZetaWidgetColor? colors}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ZetaStatusLabel(label: 'Label', status: type, rounded: false),
        ZetaStatusLabel(label: 'Label', status: type, rounded: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        statusLabelExampleRow(ZetaWidgetStatus.neutral),
        statusLabelExampleRow(ZetaWidgetStatus.info),
        statusLabelExampleRow(ZetaWidgetStatus.positive),
        statusLabelExampleRow(ZetaWidgetStatus.warning),
        statusLabelExampleRow(ZetaWidgetStatus.negative),
      ].divide(const SizedBox.square(dimension: ZetaSpacing.m)).toList(),
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
        ZetaPriorityPill(index: 1000, priority: 'Rounded', rounded: true),
        ZetaPriorityPill(index: 2, priority: 'Sharp', rounded: false),
      ].divide(const SizedBox.square(dimension: ZetaSpacing.m)).toList(),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge();

  Widget badgeExampleRow(ZetaWidgetStatus type) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ZetaBadge(label: 'Label', status: type, rounded: false),
        ZetaBadge(label: 'Label', status: type),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        badgeExampleRow(ZetaWidgetStatus.info),
        badgeExampleRow(ZetaWidgetStatus.positive),
        badgeExampleRow(ZetaWidgetStatus.warning),
        badgeExampleRow(ZetaWidgetStatus.negative),
        badgeExampleRow(ZetaWidgetStatus.neutral),
      ].divide(const SizedBox(height: ZetaSpacing.m)).toList(),
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
                      ].divide(const SizedBox.square(dimension: ZetaSpacing.m)).toList(),
                    ),
                    Row(
                      children: [
                        ZetaIndicator.icon(inverseBorder: true),
                        ZetaIndicator.icon(size: ZetaIndicatorSize.medium, inverseBorder: true),
                        ZetaIndicator.icon(size: ZetaIndicatorSize.small, inverseBorder: true),
                      ].divide(const SizedBox.square(dimension: ZetaSpacing.m)).toList(),
                    ),
                  ].divide(const SizedBox.square(dimension: ZetaSpacing.xs)).toList(),
                ),
                const SizedBox(width: 50),
              ],
            ),
          ],
        ),
        const SizedBox.square(dimension: ZetaSpacing.xl),
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
                      ].divide(const SizedBox.square(dimension: ZetaSpacing.m)).toList(),
                    ),
                    Row(
                      children: [
                        ZetaIndicator.notification(value: 3, inverseBorder: true),
                        ZetaIndicator.notification(size: ZetaIndicatorSize.medium, value: 3, inverseBorder: true),
                        ZetaIndicator.notification(size: ZetaIndicatorSize.small, inverseBorder: true),
                      ].divide(const SizedBox.square(dimension: ZetaSpacing.m)).toList(),
                    ),
                  ].divide(const SizedBox.square(dimension: ZetaSpacing.s)).toList(),
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ZetaTag.left(label: 'Sharp', rounded: false),
          ZetaTag.right(label: 'Sharp', rounded: false),
          ZetaTag.left(label: 'Rounded'),
          ZetaTag.right(label: 'Rounded'),
        ].divide(SizedBox.square(dimension: ZetaSpacing.m)).toList(),
      ),
    );
  }
}

class _WorkcloudIndicators extends StatelessWidget {
  const _WorkcloudIndicators();

  Widget workcloudIndicatorExampleRow(ZetaWorkcloudIndicatorType type) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ZetaWorkcloudIndicator(
          priorityType: type,
          prioritySize: ZetaWidgetSize.large,
          icon: ZetaIcons.star_half_round,
          label: 'Label',
        ),
        ZetaWorkcloudIndicator(
          prioritySize: ZetaWidgetSize.medium,
          index: '14',
          priorityType: type,
          label: 'Label!',
        ),
        ZetaWorkcloudIndicator(
          priorityType: type,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Medium'), Text('Small'), Text('X-Small')],
            ),
            ...List.generate(10, (index) {
              return workcloudIndicatorExampleRow(ZetaWorkcloudIndicatorType.values[index]);
            }),
          ].divide(const SizedBox.square(dimension: ZetaSpacing.s)).toList(),
        ).paddingAll(ZetaSpacing.m)
      ],
    );
  }
}
