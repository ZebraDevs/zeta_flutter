import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../zeta_flutter.dart';

import '../../interfaces/form_field.dart';
import '../text_input/hint_text.dart';
import '../text_input/input_label.dart';
import 'countries.dart';

/// ZetaPhoneInput allows entering phone numbers.
/// {@category Components}
class ZetaPhoneInput extends ZetaFormFieldOld<String> {
  /// Constructor for [ZetaPhoneInput].
  const ZetaPhoneInput({
    super.key,
    super.rounded,
    super.initialValue,
    super.onChange,
    super.requirementLevel = ZetaFormFieldRequirement.none,
    this.label,
    this.hintText,
    super.disabled = false,
    this.hasError = false,
    this.errorText,
    this.initialCountry,
    this.countries,
    this.size = ZetaWidgetSize.medium,
    this.selectCountrySemanticLabel,
  });

  /// If provided, displays a label above the input field.
  final String? label;

  /// If provided, displays a hint below the input field.
  final String? hintText;

  /// Determines if the input field should be displayed in error style.
  /// Default is `false`.
  /// If `enabled` is `false`, this has no effect.
  final bool hasError;

  /// In combination with `hasError: true`, provides the error message
  /// to be displayed below the input field.
  final String? errorText;

  /// The initial value for the selected country.
  final String? initialCountry;

  /// List of countries ISO 3166-1 alpha-2 codes
  final List<String>? countries;

  /// The size of the input.
  ///
  /// Setting this to small will have no effect.
  final ZetaWidgetSize size;

  /// The semantic label for the country selection button.
  ///
  /// {@macro zeta-widget-semantic-label}
  final String? selectCountrySemanticLabel;

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
      ..add(StringProperty('countryDialCode', initialCountry))
      ..add(IterableProperty<String>('countries', countries))
      ..add(EnumProperty<ZetaWidgetSize>('size', size))
      ..add(StringProperty('selectCountrySemanticLabel', selectCountrySemanticLabel));
  }
}

class _ZetaPhoneInputState extends State<ZetaPhoneInput> {
  late List<Country> _countries;
  late List<ZetaDropdownItem<String>> _dropdownItems;
  late Country _selectedCountry;
  late String _phoneNumber;

  final FocusNode _inputFocusNode = FocusNode();

  ZetaWidgetSize get _size => widget.size == ZetaWidgetSize.small ? ZetaWidgetSize.medium : widget.size;

  @override
  void initState() {
    super.initState();
    _setCountries();
    _setInitialCountry();
    _setDropdownItems();
  }

  @override
  void didUpdateWidget(ZetaPhoneInput oldWidget) {
    if (oldWidget.countries != widget.countries) {
      _setCountries();
      setState(_setDropdownItems);
    }
    if (oldWidget.initialCountry != widget.initialCountry) {
      setState(_setInitialCountry);
    }
    super.didUpdateWidget(oldWidget);
  }

  void _setCountries() {
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
  }

  void _setInitialCountry() {
    _selectedCountry = _countries.firstWhereOrNull(
          (country) => country.isoCode == widget.initialCountry,
        ) ??
        _countries.first;
    _phoneNumber = widget.initialValue ?? '';
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
    widget.onChange?.call('${_selectedCountry.dialCode}$_phoneNumber');
  }

  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);
    final rounded = context.rounded;

    return Semantics(
      enabled: !widget.disabled,
      excludeSemantics: widget.disabled,
      child: Column(
        children: [
          if (widget.label != null) ...[
            ZetaInputLabel(
              label: widget.label!,
              requirementLevel: widget.requirementLevel,
              disabled: widget.disabled,
            ),
            const SizedBox(height: ZetaSpacing.minimum),
          ],
          Row(
            children: [
              ZetaDropdown(
                offset: const Offset(0, ZetaSpacing.medium),
                onChange: !widget.disabled
                    ? (value) {
                        setState(() {
                          _selectedCountry = _countries.firstWhere((country) => country.dialCode == value.value);
                        });
                        _inputFocusNode.requestFocus();
                      }
                    : null,
                value: _selectedCountry.dialCode,
                onDismissed: () => setState(() {}),
                items: _dropdownItems,
                builder: (context, selectedItem, controller) {
                  final borderSide = BorderSide(
                    color: widget.disabled ? zeta.colors.borderDefault : zeta.colors.borderSubtle,
                  );

                  return GestureDetector(
                    onTap: !widget.disabled ? controller.toggle : null,
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: widget.size == ZetaWidgetSize.large ? ZetaSpacing.xl_8 : ZetaSpacing.xl_6,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: rounded ? const Radius.circular(ZetaSpacing.minimum) : Radius.zero,
                          bottomLeft: rounded ? const Radius.circular(ZetaSpacing.minimum) : Radius.zero,
                        ),
                        border: Border(
                          left: borderSide,
                          top: borderSide,
                          bottom: borderSide,
                        ),
                        color: widget.disabled ? zeta.colors.surfaceDisabled : zeta.colors.surfaceDefault,
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: ZetaSpacing.medium,
                                    right: ZetaSpacing.small,
                                  ),
                                  child: selectedItem?.icon,
                                ),
                                ZetaIcon(
                                  !controller.isOpen ? ZetaIcons.expand_more : ZetaIcons.expand_less,
                                  color: !widget.disabled ? zeta.colors.iconDefault : zeta.colors.iconDisabled,
                                  size: ZetaSpacing.xl_1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Expanded(
                child: textInputWithBorder(
                  initialValue: widget.initialValue,
                  disabled: widget.disabled,
                  size: _size,
                  requirementLevel: widget.requirementLevel,
                  rounded: rounded,
                  focusNode: _inputFocusNode,
                  errorText: widget.errorText != null ? '' : null,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d\s\-]'))],
                  keyboardType: TextInputType.phone,
                  onChange: (value) => _onChanged(phoneNumber: value),
                  prefixText: _selectedCountry.dialCode,
                  borderRadius: BorderRadius.only(
                    topRight: rounded ? const Radius.circular(ZetaSpacing.minimum) : Radius.zero,
                    bottomRight: rounded ? const Radius.circular(ZetaSpacing.minimum) : Radius.zero,
                  ),
                ),
              ),
            ],
          ),
          ZetaHintText(
            disabled: widget.disabled,
            rounded: rounded,
            hintText: widget.hintText,
            errorText: widget.errorText,
          ),
        ],
      ),
    );
  }
}
