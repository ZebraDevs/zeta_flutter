import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_example/pages/chip_example.dart';

WidgetbookComponent chipWidgetBook() {
  return WidgetbookComponent(
    name: 'Chip',
    useCases: [
      WidgetbookUseCase(
        name: 'Input Chip',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: ChipExample.inputChipExample,
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'Assist Chip',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: ChipExample.assistChipExample,
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'Filter Chip',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: ChipExample.filterChipExample,
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'Status Chip',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: ChipExample.statusChipExample,
          ),
        ),
      ),
    ],
  );
}
