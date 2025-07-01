import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class StatusLabel extends StatelessWidget {
  static const String name = 'Badges/StatusLabel';

  const StatusLabel();

  Widget statusLabelExampleRow(ZetaWidgetStatus type) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 16,
      children: [
        ZetaStatusLabel(label: 'Label', status: type),
        ZetaStatusLabel(label: 'Label', status: type, icon: ZetaIcons.star),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(key: Key('docs-status-label'), name: name, children: [
      Column(
        children: [
          statusLabelExampleRow(ZetaWidgetStatus.neutral),
          statusLabelExampleRow(ZetaWidgetStatus.info),
          statusLabelExampleRow(ZetaWidgetStatus.positive),
          statusLabelExampleRow(ZetaWidgetStatus.warning),
          statusLabelExampleRow(ZetaWidgetStatus.negative),
        ].divide(SizedBox.square(dimension: Zeta.of(context).spacing.xl_2)).toList(),
      ),
    ]);
  }
}

class PriorityPill extends StatelessWidget {
  static const String name = 'Badges/PriorityPill';

  const PriorityPill();

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: name,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  spacing: 16,
                  children: [
                    ZetaPriorityPill(
                        size: ZetaPriorityPillSize.large, isBadge: true, status: ZetaPriorityPillStatus.urgent),
                    SizedBox(
                        width: 100,
                        child: ZetaPriorityPill(
                          size: ZetaPriorityPillSize.large,
                          status: ZetaPriorityPillStatus.urgent,
                          label: 'Label',
                        )),
                    SizedBox(
                        width: 100,
                        child: ZetaPriorityPill(
                          size: ZetaPriorityPillSize.small,
                          status: ZetaPriorityPillStatus.urgent,
                          label: 'Label',
                        )),
                  ],
                ),
                Row(
                  spacing: 16,
                  children: [
                    ZetaPriorityPill(
                        size: ZetaPriorityPillSize.large, isBadge: true, status: ZetaPriorityPillStatus.high),
                    SizedBox(
                        width: 100,
                        child: ZetaPriorityPill(size: ZetaPriorityPillSize.large, status: ZetaPriorityPillStatus.high)),
                    SizedBox(
                        width: 100,
                        child: ZetaPriorityPill(size: ZetaPriorityPillSize.small, status: ZetaPriorityPillStatus.high)),
                  ],
                ),
                Row(
                  spacing: 16,
                  children: [
                    ZetaPriorityPill(
                        size: ZetaPriorityPillSize.large, isBadge: true, status: ZetaPriorityPillStatus.medium),
                    SizedBox(
                        width: 100,
                        child:
                            ZetaPriorityPill(size: ZetaPriorityPillSize.large, status: ZetaPriorityPillStatus.medium)),
                    SizedBox(
                        width: 100,
                        child:
                            ZetaPriorityPill(size: ZetaPriorityPillSize.small, status: ZetaPriorityPillStatus.medium)),
                  ],
                ),
                Row(
                  spacing: 16,
                  children: [
                    ZetaPriorityPill(
                        size: ZetaPriorityPillSize.large, isBadge: true, status: ZetaPriorityPillStatus.low),
                    SizedBox(
                        width: 100,
                        child: ZetaPriorityPill(size: ZetaPriorityPillSize.large, status: ZetaPriorityPillStatus.low)),
                    SizedBox(
                        width: 100,
                        child: ZetaPriorityPill(size: ZetaPriorityPillSize.small, status: ZetaPriorityPillStatus.low)),
                  ],
                ),
              ].divide(SizedBox.square(dimension: Zeta.of(context).spacing.xl_2)).toList(),
            ),
          ],
        )
      ],
    );
  }
}

class Label extends StatelessWidget {
  static const String name = 'Badges/Label';

  const Label();

  Widget badgeExampleRow(ZetaWidgetStatus type) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ZetaLabel(label: 'Label', status: type),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: name,
      children: [
        Column(
          children: [
            badgeExampleRow(ZetaWidgetStatus.info),
            badgeExampleRow(ZetaWidgetStatus.positive),
            badgeExampleRow(ZetaWidgetStatus.warning),
            badgeExampleRow(ZetaWidgetStatus.negative),
            badgeExampleRow(ZetaWidgetStatus.neutral),
          ].divide(SizedBox(height: Zeta.of(context).spacing.xl_2)).toList(),
        )
      ],
    );
  }
}

class Indicators extends StatelessWidget {
  static const String name = 'Badges/Indicator';

  const Indicators();

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: name,
      children: [
        Container(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
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
                            ].divide(SizedBox.square(dimension: Zeta.of(context).spacing.xl_2)).toList(),
                          ),
                        ].divide(SizedBox.square(dimension: Zeta.of(context).spacing.small)).toList(),
                      ),
                      const SizedBox(width: 50),
                    ],
                  ),
                ],
              ),
              SizedBox.square(dimension: Zeta.of(context).spacing.xl_9),
              Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ZetaIndicator.notification(value: 300),
                              ZetaIndicator.notification(size: ZetaWidgetSize.medium, value: 2),
                              ZetaIndicator.notification(size: ZetaWidgetSize.small),
                            ].divide(SizedBox.square(dimension: Zeta.of(context).spacing.xl_2)).toList(),
                          ),
                        ].divide(SizedBox.square(dimension: Zeta.of(context).spacing.medium)).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

class Tags extends StatelessWidget {
  static const String name = 'Badges/Tag';

  const Tags();

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: name,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ZetaTag.left(label: 'Left'),
            ZetaTag.right(label: 'Right'),
          ].divide(SizedBox.square(dimension: Zeta.of(context).spacing.xl_2)).toList(),
        )
      ],
    );
  }
}
