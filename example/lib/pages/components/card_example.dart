import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class CardExample extends StatelessWidget {
  static const String name = 'Cards/Card';
  const CardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(name: name, children: [
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: ZetaCard(
          title: 'Title',
          description: 'Description',
          content: Placeholder(color: Zeta.of(context).colors.surfaceDisabled),
          isRequired: true,
        ),
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
            constraints: const BoxConstraints(maxWidth: 400),
            child: ZetaCollapsibleCard(
              title: 'Form Section Title',
              description: 'Description',
              content: Placeholder(color: Zeta.of(context).colors.surfaceDisabled),
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
