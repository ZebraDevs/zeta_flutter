import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart' hide DeviceType;
import 'package:zeta_example/pages/spacing_example.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

const List<Option<ZetaSpacingType>> typeSelector = [
  Option(label: 'Square', value: ZetaSpacingType.square),
  Option(label: 'Squish', value: ZetaSpacingType.squish),
  Option(label: 'Inline', value: ZetaSpacingType.inline),
  Option(label: 'Inline Start', value: ZetaSpacingType.inlineStart),
  Option(label: 'Inline End', value: ZetaSpacingType.inlineEnd),
  Option(label: 'Stack', value: ZetaSpacingType.stack),
];
WidgetbookComponent spacingWidgetbook() {
  return WidgetbookComponent(
    name: 'Spacing',
    useCases: [
      WidgetbookUseCase(
        name: 'Defined numbers',
        builder: (context) => SingleChildScrollView(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  color: const Color(0xFFcce2fa),
                  child: ZetaSpacing(
                    const SpacingItem(),
                    size: context.knobs.options(label: 'Size', options: const [
                      Option(label: 'x0', value: ZetaSpacing.x0),
                      Option(label: 'x1', value: ZetaSpacing.x1),
                      Option(label: 'x2', value: ZetaSpacing.x2),
                      Option(label: 'x3', value: ZetaSpacing.x3),
                      Option(label: 'x4', value: ZetaSpacing.x3),
                      Option(label: 'x5', value: ZetaSpacing.x4),
                      Option(label: 'x6', value: ZetaSpacing.x5),
                      Option(label: 'x7', value: ZetaSpacing.x6),
                      Option(label: 'x8', value: ZetaSpacing.x7),
                      Option(label: 'x9', value: ZetaSpacing.x8),
                      Option(label: 'x10', value: ZetaSpacing.x9),
                      Option(label: 'x11', value: ZetaSpacing.x10),
                      Option(label: 'x12', value: ZetaSpacing.x12),
                      Option(label: 'x16', value: ZetaSpacing.x16),
                      Option(label: 'x20', value: ZetaSpacing.x20),
                      Option(label: 'x24', value: ZetaSpacing.x24),
                    ]),
                    type: context.knobs.options(label: 'Spacing Type', options: typeSelector),
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
                child: Container(
                  color: const Color(0xFFcce2fa),
                  child: ZetaSpacing(
                    const SpacingItem(),
                    size: context.knobs.options(label: 'Size', options: const [
                      Option(label: 'xxs', value: ZetaSpacing.xxs),
                      Option(label: 'xs', value: ZetaSpacing.xs),
                      Option(label: 's', value: ZetaSpacing.s),
                      Option(label: 'm', value: ZetaSpacing.m),
                      Option(label: 'l', value: ZetaSpacing.l),
                      Option(label: 'xl', value: ZetaSpacing.xl),
                      Option(label: 'xxl', value: ZetaSpacing.xxl),
                      Option(label: 'xxxl', value: ZetaSpacing.xxxl),
                    ]),
                    type: context.knobs.options(label: 'Spacing Type', options: typeSelector),
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
                child: Container(
                  color: const Color(0xFFcce2fa),
                  child: ZetaSpacing(
                    const SpacingItem(),
                    size: (context.knobs.slider(
                                label: 'Size (rounding to nearest even int)', min: 0, max: 96, initialValue: 0) ~/
                            2) *
                        2,
                    type: context.knobs.options(label: 'Spacing Type', options: typeSelector),
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
