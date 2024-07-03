import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../widgets.dart';

class FilterSelectionExample extends StatefulWidget {
  static const String name = 'FilterSelection';

  const FilterSelectionExample({super.key});

  @override
  State<FilterSelectionExample> createState() => _FilterSelectionExampleState();
}

class _FilterSelectionExampleState extends State<FilterSelectionExample> {
  final items = List.generate(12, (index) => false);
  final items2 = List.generate(12, (index) => false);

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: FilterSelectionExample.name,
      child: Column(
        children: [
          const SizedBox(height: ZetaSpacing.large),
          ZetaFilterSelection(
            items: [
              for (int i = 0; i < items.length; i++)
                ZetaFilterChip(
                  label: 'Label ${i + 1}',
                  selected: items[i],
                  onTap: (value) => setState(() => items[i] = value),
                ),
            ],
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
