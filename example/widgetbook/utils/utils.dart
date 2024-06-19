import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

String iconLabelBuilder(int? codePoint, [bool rounded = true]) {
  return icons.entries.firstWhere((element) => element.value.codePoint == codePoint).key.split('_').join(' ');
}

List<IconData> iconOptions(rounded) => icons.values
    .map((e) => IconData(e.codePoint,
        fontFamily: rounded ? ZetaIcons.familyRound : ZetaIcons.familySharp, fontPackage: ZetaIcons.package))
    .toList();

String enumLabelBuilder(Enum? value) => value?.name.split('.').last.capitalize() ?? '';

IconData? iconKnob(
  BuildContext context, {
  bool rounded = true,
  bool nullable = false,
  String name = 'Icon',
  final IconData? initial,
}) {
  return nullable
      ? context.knobs.listOrNull(
          label: name,
          options: iconOptions(rounded),
          labelBuilder: (value) => iconLabelBuilder(value?.codePoint, rounded),
          initialOption: initial,
        )
      : context.knobs.list(
          label: name,
          options: iconOptions(rounded),
          labelBuilder: (value) => iconLabelBuilder(value?.codePoint, rounded),
          initialOption: initial,
        );
}

bool roundedKnob(BuildContext context) => context.knobs.boolean(label: 'Rounded');

bool disabledKnob(BuildContext context) => context.knobs.boolean(
      label: 'Disabled',
      initialValue: false,
    );
