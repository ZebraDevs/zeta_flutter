import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_example/pages/typography_example.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import 'test_components.dart';

void main() {
  const Key key1 = Key('1');
  const Key key2 = Key('2');
  const Key key3 = Key('3');
  const Key key4 = Key('4');

  testWidgets('Text tokens', (tester) async {
    await tester.pumpWidget(
      TestWidget(
        widget: Builder(
          builder: (context) {
            return Column(
              children: [
                const ZetaText(exampleText, key: key1),
                ZetaText(
                  exampleText,
                  maxWidth: 66,
                  decoration: TextDecoration.underline,
                  key: key2,
                  upperCase: true,
                  fontSize: 100,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500,
                  textColor: ZetaColors.of(context).textSubtle,
                  textDirection: TextDirection.rtl,
                  first: true,
                  last: true,
                ),
                ZetaText(exampleText, style: ZetaText.zetaHeadingLarge, key: key3),
                ZetaText.headingLarge(exampleText, key: key4),
              ],
            );
          },
        ),
      ),
    );

    final Finder zetaText1 = find.byKey(key1);
    final Finder zetaText2 = find.byKey(key2);
    final Finder zetaText3 = find.byKey(key3);
    final Finder zetaText4 = find.byKey(key4);

    final InlineSpan text1 =
        (find.descendant(of: zetaText1, matching: find.byType(RichText)).evaluate().first.widget as RichText).text;
    final InlineSpan text2 =
        (find.descendant(of: zetaText2, matching: find.byType(RichText)).evaluate().first.widget as RichText).text;
    final InlineSpan text3 =
        (find.descendant(of: zetaText3, matching: find.byType(RichText)).evaluate().first.widget as RichText).text;
    final InlineSpan text4 =
        (find.descendant(of: zetaText4, matching: find.byType(RichText)).evaluate().first.widget as RichText).text;

    final Padding padding1 =
        find.descendant(of: zetaText1, matching: find.byType(Padding)).evaluate().first.widget as Padding;
    final Padding padding2 =
        find.descendant(of: zetaText2, matching: find.byType(Padding)).evaluate().first.widget as Padding;

    final item1Size = tester.getSize(zetaText1);
    final item2Size = tester.getSize(zetaText2);

    expect(item1Size == item2Size, false);
    expect(item2Size.width.floor(), 800);
    expect(
      TextStyle(
        fontSize: text1.style?.fontSize,
        height: text1.style?.height,
        fontWeight: text1.style?.fontWeight,
      ),
      ZetaText.zetaBodyMedium,
    );
    expect(
      TextStyle(
            fontSize: text2.style?.fontSize,
            height: text2.style?.height,
            fontWeight: text2.style?.fontWeight,
          ) ==
          ZetaText.zetaBodyMedium,
      false,
    );
    expect(text1.style?.fontFamily, 'packages/zeta_flutter/IBMPlexSans');
    expect(text1.style?.color, const Color(0xFF1D1E23));

    expect(text1.style?.decoration, TextDecoration.none);
    expect(text1.toPlainText(), exampleText);
    expect(text2.toPlainText(), exampleText.toUpperCase());
    expect(text2.style?.decoration, TextDecoration.underline);
    expect(text2.style?.fontSize, 100);
    expect(text2.style?.fontStyle, FontStyle.italic);
    expect(text2.style?.fontWeight, FontWeight.w500);
    expect(text2.style?.color, const Color(0xFF545963));
    expect(padding1.padding, Dimensions.x2.squish);
    expect(padding2.padding, EdgeInsets.zero);
    expect(text3, text4);
  });
}
