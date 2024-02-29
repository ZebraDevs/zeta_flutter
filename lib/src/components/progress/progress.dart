import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Super class for [ZetaProgress] widgets.
/// Handles state for progress of [ZetaProgress] widgets.
abstract class ZetaProgress extends StatefulWidget {
  /// Constructor for abstract [ZetaProgress] class.
  const ZetaProgress({super.key, this.progress = 0});

  /// ZetaProgress value, decimal value ranging from 0.0 - 1.0, 0.5 = 50%
  final double progress;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('progress', progress));
  }
}

/// Super class for [ZetaProgressState]
/// Defines functions that deal with state change of progress value and
/// animation changing.
abstract class ZetaProgressState<T extends ZetaProgress> extends State<T> with TickerProviderStateMixin {
  /// Decimal progress value
  late double progress;

  ///Animation controller for [ZetaProgressState]
  late AnimationController controller;

  ///Animation for [ZetaProgressState]
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    progress = widget.progress;
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    animation = Tween<double>(
      begin: widget.progress, // Start value
      end: widget.progress, // End value (initially same as start value)
    ).animate(controller)
      ..addListener(() {
        setState(() {
          progress = animation.value;
        });
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  ///Update animation with new progress value to give animation effect for progress changing.
  void updateProgress(double newProgress) {
    // Update the Tween with new start and end value

    setState(() {
      animation = Tween<double>(
        begin: progress,
        end: newProgress,
      ).animate(controller);
      controller.forward(from: progress);
    });
  }

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      updateProgress(widget.progress);
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('progress', progress))
      ..add(DiagnosticsProperty<AnimationController>('controller', controller))
      ..add(DiagnosticsProperty<Animation<double>>('animation', animation));
  }
}
