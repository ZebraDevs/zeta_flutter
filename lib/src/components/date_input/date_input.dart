import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../zeta_flutter.dart';
import '../../interfaces/form_field.dart';
import '../buttons/input_icon_button.dart';

/// A form field used to input dates.
///
/// Can be used and validated the same way as a [TextFormField]
class ZetaDateInput extends ZetaFormField<DateTime> {
  /// Creates a new [ZetaDateInput]
  ZetaDateInput({
    super.key,
    super.disabled = false,
    super.initialValue,
    super.onChange,
    super.requirementLevel = ZetaFormFieldRequirement.none,
    this.rounded = true,
    this.label,
    this.hintText,
    this.errorText,
    this.validator,
    this.size = ZetaWidgetSize.medium,
    this.dateFormat = 'MM/dd/yyyy',
    this.minDate,
    this.maxDate,
    this.pickerInitialEntryMode,
  }) : assert((minDate == null || maxDate == null) || minDate.isBefore(maxDate), 'minDate cannot be after maxDate');

  /// {@macro zeta-component-rounded}
  final bool rounded;

  /// The label for the input.
  final String? label;

  /// The hint displayed below the input.
  final String? hintText;

  /// The error displayed below the input.
  ///
  /// If you want to have custom error messages for different types of error, use [validator].
  final String? errorText;

  /// The format the given date should be in
  /// https://pub.dev/documentation/intl/latest/intl/DateFormat-class.html
  final String dateFormat;

  /// The size of the input.
  final ZetaWidgetSize size;

  /// The minimum date allowed by the date input.
  final DateTime? minDate;

  /// The maximum date allowed by the date input.
  final DateTime? maxDate;

  /// The initial entry mode of the date picker.
  final DatePickerEntryMode? pickerInitialEntryMode;

  /// The validator passed to the text input.
  /// Returns a string containing an error message.
  ///
  /// By default, the form field checks for if the date is within [minDate] and [maxDate] (if given).
  /// It also checks for null values unless [requirementLevel] is set to [ZetaFormFieldRequirement.optional]
  ///
  /// If the default validation fails, [errorText] will be shown.
  /// However, if [validator] catches any of these conditions, the return value of [validator] will be shown.
  final String? Function(DateTime? value)? validator;

  @override
  State<ZetaDateInput> createState() => ZetaDateInputState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(ObjectFlagProperty<ValueChanged<DateTime?>?>.has('onChange', onChange))
      ..add(DiagnosticsProperty<DateTime?>('initialValue', initialValue))
      ..add(DiagnosticsProperty<bool>('disabled', disabled))
      ..add(StringProperty('label', label))
      ..add(StringProperty('hintText', hintText))
      ..add(StringProperty('errorText', errorText))
      ..add(EnumProperty<ZetaWidgetSize>('size', size))
      ..add(ObjectFlagProperty<String? Function(DateTime value)?>.has('validator', validator))
      ..add(StringProperty('dateFormat', dateFormat))
      ..add(DiagnosticsProperty<DateTime?>('minDate', minDate))
      ..add(DiagnosticsProperty<DateTime?>('maxDate', maxDate))
      ..add(EnumProperty<DatePickerEntryMode?>('pickerInitialEntryMode', pickerInitialEntryMode));
  }
}

/// State for [ZetaDateInput]
class ZetaDateInputState extends State<ZetaDateInput> implements ZetaFormFieldState {
  // TODO(mikecoomber): add AM/PM selector inline.

  ZetaColors get _colors => Zeta.of(context).colors;

  late final MaskTextInputFormatter _dateFormatter;

  final _controller = TextEditingController();
  final GlobalKey<ZetaTextInputState> _key = GlobalKey();

  String? _errorText;

  bool get _showClearButton => _controller.text.isNotEmpty;

  DateTime? get _value {
    final value = _dateFormatter.getMaskedText().trim();
    final date = DateFormat(widget.dateFormat).tryParseStrict(value);

    return date;
  }

  @override
  void initState() {
    _dateFormatter = MaskTextInputFormatter(
      mask: widget.dateFormat.replaceAll(RegExp('[A-Za-z]'), '#'),
      filter: {'#': RegExp('[0-9]')},
      type: MaskAutoCompletionType.eager,
    );

    if (widget.initialValue != null) {
      _setText(widget.initialValue!);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _key.currentState?.validate();
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChange() {
    if (_dateFormatter.getMaskedText().length == widget.dateFormat.length && (_key.currentState?.validate() ?? false)) {
      widget.onChange?.call(_value);
    }
    setState(() {});
  }

  void _setText(DateTime value) {
    _controller.text = DateFormat(widget.dateFormat).format(value);
    _dateFormatter.formatEditUpdate(TextEditingValue.empty, _controller.value);
  }

  Future<void> _pickDate() async {
    final firstDate = widget.minDate ?? DateTime(0000);
    final lastDate = widget.maxDate ?? DateTime(3000);
    DateTime fallbackDate = DateTime.now();

    if (fallbackDate.isBefore(firstDate) || fallbackDate.isAfter(lastDate)) {
      fallbackDate = firstDate;
    }

    late final DateTime initialDate;

    if (_value == null || (_value != null && _value!.isBefore(firstDate) || _value!.isAfter(lastDate))) {
      initialDate = fallbackDate;
    } else {
      initialDate = _value!;
    }

    final result = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
      initialEntryMode: widget.pickerInitialEntryMode ?? DatePickerEntryMode.calendar,
      initialDate: initialDate,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            dividerTheme: DividerThemeData(color: _colors.borderSubtle),
            datePickerTheme: DatePickerThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: widget.rounded ? ZetaRadius.rounded : ZetaRadius.none,
              ),
              headerHeadlineStyle: ZetaTextStyles.titleLarge,
              headerHelpStyle: ZetaTextStyles.labelLarge,
              dividerColor: _colors.borderSubtle,
              dayStyle: ZetaTextStyles.bodyMedium,
            ),
          ),
          child: child!,
        );
      },
    );
    if (result != null) {
      _setText(result);
    }
  }

  @override
  void reset() {
    _dateFormatter.clear();
    _key.currentState?.reset();
    setState(() {
      _errorText = null;
    });
    _controller.clear();
    widget.onChange?.call(null);
  }

  @override
  bool validate() => _key.currentState?.validate() ?? false;

  @override
  Widget build(BuildContext context) {
    return ZetaTextInput(
      disabled: widget.disabled,
      key: _key,
      rounded: widget.rounded,
      size: widget.size,
      errorText: _errorText,
      label: widget.label,
      hintText: widget.hintText,
      placeholder: widget.dateFormat,
      controller: _controller,
      inputFormatters: [
        _dateFormatter,
      ],
      validator: (_) {
        final customValidation = widget.validator?.call(_value);
        if (_value == null ||
            (widget.minDate != null && _value!.isBefore(widget.minDate!)) ||
            (widget.maxDate != null && _value!.isAfter(widget.maxDate!)) ||
            customValidation != null) {
          setState(() {
            _errorText = customValidation ?? widget.errorText ?? '';
          });
          return '';
        }

        setState(() {
          _errorText = null;
        });
        return null;
      },
      onChange: (_) => _onChange(),
      requirementLevel: widget.requirementLevel,
      suffix: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_showClearButton)
            InputIconButton(
              icon: widget.rounded ? ZetaIcons.cancel_round : ZetaIcons.cancel_sharp,
              onTap: reset,
              disabled: widget.disabled,
              size: widget.size,
              color: _colors.iconSubtle,
            ),
          InputIconButton(
            icon: widget.rounded ? ZetaIcons.calendar_round : ZetaIcons.calendar_sharp,
            onTap: _pickDate,
            disabled: widget.disabled,
            size: widget.size,
            color: _colors.iconDefault,
          ),
        ],
      ),
    );
  }
}
