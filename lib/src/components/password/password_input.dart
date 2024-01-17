import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

///Extension for password visibility state handling
extension on ValueNotifier<bool> {
  void toggle() => value = !value;
}

///Zeta Password Input
class ZetaPasswordInput extends StatefulWidget {
  ///Constructs [ZetaPasswordInput]
  const ZetaPasswordInput({
    this.borderType = BorderType.rounded,
    this.size = ZetaWidgetSize.large,
    this.validator,
    this.onChanged,
    this.obscureText = true,
    this.enabled = true,
    this.controller,
    this.hintText,
    this.label,
    this.footerText,
    this.footerIcon,
    super.key,
  });

  /// Controls the text being edited.
  final TextEditingController? controller;

  /// Whether the text is obscured. Useful for passwords. Defaults to true.
  final bool obscureText;

  /// Text that suggests what sort of input the field accepts.
  final String? hintText;

  /// Whether the input field is enabled or disabled. Defaults to true.
  final bool enabled;

  /// Optional label text to display above the input field.
  final String? label;

  /// Optional footer text to display below the input field.
  final String? footerText;

  /// Optional icon to display beside the footer text.
  final IconData? footerIcon;

  /// Defines the border style of the input field. Can be either [BorderType.rounded] or [BorderType.sharp].
  /// Defaults to [BorderType.rounded].
  final BorderType borderType;

  /// Defines the size of the input field. Can be [ZetaWidgetSize.small], [ZetaWidgetSize.medium], or [ZetaWidgetSize.large].
  /// Defaults to [ZetaWidgetSize.large].
  final ZetaWidgetSize size;

  /// An optional method that validates an input. Returns an error string to
  /// display if the input is invalid, or null otherwise.
  final String? Function(String?)? validator;

  /// Called when the user initiates a change to the [ZetaPasswordInput]
  final void Function(String)? onChanged;

  @override
  State<ZetaPasswordInput> createState() => _ZetaPasswordInputState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        DiagnosticsProperty<TextEditingController?>('controller', controller),
      )
      ..add(DiagnosticsProperty<bool>('obscureText', obscureText))
      ..add(StringProperty('hintText', hintText))
      ..add(DiagnosticsProperty<bool>('enabled', enabled))
      ..add(StringProperty('label', label))
      ..add(StringProperty('footerText', footerText))
      ..add(DiagnosticsProperty<IconData?>('footerIcon', footerIcon))
      ..add(EnumProperty<BorderType>('borderType', borderType))
      ..add(
        ObjectFlagProperty<String? Function(String? p1)?>.has(
          'validator',
          validator,
        ),
      )
      ..add(
        ObjectFlagProperty<void Function(String p1)?>.has(
          'onChanged',
          onChanged,
        ),
      )
      ..add(EnumProperty<ZetaWidgetSize>('size', size));
  }
}

class _ZetaPasswordInputState extends State<ZetaPasswordInput> {
  late final ValueNotifier<bool> _obscureTextNotifier;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _obscureTextNotifier = ValueNotifier(widget.obscureText);
    widget.controller?.addListener(_validate);
  }

  void _validate() {
    if (widget.validator != null && widget.controller != null) {
      setState(
        () => _errorMessage = widget.validator!(widget.controller!.text),
      );
    }
  }

  @override
  void dispose() {
    _obscureTextNotifier.dispose();
    widget.controller?.removeListener(_validate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Zeta.of(context);
    final colors = _ZetaPasswordInputColors(colors: theme.colors);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) _buildLabel(),
        _buildTextField(context),
        if (widget.footerText != null || widget.footerIcon != null || _errorMessage != null) _buildFooter(colors),
      ],
    );
  }

  Widget _buildLabel() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.x1),
      child: Text(widget.label!, style: ZetaTextStyles.bodyMedium),
    );
  }

  Widget _buildTextField(BuildContext context) {
    return SizedBox(
      height: _getInputHeight(),
      child: ValueListenableBuilder(
        valueListenable: _obscureTextNotifier,
        builder: (context, obscureValue, child) {
          return TextFormField(
            controller: widget.controller,
            obscureText: obscureValue,
            onChanged: widget.onChanged,
            style: _getTextStyle(),
            decoration: _inputDecoration(context),
          );
        },
      ),
    );
  }

  OutlineInputBorder _getBorder(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: width),
      borderRadius: BorderRadius.circular(
        widget.borderType == BorderType.rounded ? Dimensions.x1 : Dimensions.x0,
      ),
    );
  }

  InputDecoration _inputDecoration(BuildContext context) {
    final theme = Zeta.of(context);
    final colors = _ZetaPasswordInputColors(colors: theme.colors);
    final defaultBorderColor = _errorMessage != null ? colors.borderErrorColor : colors.borderDefaultColor;
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      filled: true,
      fillColor: _getBackgroundColor(colors),
      enabledBorder: _getBorder(defaultBorderColor),
      focusedBorder: _getBorder(
        _errorMessage != null ? colors.borderErrorColor : colors.borderActiveColor,
        width: 2,
      ),
      disabledBorder: _getBorder(colors.borderDisableColor),
      border: _getBorder(defaultBorderColor),
      enabled: widget.enabled,
      hintText: widget.hintText,
      hintStyle: _getTextStyle(),
      suffixIcon: _buildVisibilityIcon(colors),
    );
  }

  Widget _buildFooter(_ZetaPasswordInputColors colors) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.x1),
      child: Row(
        children: [
          if (_errorMessage != null) ..._buildError(colors.borderErrorColor),
          if (_errorMessage == null && widget.footerIcon != null) ...[
            Icon(
              widget.footerIcon,
              size: Dimensions.x4,
              color: widget.enabled ? colors.hintIconColor : colors.hintIconDisableColor,
            ),
            const SizedBox(width: Dimensions.x1),
          ],
          if (_errorMessage == null && widget.footerText != null) ...[
            Text(
              widget.footerText!,
              style: ZetaTextStyles.bodySmall.apply(
                color: widget.enabled ? colors.hintColor : colors.hintDisableColor,
              ),
            ),
          ],
        ],
      ),
    );
  }

  List<Widget> _buildError(Color color) {
    return [
      Icon(
        ZetaIcons.error_round,
        size: Dimensions.x4,
        color: color,
      ),
      const SizedBox(width: Dimensions.x1),
      Text(
        _errorMessage!,
        style: ZetaTextStyles.bodySmall.apply(color: color),
      ),
    ];
  }

  Widget _buildVisibilityIcon(_ZetaPasswordInputColors colors) {
    return ValueListenableBuilder(
      valueListenable: _obscureTextNotifier,
      builder: (context, value, child) {
        return IconButton(
          padding: const EdgeInsets.symmetric(vertical: Dimensions.x1),
          icon: Icon(
            value ? ZetaIcons.visibility_off_sharp : ZetaIcons.visibility_sharp,
            size: _getSuffixIconSize(),
          ),
          color: widget.enabled ? colors.suffixIconColor : colors.suffixIconDisableColor,
          onPressed: () => _obscureTextNotifier.toggle(),
        );
      },
    );
  }

  Color _getBackgroundColor(_ZetaPasswordInputColors colors) {
    if (!widget.enabled) return colors.disableColor;
    if (_errorMessage != null) return colors.errorColor;
    return colors.defaultColor;
  }

  double _getInputHeight() {
    switch (widget.size) {
      case ZetaWidgetSize.small:
        return Dimensions.x8;
      case ZetaWidgetSize.medium:
        return Dimensions.x10;
      case ZetaWidgetSize.large:
        return Dimensions.x12;
    }
  }

  TextStyle _getTextStyle() {
    if (widget.size == ZetaWidgetSize.small) return ZetaTextStyles.bodyMedium;
    return ZetaTextStyles.bodyLarge;
  }

  double _getSuffixIconSize() {
    if (widget.size == ZetaWidgetSize.small) return Dimensions.x4;
    return Dimensions.x5;
  }
}

class _ZetaPasswordInputColors {
  const _ZetaPasswordInputColors({required this.colors});

  final ZetaColors colors;

  Color get defaultColor => colors.surfacePrimary;

  Color get errorColor => colors.red.shade10;

  Color get disableColor => colors.surfaceDisabled;

  Color get borderDefaultColor => colors.borderSubtle;

  Color get borderErrorColor => colors.negative;

  Color get borderActiveColor => colors.primary;

  Color get borderDisableColor => colors.borderSubtle;

  Color get suffixIconColor => colors.iconDefault;

  Color get suffixIconDisableColor => colors.iconDisabled;

  Color get hintColor => colors.textSubtle;

  Color get hintIconColor => colors.iconSubtle;

  Color get hintDisableColor => colors.textDisabled;

  Color get hintIconDisableColor => colors.iconDisabled;
}
