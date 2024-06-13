import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../zeta_flutter.dart';
import 'countries.dart';
import 'countries_dialog.dart';

/// ZetaPhoneInput allows entering phone numbers.
class ZetaPhoneInput extends ZetaStatefulWidget {
  /// Constructor for [ZetaPhoneInput].
  const ZetaPhoneInput({
    super.key,
    super.rounded,
    this.label,
    this.hint,
    this.enabled = true,
    this.hasError = false,
    this.errorText,
    this.onChanged,
    this.countryDialCode,
    this.phoneNumber,
    this.countries,
    this.countrySearchHint,
    this.useRootNavigator = true,
  });

  /// If provided, displays a label above the input field.
  final String? label;

  /// If provided, displays a hint below the input field.
  final String? hint;

  /// Determines if the inputs should be enabled (default) or disabled.
  final bool enabled;

  /// Determines if the input field should be displayed in error style.
  /// Default is `false`.
  /// If `enabled` is `false`, this has no effect.
  final bool hasError;

  /// In combination with `hasError: true`, provides the error message
  /// to be displayed below the input field.
  final String? errorText;

  /// A callback, which provides the entered phone number.
  final void Function(Map<String, String>?)? onChanged;

  /// The initial value for the country dial code including leading +
  final String? countryDialCode;

  /// The initial value for the phone number
  final String? phoneNumber;

  /// List of countries ISO 3166-1 alpha-2 codes
  final List<String>? countries;

  /// The hint to be shown inside the country search input field.
  /// Default is `Search by name or dial code`.
  final String? countrySearchHint;

  /// Determines if the root navigator should be used in the [CountriesDialog].
  final bool useRootNavigator;

  @override
  State<ZetaPhoneInput> createState() => _ZetaPhoneInputState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('label', label))
      ..add(StringProperty('hint', hint))
      ..add(DiagnosticsProperty<bool>('enabled', enabled))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<bool>('hasError', hasError))
      ..add(StringProperty('errorText', errorText))
      ..add(ObjectFlagProperty<void Function(Map<String, String>? p1)?>.has('onChanged', onChanged))
      ..add(StringProperty('countryDialCode', countryDialCode))
      ..add(StringProperty('phoneNumber', phoneNumber))
      ..add(IterableProperty<String>('countries', countries))
      ..add(DiagnosticsProperty<bool>('useRootNavigator', useRootNavigator))
      ..add(StringProperty('countrySearchHint', countrySearchHint));
  }
}

class _ZetaPhoneInputState extends State<ZetaPhoneInput> {
  bool _hasError = false;
  late List<Country> _countries;
  late Country _selectedCountry;
  late String _phoneNumber;

  @override
  void initState() {
    super.initState();
    _countries = widget.countries?.isEmpty ?? true
        ? Countries.list
        : Countries.list.where((country) => widget.countries!.contains(country.isoCode)).toList();
    if (_countries.isNotEmpty && (widget.countries?.isNotEmpty ?? false)) {
      _countries.sort(
        (a, b) => widget.countries!.indexOf(a.isoCode).compareTo(
              widget.countries!.indexOf(b.isoCode),
            ),
      );
    }
    if (_countries.isEmpty) _countries = Countries.list;
    _selectedCountry = _countries.firstWhereOrNull(
          (country) => country.dialCode == widget.countryDialCode,
        ) ??
        _countries.first;
    _phoneNumber = widget.phoneNumber ?? '';
    _hasError = widget.hasError;
  }

  @override
  void didUpdateWidget(ZetaPhoneInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    _hasError = widget.hasError;
  }

  void _onChanged({Country? selectedCountry, String? phoneNumber}) {
    setState(() {
      if (selectedCountry != null) _selectedCountry = selectedCountry;
      if (phoneNumber != null) _phoneNumber = phoneNumber;
    });
    widget.onChanged?.call(
      _phoneNumber.isEmpty
          ? {}
          : {
              'countryDialCode': _selectedCountry.dialCode,
              'phoneNumber': _phoneNumber,
            },
    );
  }

  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);
    final showError = _hasError && widget.errorText != null;
    final rounded = context.rounded;
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
        SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              SizedBox(
                width: ZetaSpacing.xl_9,
                height: ZetaSpacing.xl_8,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: widget.enabled ? zeta.colors.surfacePrimary : zeta.colors.cool.shade30,
                    borderRadius: rounded
                        ? const BorderRadius.only(
                            topLeft: Radius.circular(ZetaSpacing.minimum),
                            bottomLeft: Radius.circular(ZetaSpacing.minimum),
                          )
                        : ZetaRadius.none,
                    border: Border(
                      top: BorderSide(color: zeta.colors.cool.shade40),
                      bottom: BorderSide(color: zeta.colors.cool.shade40),
                      left: BorderSide(color: zeta.colors.cool.shade40),
                    ),
                  ),
                  child: CountriesDialog(
                    zeta: zeta,
                    useRootNavigator: widget.useRootNavigator,
                    enabled: widget.enabled,
                    searchHint: widget.countrySearchHint,
                    button: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: ZetaSpacingBase.x2_5,
                          ),
                          child: Image.asset(
                            _selectedCountry.flagUri,
                            package: 'zeta_flutter',
                            width: 26,
                            height: 18,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        Icon(
                          rounded ? ZetaIcons.expand_more_round : ZetaIcons.expand_more_sharp,
                          color: widget.enabled ? zeta.colors.textDefault : zeta.colors.cool.shade50,
                          size: ZetaSpacing.xl_1,
                        ),
                      ],
                    ),
                    items: _countries
                        .map(
                          (country) => CountriesMenuItem(
                            value: country,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 60,
                                  child: Text(country.dialCode),
                                ),
                                Expanded(
                                  child: Text(country.name),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) => _onChanged(selectedCountry: value),
                  ),
                ),
              ),
              Expanded(
                child: TextFormField(
                  maxLength: 20,
                  initialValue: widget.phoneNumber,
                  enabled: widget.enabled,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d\s\-]'))],
                  keyboardType: TextInputType.phone,
                  onChanged: (value) => _onChanged(phoneNumber: value),
                  style: ZetaTextStyles.bodyMedium.copyWith(
                    color: widget.enabled ? zeta.colors.textDefault : zeta.colors.cool.shade50,
                  ),
                  decoration: InputDecoration(
                    counterText: '',
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    hintStyle: ZetaTextStyles.bodyMedium.copyWith(
                      color: widget.enabled ? zeta.colors.textDefault : zeta.colors.cool.shade50,
                    ),
                    prefixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: ZetaSpacing.small),
                          child: Text(
                            _selectedCountry.dialCode,
                            style: ZetaTextStyles.bodyMedium.copyWith(
                              color: widget.enabled ? zeta.colors.textDefault : zeta.colors.cool.shade50,
                            ),
                          ),
                        ),
                      ],
                    ),
                    prefixIconConstraints: const BoxConstraints(
                      minHeight: ZetaSpacing.xl_8,
                      minWidth: ZetaSpacing.xl_6,
                    ),
                    filled: true,
                    fillColor: widget.enabled
                        ? _hasError
                            ? zeta.colors.red.shade10
                            : zeta.colors.surfacePrimary
                        : zeta.colors.cool.shade30,
                    enabledBorder: _hasError
                        ? _errorInputBorder(zeta, rounded: rounded)
                        : _defaultInputBorder(zeta, rounded: rounded),
                    focusedBorder: _hasError
                        ? _errorInputBorder(zeta, rounded: rounded)
                        : _focusedInputBorder(zeta, rounded: rounded),
                    disabledBorder: _defaultInputBorder(zeta, rounded: rounded),
                    errorBorder: _errorInputBorder(zeta, rounded: rounded),
                    focusedErrorBorder: _errorInputBorder(zeta, rounded: rounded),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (widget.hint != null || showError)
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: ZetaSpacing.small),
                  child: Icon(
                    showError && widget.enabled
                        ? (rounded ? ZetaIcons.error_round : ZetaIcons.error_sharp)
                        : (rounded ? ZetaIcons.info_round : ZetaIcons.info_sharp),
                    size: ZetaSpacing.large,
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

  OutlineInputBorder _defaultInputBorder(
    Zeta zeta, {
    required bool rounded,
  }) =>
      OutlineInputBorder(
        borderRadius: rounded
            ? const BorderRadius.only(
                topRight: Radius.circular(ZetaSpacing.minimum),
                bottomRight: Radius.circular(ZetaSpacing.minimum),
              )
            : ZetaRadius.none,
        borderSide: BorderSide(color: zeta.colors.cool.shade40),
      );

  OutlineInputBorder _focusedInputBorder(
    Zeta zeta, {
    required bool rounded,
  }) =>
      OutlineInputBorder(
        borderRadius: rounded
            ? const BorderRadius.only(
                topRight: Radius.circular(ZetaSpacing.minimum),
                bottomRight: Radius.circular(ZetaSpacing.minimum),
              )
            : ZetaRadius.none,
        borderSide: BorderSide(color: zeta.colors.blue.shade50),
      );

  OutlineInputBorder _errorInputBorder(
    Zeta zeta, {
    required bool rounded,
  }) =>
      OutlineInputBorder(
        borderRadius: rounded
            ? const BorderRadius.only(
                topRight: Radius.circular(ZetaSpacing.minimum),
                bottomRight: Radius.circular(ZetaSpacing.minimum),
              )
            : ZetaRadius.none,
        borderSide: BorderSide(color: zeta.colors.red.shade50),
      );
}
