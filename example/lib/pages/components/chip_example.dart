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
      ZetaInputChip(
        label: 'Label',
        leading: const ZetaIcon(ZetaIcons.user),
        trailing: IconButton(icon: Icon(ZetaIcons.close), onPressed: () {}),
      ),
    ]);

    final Widget assistChipExample = Column(children: [
      Text(
        'Assist Chip',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      SizedBox(
        height: 40,
        child: ZetaAssistChip(
          label: 'Label',
          leading: ZetaIcon(ZetaIcons.star),
          draggable: true,
          data: 'Assist chip',
        ),
      ),
    ]);

    final Widget filterChipExample = Column(children: [
      Text(
        'Filter Chip',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      SizedBox(
        height: 40,
        child: ZetaFilterChip(
          label: 'Label',
          selected: true,
          data: 'Filter chip',
          draggable: true,
        ),
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
