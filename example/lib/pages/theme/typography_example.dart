import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

const String exampleText = 'The quick brown fox jumps over the lazy dog.';

class TypographyExample extends StatelessWidget {
  static const String name = 'Typography';

  const TypographyExample({super.key});

  @override
  Widget build(BuildContext context) {
    final typography = {
      'Display Large': ZetaTextStyles.displayLarge,
      'Display Medium': ZetaTextStyles.displayMedium,
      'Display Small': ZetaTextStyles.displaySmall,
      'Heading 1': ZetaTextStyles.heading1,
      'Heading 2': ZetaTextStyles.heading2,
      'Heading 3': ZetaTextStyles.heading3,
      'Title Large': ZetaTextStyles.titleLarge,
      'Title Medium': ZetaTextStyles.titleMedium,
      'Title Small': ZetaTextStyles.titleSmall,
      'Body Large': ZetaTextStyles.bodyLarge,
      'Body Medium': ZetaTextStyles.bodyMedium,
      'Body Small': ZetaTextStyles.bodySmall,
      'Body X-Small': ZetaTextStyles.bodyXSmall,
      'Label Large': ZetaTextStyles.labelLarge,
      'Label Medium': ZetaTextStyles.labelMedium,
      'Label Small': ZetaTextStyles.labelSmall,
      'Label Indicator': ZetaTextStyles.labelIndicator,
    };

    return ExampleScaffold(
      name: name,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(ZetaSpacing.xL4),
        child: Row(
          children: [
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: typography.entries
                    .map(
                      (e) => [
                        Text(e.key, style: e.value),
                        const SizedBox(height: ZetaSpacing.minimum),
                        Text(
                          'Font Size: ' +
                              e.value.fontSize!.toInt().toString() +
                              ', Line Height:  ' +
                              (e.value.height! * e.value.fontSize!).toInt().toString() +
                              ', Weight: ' +
                              e.value.fontWeight!.value.toString(),
                          style: ZetaTextStyles.bodyMedium,
                        ),
                        const SizedBox(height: ZetaSpacing.xL9),
                      ],
                    )
                    .expand((element) => element)
                    .toList()),
          ],
        ),
      ),
    );
  }
}
