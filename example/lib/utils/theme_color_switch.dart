import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class ZetaThemeColorSwitch extends StatefulWidget {
  ZetaThemeColorSwitch({super.key});

  @override
  State<ZetaThemeColorSwitch> createState() => _ZetaThemeColorSwitchState();
}

class _ZetaThemeColorSwitchState extends State<ZetaThemeColorSwitch> {
  String currentTheme = "default";

  final Map<String, ZetaColorSwatch?> appThemes = {
    "default": null,
    "teal": ZetaPrimitivesLight().teal,
    "yellow": ZetaPrimitivesLight().yellow,
    "red": ZetaPrimitivesLight().red,
    "purple": ZetaPrimitivesLight().purple,
    "green": ZetaPrimitivesLight().green,
  };

  String get currentValue {
    if (Zeta.of(context).brightness == Brightness.light) {
      return appThemes.entries
              .firstWhereOrNull((element) => element.value?.value == Zeta.of(context).colors.mainPrimary.value)
              ?.key ??
          "default";
    }
    if (Zeta.of(context).brightness == Brightness.dark) {
      return appThemes.entries
              .firstWhereOrNull((element) => element.value?.shade50.value == Zeta.of(context).colors.mainPrimary.value)
              ?.key ??
          "default";
    }
    return 'default';
  }

  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);

    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: currentValue,
        elevation: 0,
        padding: EdgeInsets.all(8),
        icon: Nothing(),
        dropdownColor: zeta.colors.borderDisabled,
        items: appThemes.entries.map((e) {
          final color = e.value;
          final name = e.key;
          return DropdownMenuItem<String>(
            value: name,
            alignment: Alignment.center,
            child: ZetaAvatar(
              size: ZetaAvatarSize.xxs,
              backgroundColor: Zeta.of(context).colors.surfaceDefault,
              image: ZetaIcon(
                Icons.color_lens,
                color: color ??
                    (Zeta.of(context).brightness == Brightness.light
                        ? ZetaPrimitivesLight().blue
                        : ZetaPrimitivesDark().blue),
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {
          final theme = appThemes[value];
          if (theme != null && value != null) {
            ZetaProvider.of(context).updateThemeData(primary: theme);
            setState(() {
              currentTheme = value;
            });
          }
        },
      ),
    );
  }
}
