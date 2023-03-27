import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_example/pages/typography_example.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

WidgetbookComponent textWidgetBook() {
  return WidgetbookComponent(
    name: 'Typography',
    useCases: [
      WidgetbookUseCase(
        name: 'Tokens',
        builder: (context) => const _TextWrapper(),
      ),
      WidgetbookUseCase(
        name: 'Universal sizes',
        builder: (context) => ZetaText(
          exampleText,
          fontSize: context.knobs.options(
            label: 'Sizes',
            options: const [
              Option(label: 'x3/x4', value: ZetaSpacing.x3),
              Option(label: 'x3.5/x4', value: ZetaSpacing.x3_5),
              Option(label: 'x4/x5', value: ZetaSpacing.x4),
              Option(label: 'x5/x6', value: ZetaSpacing.x5),
              Option(label: 'x6/x7', value: ZetaSpacing.x6),
              Option(label: 'x7/x8', value: ZetaSpacing.x7),
              Option(label: 'x8/x9', value: ZetaSpacing.x8),
              Option(label: 'x9/x10', value: ZetaSpacing.x9),
              Option(label: 'x10/x11', value: ZetaSpacing.x10),
              Option(label: 'x11/x12', value: ZetaSpacing.x11),
              Option(label: 'x12/x13', value: ZetaSpacing.x12),
              Option(label: 'x13/x14', value: ZetaSpacing.x13),
            ],
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'Dedicated sizes',
        builder: (context) => ZetaText(
          exampleText,
          style: context.knobs.options(
            label: 'Sizes',
            options: const [
              Option(label: 'Body small', value: ZetaText.zetaBodySmall),
              Option(label: 'Body medium', value: ZetaText.zetaBodyMedium),
              Option(label: 'Body large', value: ZetaText.zetaBodyLarge),
              Option(label: 'Description', value: ZetaText.zetaDescription),
              Option(label: 'Headline small', value: ZetaText.zetaHeadingSmall),
              Option(label: 'Headline medium', value: ZetaText.zetaHeadingMedium),
              Option(label: 'Headline large', value: ZetaText.zetaHeadingLarge),
              Option(label: 'Display small', value: ZetaText.zetaDisplaySmall),
              Option(label: 'Display medium', value: ZetaText.zetaDisplayMedium),
              Option(label: 'Display large', value: ZetaText.zetaDisplayLarge),
            ],
          ),
        ),
      ),
    ],
  );
}

class _TextWrapper extends StatelessWidget {
  const _TextWrapper();

  @override
  Widget build(BuildContext context) {
    return ZetaText(
      context.knobs.text(label: 'Input text', initialValue: exampleText.split(',').first),
      decoration: context.knobs.boolean(label: 'Underline') ? TextDecoration.underline : null,
      first: context.knobs.boolean(label: 'First'),
      last: context.knobs.boolean(label: 'Last'),
      fontStyle: context.knobs.boolean(label: 'Italic') ? FontStyle.italic : null,
      fontWeight: context.knobs.options(
        label: 'Font Weight',
        options: const [
          Option(label: 'Default', value: FontWeight.w400),
          Option(label: 'Light', value: FontWeight.w300),
          Option(label: 'Medium', value: FontWeight.w500),
        ],
      ),
      resetHeight: context.knobs.boolean(label: 'Reset height'),
      textColor: context.knobs.options(
        label: 'Text color',
        options: const [
          Option(label: 'Default', value: ZetaColors.textColor),
          Option(label: 'Subtle', value: ZetaColors.textColorSubtle),
        ],
      ),
      textDirection: context.knobs.options(
        label: 'Text direction',
        options: const [
          Option(label: 'LTR', value: TextDirection.ltr),
          Option(label: 'RTL', value: TextDirection.rtl),
        ],
      ),
      upperCase: context.knobs.boolean(label: 'Upper case'),
      maxWidth: context.knobs.slider(label: 'Width', initialValue: 66, max: 100, min: 10, divisions: 90),
      fontSize: context.knobs.slider(label: 'Font size', initialValue: 12, divisions: 42, min: 12, max: 96),
    );
  }
}
