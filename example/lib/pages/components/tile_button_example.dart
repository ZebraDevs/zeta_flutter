import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

// ignore: deprecated_member_use
final buttonTypes = ZetaButtonType.outlineSubtle;

class TileButtonExample extends StatelessWidget {
  static const String name = 'Buttons/TileButton';
  const TileButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons(ZetaTileButtonBorderType? borderType) {
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
                borderType: borderType,
              ),
              SizedBox.square(dimension: Zeta.of(context).spacing.xl_2),
              ZetaTileButton(
                label: 'Button',
                icon: Icons.star,
                onPressed: () {}, // Enabled
                borderType: borderType,
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
          children: buttons(null),
          key: Key('docs-button'),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: buttons(ZetaTileButtonBorderType.sharp),
          key: Key('docs-button-full'),
        ),
      ],
    );
  }
}