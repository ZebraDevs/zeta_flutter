import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../zeta_flutter.dart';

import '../text_input/internal_text_input.dart';

/// ZetaPhoneInput allows entering phone numbers.
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=916-10934&node-type=canvas&m=dev
///
/// Widgetbook: https://zeta-ds.web.app/flutter/widgetbook/index.html#/?path=components/phone-input
class ZetaPhoneInput extends ZetaFormField<PhoneNumber> {
  /// Constructor for [ZetaPhoneInput].
  ZetaPhoneInput({
    super.key,
    bool? rounded,
    super.onFieldSubmitted,
    super.onSaved,
    super.initialValue,
    super.validator,
    super.onChange,
    super.requirementLevel = ZetaFormFieldRequirement.none,
    this.label,
    this.hintText,
    super.disabled = false,
    this.errorText,
    this.countries,
    this.size = ZetaWidgetSize.medium,
    this.selectCountrySemanticLabel,
    super.autovalidateMode,
  }) : super(
          builder: (field) {
            final _ZetaPhoneInputState state = field as _ZetaPhoneInputState;

            final colors = Zeta.of(field.context).colors;
            final spacing = Zeta.of(field.context).spacing;
            final newRounded = rounded ?? field.context.rounded;

            return InternalTextInput(
              label: label,
              hintText: hintText,
              errorText: field.errorText ?? errorText,
              size: size,
              controller: state.controller,
              requirementLevel: requirementLevel,
              rounded: rounded,
              disabled: disabled,
              focusNode: state._inputFocusNode,
              onSubmit: onFieldSubmitted != null ? (_) => onFieldSubmitted(field.value) : null,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d\s\-]'))],
              keyboardType: TextInputType.phone,
              prefixText: state._selectedCountry.dialCode,
              borderRadius: BorderRadius.only(
                topRight: newRounded ? Radius.circular(spacing.minimum) : Radius.zero,
                bottomRight: newRounded ? Radius.circular(spacing.minimum) : Radius.zero,
              ),
              externalPrefix: ZetaDropdown(
                offset: Offset(0, spacing.medium),
                onChange: !disabled ? state.onDropdownChanged : null,
                value: state._selectedCountry.dialCode,
                onDismissed: state.onDropdownDismissed,
                items: state._dropdownItems,
                builder: (context, selectedItem, dropdowncontroller) {
                  final borderSide = BorderSide(
                    color: disabled ? colors.borderDefault : colors.borderSubtle,
                  );

                  return GestureDetector(
                    onTap: !disabled ? dropdowncontroller.toggle : null,
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: size == ZetaWidgetSize.large
                            ? Zeta.of(context).spacing.xl_8
                            : Zeta.of(context).spacing.xl_6,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: newRounded ? Radius.circular(spacing.minimum) : Radius.zero,
                          bottomLeft: newRounded ? Radius.circular(spacing.minimum) : Radius.zero,
                        ),
                        border: Border(
                          left: borderSide,
                          top: borderSide,
                          bottom: borderSide,
                        ),
                        color: disabled ? colors.surfaceDisabled : colors.surfaceDefault,
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: spacing.medium,
                                    right: spacing.small,
                                  ),
                                  child: selectedItem?.icon,
                                ),
                                ZetaIcon(
                                  !dropdowncontroller.isOpen ? ZetaIcons.expand_more : ZetaIcons.expand_less,
                                  color: !disabled ? colors.mainDefault : colors.mainDisabled,
                                  size: Zeta.of(context).spacing.xl,
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
            );
          },
        );

  /// If provided, displays a label above the input field.
  final String? label;

  /// If provided, displays a hint below the input field.
  final String? hintText;

  /// In combination with `hasError: true`, provides the error message
  /// to be displayed below the input field.
  final String? errorText;

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
  FormFieldState<PhoneNumber> createState() => _ZetaPhoneInputState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('label', label))
      ..add(StringProperty('hint', hintText))
      ..add(StringProperty('errorText', errorText))
      ..add(IterableProperty<String>('countries', countries))
      ..add(EnumProperty<ZetaWidgetSize>('size', size))
      ..add(StringProperty('selectCountrySemanticLabel', selectCountrySemanticLabel));
  }
}

class _ZetaPhoneInputState extends FormFieldState<PhoneNumber> {
  late List<Country> _countries;
  late List<ZetaDropdownItem<String>> _dropdownItems;
  late Country _selectedCountry;
  final FocusNode _inputFocusNode = FocusNode();

  final TextEditingController controller = TextEditingController();

  @override
  ZetaPhoneInput get widget => super.widget as ZetaPhoneInput;

  @override
  void initState() {
    super.initState();
    _setCountries();
    _setInitialCountry();
    _setDropdownItems();

    controller
      ..text = widget.initialValue != null ? widget.initialValue!.number : ''
      ..addListener(_onChanged);
  }

  @override
  void dispose() {
    _inputFocusNode.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ZetaPhoneInput oldWidget) {
    if (oldWidget.countries != widget.countries) {
      _setCountries();
      setState(_setDropdownItems);
    }
    if (oldWidget.initialValue != widget.initialValue) {
      setState(_setInitialCountry);
      controller
        ..removeListener(_onChanged)
        ..text = widget.initialValue != null ? widget.initialValue!.number : ''
        ..addListener(_onChanged);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void reset() {
    setState(_setInitialCountry);
    controller.text = widget.initialValue != null ? widget.initialValue!.number : '';

    super.reset();
  }

  void onDropdownChanged(ZetaDropdownItem<String> value) {
    setState(() {
      _selectedCountry = _countries.firstWhere((country) => country.dialCode == value.value);
    });
    _inputFocusNode.requestFocus();
    _onChanged();
  }

  void onDropdownDismissed() {
    setState(() {});
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
          (country) => country.dialCode == widget.initialValue?.dialCode,
        ) ??
        _countries.first;
  }

  void _setDropdownItems() {
    _dropdownItems = _countries
        .map(
          (country) => ZetaDropdownItem(
            value: country.dialCode,
            icon: Image.asset(
              country.flagUri,
              width: 26,
              height: 18,
              fit: BoxFit.fitHeight,
            ),
            label: '${country.name} (${country.dialCode})',
          ),
        )
        .toList();
  }

  void _onChanged() {
    final newValue = PhoneNumber(dialCode: _selectedCountry.dialCode, number: controller.text);
    widget.onChange?.call(newValue);
    super.didChange(newValue);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextEditingController>('controller', controller));
  }
}
