import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

// TODO(Luke): Go over this one
const List<String> _items = [
  'The quick...',
  'The quick brown...',
  'The quick brown fox...',
  'The quick brown fox jumped...',
  'The quick brown fox jumped into...',
  'The quick brown fox jumped into the hole...',
];
@widgetbook.UseCase(
  name: 'Search Bar',
  type: ZetaSearchBar,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=21286-35997&t=9UKEEDe1Zek0JZal-4',
)
Widget searchBarUseCase(BuildContext context) {
  List<String> items = List.from(_items);
  return StatefulBuilder(
    builder: (context, setState) {
      final hint = context.knobs.string(label: 'Hint', initialValue: 'Search');
      final disabled = disabledKnob(context);

      final size = context.knobs
          .list<ZetaWidgetSize>(label: 'Size', options: ZetaWidgetSize.values, labelBuilder: (size) => size.name);
      final shape = context.knobs.list<ZetaWidgetBorder>(
          label: 'Shape', options: ZetaWidgetBorder.values, labelBuilder: (shape) => shape.name);
      final showSpeechToText = context.knobs.boolean(label: 'Show Speech-To-Text button', initialValue: true);

      return Padding(
        padding: EdgeInsets.all(Zeta.of(context).spacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ZetaSearchBar(
              size: size,
              shape: shape,
              disabled: disabled,
              placeholder: hint,
              showSpeechToText: showSpeechToText,
              onChange: (value) {
                if (value == null) return;
                setState(
                  () => items = _items
                      .where((item) => item.toLowerCase().contains(
                            value.toLowerCase(),
                          ))
                      .toList(),
                );
              },
              onSpeechToText: () async => 'I wanted to say...',
            ),
            SizedBox(height: Zeta.of(context).spacing.xl),
            ...items.map((item) => Text(item)),
          ],
        ),
      );
    },
  );
}
