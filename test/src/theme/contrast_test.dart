import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/src/theme/contrast.dart';

void main() {
  group('ZetaContrast Accessibility Indices', () {
    test('AA contrast indices', () {
      expect(ZetaContrast.aa.primary, 60);
      expect(ZetaContrast.aa.text, 60);
      expect(ZetaContrast.aa.icon, 60);
      expect(ZetaContrast.aa.hover, 70);
      expect(ZetaContrast.aa.selected, 80);
      expect(ZetaContrast.aa.focus, 80);
      expect(ZetaContrast.aa.border, 60);
      expect(ZetaContrast.aa.subtle, 40);
      expect(ZetaContrast.aa.surface, 10);
      expect(ZetaContrast.aa.targetContrast, 4.53);
    });

    test('AAA contrast indices', () {
      expect(ZetaContrast.aaa.primary, 80);
      expect(ZetaContrast.aaa.text, 80);
      expect(ZetaContrast.aaa.icon, 80);
      expect(ZetaContrast.aaa.hover, 90);
      expect(ZetaContrast.aaa.selected, 100);
      expect(ZetaContrast.aaa.focus, 100);
      expect(ZetaContrast.aaa.border, 80);
      expect(ZetaContrast.aaa.subtle, 60);
      expect(ZetaContrast.aaa.surface, 10);
      expect(ZetaContrast.aaa.targetContrast, 8.33);
    });
  });
}
