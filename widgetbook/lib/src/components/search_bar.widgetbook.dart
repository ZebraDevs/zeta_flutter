import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

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
  path: '$componentsPath/Search Bar',
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=21286-35997&t=sHwT9f9HuPjkpi1x-4',
)
Widget searchBarUseCase(BuildContext context) {
  var items = List<String>.from(_items);
  return Padding(
    padding: const EdgeInsets.all(16),
    child: StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ZetaSearchBar(
              size: context.knobs.object.dropdown<ZetaWidgetSize>(
                  label: 'Size', options: ZetaWidgetSize.values, labelBuilder: (size) => size.name),
              shape: context.knobs.object.dropdown<ZetaWidgetBorder>(
                label: 'Shape',
                options: ZetaWidgetBorder.values,
                labelBuilder: (shape) => shape.name,
              ),
              disabled: disabledKnob(context),
              placeholder: context.knobs.string(label: 'Hint', initialValue: 'Search'),
              showSpeechToText: context.knobs.boolean(label: 'Show Speech-To-Text button', initialValue: true),
              onChange: (value) {
                if (value == null) return;
                setState(
                    () => items = _items.where((item) => item.toLowerCase().contains(value.toLowerCase())).toList());
              },
              onSpeechToText: () async => 'I wanted to say...',
            ),
            SizedBox(height: Zeta.of(context).spacing.xl),
            ...items.map(Text.new),
          ],
        );
      },
    ),
  );
}
