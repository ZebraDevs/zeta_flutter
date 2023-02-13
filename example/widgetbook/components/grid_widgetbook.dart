import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart' hide DeviceType;
import 'package:zeta_flutter/zeta_flutter.dart';

import 'package:zeta_example/pages/grid_example.dart';

WidgetbookComponent gridWidgetBook() {
  return WidgetbookComponent(
    name: 'Grid',
    useCases: [
      WidgetbookUseCase(
        name: 'Basic Grid',
        builder: (context) => SingleChildScrollView(
          child: ZetaGrid(
            col: context.knobs.slider(label: 'col', min: 2, max: 16, divisions: 7, initialValue: 12).toInt(),
            noGaps: context.knobs.boolean(label: 'No Gaps'),
            children: List.generate(16, (index) => const GridItem()),
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'Asymmetrical Grid',
        builder: (context) => SingleChildScrollView(
          child: ZetaGrid(
            asymmetricWeight: (context.knobs.slider(label: 'Asymmetric', min: 1, max: 11, divisions: 10)).toInt(),
            noGaps: context.knobs.boolean(label: 'No Gaps'),
            children: List.generate(16, (index) => const GridItem()),
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'Hybrid Grid',
        builder: (context) => LayoutBuilder(
          builder: (context, constraints) {
            const double initialSize = 10;
            const double maxSize = 100;

            return ZetaGrid(
              noGaps: context.knobs.boolean(label: 'No Gaps'),
              hybrid: true,
              children: [
                GridItem(width: context.knobs.slider(label: '1', min: 1, max: maxSize, initialValue: initialSize)),
                const Flexible(child: GridItem()),
                GridItem(width: context.knobs.slider(label: '2', min: 1, max: maxSize, initialValue: initialSize)),
                const Flexible(child: GridItem()),
                GridItem(width: context.knobs.slider(label: '3', min: 1, max: maxSize, initialValue: initialSize)),
                const Flexible(child: GridItem()),
                GridItem(width: context.knobs.slider(label: '4', min: 1, max: maxSize, initialValue: initialSize)),
              ],
            );
          },
        ),
      )
    ],
  );
}
