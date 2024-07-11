import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../zeta_flutter.dart';

import 'countries.dart';

/// ZetaPhoneInput allows entering phone numbers.
class ZetaPhoneInput extends ZetaStatefulWidget {
  /// Constructor for [ZetaPhoneInput].
  const ZetaPhoneInput({
    super.key,
    super.rounded,
    this.label,
    this.hintText,
    this.disabled = false,
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
  final String? hintText;

  /// Determines if the inputs should be enabled (default) or disabled.
  final bool disabled;

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
      ..add(StringProperty('hint', hintText))
      ..add(DiagnosticsProperty<bool>('enabled', disabled))
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
  late List<Country> _countries;
  late List<ZetaDropdownItem<String>> _dropdownItems;
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

    _setDropdownItems();
  }

  @override
  void didUpdateWidget(ZetaPhoneInput oldWidget) {
    if (oldWidget.countries != widget.countries) {
      setState(_setDropdownItems);
    }
    super.didUpdateWidget(oldWidget);
  }

  void _setDropdownItems() {
    _dropdownItems = _countries
        .map(
          (country) => ZetaDropdownItem(
            value: country.dialCode,
            icon: Image.asset(
              country.flagUri,
              package: 'zeta_flutter',
              width: 26,
              height: 18,
              fit: BoxFit.fitHeight,
            ),
            label: '${country.name} (${country.dialCode})',
          ),
        )
        .toList();
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

    return ZetaTextInput(
      initialValue: widget.phoneNumber,
      label: widget.label,
      hintText: widget.hintText,
      disabled: widget.disabled,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d\s\-]'))],
      keyboardType: TextInputType.phone,
      onChange: (value) => _onChanged(phoneNumber: value),
      prefix: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ZetaDropdown(
                offset: const Offset(0, ZetaSpacing.medium),
                onChange: (value) {
                  setState(() {
                    _selectedCountry = _countries.firstWhere((country) => country.dialCode == value.value);
                  });
                },
                value: _selectedCountry.dialCode,
                onDismissed: () => setState(() {}),
                items: _dropdownItems,
                builder: (context, selectedItem, controller) {
                  return GestureDetector(
                    onTap: controller.toggle,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: !widget.disabled ? zeta.colors.borderSubtle : zeta.colors.borderDisabled,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: ZetaSpacingBase.x2_5,
                            ),
                            child: selectedItem?.icon,
                          ),
                          const SizedBox(
                            width: ZetaSpacing.small,
                          ),
                          ZetaIcon(
                            !controller.isOpen ? ZetaIcons.expand_more : ZetaIcons.expand_less,
                            color: !widget.disabled ? zeta.colors.iconDefault : zeta.colors.iconDisabled,
                            size: ZetaSpacing.xl_1,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: ZetaSpacing.small),
            child: Text(
              _selectedCountry.dialCode,
            ),
          ),
        ],
      ),
    );
  }
}
