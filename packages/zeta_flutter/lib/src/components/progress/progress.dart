import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

/// Super class for [ZetaProgress] widgets.
/// Handles state for progress of [ZetaProgress] widgets.
abstract class ZetaProgress extends ZetaStatefulWidget {
  /// Constructor for abstract [ZetaProgress] class.
  const ZetaProgress({
    super.key,
    super.rounded,
    this.progress = 0,
    this.maxValue = 1,
  });

  /// ZetaProgress value, decimal value ranging from 0.0 - 1.0, 0.5 = 50%
  final double progress;

  /// Maximum value for progress, defaults to 1
  final double maxValue;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('progress', progress))
      ..add(DoubleProperty('maxValue', maxValue));
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
      duration: ZetaAnimationLength.fast,
    );
    animation = Tween<double>(
      begin: widget.progress, // Start value
      end: widget.progress, // End value (initially same as start value)
    ).animate(controller)
      ..addListener(() {
        setState(() {
          progress = animation.value / widget.maxValue;
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
        begin: progress * widget.maxValue,
        end: newProgress,
      ).animate(controller);
      controller
        ..reset()
        ..forward(from: 0);
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
