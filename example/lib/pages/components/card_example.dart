import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class CardContainerExample extends StatelessWidget {
  static const String name = 'Cards/CardContainer';
  const CardContainerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(name: name, children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: Zeta.of(context).spacing.xl,
        children: [
          Expanded(
            child: ZetaCardContainer(
              title: 'Title',
              description: 'Description',
              isRequired: true,
            ).paddingAll(Zeta.of(context).spacing.xl),
          ),
          Expanded(
            child: ZetaCollapsibleCardContainer(
              title: 'Form Section Title',
              description: 'Description',
              content: Placeholder(color: Zeta.of(context).colors.surfaceDisabled),
              isAi: true,
              isRequired: true,
            ).paddingAll(Zeta.of(context).spacing.xl),
          ),
        ],
      )
    ]);
  }
}
