import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class ZetaRoundedSwitch extends StatelessWidget {
  ZetaRoundedSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);

    return DropdownButtonHideUnderline(
      child: DropdownButton<bool>(
        value: zeta.rounded,
        padding: EdgeInsets.all(8),
        elevation: 0,
        icon: Nothing(),
        dropdownColor: zeta.colors.border.disabled,
        items: [true, false].map((e) {
          return DropdownMenuItem<bool>(
            value: e,
            alignment: Alignment.center,
            child: ZetaAvatar(
              size: ZetaAvatarSize.xxs,
              image: Icon(e ? Icons.circle : Icons.square, color: zeta.colors.main.primary),
              initialTextStyle: TextStyle(
                fontSize: 28,
                letterSpacing: Zeta.of(context).spacing.none,
                color: Zeta.of(context).colors.main.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            ZetaProvider.of(context).updateRounded(value);
          }
        },
      ),
    );
  }
}
