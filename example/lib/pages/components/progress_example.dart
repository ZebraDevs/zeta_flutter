import 'package:flutter/material.dart';
import 'package:zeta_example/config/components_config.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class ProgressBarExample extends StatefulWidget {
  const ProgressBarExample({super.key});

  @override
  State<ProgressBarExample> createState() => ProgressExampleState();
}

class ProgressExampleState extends State<ProgressBarExample> {
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
      name: progressBarRoute,
      children: [
        Column(
          spacing: 16,
          children: [
            ZetaProgressBar(progress: 0.5),
            ZetaProgressBar(progress: 1),
            ZetaProgressBar.indeterminate(label: 'Uploading...'),
            ZetaProgressBar.buffering(progress: 0.5, label: 'Loading...'),
          ],
        ),
      ],
    );
  }
}

class ProgressCircleExample extends StatefulWidget {
  const ProgressCircleExample({super.key});

  @override
  State<ProgressCircleExample> createState() => _ProgressCircleExampleState();
}

class _ProgressCircleExampleState extends State<ProgressCircleExample> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 10000),
      vsync: this,
    );

    _controller.repeat();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: progressCircleRoute,
      children: [
        AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              // print(_controller.value);
              return Column(
                spacing: 40,
                children: [
                  ZetaProgressCircle(size: ZetaCircleSizes.s, progress: 0.25, label: ''),
                  ZetaProgressCircle(size: ZetaCircleSizes.m, progress: 0.5, label: ''),
                  ZetaProgressCircle(
                      size: ZetaCircleSizes.l,
                      progress: _controller.isAnimating ? _controller.value : 0,
                      onCancel: () async {
                        _controller.reset();
                        await Future.delayed(Duration(seconds: 5));
                        _controller.repeat();
                      }),
                ],
              );
            }),
      ],
    );
  }
}
