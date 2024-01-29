import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class ChipExample extends StatelessWidget {
  static const String name = 'Chip';

  const ChipExample({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
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
                ...statusChipExample,
              ],
            ),
          ),
        );
      },
    );
  }

  static List<Widget> inputChipExample = [
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
            ZetaChip.input(label: 'Label'),
            const SizedBox(height: 30),
            Text('Label + Icon', textAlign: TextAlign.center),
            const SizedBox(height: 10),
            ZetaChip.input(
              label: 'Label',
              onDelete: () {},
            ),
            const SizedBox(height: 30),
            Text('Label + Avatar', textAlign: TextAlign.center),
            const SizedBox(height: 10),
            ZetaChip.input(
              label: 'Label',
              leading: const Icon(ZetaIcons.avatar),
            ),
            const SizedBox(height: 30),
            Text('Label, Avatar + Icon', textAlign: TextAlign.center),
            const SizedBox(height: 10),
            ZetaChip.input(
              label: 'Label',
              leading: const Icon(ZetaIcons.avatar),
              onDelete: () {},
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
            ZetaChip.input(
              label: 'Label',
              rounded: false,
            ),
            const SizedBox(height: 30),
            Text('Label + Icon', textAlign: TextAlign.center),
            const SizedBox(height: 10),
            ZetaChip.input(
              label: 'Label',
              rounded: false,
              onDelete: () {},
            ),
            const SizedBox(height: 30),
            Text('Label + Avatar', textAlign: TextAlign.center),
            const SizedBox(height: 10),
            ZetaChip.input(
              label: 'Label',
              rounded: false,
              leading: const Icon(ZetaIcons.avatar),
            ),
            const SizedBox(height: 30),
            Text('Label, Avatar + Icon', textAlign: TextAlign.center),
            const SizedBox(height: 10),
            ZetaChip.input(
              label: 'Label',
              rounded: false,
              leading: const Icon(ZetaIcons.avatar),
              onDelete: () {},
            ),
          ],
        ),
      ],
    ),
  ];

  static List<Widget> assistChipExample = [
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
            ZetaChip.assist(label: 'Label'),
            const SizedBox(height: 30),
            Text('Label + Icon', textAlign: TextAlign.center),
            const SizedBox(height: 10),
            ZetaChip.assist(
              label: 'Label',
              showIcon: true,
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
            ZetaChip.assist(
              label: 'Label',
              rounded: false,
            ),
            const SizedBox(height: 30),
            Text('Label + Icon', textAlign: TextAlign.center),
            const SizedBox(height: 10),
            ZetaChip.assist(
              label: 'Label',
              rounded: false,
              showIcon: true,
            ),
          ],
        ),
      ],
    ),
  ];

  static List<Widget> filterChipExample = [
    Text(
      'Filter Chip',
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    const SizedBox(height: 10),
    Row(
      children: [
        Expanded(
          child: Column(
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
        ),
        Expanded(
          child: Column(
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
        ),
      ],
    ),
  ];

  static List<Widget> statusChipExample = [
    Text(
      'Status Chip',
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    const SizedBox(height: 10),
    ZetaChip.status('Input Custom'),
    const SizedBox(height: 10),
    ZetaChip.status('New'),
    const SizedBox(height: 10),
    ZetaChip.status('In Progress'),
    const SizedBox(height: 10),
    ZetaChip.status('Completed'),
    const SizedBox(height: 10),
    ZetaChip.status('Done'),
    const SizedBox(height: 10),
    ZetaChip.status('Drafting'),
    const SizedBox(height: 10),
    ZetaChip.status('--'),
  ];
}
