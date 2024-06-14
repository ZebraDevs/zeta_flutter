import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class SliderExample extends StatefulWidget {
  static const String name = 'Slider';

  const SliderExample({super.key});

  @override
  State<SliderExample> createState() => _SliderExampleState();
}

class _SliderExampleState extends State<SliderExample> {
  double value = 0.5;

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: SliderExample.name,
      child: Center(
        child: ZetaSlider(
          value: value,
          onChange: (newValue) {
            setState(() {
              value = newValue;
            });
          },
        ),
      ),
    );
  }
}
