import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../widgets.dart';

class IconsExample extends StatefulWidget {
  static const String name = 'Icons';

  const IconsExample({super.key});

  @override
  State<IconsExample> createState() => _IconsExampleState();
}

class _IconsExampleState extends State<IconsExample> {
  bool showGeneratedColors = false;

//TODO: LUKE ADD NAMES TO ICONS
  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: IconsExample.name,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(ZetaSpacing.medium),
        child: Column(
          children: [
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: icons.values.map((e) => ZetaIcon(e, size: 48)).toList(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
