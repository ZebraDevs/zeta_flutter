import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

/// Zeta Checkbox.
///
/// Checkboxes allow users to select one or more items from a set. Checkboxes can turn an option on or off.
///
/// The checkbox itself does not maintain any state. Instead, when the state of
/// the checkbox changes, the widget calls the [onChanged] callback.
/// Widgets that use a checkbox should listen for the [onChanged] callback and
/// rebuild the checkbox with a new [value] to update the visual appearance of
/// the checkbox.
class ZetaCheckbox extends FormField<bool> {
  /// Constructs a [ZetaCheckbox].
  ZetaCheckbox({
    required this.value,
    this.label,
    this.onChanged,
    this.rounded,
    this.useIndeterminate = false,
    super.validator,
    super.autovalidateMode,
    super.restorationId,
    super.key,
  }) : super(
          initialValue: value,
          enabled: onChanged != null,
          builder: (field) {
            return _Checkbox(
              label: label,
              onChanged: (changedValue) {
                field.didChange(changedValue);
                onChanged?.call(changedValue!);
              },
              rounded: rounded,
              useIndeterminate: useIndeterminate,
              value: value,
              error: !field.isValid,
              disabled: onChanged == null,
            );
          },
        );

  /// {@macro zeta-component-rounded}
  final bool? rounded;

  /// Whether the indeterminate state should be supported.
  ///
  /// Defaults to false.
  final bool useIndeterminate;

  /// Whether the checkbox is selected, unselected or null (indeterminate)
  final bool value;

  /// Called when the value of the checkbox should change.
  ///
  /// {@macro on-change-disable}
  final ValueChanged<bool>? onChanged;

  /// The label displayed next to the checkbox
  final String? label;

  @override
  ZetaCheckboxFormFieldState createState() => ZetaCheckboxFormFieldState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('isChecked', value))
      ..add(StringProperty('label', label))
      ..add(DiagnosticsProperty<bool>('useIndeterminate', useIndeterminate))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(ObjectFlagProperty<ValueChanged<bool>?>.has('onChanged', onChanged));
  }
}

/// [FormFieldState] for [ZetaCheckbox].
class ZetaCheckboxFormFieldState extends FormFieldState<bool> {
  @override
  ZetaCheckbox get widget => super.widget as ZetaCheckbox;
}

class _Checkbox extends ZetaStatefulWidget {
  const _Checkbox({
    required this.onChanged,
    this.disabled = false,
    this.value = false,
    this.label,
    this.useIndeterminate = false,
    this.error = false,
    super.rounded,
  });

  /// Whether the checkbox is selected, unselected or null (indeterminate)
  final bool value;

  /// Called when the value of the checkbox should change.
  final ValueChanged<bool?> onChanged;

  /// The label displayed next to the checkbox
  final String? label;

  /// Whether the indeterminate state should be supported.
  ///
  /// Defaults to false.
  final bool useIndeterminate;

  final bool error;

  final bool disabled;

  @override
  State<_Checkbox> createState() => _CheckboxState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool?>('value', value))
      ..add(StringProperty('label', label))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<bool>('useIndeterminate', useIndeterminate))
      ..add(DiagnosticsProperty<bool>('error', error))
      ..add(DiagnosticsProperty<bool>('enabled', disabled))
      ..add(ObjectFlagProperty<ValueChanged<bool?>>.has('onChanged', onChanged));
  }
}

class _CheckboxState extends State<_Checkbox> {
  bool get _checked => widget.value;

  bool _isFocused = false;
  bool _isHovered = false;

  void _setHovered(bool isHovered) {
    if (!widget.disabled) {
      setState(() {
        _isHovered = isHovered;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: !widget.disabled ? () => widget.onChanged.call(!_checked) : null,
        borderRadius: ZetaRadius.full,
        child: Padding(
          padding: const EdgeInsets.all(ZetaSpacing.medium),
          child: Semantics(
            mixed: widget.useIndeterminate,
            enabled: !widget.disabled,
            child: MouseRegion(
              cursor: !widget.disabled ? SystemMouseCursors.click : SystemMouseCursors.forbidden,
              onEnter: (event) => _setHovered(true),
              onExit: (event) => _setHovered(false),
              child: !widget.disabled
                  ? FocusableActionDetector(
                      onFocusChange: (bool focus) => setState(() => _isFocused = focus),
                      child: _buildContent(context),
                    )
                  : _buildContent(context),
            ),
          ),
        ),
      ),
    );
  }

  Flex _buildContent(BuildContext context) {
    final theme = Zeta.of(context);
    final rounded = context.rounded;

    final icon = !_checked
        ? const SizedBox.shrink()
        : Icon(
            !widget.useIndeterminate
                ? rounded
                    ? ZetaIcons.check_mark_round
                    : ZetaIcons.check_mark_sharp
                : rounded
                    ? ZetaIcons.remove_round
                    : ZetaIcons.remove_sharp,
            color: !widget.disabled ? theme.colors.white : theme.colors.iconDisabled,
            size: ZetaSpacingBase.x3_5,
          );

    return Flex(
      direction: Axis.horizontal,
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: ZetaAnimationLength.fast,
          decoration: BoxDecoration(
            boxShadow: [
              if (_isFocused && !widget.disabled)
                BoxShadow(
                  spreadRadius: 2,
                  blurStyle: BlurStyle.solid,
                  color: theme.colors.blue.shade50,
                ),
            ],
            color: _getBackground(theme),
            border: Border.all(color: _getBorderColor(theme), width: ZetaSpacingBase.x0_5),
            borderRadius: rounded ? ZetaRadius.minimal : ZetaRadius.none,
          ),
          width: ZetaSpacing.xl_1,
          height: ZetaSpacing.xl_1,
          child: icon,
        ),
        if (widget.label != null)
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: ZetaSpacing.medium),
              child: Text(widget.label!, style: ZetaTextStyles.bodyMedium),
            ),
          ),
      ],
    );
  }

  Color _getBackground(Zeta theme) {
    final ZetaColorSwatch color = widget.error ? theme.colors.error : theme.colors.primary;
    if (widget.disabled) return theme.colors.surfaceDisabled;
    if (!_checked) return Colors.transparent;
    if (_isHovered) return theme.colors.borderHover;

    return color;
  }

  Color _getBorderColor(Zeta theme) {
    if (_checked || widget.error || widget.disabled) {
      return _getBackground(theme);
    }
    if (_isHovered) {
      return theme.colors.cool.shade90;
    }

    return theme.colors.cool.shade70;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool?>('value', widget.value))
      ..add(ObjectFlagProperty<ValueChanged<bool?>>.has('onChanged', widget.onChanged))
      ..add(DiagnosticsProperty<bool>('rounded', widget.rounded))
      ..add(StringProperty('label', widget.label))
      ..add(DiagnosticsProperty<bool>('useIndeterminate', widget.useIndeterminate));
  }
}
