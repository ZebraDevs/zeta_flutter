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
      child: LayoutBuilder(builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: constraints.maxWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: _paddingSize),
                      SizedBox(
                        width: constraints.maxWidth - (_paddingSize * 2),
                        child: Text(
                          number,
                          style: ZetaTextStyles.heading3,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                        icon: ZetaIcon(Icons.backspace),
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
                        style: ZetaTextStyles.heading3,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                      IconButton(
                        icon: ZetaIcon(Icons.backspace),
                        onPressed: () => text.length == 0
                            ? null
                            : setState(
                                () => text = text.substring(0, text.length - 1),
                              ),
                      )
                    ],
                  ),
                  ZetaDialPad(
                    onNumber: (value) => setState(() => number += value),
                    onText: (value) => setState(() => text += value),
                  ),
                  ZetaButton.primary(
                    label: 'Clear',
                    borderType: ZetaWidgetBorder.full,
                    onPressed: () => setState(() => number = text = ''),
                  )
                ].divide(const SizedBox(height: ZetaSpacing.xl_2)).toList(),
              ),
            ),
          ],
        );
      }),
    );
  }
}
