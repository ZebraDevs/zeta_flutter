import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_example/pages/typography_example.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

WidgetbookComponent textWidgetBook() {
  final dedicatedSizes = {
    'Body small': ZetaText.zetaBodySmall,
    'Body medium': ZetaText.zetaBodyMedium,
    'Body large': ZetaText.zetaBodyLarge,
    'Description': ZetaText.zetaDescription,
    'Headline small': ZetaText.zetaHeadingSmall,
    'Headline medium': ZetaText.zetaHeadingMedium,
    'Headline large': ZetaText.zetaHeadingLarge,
    'Display small': ZetaText.zetaDisplaySmall,
    'Display medium': ZetaText.zetaDisplayMedium,
    'Display large': ZetaText.zetaDisplayLarge,
  };
  return WidgetbookComponent(
    name: 'Typography',
    useCases: [
      WidgetbookUseCase(
        name: 'Tokens',
        builder: (context) => const _TextWrapper(),
      ),
      WidgetbookUseCase(
        name: 'Universal sizes',
        builder: (context) => Container(
          color: ZetaColors.of(context).background,
          padding: const EdgeInsets.all(Dimensions.l),
          child: ZetaText(
            exampleText,
            fontSize: context.knobs.list(
              label: 'Sizes',
              labelBuilder: (p0) => p0 == 14 ? 'x3_5' : 'x${p0! ~/ 4}',
              options: const [
                Dimensions.x3,
                Dimensions.x3_5,
                Dimensions.x4,
                Dimensions.x5,
                Dimensions.x6,
                Dimensions.x7,
                Dimensions.x8,
                Dimensions.x9,
                Dimensions.x10,
                Dimensions.x11,
                Dimensions.x12,
                Dimensions.x13,
              ],
            ),
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'Dedicated sizes',
        builder: (context) => Container(
          color: ZetaColors.of(context).background,
          padding: const EdgeInsets.all(Dimensions.l),
          child: ZetaText(
            exampleText,
            style: context.knobs.list(
              label: 'Sizes',
              labelBuilder: (p0) => dedicatedSizes.entries.firstWhere((element) => element.value == p0).key,
              options: dedicatedSizes.values.toList(),
            ),
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
    final ZetaColors colors = ZetaColors.of(context);
    return Container(
      color: colors.background,
      padding: const EdgeInsets.all(Dimensions.l),
      child: ZetaText(
        context.knobs.string(label: 'Input text', initialValue: exampleText.split(',').first),
        decoration: context.knobs.boolean(label: 'Underline') ? TextDecoration.underline : null,
        first: context.knobs.boolean(label: 'First'),
        last: context.knobs.boolean(label: 'Last'),
        fontStyle: context.knobs.boolean(label: 'Italic') ? FontStyle.italic : null,
        fontWeight: context.knobs.list(
          label: 'Font Weight',
          labelBuilder: (p0) => p0 == FontWeight.w400
              ? 'Default'
              : p0 == FontWeight.w300
                  ? 'Light'
                  : 'Medium',
          options: const [FontWeight.w400, FontWeight.w300, FontWeight.w500],
        ),
        resetHeight: context.knobs.boolean(label: 'Reset height'),
        textColor: context.knobs.list(
          label: 'Text color',
          labelBuilder: (p0) => p0?.value == colors.textDefault.value ? 'Default' : 'Subtle',
          options: [colors.textDefault, colors.textSubtle],
        ),
        textDirection: context.knobs.list(
          label: 'Text direction',
          options: const [
            TextDirection.ltr,
            TextDirection.rtl,
          ],
        ),
        upperCase: context.knobs.boolean(label: 'Upper case'),
        maxWidth: context.knobs.double.slider(label: 'Width', initialValue: 66, max: 100, min: 10, divisions: 90),
        fontSize: context.knobs.double.slider(label: 'Font size', initialValue: 12, divisions: 42, min: 12, max: 96),
      ),
    );
  }
}
