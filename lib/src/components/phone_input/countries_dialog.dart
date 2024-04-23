import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';
import 'countries.dart';

/// Class for [CountriesDialog]
class CountriesDialog extends StatefulWidget {
  ///Constructor of [CountriesDialog]
  const CountriesDialog({
    super.key,
    this.zeta,
    required this.button,
    required this.items,
    required this.onChanged,
    this.enabled = true,
    this.searchHint,
    this.useRootNavigator = true,
  });

  /// Sometimes it is needed to pass an instance of [Zeta] from outside.
  final Zeta? zeta;

  /// The button, which opens the dialog.
  final Widget button;

  /// List of [CountriesMenuItem]
  final List<CountriesMenuItem> items;

  /// Called when an item is selected.
  final ValueSetter<Country?> onChanged;

  /// Determines if the button should be enabled (default) or disabled.
  final bool enabled;

  /// The hint to be shown inside the country search input field.
  /// Default is `Search by name or dial code`.
  final String? searchHint;

  /// Determines if the root navigator should be used.
  final bool useRootNavigator;

  @override
  State<CountriesDialog> createState() => _CountriesDialogState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<CountriesMenuItem>('items', items))
      ..add(ObjectFlagProperty<ValueSetter<Country?>>.has('onChanged', onChanged))
      ..add(DiagnosticsProperty<bool>('enabled', enabled))
      ..add(DiagnosticsProperty<bool>('useRootNavigator', useRootNavigator))
      ..add(StringProperty('searchHint', searchHint));
  }
}

class _CountriesDialogState extends State<CountriesDialog> {
  Future<Country?> _showCountriesDialog(
    BuildContext context, {
    Zeta? zeta,
    required List<CountriesMenuItem> items,
    bool barrierDismissible = true,
    bool useRootNavigator = true,
  }) =>
      showDialog<Country?>(
        context: context,
        barrierDismissible: barrierDismissible,
        useRootNavigator: useRootNavigator,
        builder: (_) => _CountriesList(
          items: items,
          searchHint: widget.searchHint,
          zeta: zeta,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.items.isEmpty || !widget.enabled
          ? null
          : () async {
              final item = await _showCountriesDialog(
                context,
                zeta: widget.zeta,
                items: widget.items,
                useRootNavigator: widget.useRootNavigator,
              );
              widget.onChanged(item);
            },
      child: widget.button,
    );
  }
}

class _CountriesList extends StatefulWidget {
  const _CountriesList({
    required this.items,
    this.searchHint,
    this.zeta,
  });

  final Zeta? zeta;
  final List<CountriesMenuItem> items;
  final String? searchHint;

  @override
  State<_CountriesList> createState() => _CountriesListState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<CountriesMenuItem>('items', items))
      ..add(StringProperty('searchHint', searchHint));
  }
}

class _CountriesListState extends State<_CountriesList> {
  late final bool _enableSearch = widget.items.length > 20;
  List<CountriesMenuItem> _items = [];

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.items);
  }

  void _search(String? text) {
    final value = text ?? '';
    setState(() {
      _items = widget.items.where((item) {
        return item.value.name.toLowerCase().contains(value.toLowerCase()) ||
            (RegExp(r'^\d+$').hasMatch(value) && item.value.dialCode.indexOf('+$value') == 0);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final zeta = widget.zeta ?? Zeta.of(context);

    return AlertDialog(
      surfaceTintColor: zeta.colors.surfacePrimary,
      shape: const RoundedRectangleBorder(borderRadius: ZetaRadius.large),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_enableSearch)
              Padding(
                padding: const EdgeInsets.only(bottom: ZetaSpacing.b),
                child: ZetaSearchBar(
                  onChanged: _search,
                  hint: widget.searchHint ?? 'Country or dial code',
                  shape: ZetaWidgetBorder.full,
                  showSpeechToText: false,
                ),
              ),
            if (_enableSearch)
              Expanded(
                child: _listView(context),
              )
            else
              _listView(context),
            Padding(
              padding: const EdgeInsets.only(top: ZetaSpacing.b),
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listView(BuildContext context) => ListView.builder(
        shrinkWrap: true,
        itemCount: _items.length,
        itemBuilder: (_, index) => InkWell(
          onTap: () {
            Navigator.of(context).pop(_items[index].value);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: ZetaSpacing.xs,
            ),
            child: _items[index].child,
          ),
        ),
      );
}

/// [CountriesMenuItem]
/// Item for the country selection dialog.
class CountriesMenuItem {
  /// Constructor for [CountriesMenuItem].
  const CountriesMenuItem({
    required this.value,
    required this.child,
  });

  /// The selected value from the list.
  final Country value;

  /// The widget which will represent each item in the list.
  final Widget child;
}
