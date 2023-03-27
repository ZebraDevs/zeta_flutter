// ignore_for_file: public_member_api_docs

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
    _SizeEx(name: 'x1', value: ZetaSpacing.x1),
    _SizeEx(name: 'xxs', value: ZetaSpacing.xxs),
    _SizeEx(name: 'x2', value: ZetaSpacing.x2),
    _SizeEx(name: 'xs', value: ZetaSpacing.xs),
    _SizeEx(name: 'x3', value: ZetaSpacing.x3),
    _SizeEx(name: 's', value: ZetaSpacing.s),
    _SizeEx(name: 'x4', value: ZetaSpacing.x4),
    _SizeEx(name: 'b', value: ZetaSpacing.b),
    _SizeEx(name: 'x5', value: ZetaSpacing.x5),
    _SizeEx(name: 'x6', value: ZetaSpacing.x6),
    _SizeEx(name: 'm', value: ZetaSpacing.m),
    _SizeEx(name: 'x7', value: ZetaSpacing.x7),
    _SizeEx(name: 'x8', value: ZetaSpacing.x8),
    _SizeEx(name: 'l', value: ZetaSpacing.l),
    _SizeEx(name: 'x9', value: ZetaSpacing.x9),
    _SizeEx(name: 'x10', value: ZetaSpacing.x10),
    _SizeEx(name: 'x11', value: ZetaSpacing.x11),
    _SizeEx(name: 'x12', value: ZetaSpacing.x12),
    _SizeEx(name: 'x16', value: ZetaSpacing.x16),
    _SizeEx(name: 'xl', value: ZetaSpacing.xl),
    _SizeEx(name: 'x20', value: ZetaSpacing.x20),
    _SizeEx(name: 'xxl', value: ZetaSpacing.xxl),
    _SizeEx(name: 'x24', value: ZetaSpacing.x24),
    _SizeEx(name: 'xxxl', value: ZetaSpacing.xxxl),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [..._x.map((e) => e == null ? const Divider() : ExampleBuilder(e)).toList()]..removeLast(),
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
          child: Container(
            color: exampleBlue,
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
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(color: const Color(0xFFdddddd)),
      ),
      child: const Text('Text with some spacing'),
    );
  }
}
