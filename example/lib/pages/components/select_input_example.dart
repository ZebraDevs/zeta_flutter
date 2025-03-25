import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class SelectInputExample extends StatefulWidget {
  static const String name = 'SelectInput';
  const SelectInputExample({super.key});

  @override
  State<SelectInputExample> createState() => _SelectInputExampleState();
}

class _SelectInputExampleState extends State<SelectInputExample> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final items = [
      ZetaDropdownItem(
        value: "Item 1",
        icon: Icon(ZetaIcons.star),
      ),
      ZetaDropdownItem(
        value: "Item 2",
        icon: Icon(ZetaIcons.star_half),
      ),
      ZetaDropdownItem(
        value: "Item 3",
      ),
    ];

    return ExampleScaffold(
      name: 'Select Input',
      child: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 320,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  ZetaSelectInput(
                    label: 'Large',
                    size: ZetaWidgetSize.large,
                    hintText: 'Default hint text',
                    placeholder: 'Placeholder',
                    initialValue: "Item 1",
                    items: items,
                    validator: (value) {
                      if (value == null) {
                        return 'Please select an item';
                      }
                      return null;
                    },
                    dropdownSemantics: 'Open dropdown',
                  ),
                  ZetaSelectInput(
                    label: 'Medium',
                    hintText: 'Default hint text',
                    placeholder: 'Placeholder',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value != 'Item 2') {
                        return 'Please select Item 2';
                      }
                      return null;
                    },
                    items: items,
                  ),
                  ZetaSelectInput(
                    label: 'Small',
                    size: ZetaWidgetSize.small,
                    hintText: 'Default hint text',
                    placeholder: 'Placeholder',
                    items: items,
                  ),
                  ZetaSelectInput(
                    label: 'Disabled',
                    hintText: 'Default hint text',
                    placeholder: 'Placeholder',
                    disabled: true,
                    items: items,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ZetaButton(
                        label: 'Validate',
                        onPressed: () {
                          formKey.currentState?.validate();
                        },
                      ),
                      ZetaButton(
                        label: 'Reset',
                        onPressed: () {
                          formKey.currentState?.reset();
                        },
                      ),
                    ],
                  )
                ].divide(const SizedBox(height: 8)).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
