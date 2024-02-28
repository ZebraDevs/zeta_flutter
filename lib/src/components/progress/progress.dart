import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Super class for [Progress] widgets.
/// Handles state for progress of [Progress] widgets.
abstract class Progress extends StatefulWidget {
  /// Constructor for abstract [Progress] class.
  const Progress({super.key, this.progress = 0});

  /// Progress value, decimal value ranging from 0.0 - 1.0, 0.5 = 50%
  final double progress;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('progress', progress));
  }
}

/// Super class for [ProgressState]
/// Defines functions that deal with state change of progress value and
/// animation changing.
abstract class ProgressState<T extends Progress> extends State<T>
    with TickerProviderStateMixin {
  /// Decimal progress value
  late double progress;

  ///Animation controller for [ProgressState]
  late AnimationController controller;

  ///Animation for [ProgressState]
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    progress = widget.progress;
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
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
