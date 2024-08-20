import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'package:zeta_flutter/zeta_flutter.dart';

Widget radiusUseCase(BuildContext context) {
  final radii = [
    Zeta.of(context).radii.none,
    Zeta.of(context).radii.minimal,
    Zeta.of(context).radii.rounded,
    Zeta.of(context).radii.full
  ];

  final rad = context.knobs.list(
    label: 'Radius',
    options: radii,
    labelBuilder: (value) => value.radiusString,
  );
  final colors = Zeta.of(context).colors;
  return SingleChildScrollView(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
            borderRadius: rad,
            color: Zeta.of(context).colors.primitives.blue.shade30,
            border: Border.all(color: colors.primitives.blue.shade80, width: 3),
          ),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: rad,
                color: Zeta.of(context).colors.surface.primary,
                border: Border.all(color: colors.primitives.blue.shade50, width: 3),
              ),
              padding: EdgeInsets.all(Zeta.of(context).spacing.large),
              child: Text(
                rad.radiusString.split('.').last.capitalize(),
                style: ZetaTextStyles.titleMedium.apply(
                  color: Zeta.of(context).colors.main.defaultColor,
                  fontStyle: FontStyle.normal,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

extension on BorderRadius {
  String get radiusString {
    if (topLeft.x == 0) return 'Zeta.of(context).radii.none';
    if (topLeft.x == 4) return 'Zeta.of(context).radii.minimal';
    if (topLeft.x == 8) return 'Zeta.of(context).radii.rounded';
    if (topLeft.x == 16) return 'Zeta.of(context).radii.large';
    if (topLeft.x == 24) return 'Zeta.of(context).radii.xl';
    return 'Zeta.of(context).radii.full';
  }
}
