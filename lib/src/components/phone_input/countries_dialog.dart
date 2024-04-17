import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

/// Class for [CountriesDialog]
class CountriesDialog<T> extends StatefulWidget {
  ///Constructor of [CountriesDialog]
  const CountriesDialog({
    super.key,
    this.zeta,
    required this.button,
    required this.items,
    required this.onChanged,
    this.enabled = true,
    this.useRootNavigator = true,
  });

  /// Sometimes it is needed to pass an instance of [Zeta] from outside.
  final Zeta? zeta;

  /// The button, which opens the dialog.
  final Widget button;

  /// List of [DropdownMenuItem]
  final List<DropdownMenuItem<T>> items;

  /// Called when an item is selected.
  final ValueSetter<T?> onChanged;

  /// Determines if the button should be enabled (default) or disabled.
  final bool enabled;

  /// Determines if the root navigator should be used.
  final bool useRootNavigator;

  @override
  State<CountriesDialog<T>> createState() => _CountriesDialogState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<DropdownMenuItem<T>>('items', items))
      ..add(ObjectFlagProperty<ValueSetter<T?>>.has('onChanged', onChanged))
      ..add(DiagnosticsProperty<bool>('enabled', enabled))
      ..add(DiagnosticsProperty<bool>('useRootNavigator', useRootNavigator));
  }
}

class _CountriesDialogState<T> extends State<CountriesDialog<T>> {
  Future<T?> _showCountriesDialog(
    BuildContext context, {
    Zeta? zeta,
    required List<DropdownMenuItem<T>> items,
    bool barrierDismissible = true,
    bool useRootNavigator = true,
  }) =>
      showDialog<T?>(
        context: context,
        barrierDismissible: barrierDismissible,
        useRootNavigator: useRootNavigator,
        builder: (_) => _CountriesList(
          items: items,
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

class _CountriesList<T> extends StatelessWidget {
  const _CountriesList({
    required this.items,
    this.zeta,
  });

  final Zeta? zeta;
  final List<DropdownMenuItem<T>> items;

  @override
  Widget build(BuildContext context) {
    final zeta = this.zeta ?? Zeta.of(context);

    return AlertDialog(
      surfaceTintColor: zeta.colors.surfacePrimary,
      shape: const RoundedRectangleBorder(borderRadius: ZetaRadius.large),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (_, index) => InkWell(
            onTap: () {
              Navigator.of(context).pop(items[index].value);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: ZetaSpacing.xs,
              ),
              child: items[index].child,
            ),
          ),
        ),
      ),
    );
  }
}
