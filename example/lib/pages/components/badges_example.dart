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
            const SizedBox(height: ZetaSpacing.xL4),
            _PriorityPill(size: ZetaPriorityPillSize.small),
            _DividingText('Badge'),
            _Badge(),
            _DividingText('Indicators'),
            _Indicators(),
            _DividingText('Tags'),
            _Tags(),
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
    ).paddingVertical(ZetaSpacing.xL4);
  }
}

class _StatusLabel extends StatelessWidget {
  const _StatusLabel();

  Widget statusLabelExampleRow(ZetaWidgetStatus type) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ZetaStatusLabel(label: 'Label', status: type),
        ZetaStatusLabel(label: 'Label', status: type, customIcon: ZetaIcons.star_round),
        ZetaStatusLabel(label: 'Label', status: type, rounded: false),
        ZetaStatusLabel(label: 'Label', status: type, rounded: false, customIcon: ZetaIcons.star_sharp),
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
      ].divide(const SizedBox.square(dimension: ZetaSpacing.xL2)).toList(),
    );
  }
}

class _PriorityPill extends StatelessWidget {
  const _PriorityPill({
    this.size = ZetaPriorityPillSize.large,
  });

  final ZetaPriorityPillSize size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ZetaPriorityPill(size: size, isBadge: true),
            ZetaPriorityPill(size: size, isBadge: true, type: ZetaPriorityPillType.high),
            ZetaPriorityPill(size: size, isBadge: true, type: ZetaPriorityPillType.medium),
            ZetaPriorityPill(size: size, isBadge: true, type: ZetaPriorityPillType.low),
          ].divide(const SizedBox.square(dimension: ZetaSpacing.xL2)).toList(),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ZetaPriorityPill(size: size),
            ZetaPriorityPill(size: size, type: ZetaPriorityPillType.high),
            ZetaPriorityPill(size: size, type: ZetaPriorityPillType.medium),
            ZetaPriorityPill(size: size, type: ZetaPriorityPillType.low),
          ].divide(const SizedBox.square(dimension: ZetaSpacing.xL2)).toList(),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ZetaPriorityPill(size: size, rounded: false),
            ZetaPriorityPill(size: size, rounded: false, type: ZetaPriorityPillType.high),
            ZetaPriorityPill(size: size, rounded: false, type: ZetaPriorityPillType.medium),
            ZetaPriorityPill(size: size, rounded: false, type: ZetaPriorityPillType.low),
          ].divide(const SizedBox.square(dimension: ZetaSpacing.xL2)).toList(),
        ),
      ],
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
        ZetaBadge(label: 'Label', status: type),
        ZetaBadge(label: 'Label', status: type, rounded: false),
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
      ].divide(const SizedBox(height: ZetaSpacing.xL2)).toList(),
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
              'ZetaIndicator\nicon',
              textAlign: TextAlign.center,
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
                        ZetaIndicator.icon(size: ZetaWidgetSize.medium),
                        ZetaIndicator.icon(size: ZetaWidgetSize.small),
                      ].divide(const SizedBox.square(dimension: ZetaSpacing.xL2)).toList(),
                    ),
                    Row(
                      children: [
                        ZetaIndicator.icon(inverse: true),
                        ZetaIndicator.icon(size: ZetaWidgetSize.medium, inverse: true),
                        ZetaIndicator.icon(size: ZetaWidgetSize.small, inverse: true),
                      ].divide(const SizedBox.square(dimension: ZetaSpacing.xL2)).toList(),
                    ),
                  ].divide(const SizedBox.square(dimension: ZetaSpacing.small)).toList(),
                ),
                const SizedBox(width: 50),
              ],
            ),
          ],
        ),
        const SizedBox.square(dimension: ZetaSpacing.xL9),
        Column(
          children: [
            Text(
              'ZetaIndicator\nnotification',
              textAlign: TextAlign.center,
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
                        ZetaIndicator.notification(value: 3),
                        ZetaIndicator.notification(size: ZetaWidgetSize.medium, value: 3),
                        ZetaIndicator.notification(size: ZetaWidgetSize.small),
                      ].divide(const SizedBox.square(dimension: ZetaSpacing.xL2)).toList(),
                    ),
                    Row(
                      children: [
                        ZetaIndicator.notification(value: 3, inverse: true),
                        ZetaIndicator.notification(size: ZetaWidgetSize.medium, value: 3, inverse: true),
                        ZetaIndicator.notification(size: ZetaWidgetSize.small, inverse: true),
                      ].divide(const SizedBox.square(dimension: ZetaSpacing.xL2)).toList(),
                    ),
                  ].divide(const SizedBox.square(dimension: ZetaSpacing.medium)).toList(),
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
        ].divide(SizedBox.square(dimension: ZetaSpacing.xL2)).toList(),
      ),
    );
  }
}
