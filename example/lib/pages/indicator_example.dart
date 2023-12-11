import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../widgets.dart';

class IndicatorExample extends StatelessWidget {
  static const String name = 'Indicator';

  const IndicatorExample({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ExampleScaffold(
          name: IndicatorExample.name,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(Dimensions.s),
            child: Column(
              children: [
                indicatorIconExample,
                const SizedBox(height: 25),
                indicatorNotificationExample,
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget get indicatorIconExample => Column(
        children: [
          Text(
            'ZetaIndicator.icon',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rounded',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      ZetaIndicator.icon(),
                      const SizedBox(width: 20),
                      ZetaIndicator.icon(
                        size: ZetaIndicatorSize.medium,
                      ),
                      const SizedBox(width: 20),
                      ZetaIndicator.icon(
                        size: ZetaIndicatorSize.small,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 50),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sharp',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      ZetaIndicator.icon(sharp: true),
                      const SizedBox(width: 20),
                      ZetaIndicator.icon(
                        size: ZetaIndicatorSize.medium,
                        sharp: true,
                      ),
                      const SizedBox(width: 20),
                      ZetaIndicator.icon(
                        size: ZetaIndicatorSize.small,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      );

  static Widget get indicatorNotificationExample => Column(
        children: [
          Text(
            'ZetaIndicator.notification',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              ZetaIndicator.notification(
                value: 3,
              ),
              const SizedBox(width: 20),
              ZetaIndicator.notification(
                size: ZetaIndicatorSize.medium,
                value: 3,
              ),
              const SizedBox(width: 20),
              ZetaIndicator.notification(
                size: ZetaIndicatorSize.small,
                value: 3,
              ),
            ],
          ),
        ],
      );
}
