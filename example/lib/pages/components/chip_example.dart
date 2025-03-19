import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class AssistChipExample extends StatelessWidget {
  static const String name = 'Chips/AssistChip';
  const AssistChipExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(name: name, children: [
      SizedBox(
        height: 40,
        child: ZetaAssistChip(
          label: 'Label',
          leading: ZetaIcon(ZetaIcons.star),
          draggable: true,
          data: 'Assist chip',
          onTap: () {},
        ),
      ),
    ]);
  }
}

class FilterChipExample extends StatefulWidget {
  static const String name = 'Chips/FilterChip';
  const FilterChipExample({super.key});

  @override
  State<FilterChipExample> createState() => _FilterChipExampleState();
}

class _FilterChipExampleState extends State<FilterChipExample> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(name: FilterChipExample.name, children: [
      ZetaFilterChip(
        label: 'Label',
        selected: true,
        data: 'Filter chip',
        draggable: true,
        onTap: (bool selected) => setState(() => this.selected = selected),
      ),
    ]);
  }
}

class InputChipExample extends StatelessWidget {
  static const String name = 'Chips/InputChip';
  const InputChipExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: name,
      children: [
        ZetaInputChip(
          label: 'Label',
          leading: ZetaIcon(ZetaIcons.user),
          trailing: IconButton(icon: Icon(ZetaIcons.close), onPressed: () {}),
          onTap: () {},
        ),
      ],
    );
  }
}

class StatusChipExample extends StatelessWidget {
  static const String name = 'Chips/StatusChip';
  const StatusChipExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: name,
      children: [
        ZetaStatusChip(
          label: 'Status Chip',
        ),
      ],
    );
  }
}
