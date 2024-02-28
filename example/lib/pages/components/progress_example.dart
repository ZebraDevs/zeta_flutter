import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class ProgressExample extends StatefulWidget {
  static const String name = 'Progress';

  const ProgressExample({super.key});

  @override
  State<ProgressExample> createState() => ProgressExampleState();
}

class ProgressExampleState extends State<ProgressExample> {
  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: 'Progress',
      child: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(children: [
              Wrapper(
                stepsCompleted: 10,
                weight: BarWeight.thin,
              ),
              SizedBox(
                height: 20,
              ),
              Wrapper(
                  stepsCompleted: 0,
                  type: BarType.standard,
                  weight: BarWeight.thin,
                  stateChangeable: true),
              SizedBox(
                height: 20,
              ),
              Wrapper(
                stepsCompleted: 0,
                type: BarType.indeterminate,
                weight: BarWeight.medium,
                label: "UPLOADING ...",
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class Wrapper extends StatefulWidget {
  const Wrapper(
      {super.key,
      required this.stepsCompleted,
      this.type = BarType.standard,
      this.weight = BarWeight.medium,
      this.border = ZetaWidgetBorder.rounded,
      this.stateChangeable = false,
      this.label});

  final int stepsCompleted;
  final ZetaWidgetBorder border;
  final BarType type;
  final BarWeight weight;
  final String? label;
  final bool stateChangeable;

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  late int stepsCompleted;
  late double progress;
  late BarType type;

  @override
  void initState() {
    super.initState();
    type = widget.type;
    stepsCompleted = widget.stepsCompleted;
    progress = stepsCompleted / 10;
  }

  ///Function to increase percentage of progress.
  void increasePercentage() {
    setState(() {
      stepsCompleted++;
      progress = stepsCompleted / 10;
    });
  }

  void setLoading() {
    setState(() {
      type = type == BarType.buffering ? BarType.standard : BarType.buffering;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // Replace with a Column for vertical
      children: [
        SizedBox(
          width: 400,
          child: ProgressBar(
              progress: progress,
              border: widget.border,
              type: type,
              weight: widget.weight,
              label: widget.label),
        ),
        const SizedBox(width: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.type != BarType.indeterminate
                ? FilledButton(
                    onPressed: increasePercentage, child: Text("Increase"))
                : Container(),
            const SizedBox(width: 40),
            widget.stateChangeable
                ? FilledButton(
                    onPressed: setLoading, child: Text("Start Buffering"))
                : Container()
          ],
        )
      ],
    );
  }
}
