import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

Widget checkboxUseCase(BuildContext context) => WidgetbookTestWidget(
      widget: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: _CheckState(context: context, initialState: true),
          ),
        ],
      ),
    );

class _CheckState extends StatefulWidget {
  final BuildContext context;
  final bool? initialState;
  const _CheckState({required this.context, this.initialState});

  @override
  State<_CheckState> createState() => __CheckStateState();
}

class __CheckStateState extends State<_CheckState> {
  bool? b = null;

  @override
  void initState() {
    super.initState();
    b = widget.initialState;
  }

  @override
  Widget build(BuildContext _) {
    dynamic onChanged =
        context.knobs.boolean(label: 'Enabled', initialValue: true) ? (b2) => setState(() => b = b2) : null;

    return Column(
      children: [
        ZetaCheckbox(
          value: b,
          onChanged: onChanged,
          useIndeterminate: context.knobs.boolean(label: 'Use Indeterminate', initialValue: true),
          rounded: context.knobs.boolean(label: 'Rounded'),
          label: context.knobs.string(label: 'Label', initialValue: 'Checkbox'),
        ),
      ],
    );
  }
}
