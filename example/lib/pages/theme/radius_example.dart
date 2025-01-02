import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class RadiusExample extends StatelessWidget {
  static const String name = 'Radius';

  const RadiusExample({super.key});

  @override
  Widget build(BuildContext context) {
    List<BorderRadius> radii = [
      Zeta.of(context).radius.none,
      Zeta.of(context).radius.minimal,
      Zeta.of(context).radius.rounded,
      Zeta.of(context).radius.full
    ];
    final colors = Zeta.of(context).colors;
    return ExampleScaffold(
      name: name,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(Zeta.of(context).spacing.xl_2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: radii
                  .map((rad) {
                    return Container(
                      width: 250,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: rad,
                        color: Zeta.of(context).colors.surfacePrimarySubtle,
                        border: Border.all(color: colors.borderPrimary, width: 3),
                      ),
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: rad,
                            color: Zeta.of(context).colors.surfaceDefault,
                            border: Border.all(color: colors.borderPrimary, width: 3),
                          ),
                          padding: EdgeInsets.all(Zeta.of(context).spacing.large),
                          child: Text(
                            rad.radiusString.split('.').last.capitalize(),
                            style: ZetaTextStyles.titleMedium.apply(
                              color: Zeta.of(context).colors.mainDefault,
                              fontStyle: FontStyle.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    );
                  })
                  .divide(SizedBox(height: Zeta.of(context).spacing.xl_4))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

extension on BorderRadius {
  String get radiusString {
    if (topLeft.x == 0) return 'Zeta.of(context).radius.none';
    if (topLeft.x == 4) return 'Zeta.of(context).radius.minimal';
    if (topLeft.x == 8) return 'Zeta.of(context).radius.rounded';
    if (topLeft.x == 24) return 'Zeta.of(context).radius.wide';
    return 'Zeta.of(context).radius.full';
  }
}
