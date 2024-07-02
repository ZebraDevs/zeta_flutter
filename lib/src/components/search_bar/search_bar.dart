import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

/// ZetaSearchBar provides input field for searching.
class ZetaSearchBar extends StatefulWidget {
  /// Constructor for [ZetaSearchBar].
  const ZetaSearchBar({
    super.key,
    this.size,
    this.shape,
    this.hint,
    this.initialValue,
    this.onChanged,
    this.onSpeechToText,
    this.disabled = false,
    this.showLeadingIcon = true,
    this.showSpeechToText = true,
    @Deprecated('Use disabled instead. ' 'enabled is deprecated as of 0.11.0') bool enabled = true,
  });

  /// Determines the size of the input field.
  /// Default is [ZetaWidgetSize.large]
  final ZetaWidgetSize? size;

  /// Determines the shape of the input field.
  /// Default is [ZetaWidgetBorder.rounded]
  final ZetaWidgetBorder? shape;

  /// If provided, displays a hint inside the input field.
  /// Default is `Search`.
  final String? hint;

  /// The initial value.
  final String? initialValue;

  /// A callback, which provides the entered text.
  final void Function(String?)? onChanged;

  /// A callback, which is invoked when the microphone button is pressed.
  final Future<String?> Function()? onSpeechToText;

  /// {@macro zeta-widget-disabled}
  final bool disabled;

  /// Determines if there should be a leading icon.
  /// Default is `true`.
  final bool showLeadingIcon;

  /// Determines if there should be a Speech-To-Text button.
  /// Default is `true`.
  final bool showSpeechToText;

  @override
  State<ZetaSearchBar> createState() => _ZetaSearchBarState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<ZetaWidgetSize>('size', size))
      ..add(EnumProperty<ZetaWidgetBorder>('shape', shape))
      ..add(StringProperty('hint', hint))
      ..add(DiagnosticsProperty<bool>('enabled', disabled))
      ..add(ObjectFlagProperty<void Function(String? p1)?>.has('onChanged', onChanged))
      ..add(StringProperty('initialValue', initialValue))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onSpeechToText', onSpeechToText))
      ..add(DiagnosticsProperty<bool>('showLeadingIcon', showLeadingIcon))
      ..add(DiagnosticsProperty<bool>('showSpeechToText', showSpeechToText));
  }
}

class _ZetaSearchBarState extends State<ZetaSearchBar> {
  late final TextEditingController _controller;
  late ZetaWidgetSize _size;
  late ZetaWidgetBorder _shape;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? '');
    _size = widget.size ?? ZetaWidgetSize.large;
    _shape = widget.shape ?? ZetaWidgetBorder.rounded;
  }

  @override
  void didUpdateWidget(ZetaSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _size = widget.size ?? ZetaWidgetSize.large;
    _shape = widget.shape ?? ZetaWidgetBorder.rounded;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);
    final iconSize = _iconSize(_size);

    return ZetaRoundedScope(
      rounded: widget.shape != ZetaWidgetBorder.sharp,
      child: TextFormField(
        enabled: !widget.disabled,
        controller: _controller,
        keyboardType: TextInputType.text,
        onChanged: (value) => setState(() => widget.onChanged?.call(value)),
        style: ZetaTextStyles.bodyMedium,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: _inputVerticalPadding(_size),
          ),
          hintText: widget.hint ?? 'Search',
          hintStyle: ZetaTextStyles.bodyMedium.copyWith(
            color: !widget.disabled ? zeta.colors.textDefault : zeta.colors.cool.shade50,
          ),
          prefixIcon: widget.showLeadingIcon
              ? Padding(
                  padding: const EdgeInsets.only(left: ZetaSpacingBase.x2_5, right: ZetaSpacing.small),
                  child: ZetaIcon(
                    ZetaIcons.search,
                    color: !widget.disabled ? zeta.colors.cool.shade70 : zeta.colors.cool.shade50,
                    size: iconSize,
                  ),
                )
              : null,
          prefixIconConstraints: const BoxConstraints(
            minHeight: ZetaSpacing.xl_2,
            minWidth: ZetaSpacing.xl_2,
          ),
          suffixIcon: IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_controller.text.isNotEmpty && !widget.disabled) ...[
                  IconButton(
                    visualDensity: const VisualDensity(
                      horizontal: -4,
                      vertical: -4,
                    ),
                    onPressed: () {
                      setState(_controller.clear);
                      widget.onChanged?.call('');
                    },
                    icon: ZetaIcon(
                      ZetaIcons.cancel,
                      color: zeta.colors.cool.shade70,
                      size: iconSize,
                    ),
                  ),
                  if (widget.showSpeechToText)
                    SizedBox(
                      height: iconSize,
                      child: VerticalDivider(
                        color: zeta.colors.cool.shade40,
                        width: 5,
                        thickness: 1,
                      ),
                    ),
                ],
                Padding(
                  padding: const EdgeInsets.only(right: ZetaSpacing.minimum),
                  child: widget.showSpeechToText
                      ? IconButton(
                          visualDensity: const VisualDensity(
                            horizontal: -4,
                            vertical: -4,
                          ),
                          onPressed: widget.onSpeechToText == null
                              ? null
                              : () async {
                                  final text = await widget.onSpeechToText!.call();
                                  if (text != null) {
                                    setState(() => _controller.text = text);
                                    widget.onChanged?.call(text);
                                  }
                                },
                          icon: ZetaIcon(
                            ZetaIcons.microphone,
                            size: iconSize,
                          ),
                        )
                      : const Nothing(),
                ),
              ],
            ),
          ),
          suffixIconConstraints: const BoxConstraints(
            minHeight: ZetaSpacing.xl_2,
            minWidth: ZetaSpacing.xl_2,
          ),
          filled: !widget.disabled ? null : true,
          fillColor: !widget.disabled ? null : zeta.colors.cool.shade30,
          enabledBorder: _defaultInputBorder(zeta, shape: _shape),
          focusedBorder: _focusedInputBorder(zeta, shape: _shape),
          disabledBorder: _defaultInputBorder(zeta, shape: _shape),
        ),
      ),
    );
  }

  double _inputVerticalPadding(ZetaWidgetSize size) => switch (size) {
        ZetaWidgetSize.large => ZetaSpacing.medium,
        ZetaWidgetSize.medium => ZetaSpacing.small,
        ZetaWidgetSize.small => ZetaSpacing.minimum,
      };

  double _iconSize(ZetaWidgetSize size) => switch (size) {
        ZetaWidgetSize.large => ZetaSpacing.xl_2,
        ZetaWidgetSize.medium => ZetaSpacing.xl_1,
        ZetaWidgetSize.small => ZetaSpacing.large,
      };

  OutlineInputBorder _defaultInputBorder(
    Zeta zeta, {
    required ZetaWidgetBorder shape,
  }) =>
      OutlineInputBorder(
        borderRadius: _borderRadius(shape),
        borderSide: BorderSide(color: zeta.colors.cool.shade40),
      );

  OutlineInputBorder _focusedInputBorder(
    Zeta zeta, {
    required ZetaWidgetBorder shape,
  }) =>
      OutlineInputBorder(
        borderRadius: _borderRadius(shape),
        borderSide: BorderSide(color: zeta.colors.blue.shade50),
      );

  BorderRadius _borderRadius(ZetaWidgetBorder shape) => switch (shape) {
        ZetaWidgetBorder.rounded => ZetaRadius.minimal,
        ZetaWidgetBorder.full => ZetaRadius.full,
        _ => ZetaRadius.none,
      };
}
