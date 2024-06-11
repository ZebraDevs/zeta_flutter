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
  WidgetStatesController controller = WidgetStatesController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
                isThin: true,
              ),
              SizedBox(
                height: 20,
              ),
              Wrapper(stepsCompleted: 0, type: ZetaProgressBarType.standard, isThin: false, stateChangeable: true),
              SizedBox(
                height: 20,
              ),
              Wrapper(
                stepsCompleted: 0,
                type: ZetaProgressBarType.indeterminate,
                isThin: false,
                label: "UPLOADING ...",
              ),
              SizedBox(
                height: 40,
              ),
              Wrapper(
                stepsCompleted: 0,
                circleSize: ZetaCircleSizes.xl_1,
                rounded: false,
                isCircle: true,
              ),
              SizedBox(
                height: 40,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [])
            ]),
          ),
        ),
      ),
    );
  }
}

class Wrapper extends StatefulWidget {
  const Wrapper({
    super.key,
    required this.stepsCompleted,
    this.type = ZetaProgressBarType.standard,
    this.isThin = false,
    this.rounded = true,
    this.stateChangeable = false,
    this.label,
    this.isCircle = false,
    this.circleSize,
  });

  final int stepsCompleted;
  final bool? rounded;
  final ZetaProgressBarType? type;
  final bool? isThin;
  final String? label;
  final bool? stateChangeable;
  final bool isCircle;
  final ZetaCircleSizes? circleSize;

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  late int stepsCompleted;
  late double progress;
  late ZetaProgressBarType type;

  @override
  void initState() {
    super.initState();
    type = widget.type!;
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
      type = type == ZetaProgressBarType.buffering ? ZetaProgressBarType.standard : ZetaProgressBarType.buffering;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // Replace with a Column for vertical
      children: [
        widget.isCircle
            ? Center(
                child: ZetaProgressCircle(
                  progress: progress,
                  size: widget.circleSize!,
                ),
              )
            : SizedBox(
                width: 400,
                child: ZetaProgressBar(
                    progress: progress,
                    rounded: widget.rounded!,
                    type: type,
                    isThin: widget.isThin!,
                    label: widget.label),
              ),
        const SizedBox(width: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.type != ZetaProgressBarType.indeterminate
                ? FilledButton(onPressed: increasePercentage, child: Text("Increase"))
                : Container(),
            const SizedBox(width: 40),
            widget.stateChangeable!
                ? FilledButton(onPressed: setLoading, child: Text("Start Buffering"))
                : SizedBox.shrink()
          ],
        )
      ],
    );
  }
}
