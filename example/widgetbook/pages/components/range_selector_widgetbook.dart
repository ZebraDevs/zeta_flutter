import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';
import '../../utils/utils.dart';

Widget rangeSelectorUseCase(BuildContext context) {
  return WidgetbookScaffold(
    builder: (context, _) => RangeSelectorExample(context),
  );
}

class RangeSelectorExample extends StatelessWidget {
  RangeSelectorExample(this.context);
  final BuildContext context;

  @override
  Widget build(BuildContext _) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ZetaRangeSelector(
        label: context.knobs.string(label: 'Label', initialValue: 'Range Selector'),
        divisions: context.knobs.intOrNull.input(label: 'Divisions', initialValue: null),
        showValues: context.knobs.boolean(label: 'Show Values', initialValue: true),
        onChange: disabledKnob(context) ? null : (value) {},
        rounded: context.knobs.booleanOrNull(label: 'Rounded', initialValue: true),
        lowerValue: context.knobs.double.input(label: 'Lower Value', initialValue: 20),
        upperValue: context.knobs.double.input(label: 'Upper Value', initialValue: 80),
        min: context.knobs.double.input(label: 'Min', initialValue: 0),
        max: context.knobs.double.input(label: 'Max', initialValue: 100),
      ),
    );
  }
}
