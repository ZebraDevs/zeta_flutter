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
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Range Slider - Rounded - Continuous', style: ZetaTextStyles.bodyLarge),
                  ZetaRangeSelector(
                    onChange: (value) {
                      print(value.start);
                      print(value.end);
                    },
                    initialValues: RangeValues(20, 80),
                    min: 0,
                    max: 100,
                    showValues: false,
                  ),
                ].gap(12),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Range Slider - Rounded - Stepped', style: ZetaTextStyles.bodyLarge),
                  ZetaRangeSelector(
                    onChange: (value) {},
                    initialValues: RangeValues(20, 80),
                    min: 0,
                    max: 100,
                    showValues: false,
                    divisions: 10,
                  ),
                ].gap(12),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Range Slider - Rounded - Disabled', style: ZetaTextStyles.bodyLarge),
                  ZetaRangeSelector(
                    initialValues: RangeValues(20, 80),
                    min: 0,
                    max: 100,
                    showValues: false,
                  ),
                ].gap(12),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Range Slider - Sharp - Continuous', style: ZetaTextStyles.bodyLarge),
                  ZetaRangeSelector(
                    onChange: (value) {},
                    initialValues: RangeValues(20, 80),
                    min: 0,
                    max: 100,
                    showValues: false,
                    rounded: false,
                  ),
                ].gap(12),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Range Slider - Sharp - Stepped', style: ZetaTextStyles.bodyLarge),
                  ZetaRangeSelector(
                    onChange: (value) {},
                    initialValues: RangeValues(20, 80),
                    min: 0,
                    max: 100,
                    showValues: false,
                    divisions: 10,
                    rounded: false,
                  ),
                ].gap(12),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Range Slider - Sharp - Disabled', style: ZetaTextStyles.bodyLarge),
                  ZetaRangeSelector(
                    initialValues: RangeValues(20, 80),
                    min: 0,
                    max: 100,
                    showValues: false,
                    rounded: false,
                  ),
                ].gap(12),
              ),
              SizedBox(
                height: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Range Selector - Rounded - Continuous', style: ZetaTextStyles.bodyLarge),
                  ZetaRangeSelector(
                    onChange: (value) {},
                    initialValues: RangeValues(20, 80),
                    min: 0,
                    max: 100,
                    label: 'Label',
                  ),
                ].gap(12),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Range Selector - Rounded - Stepped', style: ZetaTextStyles.bodyLarge),
                  ZetaRangeSelector(
                    onChange: (value) {},
                    initialValues: RangeValues(20, 80),
                    min: 0,
                    max: 100,
                    label: 'Label',
                    divisions: 10,
                  ),
                ].gap(12),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Range Selector - Rounded - Disabled', style: ZetaTextStyles.bodyLarge),
                  ZetaRangeSelector(
                    initialValues: RangeValues(20, 80),
                    min: 0,
                    max: 100,
                    label: 'Label',
                    divisions: 10,
                  ),
                ].gap(12),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Range Selector - Sharp - Continuous', style: ZetaTextStyles.bodyLarge),
                  ZetaRangeSelector(
                    onChange: (value) {},
                    initialValues: RangeValues(20, 80),
                    min: 0,
                    max: 100,
                    label: 'Label',
                    rounded: false,
                  ),
                ].gap(12),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Range Selector - Sharp - Stepped', style: ZetaTextStyles.bodyLarge),
                  ZetaRangeSelector(
                    onChange: (value) {},
                    initialValues: RangeValues(20, 80),
                    min: 0,
                    max: 100,
                    label: 'Label',
                    rounded: false,
                    divisions: 10,
                  ),
                ].gap(12),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Range Selector - Sharp - Disabled', style: ZetaTextStyles.bodyLarge),
                  ZetaRangeSelector(
                    initialValues: RangeValues(20, 80),
                    min: 0,
                    max: 100,
                    label: 'Label',
                    rounded: false,
                    divisions: 10,
                  ),
                ].gap(12),
              ),
            ].gap(32),
          ).paddingVertical(32),
        ),
      ),
    );
  }
}
