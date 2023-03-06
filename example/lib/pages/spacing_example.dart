import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class _SpacingExampleModel {
  final double? size;
  final SpacingType? type;
  final String description;
  final String? code;

  const _SpacingExampleModel(this.size, this.type, this.description, [this.code]);
}

class SpacingExample extends StatelessWidget {
  const SpacingExample({super.key});

  static const List<Map<String, double?>> sizes = [
    {'': null},
    {'x0': x0},
    {'x1': x1},
    {'xxs': xxs},
    {'x2': x2},
    {'xs': xs},
    {'x3': x3},
    {'s': s},
    {'x4': x4},
    {'b': b},
    {'x5': x5},
    {'x6': x6},
    {'m': m},
    {'x7': x7},
    {'x8': x8},
    {'l': l},
    {'x9': x9},
    {'x10': x10},
  ];

  static const Map<SpacingType?, String> typeStrings = {
    null: 'All (square)',
    SpacingType.square: 'Square',
    SpacingType.squish: 'Squish (top and bottom)',
    SpacingType.inline: 'Inline (start and end)',
    SpacingType.inlineStart: 'Inline start ',
    SpacingType.inlineEnd: 'Inline end ',
    SpacingType.stack: 'Stack',
  };

  static final List<_SpacingExampleModel> _spacingExamples = sizes
      .map((size) {
        return typeStrings.keys
            .map((type) => _SpacingExampleModel(
                  size.values.first,
                  type,
                  '${size.keys.first} ${typeStrings[type]} padding',
                  'ZetaSpacing(${size.values.first != null ? 'size: ${size.keys.first}, ' : ''}${type != null ? 'type: $type,' : ''})',
                ))
            .toList();
      })
      .expand((e) => e)
      .toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: _spacingExamples.map((e) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(e.description, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: const Color(0xFFcce2fa),
                    child: ZetaSpacing(size: e.size ?? x0, type: e.type, child: const SpacingItem()),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Container(
              color: const Color(0xFFE9E9E9),
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(left: 16),
              child: Text(e.code ?? '', style: Theme.of(context).textTheme.bodyMedium),
            ),
            const SizedBox(height: 40),
          ],
        );
      }).toList(),
    );
  }
}

class SpacingItem extends StatelessWidget {
  const SpacingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(color: const Color(0xFFdddddd), width: 1),
      ),
      child: const Text('Text with some spacing'),
    );
  }
}
