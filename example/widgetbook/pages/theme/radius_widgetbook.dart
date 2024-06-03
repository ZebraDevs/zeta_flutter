import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'package:zeta_flutter/zeta_flutter.dart';

Widget radiusUseCase(BuildContext context) {
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
            color: Zeta.of(context).colors.blue.shade30,
            border: Border.all(color: colors.blue.shade80, width: 3),
          ),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: rad,
                color: Zeta.of(context).colors.surfacePrimary,
                border: Border.all(color: colors.blue.shade50, width: 3),
              ),
              padding: EdgeInsets.all(ZetaSpacing.large),
              child: Text(
                rad.radiusString.split('.').last.capitalize(),
                style: ZetaTextStyles.titleMedium.apply(
                  color: Zeta.of(context).colors.textDefault,
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
    if (topLeft.x == 0) return 'ZetaRadius.none';
    if (topLeft.x == 4) return 'ZetaRadius.minimal';
    if (topLeft.x == 8) return 'ZetaRadius.rounded';
    if (topLeft.x == 24) return 'ZetaRadius.wide';
    return 'ZetaRadius.full';
  }
}

List<BorderRadius> radii = [ZetaRadius.none, ZetaRadius.minimal, ZetaRadius.rounded, ZetaRadius.full];
