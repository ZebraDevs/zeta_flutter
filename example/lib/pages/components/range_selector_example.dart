import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class RangeSelectorExample extends StatefulWidget {
  static const String name = 'RangeSelector';

  const RangeSelectorExample({super.key});

  @override
  State<RangeSelectorExample> createState() => _RangeSelectorExampleState();
}

class _RangeSelectorExampleState extends State<RangeSelectorExample> {
  double value = 0.5;

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: RangeSelectorExample.name,
      children: [
        Column(
          spacing: 24,
          children: [
            ZetaRangeSelector(
              onChange: (value) {},
              initialValues: RangeValues(20, 80),
              min: 0,
              max: 100,
              showValues: false,
            ),
            ZetaRangeSelector(
              onChange: (value) {},
              initialValues: RangeValues(20, 80),
              min: 0,
              max: 100,
            ),
            ZetaRangeSelector(
              onChange: (value) {},
              initialValues: RangeValues(20, 80),
              min: 0,
              max: 100,
              label: 'Label',
              divisions: 10,
            ),
            ZetaRangeSelector(
              initialValues: RangeValues(20, 80),
              min: 0,
              max: 100,
              label: 'Disabled',
              divisions: 10,
            ),
          ],
        ),
      ].gap(32),
    );
  }
}
