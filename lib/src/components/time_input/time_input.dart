import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../zeta_flutter.dart';
import '../buttons/input_icon_button.dart';
import '../text_input/internal_text_input.dart';

const _maxHrValue = 23;
const _max12HrValue = 12;

/// A form field used to input time.
///
/// Can be used and validated the same way as a [TextFormField].
/// {@category Components}
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=724-6821&node-type=canvas&m=dev
///
/// Widgetbook: https://zeta-ds.web.app/flutter/widgetbook/index.html#/?path=components/time-input
class ZetaTimeInput extends ZetaFormField<TimeOfDay> {
  /// Creates a new [ZetaTimeInput]
  ZetaTimeInput({
    super.key,
    super.disabled = false,
    super.initialValue,
    super.onChange,
    super.requirementLevel = ZetaFormFieldRequirement.none,
    super.validator,
    this.use24HourFormat = true,
    this.label,
    this.hintText,
    this.errorText,
    this.size = ZetaWidgetSize.medium,
    this.pickerInitialEntryMode,
    this.clearSemanticLabel,
    this.timePickerSemanticLabel,
    super.autovalidateMode,
    super.onFieldSubmitted,
    super.onSaved,
    bool? rounded,
  }) : super(
          builder: (field) {
            final _ZetaTimeInputState state = field as _ZetaTimeInputState;
            final colors = Zeta.of(field.context).colors;

            return InternalTextInput(
              label: label,
              hintText: hintText,
              constrained: true,
              errorText: field.errorText ?? errorText,
              size: size,
              placeholder: state.timeFormat,
              controller: state.controller,
              onSubmit: onFieldSubmitted != null ? (_) => onFieldSubmitted(state.value) : null,
              requirementLevel: requirementLevel,
              rounded: rounded,
              disabled: disabled,
              inputFormatters: [
                state.timeFormatter,
              ],
              suffix: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (state.controller.text.isNotEmpty)
                    InputIconButton(
                      icon: ZetaIcons.cancel,
                      semanticLabel: clearSemanticLabel,
                      onTap: state.clear,
                      disabled: disabled,
                      size: size,
                      color: colors.mainSubtle,
                    ),
                  InputIconButton(
                    icon: ZetaIcons.clock_outline,
                    semanticLabel: timePickerSemanticLabel,
                    onTap: state.pickTime,
                    disabled: disabled,
                    size: size,
                    color: colors.mainDefault,
                  ),
                ],
              ),
            );
          },
        );

  /// Changes the time input to 12 hour time.
  /// Defaults to true.
  ///
  /// If you want to set this to the device's default use `MediaQuery.of(context).alwaysUse24HourFormat`
  final bool use24HourFormat;

  /// The label for the input.
  final String? label;

  /// The hint displayed below the input.
  final String? hintText;

  /// The error displayed below the input.
  final String? errorText;

  /// The size of the input.
  final ZetaWidgetSize size;

  /// The initial entry mode of the time picker.
  final TimePickerEntryMode? pickerInitialEntryMode;

  /// Semantic label for the clear button.
  ///
  /// {@macro zeta-widget-semantic-label}
  final String? clearSemanticLabel;

  /// Semantic label for the time picker button.
  ///
  /// {@macro zeta-widget-semantic-label}
  final String? timePickerSemanticLabel;

  @override
  FormFieldState<TimeOfDay> createState() => _ZetaTimeInputState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('use12Hr', use24HourFormat))
      ..add(ObjectFlagProperty<ValueChanged<TimeOfDay?>?>.has('onChange', onChange))
      ..add(DiagnosticsProperty<TimeOfDay?>('initialValue', initialValue))
      ..add(StringProperty('label', label))
      ..add(StringProperty('hintText', hintText))
      ..add(StringProperty('errorText', errorText))
      ..add(EnumProperty<ZetaWidgetSize>('size', size))
      ..add(ObjectFlagProperty<String? Function(TimeOfDay value)?>.has('validator', validator))
      ..add(EnumProperty<TimePickerEntryMode?>('pickerInitialEntryMode', pickerInitialEntryMode))
      ..add(StringProperty('clearSemanticLabel', clearSemanticLabel))
      ..add(StringProperty('timePickerSemanticLabel', timePickerSemanticLabel));
  }
}

/// State for [ZetaTimeInput]
class _ZetaTimeInputState extends FormFieldState<TimeOfDay> {
  // TODO(UX-1032): add AM/PM selector inline.

  @override
  ZetaTimeInput get widget => super.widget as ZetaTimeInput;

  final String timeFormat = 'hh:mm'; // TODO(UX-1003): needs localizing.

  bool get _use24HourFormat => widget.use24HourFormat;

  late final MaskTextInputFormatter timeFormatter;
  final TextEditingController controller = TextEditingController();

  int get _hrsLimit => !_use24HourFormat ? _max12HrValue : _maxHrValue;

  @override
  void initState() {
    timeFormatter = MaskTextInputFormatter(
      mask: timeFormat.replaceAll(RegExp('[a-z]'), '#'),
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

  void _setValue(TimeOfDay? value) {
    final timeOfDayStr = _timeOfDayToString(value);
    timeFormatter.formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(text: timeOfDayStr),
    );
    controller.text = timeOfDayStr;
  }

  TimeOfDay? _parseValue() {
    final splitValue = timeFormatter.getMaskedText().trim().split(':');
    if (splitValue.length > 1 && splitValue[1].length > 1) {
      final hrsValue = int.tryParse(splitValue[0]);
      final minsValue = int.tryParse(splitValue[1]);
      if (hrsValue != null && minsValue != null) {
        return TimeOfDay(hour: hrsValue, minute: minsValue);
      }
    }

    return null;
  }

  String _timeOfDayToString(TimeOfDay? value) {
    if (value == null) return '';

    final hrsValue = !_use24HourFormat && value.hour > _hrsLimit ? value.hour - _hrsLimit : value.hour;

    final hrText = hrsValue.toString().padLeft(2, '0');
    final minText = value.minute.toString().padLeft(2, '0');

    return timeFormatter.maskText(hrText + minText);
  }

  void _onChange() {
    final newValue = _parseValue();
    super.didChange(newValue);
    if (newValue != value) {
      widget.onChange?.call(newValue);
    }
  }

  Future<void> pickTime() async {
    final rounded = context.rounded;
    final colors = Zeta.of(context).colors;

    final result = await showTimePicker(
      context: context,
      initialEntryMode: widget.pickerInitialEntryMode ?? TimePickerEntryMode.dial,
      initialTime: value ?? TimeOfDay.now(),
      builder: (BuildContext _, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              dialBackgroundColor: colors.surfacePrimarySubtle,
              dayPeriodColor: colors.mainPrimary,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(rounded ? Zeta.of(context).radius.rounded : Zeta.of(context).radius.none),
              ),
              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.all(rounded ? Zeta.of(context).radius.minimal : Zeta.of(context).radius.none),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: _use24HourFormat),
            child: child!,
          ),
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
    properties
      ..add(StringProperty('timeFormat', timeFormat))
      ..add(DiagnosticsProperty<MaskTextInputFormatter>('timeFormatter', timeFormatter))
      ..add(DiagnosticsProperty<TextEditingController>('controller', controller));
  }
}
