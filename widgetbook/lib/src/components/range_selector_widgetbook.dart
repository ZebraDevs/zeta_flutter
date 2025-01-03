import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

Widget rangeSelectorUseCase(BuildContext context) {
  return RangeSelectorExample(context);
}

class RangeSelectorExample extends StatelessWidget {
  const RangeSelectorExample(this.context2, {super.key});
  final BuildContext context2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ZetaRangeSelector(
        label: context2.knobs.string(label: 'Label', initialValue: 'Range Selector'),
        divisions: context2.knobs.intOrNull.input(label: 'Divisions', initialValue: null),
        showValues: context2.knobs.boolean(label: 'Show Values', initialValue: true),
        onChange: disabledKnob(context2) ? null : (value) {},
        initialValues: context2.knobs.range(label: 'Initial Range', initialValue: RangeValues(20, 80)),
        min: context2.knobs.double.input(label: 'Min', initialValue: 0),
        max: context2.knobs.double.input(label: 'Max', initialValue: 100),
      ),
    );
  }
}
