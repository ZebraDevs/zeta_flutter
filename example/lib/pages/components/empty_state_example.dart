import 'package:flutter/material.dart';
import 'package:zeta_example/config/components_config.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class EmptyStateExample extends StatefulWidget {
  const EmptyStateExample({super.key});

  @override
  State<EmptyStateExample> createState() => _EmptyStateExampleState();
}

class _EmptyStateExampleState extends State<EmptyStateExample> {
  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: emptyStateRoute,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 375),
          child: ZetaEmptyState(
            title: 'Title',
            description: 'This is a placeholder description. It explains what this view is for and what to do next.',
            illustration: ZetaIllustrations.serverDisconnect,
            primaryAction: ZetaButton(
              label: 'Button',
              onPressed: () {},
            ),
            secondaryAction: ZetaButton.outlineSubtle(
              label: 'Button',
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }
}
