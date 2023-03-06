import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart' hide DeviceType;
import 'package:zeta_example/pages/spacing_example.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

const List<Option<SpacingType>> typeSelector = [
  Option(label: 'Square', value: SpacingType.square),
  Option(label: 'Squish', value: SpacingType.squish),
  Option(label: 'Inline', value: SpacingType.inline),
  Option(label: 'Inline Start', value: SpacingType.inlineStart),
  Option(label: 'Inline End', value: SpacingType.inlineEnd),
  Option(label: 'Stack', value: SpacingType.stack),
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
                    size: context.knobs.options(label: 'Size', options: const [
                      Option(label: 'x0', value: x0),
                      Option(label: 'x1', value: x1),
                      Option(label: 'x2', value: x2),
                      Option(label: 'x3', value: x3),
                      Option(label: 'x4', value: x3),
                      Option(label: 'x5', value: x4),
                      Option(label: 'x6', value: x5),
                      Option(label: 'x7', value: x6),
                      Option(label: 'x8', value: x7),
                      Option(label: 'x9', value: x8),
                      Option(label: 'x10', value: x9),
                      Option(label: 'x11', value: x10),
                      Option(label: 'x12', value: x12),
                      Option(label: 'x16', value: x16),
                      Option(label: 'x20', value: x20),
                      Option(label: 'x24', value: x24),
                    ]),
                    type: context.knobs.options(label: 'Spacing Type', options: typeSelector),
                    child: const SpacingItem(),
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
                    size: context.knobs.options(label: 'Size', options: const [
                      Option(label: 'xxs', value: xxs),
                      Option(label: 'xs', value: xs),
                      Option(label: 's', value: s),
                      Option(label: 'm', value: m),
                      Option(label: 'l', value: l),
                      Option(label: 'xl', value: xl),
                      Option(label: 'xxl', value: xxl),
                      Option(label: 'xxxl', value: xxxl),
                    ]),
                    type: context.knobs.options(label: 'Spacing Type', options: typeSelector),
                    child: const SpacingItem(),
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
                    size: (context.knobs.slider(
                                label: 'Size (rounding to nearest even int)', min: 0, max: 96, initialValue: 0) ~/
                            2) *
                        2,
                    type: context.knobs.options(label: 'Spacing Type', options: typeSelector),
                    child: const SpacingItem(),
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
