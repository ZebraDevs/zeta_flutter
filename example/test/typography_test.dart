import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_example/pages/theme/typography_example.dart';

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
                const Text(exampleText, key: key1),
                Text(exampleText, style: ZetaTextStyles.bodyMedium, key: key2),
                Text(exampleText, style: ZetaTextStyles.displayLarge, key: key3),
                Text(
                  exampleText,
                  style: TextStyle(fontSize: 52, fontWeight: FontWeight.w300, height: 64 / 52),
                  key: key4,
                ),
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

    /// Test default in [Text] widget is [ZetaTextStyles.bodyMedium].
    expect(text1.style, text2.style);

    /// Test that [ZetaTextStyles.displayLarge] has not changed.
    expect(text3.style, text4.style);

    /// Test font size of [ZetaTextStyles.bodyMedium] is correct
    expect(text1.style!.fontSize, 14);

    /// Test line height of [ZetaTextStyles.bodyMedium] is correct
    expect(text1.style!.height, 20 / 14);

    /// Test font weight of [ZetaTextStyles.bodyMedium] is correct
    expect(text1.style!.fontWeight, FontWeight.w400);
  });
}
