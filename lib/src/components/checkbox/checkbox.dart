import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

/// Checkboxes allow users to select one or more items from a set. Checkboxes can turn an option on or off.
///
/// The checkbox itself does not maintain any state. Instead, when the state of
/// the checkbox changes, the widget calls the [onChanged] callback.
/// Widgets that use a checkbox should listen for the [onChanged] callback and
/// rebuild the checkbox with a new [value] to update the visual appearance of
/// the checkbox.
/// {@category Components}
///
/// Figma: https://www.figma.com/file/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=21510-54003
///
/// Widgetbook: https://zeta-ds.web.app/flutter/widgetbook/index.html#/?path=components/checkbox
class ZetaCheckbox extends FormField<bool> {
  /// Constructs a [ZetaCheckbox].
  ZetaCheckbox({
    this.value = false,
    this.label,
    this.onChanged,
    this.rounded,
    this.useIndeterminate = false,
    this.focusNode,
    this.semanticLabel,
    super.validator,
    super.autovalidateMode,
    super.restorationId,
    super.key,
  }) : super(
          initialValue: value,
          enabled: onChanged != null,
          builder: (field) {
            return ZetaInternalCheckbox(
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
              focusNode: focusNode,
              semanticLabel: semanticLabel,
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
  /// {@macro zeta-widget-change-disable}
  final ValueChanged<bool>? onChanged;

  /// The label displayed next to the checkbox
  final String? label;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// Value passed into wrapping [Semantics] widget.
  ///
  /// {@macro zeta-widget-semantic-label}
  ///
  /// If null, [label] is used.
  final String? semanticLabel;

  @override
  ZetaCheckboxFormFieldState createState() => ZetaCheckboxFormFieldState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('value', value))
      ..add(StringProperty('label', label))
      ..add(DiagnosticsProperty<bool>('useIndeterminate', useIndeterminate))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(ObjectFlagProperty<ValueChanged<bool>?>.has('onChanged', onChanged))
      ..add(DiagnosticsProperty<FocusNode?>('focusNode', focusNode))
      ..add(StringProperty('semanticLabel', semanticLabel));
  }
}

/// [FormFieldState] for [ZetaCheckbox].
class ZetaCheckboxFormFieldState extends FormFieldState<bool> {
  @override
  ZetaCheckbox get widget => super.widget as ZetaCheckbox;
}

/// Internal checkbox. Not for external use.
@visibleForTesting
@protected
class ZetaInternalCheckbox extends ZetaStatefulWidget {
  /// Constructs a [ZetaInternalCheckbox].
  const ZetaInternalCheckbox({
    super.key,
    required this.onChanged,
    this.disabled = false,
    this.value = false,
    this.label,
    this.useIndeterminate = false,
    this.error = false,
    this.focusNode,
    this.semanticLabel,
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

  /// Whether field is value.
  final bool error;

  /// {@macro zeta-widget-disabled}
  final bool disabled;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// Value passed into wrapping [Semantics] widget.
  ///
  /// {@macro zeta-widget-semantic-label}
  ///
  /// If null, [label] is used.
  final String? semanticLabel;

  @override
  State<ZetaInternalCheckbox> createState() => _CheckboxState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool?>('value', value))
      ..add(StringProperty('label', label))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<bool>('useIndeterminate', useIndeterminate))
      ..add(DiagnosticsProperty<bool>('error', error))
      ..add(DiagnosticsProperty<bool>('disabled', disabled))
      ..add(ObjectFlagProperty<ValueChanged<bool?>>.has('onChanged', onChanged))
      ..add(DiagnosticsProperty<FocusNode>('focusNode', focusNode))
      ..add(StringProperty('semanticLabel', semanticLabel));
  }
}

class _CheckboxState extends State<ZetaInternalCheckbox> {
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
    return Semantics(
      mixed: widget.useIndeterminate,
      enabled: !widget.disabled,
      focusable: true,
      container: true,
      excludeSemantics: true,
      checked: !widget.useIndeterminate && _checked,
      label: widget.semanticLabel ?? widget.label,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: !widget.disabled ? () => widget.onChanged.call(!_checked) : null,
          borderRadius: Zeta.of(context).radius.full,
          child: Padding(
            padding: EdgeInsets.all(Zeta.of(context).spacing.medium),
            child: MouseRegion(
              cursor: !widget.disabled ? SystemMouseCursors.click : SystemMouseCursors.forbidden,
              onEnter: (event) => _setHovered(true),
              onExit: (event) => _setHovered(false),
              child: !widget.disabled
                  ? FocusableActionDetector(
                      focusNode: widget.focusNode,
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
        ? const Nothing()
        : ZetaIcon(
            widget.useIndeterminate ? ZetaIcons.remove : ZetaIcons.check_mark,
            color: widget.disabled ? theme.colors.mainDisabled : theme.colors.mainInverse,
            size: 14, // TODO(UX-1202): ZetaSpacingBase
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
                  color: theme.colors.borderPrimary,
                ),
            ],
            color: _getBackground(theme),
            border: Border.all(color: _getBorderColor(theme), width: Zeta.of(context).spacing.minimum / 2),
            borderRadius: rounded ? Zeta.of(context).radius.minimal : Zeta.of(context).radius.none,
          ),
          width: Zeta.of(context).spacing.xl,
          height: Zeta.of(context).spacing.xl,
          child: icon,
        ),
        if (widget.label != null)
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(left: Zeta.of(context).spacing.medium),
              child: Text(widget.label!, style: ZetaTextStyles.bodyMedium),
            ),
          ),
      ],
    );
  }

  Color _getBackground(Zeta theme) {
    if (widget.disabled) return theme.colors.surfaceDisabled;
    if (!_checked) return theme.colors.surfaceDefault;
    if (_isHovered) return theme.colors.mainDefault;

    return theme.colors.mainPrimary;
  }

  Color _getBorderColor(Zeta theme) {
    if (_checked || widget.error || widget.disabled) {
      return _getBackground(theme);
    }
    if (_isHovered) {
      return theme.colors.borderHover;
    }

    return theme.colors.mainSubtle;
  }
}
