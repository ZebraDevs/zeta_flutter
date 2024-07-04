import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

String iconLabelBuilder(int? codePoint) {
  return icons.entries.firstWhere((element) => element.value.codePoint == codePoint).key.split('_').join(' ');
}

List<IconData> iconOptions() => icons.values
    .map((e) => IconData(e.codePoint, fontFamily: ZetaIcons.family, fontPackage: ZetaIcons.package))
    .toList();

String enumLabelBuilder(Enum? value) => value?.name.split('.').last.capitalize() ?? '';

IconData? iconKnob(
  BuildContext context, {
  bool nullable = false,
  String name = 'Icon',
  final IconData? initial,
}) {
  return nullable
      ? context.knobs.listOrNull(
          label: name,
          options: iconOptions(),
          labelBuilder: (value) => iconLabelBuilder(value?.codePoint),
          initialOption: initial,
        )
      : context.knobs.list(
          label: name,
          options: iconOptions(),
          labelBuilder: (value) => iconLabelBuilder(value?.codePoint),
          initialOption: initial,
        );
}

bool disabledKnob(BuildContext context) => context.knobs.boolean(
      label: 'Disabled',
      initialValue: false,
    );
