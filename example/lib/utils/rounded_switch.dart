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
        dropdownColor: zeta.colors.borderDisabled,
        items: [true, false].map((e) {
          return DropdownMenuItem<bool>(
            value: e,
            alignment: Alignment.center,
            child: ZetaAvatar(
              size: ZetaAvatarSize.xxs,
              initials: e ? '●' : '■',
              initialTextStyle: TextStyle(
                fontSize: 14,
                letterSpacing: ZetaSpacing.none,
                color: Zeta.of(context).colors.primary,
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
