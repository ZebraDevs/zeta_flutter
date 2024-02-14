import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'package:zeta_flutter/zeta_flutter.dart';

WidgetbookComponent radiusWidgetbook() {
  return WidgetbookComponent(
    name: 'Radius',
    useCases: [
      WidgetbookUseCase(
        name: 'Radius',
        builder: (context) => SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: radii.entries
                    .map((obj) => _RadiiDemo(obj))
                    .divide(const SizedBox.square(dimension: ZetaSpacing.l))
                    .toList(),
              ).paddingTop(ZetaSpacing.l),
            ],
          ),
        ),
      ),
    ],
  );
}

Map<String, BorderRadius> radii = {
  'none': ZetaRadius.none,
  'minimal': ZetaRadius.minimal,
  'rounded': ZetaRadius.rounded,
  'wide': ZetaRadius.wide,
  'full': ZetaRadius.full,
};

class _RadiiDemo extends StatelessWidget {
  final MapEntry<String, BorderRadius> obj;
  const _RadiiDemo(this.obj);

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: obj.value,
        color: Zeta.of(context).colors.blue.shade30,
        border: Border.all(color: colors.blue.shade80, width: 3),
      ),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: obj.value,
            color: Zeta.of(context).colors.surfacePrimary,
            border: Border.all(color: colors.blue.shade50, width: 3),
          ),
          padding: EdgeInsets.all(ZetaSpacing.b),
          child: Text(
            'ZetaRadius.' + obj.key,
            style: ZetaTextStyles.titleMedium.apply(
              color: Zeta.of(context).colors.textDefault,
              fontStyle: FontStyle.normal,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}
