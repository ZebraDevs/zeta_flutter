import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class ZetaThemeContrastSwitch extends StatelessWidget {
  ZetaThemeContrastSwitch({super.key});

  late final _themes = [
    ZetaContrast.aa,
    ZetaContrast.aaa,
  ];

  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);

    ZetaColors zetaColors(ZetaContrast contrast) {
      if (zeta.brightness == Brightness.light) {
        return zeta.themeData.apply(contrast: contrast).colorsLight;
      } else {
        return zeta.themeData.apply(contrast: contrast).colorsDark;
      }
    }

    return DropdownButtonHideUnderline(
      child: DropdownButton<ZetaContrast>(
        value: zeta.contrast,
        elevation: 0,
        isDense: true,
        alignment: Alignment.center,
        icon: SizedBox(width: 8),
        dropdownColor: zeta.colors.borderDisabled,
        items: _themes.map((e) {
          final colors = zetaColors(e);
          return DropdownMenuItem<ZetaContrast>(
            value: e,
            alignment: Alignment.center,
            child: CircleAvatar(
              backgroundColor: colors.primary.surface,
              foregroundColor: colors.primary,
              child: ZetaText.bodyMedium(
                e == ZetaContrast.aa ? 'AA' : 'AAA',
                textColor: colors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            ZetaProvider.of(context).updateContrast(value);
          }
        },
      ),
    );
  }
}
