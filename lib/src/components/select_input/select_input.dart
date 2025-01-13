import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';
import '../buttons/input_icon_button.dart';
import '../dropdown/dropdown_controller.dart';
import '../text_input/internal_text_input.dart';

/// Class for [ZetaSelectInput].
/// {@category Components}
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=229-39&node-type=canvas&m=dev
///
/// Widgetbook: https://zeta-ds.web.app/flutter/widgetbook/index.html#/?path=components/select-input
class ZetaSelectInput<T> extends ZetaFormField<T> {
  ///Constructor of [ZetaSelectInput]
  ZetaSelectInput({
    super.key,
    bool? rounded,
    super.validator,
    super.onFieldSubmitted,
    super.autovalidateMode,
    super.onSaved,
    super.disabled = false,
    super.initialValue,
    super.onChange,
    super.requirementLevel,
    required this.items,
    this.onTextChanged,
    this.size = ZetaWidgetSize.medium,
    this.label,
    this.hintText,
    this.prefix,
    this.placeholder,
    this.errorText,
    this.dropdownSemantics,
  }) : super(
          builder: (field) {
            final _ZetaSelectInputState<T> state = field as _ZetaSelectInputState<T>;
            final colors = Zeta.of(field.context).colors;

            return ZetaRoundedScope(
              rounded: rounded ?? field.context.rounded,
              child: ZetaDropdown<T>(
                disableButtonSemantics: true,
                items: state.currentItems,
                onChange: !disabled ? state.setItem : null,
                key: state.dropdownKey,
                value: state._selectedItem?.value,
                offset: Offset(0, Zeta.of(field.context).spacing.xl * -1),
                onDismissed: state.onDropdownDismissed,
                builder: (context, _, controller) {
                  return InternalTextInput(
                    size: size,
                    constrained: true,
                    requirementLevel: requirementLevel,
                    disabled: disabled,
                    controller: state.inputController,
                    focusNode: state.inputFocusNode,
                    prefix: state._selectedItem?.icon ?? prefix,
                    label: label,
                    onSubmit: (_) {
                      state.onInputSubmitted(controller);
                      onFieldSubmitted?.call(state._selectedItem?.value);
                    },
                    errorText: field.errorText ?? errorText,
                    placeholder: placeholder,
                    hintText: hintText,
                    onChange: (val) => state.onInputChanged(controller),
                    suffix: InputIconButton(
                      semanticLabel: dropdownSemantics,
                      icon: controller.isOpen ? ZetaIcons.expand_less : ZetaIcons.expand_more,
                      disabled: disabled,
                      size: size,
                      color: colors.mainSubtle,
                      onTap: () => state.onIconTapped(controller),
                    ),
                  );
                },
              ),
            );
          },
        );

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

  /// Determines the size of the input field.
  /// Defaults to [ZetaWidgetSize.medium]
  final ZetaWidgetSize size;

  /// If provided, displays a label above the input field.
  final String? label;

  /// If provided, displays a hint below the input field.
  final String? hintText;

  /// The placeholder for the input.
  final String? placeholder;

  /// The semantics label for the dropdown button.
  ///
  /// {@macro zeta-widget-semantic-label}
  final String? dropdownSemantics;

  @override
  FormFieldState<T> createState() => _ZetaSelectInputState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<ZetaWidgetSize?>('size', size))
      ..add(StringProperty('hint', hintText))
      ..add(ObjectFlagProperty<ValueSetter<String>?>.has('onTextChanged', onTextChanged))
      ..add(IterableProperty<ZetaDropdownItem<T>>('items', items))
      ..add(StringProperty('errorText', errorText))
      ..add(ObjectFlagProperty<String? Function(T? value)?>.has('validator', validator))
      ..add(StringProperty('label', label))
      ..add(StringProperty('placeholder', placeholder))
      ..add(StringProperty('dropdownSemantics', dropdownSemantics));
  }
}

class _ZetaSelectInputState<T> extends FormFieldState<T> {
  @override
  ZetaSelectInput<T> get widget => super.widget as ZetaSelectInput<T>;

  final GlobalKey<ZetaDropDownState<T>> dropdownKey = GlobalKey();

  final TextEditingController inputController = TextEditingController();
  final FocusNode inputFocusNode = FocusNode();

  late List<ZetaDropdownItem<T>> currentItems;

  ZetaDropdownItem<T>? _selectedItem;

  @override
  void initState() {
    currentItems = widget.items;
    _setInitialItem();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ZetaSelectInput<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      _setInitialItem();
    }
  }

  @override
  void reset() {
    super.reset();
    _setInitialItem();
    super.didChange(_selectedItem?.value);
    widget.onChange?.call(_selectedItem?.value);
  }

  void _setInitialItem() {
    _selectedItem = widget.items.firstWhereOrNull((item) => item.value == widget.initialValue);
    inputController.text = _selectedItem?.label ?? '';
  }

  void onDropdownDismissed() {
    setState(() {
      currentItems = widget.items;
      _onLoseFocus();
    });
  }

  void onInputSubmitted(ZetaDropdownController dropdownController) {
    if (dropdownController.isOpen && currentItems.isNotEmpty) {
      setItem(currentItems.first);
    }
    dropdownController.close();
  }

  void _onLoseFocus() {
    if (_selectedItem == null) {
      inputController.text = '';
    } else {
      setItem(_selectedItem!);
    }
  }

  void _filterItems() {
    late List<ZetaDropdownItem<T>> filteredItems;
    if (inputController.text.isNotEmpty) {
      filteredItems = widget.items.where(
        (item) {
          return item.label.toLowerCase().startsWith(inputController.text.toLowerCase());
        },
      ).toList();
    } else {
      filteredItems = widget.items;
    }
    setState(() {
      currentItems = filteredItems;
    });
  }

  void onInputChanged(ZetaDropdownController dropdownController) {
    dropdownController.open();
    _filterItems();
  }

  void onIconTapped(ZetaDropdownController dropdownController) {
    dropdownController.toggle();
    if (dropdownController.isOpen) {
      inputFocusNode.requestFocus();
      setState(() {
        currentItems = widget.items;
      });
    }
  }

  void setItem(ZetaDropdownItem<T> item) {
    inputController.text = item.label;
    setState(() {
      _selectedItem = item;
    });
    super.didChange(item.value);
    widget.onChange?.call(item.value);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<GlobalKey<ZetaDropDownState<T>>>('dropdownKey', dropdownKey))
      ..add(DiagnosticsProperty<TextEditingController>('inputController', inputController))
      ..add(DiagnosticsProperty<FocusNode>('inputFocusNode', inputFocusNode))
      ..add(IterableProperty<ZetaDropdownItem<T>>('currentItems', currentItems));
  }
}
