import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class ChipExample extends StatefulWidget {
  static const String name = 'Chip';
  const ChipExample({super.key});

  @override
  State<ChipExample> createState() => _ChipExampleState();
}

class _ChipExampleState extends State<ChipExample> {
  String chipType = 'none';
  @override
  Widget build(BuildContext context) {
    final Widget inputChipExample = Column(children: [
      Text(
        'Input Chip',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Column(
              children: [
                ZetaInputChip(
                  label: 'Label',
                  leading: ZetaAvatar.initials(initials: "ZA"),
                  trailing: IconButton(icon: Icon(ZetaIcons.close_round), onPressed: () {}),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                ZetaInputChip(
                  label: 'Label',
                  rounded: false,
                  leading: const Icon(ZetaIcons.user_round),
                  trailing: Icon(ZetaIcons.close_sharp),
                ),
              ],
            ),
          ),
        ],
      ),
    ]);

    final Widget assistChipExample = Column(children: [
      Text(
        'Assist Chip',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Column(
              children: [
                ZetaAssistChip(
                  label: 'Label',
                  leading: Icon(ZetaIcons.star_round),
                  draggable: true,
                  data: 'Round Assist chip',
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                ZetaAssistChip(
                  label: 'Label',
                  rounded: false,
                  leading: Icon(ZetaIcons.star_round),
                  data: 'Sharp Assist chip',
                  draggable: true,
                ),
              ],
            ),
          ),
        ],
      ),
    ]);

    final Widget filterChipExample = Column(children: [
      Text(
        'Filter Chip',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Column(
              children: [
                ZetaFilterChip(
                  label: 'Label',
                  selected: true,
                  data: 'Round filter chip',
                  draggable: true,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                ZetaFilterChip(
                  label: 'Label',
                  rounded: false,
                  selected: true,
                  data: 'Sharp filter chip',
                  draggable: true,
                ),
              ],
            ),
          ),
        ],
      ),
    ]);
    final colors = Zeta.of(context).colors;
    return ExampleScaffold(
      name: ChipExample.name,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(ZetaSpacing.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(child: Center(child: Text('Rounded'))),
                Expanded(child: Center(child: Text('Sharp'))),
              ],
            ),
            inputChipExample,
            assistChipExample,
            filterChipExample,
            const SizedBox(height: 100),
            DragTarget<String>(
              onAcceptWithDetails: (details) => setState(() => chipType = details.data),
              builder: (context, _, __) {
                return Container(
                  padding: EdgeInsets.all(ZetaSpacing.medium),
                  color: colors.surfaceSelectedHover,
                  height: 100,
                  width: 200,
                  child: Center(child: Text('Last chip dragged here: $chipType')),
                );
              },
            )
          ].gap(30),
        ),
      ),
    );
  }
}
