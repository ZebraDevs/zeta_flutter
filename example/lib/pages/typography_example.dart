// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';
import '../widgets.dart';

const String exampleText = 'Lorem ipsum dolor sit amet.';
const String exampleParagraph =
    'Paragraph: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse varius enim in eros elementum tristique. Duis cursus, mi quis viverra ornare, eros dolor interdum nulla, ut commodo diam libero vitae erat. Aenean faucibus nibh et justo cursus id rutrum lorem imperdiet. Nunc ut sem vitae risus tristique posuere.';

class TypographyExample extends StatelessWidget {
  static const String name = 'Typography';

  const TypographyExample({super.key});

  static const tokens = [
    ExampleModel(
      example: ZetaText(exampleText),
      code: "ZetaText('')",
      token: r'$text.zeta',
    ),
    ExampleModel(
      example: ZetaText(exampleText, textColor: ZetaColors.textColorSubtle),
      code: "ZetaText('', textColor: ZetaColors.textColorSubtle)",
      token: r'$text.zeta.subtle',
    ),
    ExampleModel(
      example: ZetaText(exampleText, fontWeight: FontWeight.w300),
      code: "ZetaText('', fontWeight: FontWeight.w300)",
      token: r'$text.zeta.300',
    ),
    ExampleModel(
      example: ZetaText(exampleText, fontWeight: FontWeight.w500),
      code: "ZetaText('', fontWeight: FontWeight.w500)",
      token: r'$text.zeta.500',
    ),
    ExampleModel(
      example: ZetaText(exampleText, fontStyle: FontStyle.italic),
      code: "ZetaText('', fontStyle: FontStyle.italic)",
      token: r'$text.zeta.italics',
    ),
    ExampleModel(
      code: "ZetaText('', uppercase: true)",
      token: r'$text.zeta.caps',
      example: ZetaText(exampleText, upperCase: true),
    ),
    ExampleModel(
      example: ZetaText(exampleText, decoration: TextDecoration.underline),
      code: "ZetaText('', decoration: TextDecoration.underline)",
      token: r'$text.zeta.underline',
    ),
    ExampleModel(
      code: "ZetaText('', textDirection: TextDirection.rtl)",
      token: r'$text.zeta.direction',
      example: ZetaText(exampleText, textDirection: TextDirection.rtl),
    ),
    ExampleModel(
      code: "ZetaText('', first: true)",
      token: r'$text.zeta.first',
      example: ZetaText(exampleText, first: true),
    ),
    ExampleModel(
      code: "ZetaText('', last: true)",
      token: r'$text.zeta.last',
      example: ZetaText(exampleText, last: true),
    ),
    ExampleModel(
      code: "ZetaText('', resetHeight: true)",
      token: r'$text.zeta.reset',
      example: ZetaText(exampleText, resetHeight: true),
    ),
  ];

  static const Map<String, double> sizes = {
    'x3': Dimensions.x3,
    'x3_5': Dimensions.x3_5,
    'x4': Dimensions.x4,
    'x5': Dimensions.x5,
    'x6': Dimensions.x6,
    'x7': Dimensions.x7,
    'x8': Dimensions.x8,
    'x9': Dimensions.x9,
    'x10': Dimensions.x10,
    'x11': Dimensions.x11,
    'x12': Dimensions.x12,
    'x13': Dimensions.x13,
  };
  static final List<ExampleModel> universalSizes = sizes.entries.map(
    (size) {
      return ExampleModel(
        example: ZetaText(exampleText, fontSize: size.value),
        token: size.value == Dimensions.x3_5
            ? r'$text.zeta.x3_5.x4'
            // ignore: prefer_adjacent_string_concatenation
            : r'$text.zeta.x' + '${size.value ~/ 4}.x${(size.value + 4) ~/ 4}',
        code: "ZetaText('', size: ZetaSpacing.${size.key})",
      );
    },
  ).toList();

  static const dedicatedSizes = [
    ExampleModel(
      example: ZetaText.bodySmall(exampleText),
      wDescription: ZetaText.bodySmall(exampleParagraph, maxWidth: 66),
      code: "ZetaText.bodySmall('')",
      token: r'$text.zeta.bodysmall',
    ),
    ExampleModel(
      example: ZetaText.bodyMedium(exampleText),
      wDescription: ZetaText.bodyMedium(exampleParagraph, maxWidth: 66),
      code: "ZetaText.bodyMedium('')",
      token: r'$text.zeta.bodymedium',
    ),
    ExampleModel(
      example: ZetaText.bodyLarge(exampleText),
      wDescription: ZetaText.bodyLarge(exampleParagraph, maxWidth: 66),
      code: "ZetaText.bodyLarge('')",
      token: r'$text.zeta.bodylarge',
    ),
    ExampleModel(
      example: ZetaText.titleSmall(exampleText),
      code: "ZetaText.titleSmall('')",
      token: r'$text.zeta.titlesmall',
    ),
    ExampleModel(
      example: ZetaText.titleMedium(exampleText),
      code: "ZetaText.titleMedium('')",
      token: r'$text.zeta.titlemedium',
    ),
    ExampleModel(
      example: ZetaText.titleLarge(exampleText),
      code: "ZetaText.titleLarge('')",
      token: r'$text.zeta.titlelarge',
    ),
    ExampleModel(
      example: ZetaText.headingSmall(exampleText),
      code: "ZetaText.headingSmall('')",
      token: r'$text.zeta.headingsmall',
    ),
    ExampleModel(
      example: ZetaText.headingMedium(exampleText),
      code: "ZetaText.headingMedium('')",
      token: r'$text.zeta.headingmedium',
    ),
    ExampleModel(
      example: ZetaText.headingLarge(exampleText),
      code: "ZetaText.headingLarge('')",
      token: r'$text.zeta.headinglarge',
    ),
    ExampleModel(
      example: ZetaText.displaySmall(exampleText),
      code: "ZetaText.displaySmall('')",
      token: r'$text.zeta.displaysmall',
    ),
    ExampleModel(
      example: ZetaText.displayMedium(exampleText),
      code: "ZetaText.displayMedium('')",
      token: r'$text.zeta.displaymedium',
    ),
    ExampleModel(
      example: ZetaText.displayLarge(exampleText),
      code: "ZetaText.displayLarge('')",
      token: r'$text.zeta.displaylarge',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: name,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ZetaText.headingLarge('Text').inline(Dimensions.x10),
          ...tokens.map(ExampleBuilder.new).toList(),
          const Divider().squish(Dimensions.x4),
          const ZetaText.headingLarge('Universal sizes').inline(Dimensions.x10),
          ...universalSizes.map(ExampleBuilder.new).toList(),
          const Divider().squish(Dimensions.x4),
          const ZetaText.headingLarge('Dedicated sizes').inline(Dimensions.x10),
          ...dedicatedSizes.map(ExampleBuilder.new).toList(),
        ],
      ),
    );
  }
}
