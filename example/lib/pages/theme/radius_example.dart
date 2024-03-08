import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class RadiusExample extends StatelessWidget {
  static const String name = 'Radius';

  const RadiusExample({super.key});

  @override
  Widget build(BuildContext context) {
    List<BorderRadius> radii = [
      ZetaRadius.none,
      ZetaRadius.minimal,
      ZetaRadius.rounded,
      ZetaRadius.wide,
      ZetaRadius.full
    ];
    final colors = Zeta.of(context).colors;
    return ExampleScaffold(
      name: name,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(ZetaSpacing.m),
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
                          padding: EdgeInsets.all(ZetaSpacing.b),
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
                    );
                  })
                  .divide(const SizedBox(height: ZetaSpacing.l))
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
    if (topLeft.x == 0) return 'ZetaRadius.none';
    if (topLeft.x == 4) return 'ZetaRadius.minimal';
    if (topLeft.x == 8) return 'ZetaRadius.rounded';
    if (topLeft.x == 24) return 'ZetaRadius.wide';
    return 'ZetaRadius.full';
  }
}
