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
  final String? hint;

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
      ..add(StringProperty('hint', hint))
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
    final hintErrorColor = !widget.disabled
        ? showError
            ? zeta.colors.red
            : zeta.colors.cool.shade70
        : zeta.colors.cool.shade50;

    return ZetaTextInput(
      initialValue: widget.phoneNumber,
      disabled: widget.disabled,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d\s\-]'))],
      keyboardType: TextInputType.phone,
      onChange: (value) => _onChanged(phoneNumber: value),
      prefix: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
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

// class _CountriesDialog extends StatelessWidget {
//   const _CountriesDialog({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return CountriesDialog(
//       zeta: zeta,
//       useRootNavigator: widget.useRootNavigator,
//       enabled: widget.enabled,
//       searchHint: widget.countrySearchHint,
//       button: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(
//               left: ZetaSpacingBase.x2_5,
//             ),
//             child: Image.asset(
//               _selectedCountry.flagUri,
//               package: 'zeta_flutter',
//               width: 26,
//               height: 18,
//               fit: BoxFit.fitHeight,
//             ),
//           ),
//           ZetaIcon(
//             ZetaIcons.expand_more,
//             color: widget.enabled ? zeta.colors.textDefault : zeta.colors.cool.shade50,
//             size: ZetaSpacing.xl_1,
//           ),
//         ],
//       ),
//       items: _countries
//           .map(
//             (country) => CountriesMenuItem(
//               value: country,
//               child: Row(
//                 children: [
//                   SizedBox(
//                     width: 60,
//                     child: Text(country.dialCode),
//                   ),
//                   Expanded(
//                     child: Text(country.name),
//                   ),
//                 ],
//               ),
//             ),
//           )
//           .toList(),
//       onChanged: (value) => _onChanged(selectedCountry: value),
//     );
//   }
// }
