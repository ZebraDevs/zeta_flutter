import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';
import '../../interfaces/form_field.dart';

/// Class for [ZetaSelectInput]
class ZetaSelectInput<T> extends ZetaFormField<T> {
  ///Constructor of [ZetaSelectInput]
  const ZetaSelectInput({
    super.key,
    required this.items,
    this.onTextChanged,
    this.size = ZetaWidgetSize.medium,
    this.label,
    this.hintText,
    this.rounded = true,
    this.prefix,
    this.placeholder,
    this.validator,
    this.errorText,
    super.disabled = false,
    super.initialValue,
    super.onChange,
    super.requirementLevel = ZetaFormFieldRequirement.none,
  });

  /// Input items as list of [ZetaDropdownItem]
  final List<ZetaDropdownItem<T>> items;

  /// Handles changes of input text
  final ValueSetter<String>? onTextChanged;

  /// The prefix widget for the input.
  ///
  /// Will be overriden if the selected item has an icon.
  final Widget? prefix;

  /// The error text shown beneath the input when the validator fails.
  final String? errorText;

  /// The validator for the input.
  final String? Function(T? value)? validator;

  /// Determines the size of the input field.
  /// Defaults to [ZetaWidgetSize.medium]
  final ZetaWidgetSize size;

  /// If provided, displays a label above the input field.
  final String? label;

  /// If provided, displays a hint below the input field.
  final String? hintText;

  /// The placeholder for the input.
  final String? placeholder;

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
      ..add(ObjectFlagProperty<ValueSetter<String>?>.has('onTextChanged', onTextChanged))
      ..add(IterableProperty<ZetaDropdownItem<T>>('items', items))
      ..add(StringProperty('errorText', errorText))
      ..add(ObjectFlagProperty<String? Function(T? value)?>.has('validator', validator))
      ..add(StringProperty('label', label))
      ..add(StringProperty('placeholder', placeholder));
  }
}

class _ZetaSelectInputState<T> extends State<ZetaSelectInput<T>> {
  final GlobalKey<ZetaDropDownState<T>> _dropdownKey = GlobalKey();
  final TextEditingController _inputController = TextEditingController();

  ZetaDropdownItem<T>? _selectedItem;

  bool get _dropdownOpen => _dropdownKey.currentState?.isOpen ?? false;

  IconData get _icon {
    if (_dropdownOpen) {
      return widget.rounded ? ZetaIcons.expand_less_round : ZetaIcons.expand_less_sharp;
    } else {
      return widget.rounded ? ZetaIcons.expand_more_round : ZetaIcons.expand_more_sharp;
    }
  }

  @override
  void initState() {
    _inputController.addListener(
      () => setState(() {}),
    );
    _setInitialItem();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ZetaSelectInput<T> oldWidget) {
    if (oldWidget.initialValue != widget.initialValue) {
      setState(_setInitialItem);
    }
    super.didUpdateWidget(oldWidget);
  }

  void _setInitialItem() {
    _selectedItem = widget.items.firstWhereOrNull((item) => item.value == widget.initialValue);
    _inputController.text = _selectedItem?.label ?? '';
  }

  void _onInputChanged(ZetaDropdownController dropdownController) {
    dropdownController.open();
    setState(() {
      _selectedItem = null;
    });
    widget.onChange?.call(null);
  }

  void _onIconTapped(ZetaDropdownController dropdownController) {
    dropdownController.toggle();
    setState(() {});
  }

  void _onDropdownChanged(ZetaDropdownItem<T> item) {
    _inputController.text = item.label;
    setState(() {
      _selectedItem = item;
    });
    widget.onChange?.call(item.value);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    late List<ZetaDropdownItem<T>> filteredItems;
    if (_inputController.text.isNotEmpty) {
      filteredItems = widget.items.where(
        (item) {
          return item.label.toLowerCase().startsWith(_inputController.text.toLowerCase());
        },
      ).toList();
    } else {
      filteredItems = widget.items;
    }

    return ZetaDropdown<T>(
      items: filteredItems,
      onChange: !widget.disabled ? _onDropdownChanged : null,
      key: _dropdownKey,
      value: _selectedItem?.value,
      onDismissed: () => setState(() {}),
      builder: (context, _, controller) {
        return ZetaTextInput(
          size: widget.size,
          requirementLevel: widget.requirementLevel,
          disabled: widget.disabled,
          validator: (_) {
            final currentValue = _selectedItem?.value;
            String? errorText;
            final customValidation = widget.validator?.call(currentValue);
            if ((currentValue == null && widget.requirementLevel != ZetaFormFieldRequirement.optional) ||
                customValidation != null) {
              errorText = customValidation ?? widget.errorText ?? '';
            }

            return errorText;
          },
          controller: _inputController,
          prefix: _selectedItem?.icon ?? widget.prefix,
          label: widget.label,
          placeholder: widget.placeholder,
          hintText: widget.hintText,
          onChange: (val) => _onInputChanged(controller),
          suffix: IconButton(
            icon: Icon(_icon, color: colors.iconSubtle),
            onPressed: widget.disabled ? null : () => _onIconTapped(controller),
          ),
        );
      },
    );
  }
}
