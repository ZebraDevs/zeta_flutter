import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class TileButtonExample extends StatelessWidget {
  static const String name = 'Buttons/TileButton';
  const TileButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons(bool rounded) {
      return [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ZetaTileButton(
                label: 'Button',
                icon: Icons.star,
                onPressed: null, // Disabled
                rounded: rounded,
              ),
              SizedBox.square(dimension: Zeta.of(context).spacing.xl_2),
              ZetaTileButton(
                label: 'Button',
                icon: Icons.star,
                onPressed: () {}, // Enabled
                rounded: rounded,
              ),
            ].reversed.toList(),
          ).paddingHorizontal(Zeta.of(context).spacing.medium)
           .paddingVertical(Zeta.of(context).spacing.large),
        ),
      ];
    }

    return ExampleScaffold(
      name: TileButtonExample.name,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: buttons(false),
          key: Key('docs-button'),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: buttons(true),
          key: Key('docs-button-full'),
        ),
      ],
    );
  }
}