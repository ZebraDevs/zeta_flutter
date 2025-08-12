import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

String iconLabelBuilder(int? codePoint) {
  return icons.entries.firstWhere((element) => element.value.codePoint == codePoint).key.split('_').join(' ');
}

List<IconData> iconOptions() => icons.values
    .map((e) => IconData(e.codePoint, fontFamily: ZetaIcons.family, fontPackage: ZetaIcons.package))
    .toList();

String enumLabelBuilder(Enum? value) => value?.name.split('.').last.capitalize ?? '';

String sentencer(String? value) {
  if (value == null || value.isEmpty) return '';
  value = value.replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(0)}');
  return value[0].toUpperCase() + value.substring(1);
}

IconData? iconKnob(
  BuildContext context, {
  bool nullable = false,
  String name = 'Icon',
  IconData? initial,
}) {
  return nullable
      ? context.knobs.objectOrNull.dropdown(
          label: name,
          options: iconOptions(),
          labelBuilder: (value) => iconLabelBuilder(value.codePoint),
          initialOption: initial,
        )
      : context.knobs.object.dropdown(
          label: name,
          options: iconOptions(),
          labelBuilder: (value) => iconLabelBuilder(value?.codePoint),
          initialOption: initial,
        );
}

bool disabledKnob(BuildContext context) => context.knobs.boolean(
      label: 'Disabled',
    );

class RangeKnob extends Knob<RangeValues> {
  RangeKnob({
    required super.label,
    required super.initialValue,
  });
  @override
  List<Field> get fields => [
        DoubleInputField(
          name: 'min-$label',
          initialValue: initialValue.start,
        ),
        DoubleInputField(
          name: 'max-$label',
          initialValue: initialValue.end,
        ),
      ];
  @override
  RangeValues valueFromQueryGroup(Map<String, String> group) {
    return RangeValues(
      valueOf('min-$label', group)!,
      valueOf('max-$label', group)!,
    );
  }
}

extension RangeKnobBuilder on KnobsBuilder {
  RangeValues range({
    required String label,
    RangeValues initialValue = const RangeValues(0, 10),
  }) =>
      onKnobAdded(
        RangeKnob(
          label: label,
          initialValue: initialValue,
        ),
      )!;
}

class SmallContentWrapper extends StatelessWidget {
  const SmallContentWrapper({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 328),
      child: child,
    );
  }
}
