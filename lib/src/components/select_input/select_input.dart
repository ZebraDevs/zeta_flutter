import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';
import '../../interfaces/form_field.dart';

/// Class for [ZetaSelectInput]
class ZetaSelectInput<T> extends ZetaFormField<ZetaDropdownItem<T>> {
  ///Constructor of [ZetaSelectInput]
  const ZetaSelectInput({
    super.key,
    required this.items,
    this.onTextChanged,
    this.size = ZetaWidgetSize.medium,
    this.leadingIcon,
    this.label,
    this.hintText,
    this.rounded = true,
    super.disabled = false,
    super.initialValue,
    super.onChange,
    super.requirementLevel = ZetaFormFieldRequirement.none,
  });

  /// Input items as list of [ZetaDropdownItem]
  final List<ZetaDropdownItem<T>> items;

  /// Handles changes of input text
  final ValueSetter<String>? onTextChanged;

  /// Determines the size of the input field.
  /// Defaults to [ZetaWidgetSize.medium]
  final ZetaWidgetSize size;

  /// The input's leading icon.
  final Widget? leadingIcon;

  /// If provided, displays a label above the input field.
  final String? label;

  /// If provided, displays a hint below the input field.
  final String? hintText;

  /// {@macro zeta-component-rounded}
  final bool rounded;

  @override
  State<ZetaSelectInput<T>> createState() => _ZetaSelectInputState<T>();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(EnumProperty<ZetaWidgetSize?>('size', size))
      ..add(StringProperty('hint', hintText))
      ..add(ObjectFlagProperty<ValueSetter<String>?>.has('onTextChanged', onTextChanged));
  }
}

class _ZetaSelectInputState<T> extends State<ZetaSelectInput<T>> {
  late List<ZetaDropdownItem<T>> _filteredItems;

  @override
  void initState() {
    _filteredItems = widget.items;
    super.initState();
  }

  void _onInputChanged(String? val) {
    setState(() {
      if (val != null && val.isNotEmpty) {
        _filteredItems = widget.items
            .where(
              (item) => item.label.toLowerCase().contains(
                    val.toLowerCase(),
                  ),
            )
            .toList();
      } else {
        _filteredItems = widget.items;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ZetaDropdown<T>(
      items: _filteredItems,
      builder: (context, selectedItem, controller) {
        return ZetaTextInput(
          size: widget.size,
          prefix: widget.leadingIcon,
          label: widget.label,
          hintText: widget.hintText,
          onChange: _onInputChanged,
          suffix: IconButton(
            icon: const Icon(ZetaIcons.expand_more_round),
            onPressed: widget.items.isEmpty ? null : controller.toggle,
          ),
        );
      },
    );
  }
}
