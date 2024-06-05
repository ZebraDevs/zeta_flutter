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

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: IconsExample.name,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(ZetaSpacing.medium),
        child: Column(
          children: [
            Text('Round', style: ZetaTextStyles.bodyLarge),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: iconsRound.values.map((e) => Icon(e)).toList(),
            ),
            const SizedBox(height: 20),
            Text('Sharp', style: ZetaTextStyles.bodyLarge),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: iconsSharp.values.map((e) => Icon(e)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
