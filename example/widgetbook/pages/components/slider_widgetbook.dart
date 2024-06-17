import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

Widget sliderUseCase(BuildContext context) {
  return WidgetbookTestWidget(widget: Builder(builder: (context) {
    return ZetaSliderExample(context);
  }));
}

class ZetaSliderExample extends StatefulWidget {
  const ZetaSliderExample(this.c);
  final BuildContext c;

  @override
  State<ZetaSliderExample> createState() => _ZetaSliderExampleState();
}

class _ZetaSliderExampleState extends State<ZetaSliderExample> {
  double value = 0.5;

  @override
  Widget build(BuildContext context) {
    return ZetaSlider(
      value: value,
      rounded: widget.c.knobs.boolean(label: "Rounded"),
      divisions: widget.c.knobs.intOrNull.slider(label: "Divisions", min: 1, initialValue: 10),
      onChange: widget.c.knobs.boolean(label: "Disabled")
          ? null
          : (newValue) {
              setState(() {
                value = newValue;
              });
            },
    );
  }
}
