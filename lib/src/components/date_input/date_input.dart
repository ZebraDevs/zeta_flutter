import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../zeta_flutter.dart';
import '../../interfaces/form_field.dart';
import '../buttons/input_icon_button.dart';
import '../text_input/internal_text_input.dart';

/// A form field used to input dates.
///
/// Can be used and validated the same way as a [TextFormField].
/// {@category Components}
class ZetaDateInput extends ZetaFormField<DateTime> {
  /// Creates a new [ZetaDateInput]
  ZetaDateInput({
    super.key,
    super.disabled = false,
    super.initialValue,
    super.onChange,
    super.requirementLevel = ZetaFormFieldRequirement.none,
    super.validator,
    super.onFieldSubmitted,
    super.onSaved,
    super.autovalidateMode,
    bool? rounded,
    this.label,
    this.hintText,
    this.errorText,
    this.size = ZetaWidgetSize.medium,
    this.dateFormat = 'MM/dd/yyyy',
    this.pickerInitialEntryMode,
    this.datePickerSemanticLabel,
    this.minDate,
    this.maxDate,
    this.clearSemanticLabel,
  }) : super(
          builder: (field) {
            final _ZetaDateInputState state = field as _ZetaDateInputState;
            final colors = Zeta.of(field.context).colors;

            return InternalTextInput(
              label: label,
              hintText: hintText,
              errorText: field.errorText ?? errorText,
              size: size,
              placeholder: dateFormat,
              controller: state.controller,
              onSubmit: onFieldSubmitted != null ? (_) => onFieldSubmitted(field.value) : null,
              requirementLevel: requirementLevel,
              rounded: rounded,
              disabled: disabled,
              inputFormatters: [
                state._dateFormatter,
              ],
              suffix: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (state.controller.text.isNotEmpty)
                    InputIconButton(
                      icon: ZetaIcons.cancel,
                      onTap: state.clear,
                      disabled: disabled,
                      size: size,
                      color: colors.main.subtle,
                      semanticLabel: clearSemanticLabel,
                    ),
                  InputIconButton(
                    icon: ZetaIcons.calendar,
                    onTap: state.pickDate,
                    disabled: disabled,
                    size: size,
                    color: colors.main.defaultColor,
                    semanticLabel: datePickerSemanticLabel,
                  ),
                ],
              ),
            );
          },
        );

  /// The label for the input.
  final String? label;

  /// The hint displayed below the input.
  final String? hintText;

  /// The error displayed below the input.
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

  /// The semantic label for the clear button.
  ///
  /// {@macro zeta-widget-semantic-label}
  final String? clearSemanticLabel;

  /// The semantic label for the calendar button.
  ///
  /// {@macro zeta-widget-semantic-label}
  final String? datePickerSemanticLabel;

  @override
  FormFieldState<DateTime> createState() => _ZetaDateInputState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<ValueChanged<DateTime?>?>.has('onChange', onChange))
      ..add(DiagnosticsProperty<DateTime?>('initialValue', initialValue))
      ..add(StringProperty('label', label))
      ..add(StringProperty('hintText', hintText))
      ..add(StringProperty('errorText', errorText))
      ..add(EnumProperty<ZetaWidgetSize>('size', size))
      ..add(ObjectFlagProperty<String? Function(DateTime value)?>.has('validator', validator))
      ..add(StringProperty('dateFormat', dateFormat))
      ..add(EnumProperty<DatePickerEntryMode?>('pickerInitialEntryMode', pickerInitialEntryMode))
      ..add(StringProperty('semanticCalendar', datePickerSemanticLabel))
      ..add(StringProperty('semanticClear', clearSemanticLabel))
      ..add(DiagnosticsProperty<DateTime?>('minDate', minDate))
      ..add(DiagnosticsProperty<DateTime?>('maxDate', maxDate));
  }
}

/// State for [ZetaDateInput]
class _ZetaDateInputState extends FormFieldState<DateTime> {
  late final MaskTextInputFormatter _dateFormatter;

  @override
  ZetaDateInput get widget => super.widget as ZetaDateInput;

  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    _dateFormatter = MaskTextInputFormatter(
      mask: widget.dateFormat.replaceAll(RegExp('[A-Za-z]'), '#'),
      filter: {'#': RegExp('[0-9]')},
      type: MaskAutoCompletionType.eager,
    );

    _setValue(widget.initialValue);
    controller.addListener(_onChange);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void reset() {
    _setValue(widget.initialValue);
    super.reset();
  }

  void clear() {
    _setValue(null);
  }

  void _setValue(DateTime? value) {
    final dateTimeStr = _dateTimeToString(value);
    _dateFormatter.formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(text: dateTimeStr),
    );
    controller.text = dateTimeStr;
  }

  DateTime? _parseValue() {
    final value = _dateFormatter.getMaskedText().trim();
    final date = DateFormat(widget.dateFormat).tryParseStrict(value);

    return date;
  }

  String _dateTimeToString(DateTime? value) {
    return value != null ? DateFormat(widget.dateFormat).format(value) : '';
  }

  void _onChange() {
    final newValue = _parseValue();
    widget.onChange?.call(newValue);
    super.didChange(newValue);
  }

  Future<void> pickDate() async {
    final colors = Zeta.of(context).colors;

    final firstDate = widget.minDate ?? DateTime(0000);
    final lastDate = widget.maxDate ?? DateTime(3000);
    DateTime fallbackDate = DateTime.now();

    if (fallbackDate.isBefore(firstDate) || fallbackDate.isAfter(lastDate)) {
      fallbackDate = firstDate;
    }

    late final DateTime initialDate;

    if (value == null || (value != null && value!.isBefore(firstDate) || value!.isAfter(lastDate))) {
      initialDate = fallbackDate;
    } else {
      initialDate = value!;
    }
    final rounded = context.rounded;

    final result = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
      initialEntryMode: widget.pickerInitialEntryMode ?? DatePickerEntryMode.calendar,
      initialDate: initialDate,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            dividerTheme: DividerThemeData(color: colors.border.subtle),
            datePickerTheme: DatePickerThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: rounded ? Zeta.of(context).radii.rounded : Zeta.of(context).radii.none,
              ),
              headerHeadlineStyle: ZetaTextStyles.titleLarge,
              headerHelpStyle: ZetaTextStyles.labelLarge,
              dividerColor: colors.border.subtle,
              dayStyle: ZetaTextStyles.bodyMedium,
            ),
          ),
          child: child!,
        );
      },
    );
    if (result != null) {
      _setValue(result);
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextEditingController>('controller', controller));
  }
}
