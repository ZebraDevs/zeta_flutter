import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';
import '../../utils/utils.dart';

const List<String> _items = [
  'The quick...',
  'The quick brown...',
  'The quick brown fox...',
  'The quick brown fox jumped...',
  'The quick brown fox jumped into...',
  'The quick brown fox jumped into the hole...',
];

Widget searchBarUseCase(BuildContext context) {
  List<String> items = List.from(_items);
  return WidgetbookTestWidget(
    widget: StatefulBuilder(
      builder: (context, setState) {
        final hint = context.knobs.string(
          label: 'Hint',
          initialValue: 'Search',
        );
        final disabled = disabledKnob(context);

        final size = context.knobs.list<ZetaWidgetSize>(
          label: 'Size',
          options: ZetaWidgetSize.values,
          labelBuilder: (size) => size.name,
        );
        final shape = context.knobs.list<ZetaWidgetBorder>(
          label: 'Shape',
          options: ZetaWidgetBorder.values,
          labelBuilder: (shape) => shape.name,
        );
        final showLeadingIcon = context.knobs.boolean(
          label: 'Show leading icon',
          initialValue: true,
        );
        final showSpeechToText = context.knobs.boolean(
          label: 'Show Speech-To-Text button',
          initialValue: true,
        );

        return Padding(
          padding: const EdgeInsets.all(ZetaSpacing.xl_1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ZetaSearchBar(
                size: size,
                shape: shape,
                disabled: disabled,
                hint: hint,
                showLeadingIcon: showLeadingIcon,
                showSpeechToText: showSpeechToText,
                onChanged: (value) {
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
              const SizedBox(height: ZetaSpacing.xl_1),
              ...items.map((item) => Text(item)).toList(),
            ],
          ),
        );
      },
    ),
  );
}
