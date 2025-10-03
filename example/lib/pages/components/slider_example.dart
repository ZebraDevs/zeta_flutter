import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class SliderExample extends StatefulWidget {
  static const String name = 'Slider/Slider';

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
      gap: 40,
      children: [
        ZetaSlider(
          value: value,
          key: Key('docs-slider-continuous'),
          onChange: (newValue) => setState(() => value = newValue),
        ),
        ZetaSlider(
          value: value,
          key: Key('docs-slider-step'),
          divisions: 5,
          onChange: (newValue) => setState(() => value = newValue),
        ),
        ZetaSlider(
          value: value,
          key: Key('docs-slider-step'),
          divisions: 5,
          onChange: (newValue) => setState(() => value = newValue),
          inputField: true,
        ),
      ],
    );
  }
}
