import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class CardExample extends StatelessWidget {
  static const String name = 'Cards/Card';
  const CardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(name: name, children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        spacing: Zeta.of(context).spacing.xl,
        children: [
          Expanded(
            child: ZetaCard(
              title: 'Title Title Title Title Title Title Title Title Title Title Title',
              description: 'Description',
              isRequired: true,
              isAi: true,
            ),
          ),
          Expanded(
            child: ZetaCard(
              title: 'Title',
              description: 'Description',
              content: Placeholder(color: Zeta.of(context).colors.surfaceDisabled),
              isAi: true,
              isRequired: true,
            ),
          ),
        ],
      )
    ]);
  }
}

class CollapsibleCardExample extends StatelessWidget {
  static const String name = 'Cards/CollapsibleCard';

  const CollapsibleCardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: name,
      children: [
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 528),
            child: ZetaCollapsibleCard(
              title: 'Form Section Title',
              description: 'Description',
              content: SizedBox(
                width: 480,
                height: 240,
                child: Placeholder(),
              ),
              isAi: true,
              isExpanded: false,
              isRequired: true,
            ),
          ),
        ),
      ],
    );
  }
}
