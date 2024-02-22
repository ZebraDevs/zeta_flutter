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
            child: Column(
              children: [
                Text('Progress Bars', style: ZetaTextStyles.displayMedium),
                SizedBox(
                  height: 20,
                ),
                Wrapper(
                  stepsCompleted: 10,
                  isThin: true,
                ),
                SizedBox(
                  height: 20,
                ),
                Wrapper(
                    stepsCompleted: 0,
                    type: ZetaBarType.standard,
                    isThin: false,
                    stateChangeable: true),
                SizedBox(
                  height: 20,
                ),
                Wrapper(
                  stepsCompleted: 0,
                  type: ZetaBarType.indeterminate,
                  isThin: false,
                  label: "UPLOADING ...",
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Progress CIrcles', style: ZetaTextStyles.displayMedium),
                SizedBox(
                  height: 80,
                ),
                Wrapper(
                  stepsCompleted: 0,
                  circleSize: ZetaCircleSizes.xl,
                  rounded: false,
                  isCircle: true,
                ),
              ],
            ),
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
    this.type = ZetaBarType.standard,
    this.isThin = false,
    this.rounded = true,
    this.stateChangeable = false,
    this.label,
    this.isCircle = false,
    this.circleSize,
  });

  final int stepsCompleted;
  final bool? rounded;
  final ZetaBarType? type;
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
  late ZetaBarType type;

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
      type = type == ZetaBarType.buffering
          ? ZetaBarType.standard
          : ZetaBarType.buffering;
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
            widget.type != ZetaBarType.indeterminate
                ? FilledButton(
                    onPressed: increasePercentage, child: Text("Increase"))
                : Container(),
            const SizedBox(width: 40),
            widget.stateChangeable!
                ? FilledButton(
                    onPressed: setLoading, child: Text("Start Buffering"))
                : SizedBox.shrink()
          ],
        )
      ],
    );
  }
}
