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
                    label: 'Label',
                    hintText: 'Default hint text',
                    initialValue: "Item 1",
                    items: [
                      ZetaDropdownItem(
                        value: "Item 1",
                        icon: Icon(ZetaIcons.star_round),
                      ),
                      ZetaDropdownItem(
                        value: "Item 2",
                        icon: Icon(ZetaIcons.star_half_round),
                      ),
                      ZetaDropdownItem(
                        value: "Item 3",
                      ),
                    ],
                  ),
                  ZetaButton(
                    label: 'Validate',
                    onPressed: () {
                      formKey.currentState?.validate();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
