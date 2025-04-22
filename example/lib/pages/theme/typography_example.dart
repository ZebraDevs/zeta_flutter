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
      'Display Large': Zeta.of(context).textStyles.displayLarge,
      'Display Medium': Zeta.of(context).textStyles.displayMedium,
      'Display Small': Zeta.of(context).textStyles.displaySmall,
      'Heading 1': Zeta.of(context).textStyles.heading1,
      'Heading 2': Zeta.of(context).textStyles.heading2,
      'Heading 3': Zeta.of(context).textStyles.heading3,
      'Title Large': Zeta.of(context).textStyles.titleLarge,
      'Title Medium': Zeta.of(context).textStyles.titleMedium,
      'Title Small': Zeta.of(context).textStyles.titleSmall,
      'Body Large': Zeta.of(context).textStyles.bodyLarge,
      'Body Medium': Zeta.of(context).textStyles.bodyMedium,
      'Body Small': Zeta.of(context).textStyles.bodySmall,
      'Body X-Small': Zeta.of(context).textStyles.bodyXSmall,
      'Label Large': Zeta.of(context).textStyles.labelLarge,
      'Label Medium': Zeta.of(context).textStyles.labelMedium,
      'Label Small': Zeta.of(context).textStyles.labelSmall,
      'Label Indicator': Zeta.of(context).textStyles.labelIndicator,
    };

    return ExampleScaffold(
      name: name,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(Zeta.of(context).spacing.xl_4),
        child: Row(
          children: [
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: typography.entries
                    .map(
                      (e) => [
                        Text(e.key, style: e.value),
                        SizedBox(height: Zeta.of(context).spacing.minimum),
                        Text(
                          'Font Size: ' +
                              e.value.fontSize!.toInt().toString() +
                              ', Line Height:  ' +
                              (e.value.height! * e.value.fontSize!).toInt().toString() +
                              ', Weight: ' +
                              e.value.fontWeight!.value.toString(),
                          style: Zeta.of(context).textStyles.bodyMedium,
                        ),
                        SizedBox(height: Zeta.of(context).spacing.xl_9),
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
