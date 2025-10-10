import 'package:flutter/material.dart';
import 'package:zeta_example/config/components_config.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class SliderExample extends StatefulWidget {
  const SliderExample({super.key});

  @override
  State<SliderExample> createState() => _SliderExampleState();
}

class _SliderExampleState extends State<SliderExample> {
  double value = 0.5;

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: sliderRoute,
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
      ],
    );
  }
}

class SliderInputFieldExample extends StatefulWidget {
  static const String name = 'Slider/SliderInputField';

  const SliderInputFieldExample({super.key});

  @override
  State<SliderInputFieldExample> createState() => _SliderInputFieldExampleState();
}

class _SliderInputFieldExampleState extends State<SliderInputFieldExample> {
  double value1 = 50;
  double value2 = 50;

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: SliderInputFieldExample.name,
      children: [
        ZetaSlider(
          value: value1,
          divisions: 5,
          inputField: true,
        ),
        ZetaSlider(
          value: value1,
          onChange: (newValue) => setState(() => value1 = newValue),
          inputField: true,
        ),
        ZetaSlider(
          value: value2,
          divisions: 5,
          onChange: (newValue) => setState(() => value2 = newValue),
          inputField: true,
        ),
      ],
    );
  }
}
