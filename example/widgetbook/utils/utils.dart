import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

String iconLabelBuilder(IconData? value, [bool rounded = true]) {
  return ((rounded
              ? iconsRounded.entries.firstWhere((element) => element.value == value)
              : iconsSharp.entries.firstWhere((element) => element.value == value))
          .key
          .split('.')
          .last
          .split('_')
        ..removeLast())
      .join(' ');
}

List<IconData> iconOptions(rounded) => rounded ? iconsRounded.values.toList() : iconsSharp.values.toList();

String enumLabelBuilder(Enum? value) => value?.name.split('.').last.capitalize() ?? '';

IconData? iconKnob(BuildContext context,
    {bool rounded = true, bool nullable = false, String name = 'Icon', final IconData? initial}) {
  return nullable
      ? context.knobs.listOrNull(
          label: name,
          options: iconOptions(rounded),
          labelBuilder: (value) => iconLabelBuilder(value, rounded),
          initialOption: initial,
        )
      : context.knobs.list(
          label: name,
          options: iconOptions(rounded),
          labelBuilder: (value) => iconLabelBuilder(value, rounded),
          initialOption: initial,
        );
}

bool roundedKnob(BuildContext context) => context.knobs.boolean(label: 'Rounded');
