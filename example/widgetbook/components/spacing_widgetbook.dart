import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart' hide DeviceType;
import 'package:zeta_example/pages/spacing_example.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

const List<ZetaSpacingType> typeSelector = [
  ZetaSpacingType.square,
  ZetaSpacingType.squish,
  ZetaSpacingType.inline,
  ZetaSpacingType.inlineStart,
  ZetaSpacingType.inlineEnd,
  ZetaSpacingType.stack,
];
WidgetbookComponent spacingWidgetbook() {
  final tShirtSizes = {
    'xxs': Dimensions.xxs,
    'xs': Dimensions.xs,
    's': Dimensions.s,
    'm': Dimensions.m,
    'l': Dimensions.l,
    'xl': Dimensions.xl,
    'xxl': Dimensions.xxl,
    'xxxl': Dimensions.xxxl,
  };
  return WidgetbookComponent(
    name: 'Spacing',
    useCases: [
      WidgetbookUseCase(
        name: 'Defined numbers',
        builder: (context) => SingleChildScrollView(
          child: Row(
            children: [
              Expanded(
                child: ColoredBox(
                  color: const Color(0xFFcce2fa),
                  child: ZetaSpacing(
                    const SpacingItem(),
                    size: context.knobs.list(
                      label: 'Size',
                      labelBuilder: (p0) => 'x${p0 ~/ 4}',
                      options: const [
                        Dimensions.x0,
                        Dimensions.x1,
                        Dimensions.x2,
                        Dimensions.x3,
                        Dimensions.x3,
                        Dimensions.x4,
                        Dimensions.x5,
                        Dimensions.x6,
                        Dimensions.x7,
                        Dimensions.x8,
                        Dimensions.x9,
                        Dimensions.x10,
                        Dimensions.x12,
                        Dimensions.x16,
                        Dimensions.x20,
                        Dimensions.x24,
                      ],
                    ),
                    type: context.knobs.list(label: 'Spacing Type', options: typeSelector),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'T-Shirt Sizes',
        builder: (context) => SingleChildScrollView(
          child: Row(
            children: [
              Expanded(
                child: ColoredBox(
                  color: const Color(0xFFcce2fa),
                  child: ZetaSpacing(
                    const SpacingItem(),
                    size: context.knobs.list(
                      label: 'Size',
                      labelBuilder: (p0) => tShirtSizes.entries.firstWhere((element) => element.value == p0).key,
                      options: tShirtSizes.values.toList(),
                    ),
                    type: context.knobs.list(label: 'Spacing Type', options: typeSelector),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'Numbers',
        builder: (context) => SingleChildScrollView(
          child: Row(
            children: [
              Expanded(
                child: ColoredBox(
                  color: const Color(0xFFcce2fa),
                  child: ZetaSpacing(
                    const SpacingItem(),
                    size: (context.knobs.double.slider(
                              label: 'Size (rounding to nearest even int)',
                              min: 0,
                              max: 96,
                              initialValue: 0,
                            ) ~/
                            2) *
                        2,
                    type: context.knobs.list(label: 'Spacing Type', options: typeSelector),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
