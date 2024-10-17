import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

/// Zeta stepper widget that displays progress through a sequence of
/// steps. Steppers are particularly useful in the case of forms where one step
/// requires the completion of another one, or where multiple steps need to be
/// completed in order to submit the whole form.
/// {@category Components}
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
      ..properties.add(IntProperty('currentStep', currentStep))
      ..add(EnumProperty<ZetaStepperType>('type', type))
      ..add(
        ObjectFlagProperty<ValueChanged<int>?>.has(
          'onStepTapped',
          onStepTapped,
        ),
      )
      ..properties.add(DiagnosticsProperty<bool>('rounded', rounded));
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
    final spacing = Zeta.of(context).spacing;

    return ZetaRoundedScope(
      rounded: context.rounded,
      child: switch (widget.type) {
        ZetaStepperType.vertical => IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.steps
                  .map(
                    (step) => _VerticalStep(
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
                    _HorizontalStep(
                      step: step,
                      index: widget.steps.indexOf(step),
                      completed: _isComplete(widget.steps.indexOf(step)),
                      onStepTapped: !step.disabled ? () => widget.onStepTapped?.call(widget.steps.indexOf(step)) : null,
                    ),
                    if (!_isLast(widget.steps.indexOf(step)))
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                            top: spacing.xl_3,
                            right: spacing.small,
                            left: spacing.small,
                          ),
                          height: ZetaBorders.medium,
                          decoration: BoxDecoration(
                            borderRadius: Zeta.of(context).radius.full,
                            color: _getElementColor(context, step.disabled, _isComplete(widget.steps.indexOf(step))),
                          ),
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
  Color boxColor = colors.primary;

  if (disabled) {
    boxColor = colors.borderSubtle;
  } else if (completed) {
    boxColor = colors.surfacePositive;
  }

  return boxColor;
}

class _StepIcon extends StatelessWidget {
  const _StepIcon({
    required this.index,
    required this.completed,
    required this.disabled,
    required this.size,
  });

  final int index;
  final bool completed;
  final bool disabled;
  final double size;

  @override
  Widget build(BuildContext context) {
    final rounded = context.rounded;
    final colors = Zeta.of(context).colors;

    return SizedBox(
      width: size,
      height: size,
      child: AnimatedContainer(
        curve: Curves.fastOutSlowIn,
        duration: kThemeAnimationDuration,
        decoration: BoxDecoration(
          color: _getElementColor(context, disabled, completed),
          shape: rounded ? BoxShape.circle : BoxShape.rectangle,
        ),
        child: Center(
          child: completed && !disabled
              ? ZetaIcon(
                  ZetaIcons.check_mark,
                  color: colors.textInverse,
                )
              : Text(
                  (index + 1).toString(),
                  style: ZetaTextStyles.labelLarge.copyWith(
                    color: colors.textInverse,
                  ),
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
      ..add(DoubleProperty('size', size));
  }
}

class _HorizontalStep extends StatelessWidget {
  const _HorizontalStep({
    required this.step,
    required this.index,
    required this.completed,
    this.onStepTapped,
  });

  final ZetaStep step;
  final int index;
  final bool completed;
  final VoidCallback? onStepTapped;

  @override
  Widget build(BuildContext context) {
    final spacing = Zeta.of(context).spacing;
    final colors = Zeta.of(context).colors;
    final radius = Zeta.of(context).radius;

    return Row(
      children: [
        InkWell(
          onTap: onStepTapped,
          canRequestFocus: !step.disabled,
          borderRadius: radius.minimal,
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
                    child: _StepIcon(
                      index: index,
                      completed: completed,
                      disabled: step.disabled,
                      size: spacing.xl_4,
                    ),
                  ),
                ),
                DefaultTextStyle(
                  style: ZetaTextStyles.bodySmall.copyWith(
                    color: step.disabled ? colors.textDisabled : colors.textDefault,
                  ),
                  child: step.title,
                ),
              ],
            ),
          ),
        ),
      ],
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

class _VerticalStep extends StatelessWidget {
  const _VerticalStep({
    required this.step,
    required this.index,
    required this.completed,
    required this.isLast,
    this.onStepTapped,
  });

  final ZetaStep step;
  final int index;
  final bool completed;
  final bool isLast;
  final VoidCallback? onStepTapped;

  @override
  Widget build(BuildContext context) {
    final spacing = Zeta.of(context).spacing;
    final colors = Zeta.of(context).colors;

    return InkWell(
      borderRadius: Zeta.of(context).radius.minimal,
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
                _StepIcon(
                  index: index,
                  completed: completed,
                  disabled: step.disabled,
                  size: spacing.xl_6,
                ),
                if (!isLast)
                  Container(
                    margin: EdgeInsets.only(top: spacing.minimum),
                    width: Zeta.of(context).spacing.minimum,
                    height: Zeta.of(context).spacing.xl_8,
                    decoration: BoxDecoration(
                      borderRadius: Zeta.of(context).radius.full,
                      color: _getElementColor(context, step.disabled, completed),
                    ),
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
                    color: step.disabled ? colors.textDisabled : colors.textDefault,
                  ),
                  maxLines: 1,
                  child: step.title,
                ),
              ],
            ),
          ],
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
    @Deprecated('Steps no longer manage their own content. ' 'Deprecated as of 0.16.1') this.content,
    this.subtitle,
    this.disabled = false,
    @Deprecated(
        'To disable a step, set its disabled prop to true. To complete a step, set the currentStep prop on the stepper greater than the step index. '
        'Deprecated as of 0.16.1')
    this.type = ZetaStepType.disabled,
  });

  /// The content of the step that appears below the [title] and [subtitle].
  @Deprecated('Steps no longer manage their own content. ' 'Deprecated as of 0.16.1')
  final Widget? content;

  /// The subtitle of the step that appears above the title.
  final Widget? subtitle;

  /// The title of the step that typically describes it.
  final Widget title;

  /// Whether the step is disabled and does not react to taps.
  final bool disabled;

  /// The type of the step which determines the styling of its components
  /// and whether steps are interactive.
  @Deprecated(
      'To disable a step, set its disabled prop to true. To complete a step, set the activeStep prop on the stepper greater than the step index. '
      'Deprecated as of 0.16.1')
  final ZetaStepType type;
}

/// The type of a [ZetaStep] which is used to control the style of the circle and text.
@Deprecated(
    'To disable a step, set its disabled prop to true. To complete a step, set the activeStep prop on the stepper greater than the step index. '
    'Deprecated as of 0.16.1')
enum ZetaStepType {
  /// A step that is currently selected with primary color icon
  enabled,

  /// A step that displays a tick icon in its circle.
  complete,

  /// A step that is disabled and does not to react to taps.
  disabled,
}

/// Defines the [ZetaStepper]'s main axis.
enum ZetaStepperType {
  /// A vertical layout of the steps with their content in-between the titles.
  vertical,

  /// A horizontal layout of the steps with their content below the titles.
  horizontal,
}
