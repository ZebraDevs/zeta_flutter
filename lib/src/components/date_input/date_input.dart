import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../zeta_flutter.dart';

/// [ZetaDateInput] size
enum ZetaDateInputSize {
  /// [large] 48 pixels height of the input field.
  large,

  /// [medium] 40 pixels height of the input field.
  medium,

  /// [small] 32 pixels height of the input field.
  small,
}

/// ZetaDateInput allows entering date in a pre-defined format.
/// Validation is performed to make sure the date is valid
/// and is in the proper format.
class ZetaDateInput extends StatefulWidget {
  /// Constructor for [ZetaDateInput].
  ///
  /// Example usage how to provide custom validanions
  /// via `onChanged`, `hasError` and `errorText`:
  /// ```dart
  /// ZetaDateInput(
  ///   label: 'Birthdate',
  ///   hint: 'Enter birthdate',
  ///   hasError: _errorText != null,
  ///   errorText: _errorText ?? 'Invalid date',
  ///   onChanged: (value) {
  ///     if (value == null) return setState(() => _errorText = null);
  ///     final now = DateTime.now();
  ///     setState(
  ///       () => _errorText = value.difference(
  ///         DateTime(now.year, now.month, now.day)).inDays > 0
  ///           ? 'Birthdate cannot be in the future'
  ///           : null,
  ///     );
  ///   },
  /// )
  /// ```
  const ZetaDateInput({
    super.key,
    this.size,
    this.label,
    this.hint,
    this.enabled = true,
    this.rounded = true,
    this.hasError = false,
    this.errorText,
    this.onChanged,
    this.datePattern = 'MM/dd/yyyy',
  });

  /// Determines the size of the input field.
  /// Default is `ZetaDateInputSize.large`
  final ZetaDateInputSize? size;

  /// If provided, displays a label above the input field.
  final String? label;

  /// If provided, displays a hint below the input field.
  final String? hint;

  /// Determines if the input field should be enabled (default) or disabled.
  final bool enabled;

  /// Determines if the input field corners are rounded (default) or sharp.
  final bool rounded;

  /// Determines if the input field should be displayed in error style.
  /// Default is `false`.
  /// If `enabled` is `false`, this has no effect.
  final bool hasError;

  /// In combination with `hasError: true`, provides the error message
  /// to be displayed below the input field.
  ///
  /// If `hasError` is false, then `errorText` should provide
  /// date validation error message.
  ///
  /// See the example in the [ZetaDateInput] documentation.
  final String? errorText;

  /// A callback, which provides the entered date, or `null`, if invalid.
  ///
  /// See the example in the [ZetaDateInput] documentation
  /// how to provide custom validations
  /// in combination with `hasError` and `errorText`.
  final void Function(DateTime?)? onChanged;

  /// `datePattern` is needed for the date format validation as described here:
  ///  https://pub.dev/documentation/intl/latest/intl/DateFormat-class.html
  final String datePattern;

  @override
  State<ZetaDateInput> createState() => _ZetaDateInputState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<ZetaDateInputSize>('size', size))
      ..add(StringProperty('label', label))
      ..add(StringProperty('hint', hint))
      ..add(DiagnosticsProperty<bool>('enabled', enabled))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<bool>('hasError', hasError))
      ..add(StringProperty('errorText', errorText))
      ..add(ObjectFlagProperty<void Function(DateTime? p1)?>.has('onChanged', onChanged))
      ..add(StringProperty('datePattern', datePattern));
  }
}

class _ZetaDateInputState extends State<ZetaDateInput> {
  final _controller = TextEditingController();
  late ZetaDateInputSize _size;
  late final String _hintText;
  late final MaskTextInputFormatter _dateFormatter;
  bool _invalidDate = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _hintText = widget.datePattern.toLowerCase();
    _dateFormatter = MaskTextInputFormatter(
      mask: _hintText.replaceAll(RegExp('[a-z]'), '#'),
      filter: {'#': RegExp('[0-9]')},
      type: MaskAutoCompletionType.eager,
    );
    _setParams();
  }

  @override
  void didUpdateWidget(ZetaDateInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setParams();
  }

  void _setParams() {
    _size = widget.size ?? ZetaDateInputSize.large;
    _hasError = widget.hasError;
  }

  void _onChanged() {
    final value = _dateFormatter.getMaskedText().trim();
    final date = DateFormat(widget.datePattern).tryParseStrict(value);
    _invalidDate = value.isNotEmpty && date == null;
    widget.onChanged?.call(date);
    setState(() {});
  }

  void _clear() {
    _controller.clear();
    setState(() {
      _invalidDate = false;
      _hasError = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);
    final hasError = _invalidDate || _hasError;
    final showError = hasError && widget.errorText != null;
    final hintErrorColor = widget.enabled
        ? showError
            ? zeta.colors.red
            : zeta.colors.cool.shade70
        : zeta.colors.cool.shade50;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              widget.label!,
              style: ZetaTextStyles.bodyMedium.copyWith(
                color: widget.enabled ? zeta.colors.textDefault : zeta.colors.cool.shade50,
              ),
            ),
          ),
        TextFormField(
          enabled: widget.enabled,
          controller: _controller,
          inputFormatters: [_dateFormatter],
          keyboardType: TextInputType.number,
          onChanged: (_) => _onChanged(),
          style: _size == ZetaDateInputSize.small ? ZetaTextStyles.bodyXSmall : ZetaTextStyles.bodyMedium,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: _inputVerticalPadding(_size),
            ),
            hintText: _hintText,
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_controller.text.isNotEmpty)
                  IconButton(
                    visualDensity: const VisualDensity(
                      horizontal: -4,
                      vertical: -4,
                    ),
                    onPressed: _clear,
                    icon: Icon(
                      widget.rounded ? ZetaIcons.cancel_round : ZetaIcons.cancel_sharp,
                      color: zeta.colors.cool.shade70,
                      size: _iconSize(_size),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 6, right: 10),
                  child: Icon(
                    widget.rounded ? ZetaIcons.calendar_3_day_round : ZetaIcons.calendar_3_day_sharp,
                    color: widget.enabled ? zeta.colors.textDefault : zeta.colors.cool.shade50,
                    size: _iconSize(_size),
                  ),
                ),
              ],
            ),
            suffixIconConstraints: const BoxConstraints(
              minHeight: ZetaSpacing.m,
              minWidth: ZetaSpacing.m,
            ),
            hintStyle: _size == ZetaDateInputSize.small
                ? ZetaTextStyles.bodyXSmall.copyWith(
                    color: widget.enabled ? zeta.colors.textDefault : zeta.colors.cool.shade50,
                  )
                : ZetaTextStyles.bodyMedium.copyWith(
                    color: widget.enabled ? zeta.colors.textDefault : zeta.colors.cool.shade50,
                  ),
            filled: !widget.enabled || hasError ? true : null,
            fillColor: widget.enabled
                ? hasError
                    ? zeta.colors.red.shade10
                    : null
                : zeta.colors.cool.shade30,
            enabledBorder: hasError
                ? _errorInputBorder(zeta, rounded: widget.rounded)
                : _defaultInputBorder(zeta, rounded: widget.rounded),
            focusedBorder: hasError
                ? _errorInputBorder(zeta, rounded: widget.rounded)
                : _focusedInputBorder(zeta, rounded: widget.rounded),
            disabledBorder: _defaultInputBorder(zeta, rounded: widget.rounded),
            errorBorder: _errorInputBorder(zeta, rounded: widget.rounded),
            focusedErrorBorder: _errorInputBorder(zeta, rounded: widget.rounded),
          ),
        ),
        if (widget.hint != null || showError)
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    showError && widget.enabled
                        ? (widget.rounded ? ZetaIcons.error_round : ZetaIcons.error_sharp)
                        : (widget.rounded ? ZetaIcons.info_round : ZetaIcons.info_sharp),
                    size: ZetaSpacing.b,
                    color: hintErrorColor,
                  ),
                ),
                Expanded(
                  child: Text(
                    showError && widget.enabled ? widget.errorText! : widget.hint!,
                    style: ZetaTextStyles.bodyXSmall.copyWith(
                      color: hintErrorColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  double _inputVerticalPadding(ZetaDateInputSize size) => switch (size) {
        ZetaDateInputSize.large => ZetaSpacing.x3,
        ZetaDateInputSize.medium => ZetaSpacing.x2,
        ZetaDateInputSize.small => ZetaSpacing.x2,
      };

  double _iconSize(ZetaDateInputSize size) => switch (size) {
        ZetaDateInputSize.large => ZetaSpacing.x6,
        ZetaDateInputSize.medium => ZetaSpacing.x5,
        ZetaDateInputSize.small => ZetaSpacing.x4,
      };

  OutlineInputBorder _defaultInputBorder(
    Zeta zeta, {
    required bool rounded,
  }) =>
      OutlineInputBorder(
        borderRadius: rounded ? ZetaRadius.minimal : ZetaRadius.none,
        borderSide: BorderSide(color: zeta.colors.cool.shade40),
      );

  OutlineInputBorder _focusedInputBorder(
    Zeta zeta, {
    required bool rounded,
  }) =>
      OutlineInputBorder(
        borderRadius: rounded ? ZetaRadius.minimal : ZetaRadius.none,
        borderSide: BorderSide(color: zeta.colors.blue.shade50),
      );

  OutlineInputBorder _errorInputBorder(
    Zeta zeta, {
    required bool rounded,
  }) =>
      OutlineInputBorder(
        borderRadius: rounded ? ZetaRadius.minimal : ZetaRadius.none,
        borderSide: BorderSide(color: zeta.colors.red.shade50),
      );
}
