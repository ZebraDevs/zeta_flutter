import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

/// Zeta stepper widget that displays progress through a sequence of
/// steps. Steppers are particularly useful in the case of forms where one step
/// requires the completion of another one, or where multiple steps need to be
/// completed in order to submit the whole form.
///
/// The steppers current step is managed through the [currentStep] property.
/// To change it, store this value in state and change it with the [onStepTapped] callback.
/// The stored value can then be used to update content depending on the selected step.
///
/// ```dart
/// ZetaStepper(
///   steps: [
///     ZetaStep(title: Text('Step 1')),
///     ZetaStep(title: Text('Step 2')),
///     ZetaStep(title: Text('Step 3')),
///   ],
///   currentStep: currentStep,
///   onStepTapped: (step) {
///     setState(() {
///       currentStep = step;
///     });
///   },
/// )
/// ```
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=3420-67488&node-type=canvas&m=dev
///
/// Widgetbook: https://zeta-ds.web.app/flutter/widgetbook/index.html#/?path=components/stepper
class ZetaStepper extends ZetaStatefulWidget {
  /// Creates a stepper from a list of steps.
  ///
  /// This widget is not meant to be rebuilt with a different list of steps
  /// unless a key is provided in order to distinguish the old stepper from the
  /// new one.
  const ZetaStepper({
    required this.steps,
    required this.currentStep,
    this.type = ZetaStepperType.horizontal,
    this.onStepTapped,
    super.rounded,
    super.key,
  });

  /// The index into [steps] of the current step whose content is displayed.
  final int currentStep;

  /// The callback called when a step is tapped, with its index passed as
  /// an argument.
  final ValueChanged<int>? onStepTapped;

  /// The steps of the stepper whose titles, subtitles, icons always get shown.
  ///
  /// The length of [steps] must not change.
  final List<ZetaStep> steps;

  /// The type of stepper that determines the layout. In the case of
  /// [ZetaStepperType.horizontal], the content of the current step is displayed
  /// underneath as opposed to the [ZetaStepperType.vertical] case where it is
  /// displayed in-between.
  final ZetaStepperType type;

  @override
  State<ZetaStepper> createState() => _ZetaStepperState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<ZetaStep>('steps', steps))
      ..add(IntProperty('currentStep', currentStep))
      ..add(EnumProperty<ZetaStepperType>('type', type))
      ..add(
        ObjectFlagProperty<ValueChanged<int>?>.has(
          'onStepTapped',
          onStepTapped,
        ),
      );
  }
}

class _ZetaStepperState extends State<ZetaStepper> with TickerProviderStateMixin {
  bool _isLast(int index) {
    return widget.steps.length - 1 == index;
  }

  bool _isComplete(int index) {
    return widget.currentStep > index;
  }

  @override
  Widget build(BuildContext context) {
    return ZetaRoundedScope(
      rounded: context.rounded,
      child: switch (widget.type) {
        ZetaStepperType.vertical => IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: widget.steps
                  .map(
                    (step) => VerticalStep(
                      step: step,
                      index: widget.steps.indexOf(step),
                      completed: _isComplete(widget.steps.indexOf(step)),
                      isLast: _isLast(widget.steps.indexOf(step)),
                      onStepTapped: !step.disabled ? () => widget.onStepTapped?.call(widget.steps.indexOf(step)) : null,
                    ),
                  )
                  .toList(),
            ),
          ),
        ZetaStepperType.horizontal => Material(
            color: Colors.transparent,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: Zeta.of(context).spacing.xl_2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final step in widget.steps) ...[
                    HorizontalStep(
                      step: step,
                      index: widget.steps.indexOf(step),
                      completed: _isComplete(widget.steps.indexOf(step)),
                      onStepTapped: !step.disabled ? () => widget.onStepTapped?.call(widget.steps.indexOf(step)) : null,
                    ),
                    if (!_isLast(widget.steps.indexOf(step)))
                      Expanded(
                        child: StepDivider(
                          disabled: step.disabled,
                          type: ZetaStepperType.horizontal,
                          completed: _isComplete(widget.steps.indexOf(step)),
                        ),
                      ),
                  ],
                ],
              ),
            ),
          )
      },
    );
  }
}

Color _getElementColor(BuildContext context, bool disabled, bool completed) {
  final colors = Zeta.of(context).colors;
  Color boxColor = colors.mainPrimary;

  if (disabled) {
    boxColor = colors.mainDisabled;
  } else if (completed) {
    boxColor = colors.surfacePositive;
  }

  return boxColor;
}

/// The icon that represents a step in the [ZetaStepper] widget.
@visibleForTesting
@protected
class StepIcon extends StatelessWidget {
  /// Creates a step icon for the [ZetaStepper] widget.
  const StepIcon({
    required this.index,
    required this.completed,
    required this.disabled,
    required this.type,
    super.key,
  });

  /// The index of the step in the list of steps.
  final int index;

  /// Whether the step is completed.
  final bool completed;

  /// Whether the step is disabled.
  final bool disabled;

  /// The size of the icon.
  final ZetaStepperType type;

  @override
  Widget build(BuildContext context) {
    final rounded = context.rounded;
    final colors = Zeta.of(context).colors;
    final spacing = Zeta.of(context).spacing;

    final size = switch (type) {
      ZetaStepperType.horizontal => spacing.xl_4,
      ZetaStepperType.vertical => spacing.xl_6,
    };

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _getElementColor(context, disabled, completed),
        shape: rounded ? BoxShape.circle : BoxShape.rectangle,
      ),
      child: Center(
        child: completed && !disabled
            ? ZetaIcon(
                ZetaIcons.check_mark,
                color: colors.mainInverse,
              )
            : Text(
                (index + 1).toString(),
                style: ZetaTextStyles.labelLarge.copyWith(
                  color: colors.mainInverse,
                ),
              ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('index', index))
      ..add(DiagnosticsProperty<bool>('completed', completed))
      ..add(DiagnosticsProperty<bool>('disabled', disabled))
      ..add(EnumProperty<ZetaStepperType>('type', type));
  }
}

/// A divider that separates steps in the [ZetaStepper] widget.
@visibleForTesting
@protected
class StepDivider extends StatelessWidget {
  /// Creates a step divider for the [ZetaStepper] widget.
  const StepDivider({
    super.key,
    required this.type,
    required this.disabled,
    required this.completed,
  });

  /// Disables the divider and changes its color.
  final bool disabled;

  /// Changes the color of the divider to indicate completion.
  final bool completed;

  /// The type of the divider.
  final ZetaStepperType type;

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    final spacing = Zeta.of(context).spacing;

    Color color = colors.borderPrimary;

    if (disabled) {
      color = colors.borderDefault;
    } else if (completed) {
      color = colors.borderPositive;
    }

    return Container(
      margin: switch (type) {
        ZetaStepperType.horizontal => EdgeInsets.only(
            top: spacing.xl_3,
            right: spacing.small,
            left: spacing.small,
          ),
        ZetaStepperType.vertical => EdgeInsets.only(
            top: spacing.minimum,
          ),
      },
      width: switch (type) {
        ZetaStepperType.horizontal => double.infinity,
        ZetaStepperType.vertical => spacing.minimum,
      },
      height: switch (type) {
        ZetaStepperType.horizontal => ZetaBorders.medium,
        ZetaStepperType.vertical => spacing.xl_8,
      },
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Zeta.of(context).radius.full),
        color: color,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('disabled', disabled))
      ..add(DiagnosticsProperty<bool>('completed', completed))
      ..add(EnumProperty<ZetaStepperType>('type', type));
  }
}

/// A horizontal step in the [ZetaStepper] widget.
@visibleForTesting
@protected
class HorizontalStep extends StatelessWidget {
  /// Creates a horizontal step in the [ZetaStepper] widget.
  const HorizontalStep({
    required this.step,
    required this.index,
    required this.completed,
    this.onStepTapped,
    super.key,
  });

  /// The step that this widget represents.
  final ZetaStep step;

  /// The index of the step in the list of steps.
  final int index;

  /// Whether the step is completed.
  final bool completed;

  /// The callback called when the step is tapped.
  final VoidCallback? onStepTapped;

  @override
  Widget build(BuildContext context) {
    final spacing = Zeta.of(context).spacing;
    final colors = Zeta.of(context).colors;
    final radius = Zeta.of(context).radius;

    return Semantics(
      label: step.semanticLabel,
      excludeSemantics: step.semanticLabel != null,
      child: InkWell(
        onTap: onStepTapped,
        canRequestFocus: !step.disabled,
        borderRadius: BorderRadius.all(radius.minimal),
        child: Padding(
          padding: EdgeInsets.only(left: spacing.small, right: spacing.small, bottom: spacing.small),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: spacing.medium,
                  ),
                  child: StepIcon(
                    index: index,
                    completed: completed,
                    disabled: step.disabled,
                    type: ZetaStepperType.horizontal,
                  ),
                ),
              ),
              DefaultTextStyle(
                style: ZetaTextStyles.bodySmall.copyWith(
                  color: step.disabled ? colors.mainDisabled : colors.mainDefault,
                ),
                child: step.title,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ZetaStep>('step', step))
      ..add(IntProperty('index', index))
      ..add(DiagnosticsProperty<bool>('completed', completed))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onStepTapped', onStepTapped));
  }
}

/// A vertical step in the [ZetaStepper] widget.
@visibleForTesting
@protected
class VerticalStep extends StatelessWidget {
  /// Creates a vertical step in the [ZetaStepper] widget.
  const VerticalStep({
    required this.step,
    required this.index,
    required this.completed,
    required this.isLast,
    this.onStepTapped,
    super.key,
  });

  /// The step that this widget represents.
  final ZetaStep step;

  /// The index of the step in the list of steps.
  final int index;

  /// Whether the step is completed.
  final bool completed;

  /// Whether the step is the last one in the list.
  final bool isLast;

  /// The callback called when the step is tapped.
  final VoidCallback? onStepTapped;

  @override
  Widget build(BuildContext context) {
    final spacing = Zeta.of(context).spacing;
    final colors = Zeta.of(context).colors;

    return Semantics(
      label: step.semanticLabel,
      excludeSemantics: step.semanticLabel != null,
      child: InkWell(
        borderRadius: BorderRadius.all(Zeta.of(context).radius.minimal),
        onTap: onStepTapped,
        canRequestFocus: !step.disabled,
        child: Container(
          padding: EdgeInsets.all(
            spacing.medium,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  StepIcon(
                    index: index,
                    completed: completed,
                    disabled: step.disabled,
                    type: ZetaStepperType.vertical,
                  ),
                  if (!isLast)
                    StepDivider(
                      type: ZetaStepperType.vertical,
                      completed: completed,
                      disabled: step.disabled,
                    ),
                ],
              ),
              SizedBox(width: spacing.xl_2),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (step.subtitle != null)
                    AnimatedDefaultTextStyle(
                      style: ZetaTextStyles.bodyMedium.copyWith(
                        color: _getElementColor(context, step.disabled, completed),
                      ),
                      maxLines: 1,
                      duration: kThemeAnimationDuration,
                      curve: Curves.fastOutSlowIn,
                      child: step.subtitle!,
                    ),
                  DefaultTextStyle(
                    style: ZetaTextStyles.titleLarge.copyWith(
                      color: step.disabled ? colors.mainDisabled : colors.mainDefault,
                    ),
                    maxLines: 1,
                    child: step.title,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ZetaStep>('step', step))
      ..add(IntProperty('index', index))
      ..add(DiagnosticsProperty<bool>('completed', completed))
      ..add(DiagnosticsProperty<bool>('isLast', isLast))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onStepTapped', onStepTapped));
  }
}

/// Zeta step used in [ZetaStepper]. The step can have a title and subtitle,
/// an icon within its circle, some content and a state that governs its
/// styling.
class ZetaStep {
  /// Creates a step for a [ZetaStepper].
  const ZetaStep({
    required this.title,
    this.subtitle,
    this.disabled = false,
    this.semanticLabel,
  });

  /// The subtitle of the step that appears above the title.
  final Widget? subtitle;

  /// The title of the step that typically describes it.
  final Widget title;

  /// The semantic label of the step that is read by screen readers.
  final String? semanticLabel;

  /// Whether the step is disabled and does not react to taps.
  final bool disabled;
}

/// Defines the [ZetaStepper]'s main axis.
enum ZetaStepperType {
  /// A vertical layout of the steps with their content in-between the titles.
  vertical,

  /// A horizontal layout of the steps with their content below the titles.
  horizontal,
}
