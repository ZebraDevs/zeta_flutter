import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

const double _paddingSize = 40;

class DialPadExample extends StatefulWidget {
  static const String name = 'DialPad';

  const DialPadExample({super.key});

  @override
  State<DialPadExample> createState() => _DialPadExampleState();
}

class _DialPadExampleState extends State<DialPadExample> {
  String number = '', text = '';

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: DialPadExample.name,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: _paddingSize),
            SizedBox(
              child: Text(
                number,
                style: Zeta.of(context).textStyles.heading3,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            IconButton(
              icon: Icon(Icons.backspace),
              onPressed: () => number.length == 0
                  ? null
                  : setState(
                      () => number = number.substring(0, (number.length - 1)),
                    ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Nothing(),
            Text(
              text,
              style: Zeta.of(context).textStyles.heading3,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            IconButton(
              icon: Icon(Icons.backspace),
              onPressed: () => text.length == 0
                  ? null
                  : setState(
                      () => text = text.substring(0, text.length - 1),
                    ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          key: Key('docs-dialpad'),
          children: [
            ZetaDialPad(
              onNumber: (value) => setState(() => number += value),
              onText: (value) => setState(() => text += value),
            ),
          ],
        ),
        ZetaButton.primary(
          label: 'Clear',
          borderType: ZetaWidgetBorder.full,
          onPressed: () => setState(() => number = text = ''),
        )
      ].divide(SizedBox(height: Zeta.of(context).spacing.xl_2)).toList(),
    );
  }
}
