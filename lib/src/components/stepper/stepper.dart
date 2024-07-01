import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

/// Zeta stepper widget that displays progress through a sequence of
/// steps. Steppers are particularly useful in the case of forms where one step
/// requires the completion of another one, or where multiple steps need to be
/// completed in order to submit the whole form.
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
  late List<GlobalKey> _keys;

  @override
  void initState() {
    super.initState();
    _keys = List<GlobalKey>.generate(
      widget.steps.length,
      (_) => GlobalKey(),
    );
  }

  ZetaColors get _colors => Zeta.of(context).colors;

  bool _isFirst(int index) {
    return index == 0;
  }

  bool _isLast(int index) {
    return widget.steps.length - 1 == index;
  }

  bool _isCurrent(int index) {
    return widget.currentStep == index;
  }

  Widget _buildHorizontalIcon(int index) {
    final rounded = context.rounded;

    return SizedBox(
      width: ZetaSpacing.xl_4,
      height: ZetaSpacing.xl_4,
      child: AnimatedContainer(
        curve: Curves.fastOutSlowIn,
        duration: kThemeAnimationDuration,
        decoration: BoxDecoration(
          color: _getColorForType(widget.steps[index].type),
          shape: rounded ? BoxShape.circle : BoxShape.rectangle,
        ),
        child: Center(
          child: switch (widget.steps[index].type) {
            ZetaStepType.complete => ZetaIcon(
                ZetaIcons.check_mark,
                color: _colors.textInverse,
              ),
            ZetaStepType.enabled || ZetaStepType.disabled => Text(
                (index + 1).toString(),
                style: ZetaTextStyles.labelLarge.copyWith(
                  color: _colors.textInverse,
                ),
              ),
          },
        ),
      ),
    );
  }

  Widget _getVerticalIcon(int index) {
    return SizedBox(
      width: ZetaSpacing.xl_8,
      height: ZetaSpacing.xl_8,
      child: AnimatedContainer(
        curve: Curves.fastOutSlowIn,
        duration: kThemeAnimationDuration,
        decoration: BoxDecoration(
          color: _getColorForType(widget.steps[index].type),
          shape: context.rounded ? BoxShape.circle : BoxShape.rectangle,
        ),
        child: Center(
          child: switch (widget.steps[index].type) {
            ZetaStepType.complete => ZetaIcon(
                ZetaIcons.check_mark,
                color: _colors.textInverse,
              ),
            ZetaStepType.enabled || ZetaStepType.disabled => Text(
                (index + 1).toString(),
                style: ZetaTextStyles.titleLarge.copyWith(
                  color: _colors.textInverse,
                ),
              ),
          },
        ),
      ),
    );
  }

  Widget _getHeaderText(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedDefaultTextStyle(
          style: switch (widget.steps[index].type) {
            ZetaStepType.enabled || ZetaStepType.complete => ZetaTextStyles.bodySmall.copyWith(
                color: _colors.textDefault,
              ),
            ZetaStepType.disabled => ZetaTextStyles.bodySmall.copyWith(
                color: _colors.textDisabled,
              ),
          },
          maxLines: 1,
          duration: kThemeAnimationDuration,
          curve: Curves.fastOutSlowIn,
          child: widget.steps[index].title,
        ),
      ],
    );
  }

  Widget _getVerticalHeader(int index) {
    final subtitle = widget.steps[index].subtitle;

    return Container(
      margin: EdgeInsets.only(top: _isFirst(index) ? 0.0 : ZetaSpacing.xl_2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              _getVerticalIcon(index),
              Container(
                margin: const EdgeInsets.only(top: ZetaSpacing.minimum),
                width: ZetaSpacing.minimum,
                height: ZetaSpacing.xl_8,
                decoration: BoxDecoration(
                  borderRadius: ZetaRadius.full,
                  color: switch (widget.steps[index].type) {
                    ZetaStepType.complete => _colors.green.shade50,
                    ZetaStepType.disabled => _colors.borderSubtle,
                    ZetaStepType.enabled => _colors.blue.shade50,
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: ZetaSpacing.xl_2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (subtitle != null)
                    AnimatedDefaultTextStyle(
                      style: ZetaTextStyles.bodyMedium.copyWith(
                        color: _getColorForType(widget.steps[index].type),
                      ),
                      maxLines: 1,
                      duration: kThemeAnimationDuration,
                      curve: Curves.fastOutSlowIn,
                      child: subtitle,
                    ),
                  AnimatedDefaultTextStyle(
                    style: switch (widget.steps[index].type) {
                      ZetaStepType.enabled || ZetaStepType.complete => ZetaTextStyles.titleLarge.copyWith(
                          color: _colors.textDefault,
                        ),
                      ZetaStepType.disabled => ZetaTextStyles.titleLarge.copyWith(
                          color: _colors.textDisabled,
                        ),
                    },
                    maxLines: 1,
                    duration: kThemeAnimationDuration,
                    curve: Curves.fastOutSlowIn,
                    child: widget.steps[index].title,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getVerticalBody(int index) {
    return Stack(
      children: <Widget>[
        AnimatedCrossFade(
          firstChild: Container(height: 0),
          secondChild: widget.steps[index].content ?? const SizedBox(),
          firstCurve: const Interval(0, 0.6, curve: Curves.fastOutSlowIn),
          secondCurve: const Interval(0.4, 1, curve: Curves.fastOutSlowIn),
          sizeCurve: Curves.fastOutSlowIn,
          crossFadeState: _isCurrent(index) ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: kThemeAnimationDuration,
        ),
      ],
    );
  }

  Color _getColorForType(ZetaStepType type) {
    return switch (type) {
      ZetaStepType.complete => _colors.surfacePositive,
      ZetaStepType.disabled => _colors.cool.shade50,
      ZetaStepType.enabled => _colors.primary,
    };
  }

  @override
  Widget build(BuildContext context) {
    return ZetaRoundedScope(
      rounded: context.rounded,
      child: switch (widget.type) {
        ZetaStepperType.vertical => Column(
            children: [
              for (int index = 0; index < widget.steps.length; index += 1)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  key: _keys[index],
                  children: [
                    InkResponse(
                      containedInkWell: true,
                      borderRadius: ZetaRadius.minimal,
                      onTap: widget.onStepTapped != null ? () => widget.onStepTapped?.call(index) : null,
                      canRequestFocus: widget.steps[index].type != ZetaStepType.disabled,
                      child: _getVerticalHeader(index),
                    ),
                    _getVerticalBody(index),
                  ],
                ),
            ],
          ),
        ZetaStepperType.horizontal => Builder(
            builder: (context) {
              final children = [
                for (int index = 0; index < widget.steps.length; index += 1) ...[
                  InkResponse(
                    onTap: widget.onStepTapped != null ? () => widget.onStepTapped?.call(index) : null,
                    canRequestFocus: widget.steps[index].type != ZetaStepType.disabled,
                    child: Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: ZetaSpacing.medium,
                            ),
                            child: _buildHorizontalIcon(index),
                          ),
                        ),
                        _getHeaderText(index),
                      ],
                    ),
                  ),
                  if (!_isLast(index))
                    Expanded(
                      child: Container(
                        key: Key('line$index'),
                        margin: const EdgeInsets.only(
                          top: ZetaSpacing.xl_3,
                          right: ZetaSpacing.large,
                          left: ZetaSpacing.large,
                        ),
                        height: ZetaSpacingBase.x0_5,
                        decoration: BoxDecoration(
                          borderRadius: ZetaRadius.full,
                          color: switch (widget.steps[index].type) {
                            ZetaStepType.complete => _colors.green.shade50,
                            ZetaStepType.disabled => _colors.borderSubtle,
                            ZetaStepType.enabled => _colors.blue.shade50,
                          },
                        ),
                      ),
                    ),
                ],
              ];

              final List<Widget> stepPanels = <Widget>[];
              for (int i = 0; i < widget.steps.length; i += 1) {
                stepPanels.add(
                  Visibility(
                    maintainState: true,
                    visible: i == widget.currentStep,
                    child: widget.steps[i].content ?? const SizedBox(),
                  ),
                );
              }

              return Column(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: ZetaSpacing.xl_2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: children,
                      ),
                    ),
                  ),
                  Expanded(
                    child: AnimatedSize(
                      curve: Curves.fastOutSlowIn,
                      duration: kThemeAnimationDuration,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: stepPanels,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
      },
    );
  }
}

/// Zeta step used in [ZetaStepper]. The step can have a title and subtitle,
/// an icon within its circle, some content and a state that governs its
/// styling.
class ZetaStep {
  /// Creates a step for a [ZetaStepper].
  const ZetaStep({
    required this.title,
    this.content,
    this.subtitle,
    this.type = ZetaStepType.disabled,
  });

  /// The content of the step that appears below the [title] and [subtitle].
  final Widget? content;

  /// The subtitle of the step that appears above the title.
  final Widget? subtitle;

  /// The title of the step that typically describes it.
  final Widget title;

  /// The type of the step which determines the styling of its components
  /// and whether steps are interactive.
  final ZetaStepType type;
}

/// The type of a [ZetaStep] which is used to control the style of the circle and text.
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
