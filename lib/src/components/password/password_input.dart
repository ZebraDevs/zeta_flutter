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
    this.rounded = false,
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

  /// {@macro zeta-component-rounded}
  final bool rounded;

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
      ..add(EnumProperty<ZetaWidgetSize>('size', size))
      ..add(DiagnosticsProperty<bool>('rounded', rounded));
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
      setState(() => _errorMessage = widget.validator!(widget.controller!.text));
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
    final defaultBorderColor = _errorMessage != null ? theme.colors.error.border : theme.colors.borderDefault;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: ZetaSpacing.minimum),
            child: Text(widget.label!, style: ZetaTextStyles.bodyMedium),
          ),
        SizedBox(
          height: _inputHeight,
          child: ValueListenableBuilder(
            valueListenable: _obscureTextNotifier,
            builder: (context, obscureValue, child) {
              return TextFormField(
                controller: widget.controller,
                obscureText: obscureValue,
                onChanged: widget.onChanged,
                style: _textStyle,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: ZetaSpacing.small),
                  filled: true,
                  fillColor: _getBackgroundColor(theme.colors),
                  enabledBorder: _getBorder(defaultBorderColor),
                  focusedBorder: _getBorder(
                    _errorMessage != null ? theme.colors.error.border : theme.colors.primary.border,
                    width: ZetaSpacingBase.x0_5,
                  ),
                  disabledBorder: _getBorder(theme.colors.borderDefault),
                  border: _getBorder(defaultBorderColor),
                  enabled: widget.enabled,
                  hintText: widget.hintText,
                  hintStyle: _textStyle,
                  suffixIcon: ValueListenableBuilder(
                    valueListenable: _obscureTextNotifier,
                    builder: (context, value, child) {
                      return IconButton(
                        padding: const EdgeInsets.symmetric(vertical: ZetaSpacing.minimum),
                        icon: Icon(
                          value ? ZetaIcons.visibility_off_sharp : ZetaIcons.visibility_sharp,
                          size: widget.size == ZetaWidgetSize.small ? ZetaSpacing.large : ZetaSpacing.xl_1,
                        ),
                        color: widget.enabled ? theme.colors.iconDefault : theme.colors.iconDisabled,
                        onPressed: () => _obscureTextNotifier.toggle(),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
        if (widget.footerText != null || widget.footerIcon != null || _errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: ZetaSpacing.minimum),
            child: Row(
              children: [
                if (_errorMessage != null) ...[
                  Icon(
                    ZetaIcons.error_round,
                    size: ZetaSpacing.large,
                    color: theme.colors.error.border,
                  ),
                  const SizedBox(width: ZetaSpacing.minimum),
                  Text(
                    _errorMessage!,
                    style: ZetaTextStyles.bodySmall.apply(color: theme.colors.error.border),
                  ),
                ],
                if (_errorMessage == null && widget.footerIcon != null) ...[
                  Icon(
                    widget.footerIcon,
                    size: ZetaSpacing.large,
                    color: widget.enabled ? theme.colors.iconDefault : theme.colors.iconDisabled,
                  ),
                  const SizedBox(width: ZetaSpacing.minimum),
                ],
                if (_errorMessage == null && widget.footerText != null) ...[
                  Text(
                    widget.footerText!,
                    style: ZetaTextStyles.bodySmall.apply(
                      color: widget.enabled ? theme.colors.textSubtle : theme.colors.textDefault,
                    ),
                  ),
                ],
              ],
            ),
          ),
      ],
    );
  }

  OutlineInputBorder _getBorder(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: width),
      borderRadius: widget.rounded ? ZetaRadius.minimal : ZetaRadius.none,
    );
  }

  Color _getBackgroundColor(ZetaColors zetaColors) {
    if (!widget.enabled) return zetaColors.surfaceDisabled;
    if (_errorMessage != null) return zetaColors.error.surface;
    return zetaColors.surfacePrimary;
  }

  double get _inputHeight {
    switch (widget.size) {
      case ZetaWidgetSize.small:
        return ZetaSpacing.xl_4;
      case ZetaWidgetSize.medium:
        return ZetaSpacing.xl_6;
      case ZetaWidgetSize.large:
        return ZetaSpacing.xl_8;
    }
  }

  TextStyle get _textStyle =>
      (widget.size == ZetaWidgetSize.small ? ZetaTextStyles.bodyMedium : ZetaTextStyles.bodyLarge)
          .copyWith(height: 1.2);
}
