import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class ChipExample extends StatelessWidget {
  static const String name = 'Chip';

  const ChipExample({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> inputChipExample = [
      Text(
        'Input Chip',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                'Rounded',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              Text('Label Only', textAlign: TextAlign.center),
              const SizedBox(height: 10),
              ZetaInputChip(label: 'Label'),
              const SizedBox(height: 30),
              Text('Label + Icon', textAlign: TextAlign.center),
              const SizedBox(height: 10),
              ZetaInputChip(
                label: 'Label',
              ),
              const SizedBox(height: 30),
              Text('Label + Avatar', textAlign: TextAlign.center),
              const SizedBox(height: 10),
              ZetaInputChip(
                label: 'Label',
                leading: const Icon(ZetaIcons.user_round),
              ),
              const SizedBox(height: 30),
              Text('Label, Avatar + Icon', textAlign: TextAlign.center),
              const SizedBox(height: 10),
              ZetaInputChip(
                label: 'Label',
                leading: const Icon(ZetaIcons.user_round),
                trailing: Icon(ZetaIcons.close_round),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                'Sharp',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              Text('Label Only', textAlign: TextAlign.center),
              const SizedBox(height: 10),
              ZetaInputChip(
                label: 'Label',
                rounded: false,
              ),
              const SizedBox(height: 30),
              Text('Label + Icon', textAlign: TextAlign.center),
              const SizedBox(height: 10),
              ZetaInputChip(
                label: 'Label',
                rounded: false,
              ),
              const SizedBox(height: 30),
              Text('Label + Avatar', textAlign: TextAlign.center),
              const SizedBox(height: 10),
              ZetaInputChip(
                label: 'Label',
                rounded: false,
                leading: const Icon(ZetaIcons.user_round),
              ),
              const SizedBox(height: 30),
              Text('Label, Avatar + Icon', textAlign: TextAlign.center),
              const SizedBox(height: 10),
              ZetaInputChip(
                label: 'Label',
                rounded: false,
                leading: const Icon(ZetaIcons.user_round),
                trailing: Icon(ZetaIcons.close_sharp),
              ),
            ],
          ),
        ],
      ),
    ];

    final List<Widget> filterChipExample = [
      Text(
        'Filter Chip',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                'Rounded',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ZetaFilterChip(label: 'Label'),
              const SizedBox(height: 10),
              ZetaFilterChip(
                label: 'Label',
                selected: true,
              ),
            ],
          ),
          Column(
            children: [
              Text(
                'Sharp',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ZetaFilterChip(
                label: 'Label',
                rounded: false,
              ),
              const SizedBox(height: 10),
              ZetaFilterChip(
                label: 'Label',
                rounded: false,
                selected: true,
              ),
            ],
          ),
        ],
      ),
    ];

    final List<Widget> assistChipExample = [
      Text(
        'Assist Chip',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                'Rounded',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              Text('Label Only', textAlign: TextAlign.center),
              const SizedBox(height: 10),
              ZetaAssistChip(label: 'Label'),
              const SizedBox(height: 30),
              Text('Label + Icon', textAlign: TextAlign.center),
              const SizedBox(height: 10),
              ZetaAssistChip(
                label: 'Label',
                leading: Icon(ZetaIcons.star_round),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                'Sharp',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              Text('Label Only', textAlign: TextAlign.center),
              const SizedBox(height: 10),
              ZetaAssistChip(
                label: 'Label',
                rounded: false,
              ),
              const SizedBox(height: 30),
              Text('Label + Icon', textAlign: TextAlign.center),
              const SizedBox(height: 10),
              ZetaAssistChip(
                label: 'Label',
                rounded: false,
                leading: Icon(ZetaIcons.star_round),
              ),
            ],
          ),
        ],
      ),
    ];

    return ExampleScaffold(
      name: ChipExample.name,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(ZetaSpacing.s),
        child: Column(
          children: [
            ...inputChipExample,
            const SizedBox(height: 30),
            ...assistChipExample,
            const SizedBox(height: 30),
            ...filterChipExample,
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
