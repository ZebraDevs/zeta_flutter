import 'package:flutter_test/flutter_test.dart';

import 'package:zeta_icons/zeta_icons.dart';

void main() {
  test('Icons should have unique code points', () {
    final codePoints = icons.values.map((icon) => icon.codePoint).toSet();
    expect(codePoints.length, icons.length);
  });

  test('Icons should have correct font family', () {
    expect(ZetaIcons.alarm_round.fontFamily, ZetaIcons.familyRound);
    expect(ZetaIcons.alarm_sharp.fontFamily, ZetaIcons.familySharp);
  });

  // TODO(test): Find a way to test icon data, perhaps against generated PNGs?
}
