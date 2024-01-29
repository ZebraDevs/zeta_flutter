import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'package:zeta_flutter/zeta_flutter.dart';

WidgetbookComponent textWidgetBook() {
  final dedicatedSizes = {
    'Display large': ZetaTextStyles.displayLarge,
    'Display medium': ZetaTextStyles.displayMedium,
    'Display small': ZetaTextStyles.displaySmall,
    'Heading 1': ZetaTextStyles.heading1,
    'Heading 2': ZetaTextStyles.heading2,
    'Heading 3': ZetaTextStyles.heading3,
    'Title large': ZetaTextStyles.titleLarge,
    'Title medium': ZetaTextStyles.titleMedium,
    'Title small': ZetaTextStyles.titleSmall,
    'Body large': ZetaTextStyles.bodyLarge,
    'Body medium': ZetaTextStyles.bodyMedium,
    'Body small': ZetaTextStyles.bodySmall,
    'Label large': ZetaTextStyles.labelLarge,
    'Label medium': ZetaTextStyles.labelMedium,
    'Label small': ZetaTextStyles.labelSmall,
    'Label indicator': ZetaTextStyles.labelIndicator,
    'Label tiny': ZetaTextStyles.labelTiny,
  };
  return WidgetbookComponent(
    name: 'Typography',
    useCases: [
      WidgetbookUseCase(
        name: 'Text styles',
        builder: (context) => Container(
          color: Theme.of(context).colorScheme.background,
          padding: const EdgeInsets.all(ZetaSpacing.l),
          child: Text(
            context.knobs.string(label: 'Text', initialValue: 'The quick brown fox jumps over the lazy dog.'),
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
