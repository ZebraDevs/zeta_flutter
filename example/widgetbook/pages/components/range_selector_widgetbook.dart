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
        initialValues: context.knobs.range(label: 'Initial Range', initialValue: RangeValues(20, 80)),
        min: context.knobs.double.input(label: 'Min', initialValue: 0),
        max: context.knobs.double.input(label: 'Max', initialValue: 100),
      ),
    );
  }
}
