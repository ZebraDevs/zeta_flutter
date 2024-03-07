import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'package:zeta_flutter/zeta_flutter.dart';

const Map<String, TextStyle> allTypes = {
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

Widget typographyUseCase(BuildContext context) => Padding(
      padding: const EdgeInsets.all(ZetaSpacing.m),
      child: Text(
        context.knobs.string(label: 'Text', initialValue: 'The quick brown fox jumps over the lazy dog.'),
        style: context.knobs
            .list(
              label: 'Sizes',
              labelBuilder: (p0) => allTypes.entries.firstWhere((element) => element.value == p0).key,
              options: allTypes.values.toList(),
            )
            .apply(
              color: Zeta.of(context).colors.textDefault,
              fontStyle: FontStyle.normal,
              decoration: TextDecoration.none,
            ),
      ),
    );
