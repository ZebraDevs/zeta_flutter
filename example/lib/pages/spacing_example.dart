import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../widgets.dart';

class _SizeEx {
  final String name;
  final double? value;

  const _SizeEx({required this.name, required this.value});
}

class _TypeEx {
  final String name;
  final ZetaSpacingType? value;
  final String description;

  const _TypeEx({required this.name, required this.value, required this.description});
}

class SpacingExample extends StatelessWidget {
  static const String name = 'Spacing';

  const SpacingExample({super.key});

  static const List<_SizeEx> _sizes = [
    _SizeEx(name: '', value: null),
    _SizeEx(name: 'x1', value: Dimensions.x1),
    _SizeEx(name: 'xxs', value: Dimensions.xxs),
    _SizeEx(name: 'x2', value: Dimensions.x2),
    _SizeEx(name: 'xs', value: Dimensions.xs),
    _SizeEx(name: 'x3', value: Dimensions.x3),
    _SizeEx(name: 's', value: Dimensions.s),
    _SizeEx(name: 'x4', value: Dimensions.x4),
    _SizeEx(name: 'b', value: Dimensions.b),
    _SizeEx(name: 'x5', value: Dimensions.x5),
    _SizeEx(name: 'x6', value: Dimensions.x6),
    _SizeEx(name: 'm', value: Dimensions.m),
    _SizeEx(name: 'x7', value: Dimensions.x7),
    _SizeEx(name: 'x8', value: Dimensions.x8),
    _SizeEx(name: 'l', value: Dimensions.l),
    _SizeEx(name: 'x9', value: Dimensions.x9),
    _SizeEx(name: 'x10', value: Dimensions.x10),
    _SizeEx(name: 'x11', value: Dimensions.x11),
    _SizeEx(name: 'x12', value: Dimensions.x12),
    _SizeEx(name: 'x16', value: Dimensions.x16),
    _SizeEx(name: 'xl', value: Dimensions.xl),
    _SizeEx(name: 'x20', value: Dimensions.x20),
    _SizeEx(name: 'xxl', value: Dimensions.xxl),
    _SizeEx(name: 'x24', value: Dimensions.x24),
    _SizeEx(name: 'xxxl', value: Dimensions.xxxl),
  ];

  static const List<_TypeEx> _types = [
    _TypeEx(name: '', value: null, description: 'Adds {0}rem either or both margin and padding.'),
    _TypeEx(name: 'square', value: ZetaSpacingType.square, description: 'Adds {0}rem padding.'),
    _TypeEx(name: 'squish', value: ZetaSpacingType.squish, description: 'Adds {0}rem top and bottom padding.'),
    _TypeEx(name: 'inline', value: ZetaSpacingType.inline, description: 'Adds {0}rem left and right padding.'),
    _TypeEx(name: 'inline.start', value: ZetaSpacingType.inlineStart, description: 'Adds {0}rem start padding.'),
    _TypeEx(name: 'inline.end', value: ZetaSpacingType.inlineEnd, description: 'Adds {0}rem end padding.'),
    _TypeEx(name: 'stack', value: ZetaSpacingType.stack, description: 'Adds {0}rem bottom padding.'),
  ];

  static final List<ExampleModel?> _x = _sizes
      .map((size) {
        final x = _types.map((type) {
          return ExampleModel(
            token: r'$spacing.zeta' +
                (type.value != null ? '.${type.name}' : '') +
                (size.value != null ? '.${size.name}' : ''),
            example: _SpaceExample(size: size.value ?? 0, type: type.value ?? ZetaSpacingType.square),
            description: type.description.replaceAll('{0}', size.value == null ? '0' : (size.value! ~/ 4).toString()),
            code:
                'ZetaSpacing${type.value != null ? '.${type.name}' : ''}(child${size.value != null ? ', size: ZetaSpacing.${size.name}' : ''})',
          );
        });
        return [...x, null];
      })
      .expand((element) => element)
      .toList();

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: name,
      child: ListView.builder(
        padding: EdgeInsets.all(Dimensions.s),
        itemCount: _x.length,
        itemBuilder: (context, index) {
          final e = _x[index];
          return e == null ? const Divider() : ExampleBuilder(e);
        },
      ),
    );
  }
}

class _SpaceExample extends StatelessWidget {
  final double size;
  final ZetaSpacingType type;

  const _SpaceExample({required this.size, required this.type});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ColoredBox(
            color: Zeta.of(context).colors.blue.shade20,
            child: ZetaSpacing(const SpacingItem(), size: size, type: type),
          ),
        ),
      ],
    );
  }
}

class SpacingItem extends StatelessWidget {
  const SpacingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(color: const Color(0xFFdddddd)),
      ),
      child: const Text('Text with some spacing'),
    );
  }
}
