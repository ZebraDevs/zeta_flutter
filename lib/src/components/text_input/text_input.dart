import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../zeta_flutter.dart';
import '../../interfaces/form_field.dart';

class ZetaTextInput extends StatefulWidget {
  const ZetaTextInput({
    super.key,
    this.label,
    this.hintText,
    this.placeholder,
    this.errorText,
    this.controller,
    this.onChanged,
    this.validator,
    this.suffix,
    this.prefix,
    this.size = ZetaWidgetSize.medium,
    this.rounded = true,
    this.disabled = false,
    this.inputFormatters,
    this.initialValue,
    this.prefixText,
    this.prefixTextStyle,
    this.suffixText,
    this.suffixTextStyle,
  })  : assert(initialValue == null || controller == null, 'Only one of initial value and controller can be accepted.'),
        assert(prefix == null || prefixText == null, 'Only one of prefix or prefixText can be accepted.'),
        assert(suffix == null || suffixText == null, 'Only one of suffix or suffixText can be accepted.');

  final String? label;
  final String? hintText;
  final String? placeholder;
  final String? initialValue;
  final String? errorText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final Widget? suffix;
  final String? suffixText;
  final TextStyle? suffixTextStyle;
  final Widget? prefix;
  final String? prefixText;
  final TextStyle? prefixTextStyle;
  final ZetaWidgetSize size;
  final bool rounded;
  final bool disabled;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<ZetaTextInput> createState() => ZetaTextInputState();
}

class ZetaTextInputState extends State<ZetaTextInput> implements ZetaFormField {
  late final TextEditingController _controller;
  final GlobalKey<FormFieldState<String>> _key = GlobalKey();
  ZetaColors get _colors => Zeta.of(context).colors;

  bool _hovered = false;

  String? _errorText;

  Color get _backgroundColor {
    if (widget.disabled) {
      return _colors.surfaceDisabled;
    }
    if (_errorText != null) {
      return _colors.error.shade10;
    }
    return _colors.surfacePrimary;
  }

  TextStyle get _baseTextStyle {
    TextStyle style = ZetaTextStyles.bodyMedium;
    if (widget.size == ZetaWidgetSize.small) {
      style = ZetaTextStyles.bodyXSmall;
    }
    return style;
  }

  TextStyle get _labelStyle {
    Color color = _colors.textSubtle;
    if (widget.disabled) {
      color = _colors.textDisabled;
    }
    return _baseTextStyle.copyWith(color: color);
  }

  EdgeInsets get _contentPadding {
    switch (widget.size) {
      case ZetaWidgetSize.large:
        return const EdgeInsets.symmetric(horizontal: ZetaSpacing.x3, vertical: ZetaSpacing.x4);
      case ZetaWidgetSize.small:
      case ZetaWidgetSize.medium:
        return const EdgeInsets.symmetric(horizontal: ZetaSpacing.x3, vertical: ZetaSpacing.x3);
    }
  }

  BoxConstraints get _affixConstraints {
    late final double size;
    switch (widget.size) {
      case ZetaWidgetSize.large:
        size = ZetaSpacing.x10;
      case ZetaWidgetSize.medium:
        size = ZetaSpacing.x8;
      case ZetaWidgetSize.small:
        size = ZetaSpacing.x6;
    }
    return BoxConstraints(
      maxHeight: size,
      minWidth: size,
    );
  }

  Widget? get _prefix {
    Widget? child;
    if (widget.prefix != null) child = widget.prefix;
    if (widget.prefixText != null) {
      final style = widget.prefixTextStyle ?? _labelStyle;
      child = Text(
        widget.prefixText!,
        style: style,
        textAlign: TextAlign.end,
      );
    }

    if (child != null) {
      child = Padding(
        padding: const EdgeInsets.only(left: ZetaSpacing.x3, right: ZetaSpacing.x2),
        child: child,
      );
    }
    return child;
  }

  Widget? get _suffix {
    if (widget.suffix != null) return widget.suffix;
    if (widget.suffixText != null) {
      final style = widget.suffixTextStyle ?? _labelStyle;
      return Text(
        widget.suffixText!,
        style: style,
      );
    }

    return null;
  }

  OutlineInputBorder get _baseBorder => OutlineInputBorder(
        borderRadius: widget.rounded ? ZetaRadius.minimal : ZetaRadius.none,
        borderSide: BorderSide(color: _hovered ? _colors.borderSelected : _colors.borderSubtle),
      );

  OutlineInputBorder get _focusedBorder => _baseBorder.copyWith(
        borderSide: BorderSide(color: _colors.primary.shade50, width: ZetaSpacing.x0_5),
      ); // TODO(mikecoomber): change to colors.borderPrimary when added

  OutlineInputBorder get _errorBorder => _baseBorder.copyWith(
        borderSide: BorderSide(color: _colors.error, width: ZetaSpacing.x0_5),
      );

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }
    super.initState();
  }

  @override
  bool validate() => _key.currentState?.validate() ?? false;

  @override
  void reset() => _key.currentState?.reset();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: _labelStyle,
          ),
          const SizedBox(height: ZetaSpacing.x2),
        ],
        MouseRegion(
          onEnter: !widget.disabled
              ? (_) => setState(() {
                    _hovered = true;
                  })
              : null,
          onExit: !widget.disabled
              ? (_) => setState(() {
                    _hovered = false;
                  })
              : null,
          child: TextFormField(
            enabled: !widget.disabled,
            key: _key,
            controller: _controller,
            inputFormatters: widget.inputFormatters,
            validator: (val) {
              setState(() {
                _errorText = widget.validator?.call(val);
              });
              return _errorText;
            },
            textAlignVertical: TextAlignVertical.center,
            onChanged: widget.onChanged,
            style: _baseTextStyle,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: _contentPadding,
              filled: true,
              prefixIcon: _prefix,
              prefixIconConstraints: _affixConstraints,
              suffixIcon: _suffix,
              suffixIconConstraints: _affixConstraints,
              focusColor: _backgroundColor,
              hoverColor: _backgroundColor,
              fillColor: _backgroundColor,
              enabledBorder: _baseBorder,
              disabledBorder: _baseBorder,
              focusedBorder: _focusedBorder,
              focusedErrorBorder: _errorBorder,
              errorBorder: _errorBorder,
              hintText: widget.placeholder,
              hintStyle: _baseTextStyle,
              errorStyle: const TextStyle(height: 0),
            ),
          ),
        ),
        _HintText(
          disabled: widget.disabled,
          rounded: widget.rounded,
          hintText: widget.hintText,
          errorText: _errorText,
        ),
      ],
    );
  }
}

class _HintText extends StatelessWidget {
  const _HintText({
    required this.disabled,
    required this.hintText,
    required this.errorText,
    required this.rounded,
  });
  final bool disabled;
  final bool rounded;
  final String? hintText;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    final error = errorText != null && errorText!.isNotEmpty;

    final text = error ? errorText : hintText;

    Color elementColor = colors.textSubtle;

    if (disabled) {
      elementColor = colors.textDisabled;
    } else if (error) {
      elementColor = colors.error;
    }

    if (text == null) {
      return const SizedBox();
    }

    return Row(
      children: [
        Icon(
          errorText != null
              ? rounded
                  ? ZetaIcons.error_round
                  : ZetaIcons.error_sharp
              : rounded
                  ? ZetaIcons.info_round
                  : ZetaIcons.info_sharp,
          size: ZetaSpacing.x4,
          color: elementColor,
        ),
        const SizedBox(
          width: ZetaSpacing.x1,
        ),
        Expanded(
          child: Text(
            text,
            style: ZetaTextStyles.bodyXSmall.copyWith(color: elementColor),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ).paddingTop(ZetaSpacing.x2);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('disabled', disabled))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(StringProperty('hintText', hintText))
      ..add(StringProperty('errorText', errorText));
  }
}
