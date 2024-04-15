import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

/// Zeta Checkbox.
///
/// Checkboxes allow users to select one or more items from a set. Checkboxes can turn an option on or off.
class ZetaCheckbox extends FormField<bool> {
  /// Constructs a [ZetaCheckbox].
  ZetaCheckbox({
    super.key,
    this.value = false,
    this.label,
    this.onChanged,
    this.rounded = true,
    this.useIndeterminate = false,
    super.validator,
    super.autovalidateMode,
    super.restorationId,
  }) : super(
          initialValue: value,
          enabled: onChanged != null,
          builder: (field) {
            return _Checkbox(
              label: label,
              onChanged: (changedValue) {
                field.didChange(changedValue);
                onChanged?.call(changedValue);
              },
              rounded: rounded,
              useIndeterminate: useIndeterminate,
              value: value,
              error: !field.isValid,
              enabled: onChanged != null,
            );
          },
        );

  /// {@macro zeta-component-rounded}
  final bool rounded;

  /// Whether the indeterminate state should be supported.
  ///
  /// Defaults to false.
  final bool useIndeterminate;

  /// Whether the checkbox is selected, unselected or null (indeterminate)
  final bool? value;

  /// Called when the value of the checkbox should change.
  final ValueChanged<bool?>? onChanged;

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
      ..add(ObjectFlagProperty<ValueChanged<bool?>?>.has('onChanged', onChanged));
  }
}

/// [FormFieldState] for [ZetaCheckbox].
class ZetaCheckboxFormFieldState extends FormFieldState<bool> {
  @override
  ZetaCheckbox get widget => super.widget as ZetaCheckbox;
}

class _Checkbox extends StatefulWidget {
  const _Checkbox({
    this.value = false,
    required this.onChanged,
    this.label,
    this.rounded = true,
    this.useIndeterminate = false,
    this.error = false,
    required this.enabled,
  });

  /// Whether the checkbox is selected, unselected or null (indeterminate)
  final bool? value;

  /// Called when the value of the checkbox should change.
  final ValueChanged<bool?> onChanged;

  /// The label displayed next to the checkbox
  final String? label;

  /// {@macro zeta-component-rounded}
  final bool rounded;

  /// Whether the indeterminate state should be supported.
  ///
  /// Defaults to false.
  final bool useIndeterminate;

  final bool error;

  final bool enabled;

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
      ..add(DiagnosticsProperty<bool>('enabled', enabled))
      ..add(ObjectFlagProperty<ValueChanged<bool?>>.has('onChanged', onChanged));
  }
}

class _CheckboxState extends State<_Checkbox> {
  bool? get _value => widget.useIndeterminate ? widget.value : (widget.value ?? false);

  bool? get _updatedValue {
    if (widget.useIndeterminate) {
      if (widget.value == null) {
        return false;
      } else if (widget.value!) {
        return null;
      } else {
        return true;
      }
    } else {
      return !_value!;
    }
  }

  bool _isFocused = false;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      mixed: widget.useIndeterminate,
      enabled: widget.enabled,
      child: MouseRegion(
        cursor: widget.enabled ? SystemMouseCursors.click : SystemMouseCursors.forbidden,
        onEnter: (event) => setState(() => _isHovered = true),
        onExit: (event) => setState(() => _isHovered = false),
        child: widget.enabled
            ? FocusableActionDetector(
                onFocusChange: (bool focus) => setState(() => _isFocused = focus),
                child: GestureDetector(
                  onTap: widget.enabled ? () => widget.onChanged.call(_updatedValue) : null,
                  child: _buildContent(context),
                ),
              )
            : _buildContent(context),
      ),
    );
  }

  Flex _buildContent(BuildContext context) {
    final theme = Zeta.of(context);

    final icon = _value != null && !_value!
        ? const SizedBox.shrink()
        : Icon(
            _value != null
                ? widget.rounded
                    ? ZetaIcons.check_mark_round
                    : ZetaIcons.check_mark_sharp
                : widget.rounded
                    ? ZetaIcons.remove_round
                    : ZetaIcons.remove_sharp,
            color: widget.enabled ? theme.colors.white : theme.colors.textDisabled,
            size: ZetaSpacing.x3_5,
          );

    return Flex(
      direction: Axis.horizontal,
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            boxShadow: [
              if (_isFocused && widget.enabled)
                BoxShadow(
                  spreadRadius: 2,
                  blurStyle: BlurStyle.solid,
                  color: theme.colors.blue.shade50,
                ),
            ],
            color: _getBackground(theme),
            border: widget.enabled ? Border.all(color: _getBorderColor(theme), width: ZetaSpacing.x0_5) : null,
            borderRadius: widget.rounded ? ZetaRadius.minimal : ZetaRadius.none,
          ),
          width: ZetaSpacing.x5,
          height: ZetaSpacing.x5,
          child: icon,
        ),
        if (widget.label != null) ...[
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: ZetaSpacing.s),
              child: Text(widget.label!, style: ZetaTextStyles.bodyMedium),
            ),
          ),
        ],
      ],
    );
  }

  Color _getBackground(Zeta theme) {
    final ZetaColorSwatch color = widget.error ? theme.colors.error : theme.colors.primary;
    if (!widget.enabled) return theme.colors.surfaceDisabled;
    if (_value != null && !_value!) return theme.colors.surfacePrimary;
    if (_isHovered) return color.hover;

    return color;
  }

  Color _getBorderColor(Zeta theme) {
    final ZetaColorSwatch color = widget.error ? theme.colors.error : theme.colors.cool;

    if (_isHovered) return color.shade90;

    return color;
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
