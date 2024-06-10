import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../zeta_flutter.dart';
import '../../interfaces/form_field.dart';
import '../buttons/input_icon_button.dart';

const _maxHrValue = 23;
const _max12HrValue = 12;
const _maxMinsValue = 59;

/// A form field used to input time.
///
/// Can be used and validated the same way as a [TextFormField]
class ZetaTimeInput extends ZetaFormField<TimeOfDay> {
  /// Creates a new [ZetaTimeInput]
  const ZetaTimeInput({
    super.key,
    super.disabled = false,
    super.initialValue,
    super.onChange,
    super.requirementLevel = ZetaFormFieldRequirement.none,
    this.rounded = true,
    this.use12Hr,
    this.label,
    this.hintText,
    this.errorText,
    this.validator,
    this.size = ZetaWidgetSize.medium,
    this.pickerInitialEntryMode,
  });

  /// {@macro zeta-component-rounded}
  final bool rounded;

  /// Changes the time input to 12 hour time.
  /// Uses the device default if not set.
  final bool? use12Hr;

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

  /// The validator passed to the text input.
  /// Returns a string containing an error message.
  ///
  /// By default, the input checks for invalid hour or minute values.
  /// It also checks for null values unless [requirementLevel] is set to [ZetaFormFieldRequirement.optional]
  ///
  /// If the default validation fails, [errorText] will be shown.
  /// However, if [validator] catches any of these conditions, the return value of [validator] will be shown.
  final String? Function(TimeOfDay? value)? validator;

  @override
  State<ZetaTimeInput> createState() => ZetaTimeInputState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<bool>('use12Hr', use12Hr))
      ..add(ObjectFlagProperty<ValueChanged<TimeOfDay?>?>.has('onChange', onChange))
      ..add(DiagnosticsProperty<TimeOfDay?>('initialValue', initialValue))
      ..add(DiagnosticsProperty<bool>('disabled', disabled))
      ..add(StringProperty('label', label))
      ..add(StringProperty('hintText', hintText))
      ..add(StringProperty('errorText', errorText))
      ..add(EnumProperty<ZetaWidgetSize>('size', size))
      ..add(ObjectFlagProperty<String? Function(TimeOfDay value)?>.has('validator', validator))
      ..add(EnumProperty<TimePickerEntryMode?>('pickerInitialEntryMode', pickerInitialEntryMode));
  }
}

/// State for [ZetaTimeInput]
class ZetaTimeInputState extends State<ZetaTimeInput> implements ZetaFormFieldState {
  // TODO(mikecoomber): add AM/PM selector inline.

  ZetaColors get _colors => Zeta.of(context).colors;

  final _timeFormat = 'hh:mm'; // TODO(UX-1003): needs localizing.
  late final MaskTextInputFormatter _timeFormatter;

  bool _firstBuildComplete = false;
  bool get _use12Hr => widget.use12Hr ?? !MediaQuery.of(context).alwaysUse24HourFormat;

  final _controller = TextEditingController();
  final GlobalKey<ZetaTextInputState> _key = GlobalKey();

  String? _errorText;

  bool get _showClearButton => _controller.text.isNotEmpty;

  BorderRadius get _borderRadius => widget.rounded ? ZetaRadius.minimal : ZetaRadius.none;

  int get _hrsLimit => _use12Hr ? _max12HrValue : _maxHrValue;
  final int _minsLimit = _maxMinsValue;

  TimeOfDay? get _value {
    final splitValue = _timeFormatter.getMaskedText().trim().split(':');
    if (splitValue.length > 1) {
      final hrsValue = int.tryParse(splitValue[0]);
      final minsValue = int.tryParse(splitValue[1]);
      if (hrsValue != null && minsValue != null) {
        return TimeOfDay(hour: hrsValue, minute: minsValue);
      }
    }
    return null;
  }

  @override
  void initState() {
    _timeFormatter = MaskTextInputFormatter(
      mask: _timeFormat.replaceAll(RegExp('[a-z]'), '#'),
      filter: {'#': RegExp('[0-9]')},
      type: MaskAutoCompletionType.eager,
    );

    if (widget.initialValue != null) {
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
    if (_timeFormatter.getUnmaskedText().length > (_timeFormat.length - 2) &&
        (_key.currentState?.validate() ?? false)) {
      widget.onChange?.call(_value);
    }
    setState(() {});
  }

  void _setText(TimeOfDay value) {
    final hrsValue = _use12Hr && value.hour > _hrsLimit ? value.hour - _hrsLimit : value.hour;

    final hrText = hrsValue.toString().padLeft(2, '0');
    final minText = value.minute.toString().padLeft(2, '0');

    _controller.text = _timeFormatter.maskText(hrText + minText);
    _timeFormatter.formatEditUpdate(TextEditingValue.empty, _controller.value);
  }

  Future<void> _pickTime() async {
    final result = await showTimePicker(
      context: context,
      initialEntryMode: widget.pickerInitialEntryMode ?? TimePickerEntryMode.dial,
      initialTime: _value ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              dialBackgroundColor: _colors.warm.shade30,
              dayPeriodColor: _colors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: widget.rounded ? ZetaRadius.rounded : ZetaRadius.none,
              ),
              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: _borderRadius,
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: !_use12Hr),
            child: child!,
          ),
        );
      },
    );
    if (result != null) {
      _setText(result);
    }
  }

  @override
  void reset() {
    _timeFormatter.clear();
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
    if (!_firstBuildComplete && widget.initialValue != null) {
      _setText(widget.initialValue!);
      _firstBuildComplete = true;
    }
    return ZetaTextInput(
      disabled: widget.disabled,
      key: _key,
      size: widget.size,
      errorText: _errorText,
      rounded: widget.rounded,
      label: widget.label,
      hintText: widget.hintText,
      placeholder: _timeFormat,
      controller: _controller,
      inputFormatters: [
        _timeFormatter,
      ],
      validator: (_) {
        String? errorText;
        final customValidation = widget.validator?.call(_value);
        if ((_value == null && widget.requirementLevel != ZetaFormFieldRequirement.optional) ||
            (_value != null && (_value!.hour > _hrsLimit || _value!.minute > _minsLimit)) ||
            customValidation != null) {
          errorText = customValidation ?? widget.errorText ?? '';
        }

        setState(() {
          _errorText = errorText;
        });
        return errorText;
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
            icon: widget.rounded ? ZetaIcons.clock_outline_round : ZetaIcons.clock_outline_sharp,
            onTap: _pickTime,
            disabled: widget.disabled,
            size: widget.size,
            color: _colors.iconDefault,
          ),
        ],
      ),
    );
  }
}
