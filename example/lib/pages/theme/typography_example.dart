import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

const String exampleText = 'The quick brown fox jumps over the lazy dog.';

class TypographyExample extends StatelessWidget {
  static const String name = 'Typography';

  const TypographyExample({super.key});

  @override
  Widget build(BuildContext context) {
    final dedicatedSizes = [
      ExampleModel(
        example: Text(exampleText, style: ZetaTextStyles.displayLarge),
        code: "Text('...', style: ZetaTextStyles.displayLarge)",
        title: 'Display Large',
      ),
      ExampleModel(
        example: Text(exampleText, style: ZetaTextStyles.displayMedium),
        code: "Text('...', style: ZetaTextStyles.displayMedium)",
        title: 'Display Medium',
      ),
      ExampleModel(
        example: Text(exampleText, style: ZetaTextStyles.displaySmall),
        code: "Text('...', style: ZetaTextStyles.displaySmall)",
        title: 'Display Small',
      ),
      ExampleModel(
        example: Text(exampleText, style: ZetaTextStyles.heading1),
        code: "Text('...', style: ZetaTextStyles.heading1)",
        title: 'Heading 1',
      ),
      ExampleModel(
        example: Text(exampleText, style: ZetaTextStyles.heading2),
        code: "Text('...', style: ZetaTextStyles.heading2)",
        title: 'Heading 2',
      ),
      ExampleModel(
        example: Text(exampleText, style: ZetaTextStyles.heading3),
        code: "Text('...', style: ZetaTextStyles.heading3)",
        title: 'Heading 3',
      ),
      ExampleModel(
        example: Text(exampleText, style: ZetaTextStyles.titleLarge),
        code: "Text('...', style: ZetaTextStyles.titleLarge)",
        title: 'Title Large',
      ),
      ExampleModel(
        example: Text(exampleText, style: ZetaTextStyles.titleMedium),
        code: "Text('...', style: ZetaTextStyles.titleMedium)",
        title: 'Title Medium',
      ),
      ExampleModel(
        example: Text(exampleText, style: ZetaTextStyles.titleSmall),
        code: "Text('...', style: ZetaTextStyles.titleSmall)",
        title: 'Title Small',
      ),
      ExampleModel(
        example: Text(exampleText, style: ZetaTextStyles.bodyLarge),
        code: "Text('...', style: ZetaTextStyles.titleLarge)",
        title: 'Body Large',
      ),
      ExampleModel(
        example: Text(exampleText, style: ZetaTextStyles.bodyMedium),
        code: "Text('...', style: ZetaTextStyles.titleMedium)",
        title: 'Body Medium',
      ),
      ExampleModel(
        example: Text(exampleText, style: ZetaTextStyles.bodySmall),
        code: "Text('...', style: ZetaTextStyles.titleSmall)",
        title: 'Body Small',
      ),
      ExampleModel(
        example: Text(exampleText, style: ZetaTextStyles.labelLarge),
        code: "Text('...', style: ZetaTextStyles.labelLarge)",
        title: 'Label Large',
      ),
      ExampleModel(
        example: Text(exampleText, style: ZetaTextStyles.labelMedium),
        code: "Text('...', style: ZetaTextStyles.labelMedium)",
        title: 'Label Medium',
      ),
      ExampleModel(
        example: Text(exampleText, style: ZetaTextStyles.labelSmall),
        code: "Text('...', style: ZetaTextStyles.labelSmall)",
        title: 'Label Small',
      ),
      ExampleModel(
        example: Text(exampleText, style: ZetaTextStyles.labelIndicator),
        code: "Text('...', style: ZetaTextStyles.labelIndicator)",
        title: 'Label Indicator',
      ),
      ExampleModel(
        example: Text(exampleText, style: ZetaTextStyles.labelTiny),
        code: "Text('...', style: ZetaTextStyles.labelTiny)",
        title: 'Label Tiny',
      ),
    ];

    return ExampleScaffold(
      name: name,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(Dimensions.s),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...dedicatedSizes.map(ExampleBuilder.new),
          ],
        ),
      ),
    );
  }
}
