import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../zeta_flutter.dart';

/// Zeta Checkbox border type
enum BorderType {
  ///sharp border
  sharp,

  ///rounded border
  rounded,
}

///Zeta Checkbox
class ZetaCheckbox extends StatelessWidget {
  /// Constructs a [ZetaCheckbox].
  const ZetaCheckbox({
    required this.value,
    required this.onChanged,
    this.borderType = BorderType.sharp,
    this.label,
    this.labelStyle,
    this.checkboxSize = const Size(25, 25),
    this.selectedColor,
    this.unselectedColor,
    this.unselectedBorderColor,
    this.unselectedBorderWidth = 2.5,
    this.disabledColor,
    this.isEnabled = true,
    this.iconSize = 18.0,
    super.key,
  }) : assert(iconSize > 0, 'Icon size must be greater than 0');

  /// Whether the checkbox is selected, unselected or null (indeterminate)
  final bool? value;

  /// Called when the value of the checkbox should change.
  final ValueChanged<bool?> onChanged;

  /// The type of border to display
  ///
  /// defaults to sharp
  final BorderType borderType;

  /// The label displayed next to the checkbox
  final String? label;

  /// Style to use on the label
  final TextStyle? labelStyle;

  ///Size of the checkbox
  final Size checkboxSize;

  /// The color to use when this checkbox is checked.
  final Color? selectedColor;

  ///Color of the checkbox when it's not selected
  final Color? unselectedColor;

  ///Color of the border when the checkbox not selected
  final Color? unselectedBorderColor;

  ///Width of the border when the checkbox is not selected
  ///
  /// Defaults to 2.5
  final double unselectedBorderWidth;

  ///Size of the icon displayed inside the checkbox
  final double iconSize;

  ///If checkbox is enabled
  ///
  ///defaults to true
  final bool isEnabled;

  ///Color of the checkbox when it's disabled
  final Color? disabledColor;

  @override
  Widget build(BuildContext context) {
    final theme = Zeta.of(context);
    final ValueNotifier<bool> isFocused = ValueNotifier(false);

    return FocusableActionDetector(
      onFocusChange: (bool focus) => isFocused.value = focus,
      child: GestureDetector(
        onTap: _handleOnTap,
        child: _buildCheckboxRow(theme, isFocused),
      ),
    );
  }

  void _handleOnTap() {
    if (isEnabled) {
      onChanged(
        value == null
            ? true
            : value!
                ? false
                : null,
      );
    }
  }

  Widget _buildCheckboxRow(
    Zeta theme,
    ValueNotifier<bool> isFocused,
  ) {
    return Flex(
      direction: Axis.horizontal,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildCheckboxContainer(theme, isFocused),
        if (label != null) ...[
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: Dimensions.s),
              child: Text(
                label!,
                style: labelStyle ?? ZetaText.zetaTitleMedium,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildCheckboxContainer(Zeta theme, ValueNotifier<bool> isFocused) {
    return ValueListenableBuilder(
      valueListenable: isFocused,
      builder: (context, focused, child) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: _getBoxShadow(theme, focused),
            color: _getCheckboxBackgroundColor(theme),
            border: Border.all(
              color: _getCheckboxBorderColor(theme),
              width: unselectedBorderWidth,
            ),
            borderRadius: BorderRadius.circular(
              borderType == BorderType.rounded ? 4.0 : 0.0,
            ),
          ),
          width: checkboxSize.width,
          height: checkboxSize.height,
          child: _getCheckboxIcon(theme),
        );
      },
    );
  }

  List<BoxShadow> _getBoxShadow(Zeta theme, bool focused) {
    if (!focused) return [];
    return [
      BoxShadow(
        spreadRadius: 3,
        color: theme.colors.surfaceSelectedHovered,
      ),
    ];
  }

  Widget _getCheckboxIcon(Zeta theme) {
    if (value == null) return const SizedBox.shrink();
    return Icon(
      value! ? Icons.check : Icons.remove,
      color: isEnabled ? theme.colors.white : theme.colors.textDisabled,
      size: iconSize,
    );
  }

  Color _getCheckboxBackgroundColor(Zeta theme) {
    if (!isEnabled) return disabledColor ?? theme.colors.surfaceDisabled;
    if (value == null) return unselectedColor ?? theme.colors.surfaceSecondary;
    return selectedColor ?? theme.colors.primary;
  }

  Color _getCheckboxBorderColor(Zeta theme) {
    if (!isEnabled || value != null) return Colors.transparent;
    return unselectedBorderColor ?? theme.colors.borderDefault;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool?>('value', value))
      ..add(ObjectFlagProperty<ValueChanged<bool?>>.has('onChanged', onChanged))
      ..add(EnumProperty<BorderType>('borderType', borderType))
      ..add(StringProperty('label', label))
      ..add(DiagnosticsProperty<TextStyle?>('labelStyle', labelStyle))
      ..add(DiagnosticsProperty<Size>('checkboxSize', checkboxSize))
      ..add(ColorProperty('selectedColor', selectedColor))
      ..add(ColorProperty('unselectedColor', unselectedColor))
      ..add(ColorProperty('unselectedBorderColor', unselectedBorderColor))
      ..add(DoubleProperty('unselectedBorderWidth', unselectedBorderWidth))
      ..add(ColorProperty('disabledColor', disabledColor))
      ..add(DiagnosticsProperty<bool>('isEnabled', isEnabled))
      ..add(DoubleProperty('iconSize', iconSize));
  }
}
