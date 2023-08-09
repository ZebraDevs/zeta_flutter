import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart' hide DeviceType;
import 'package:zeta_example/pages/grid_example.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

WidgetbookComponent gridWidgetBook() {
  return WidgetbookComponent(
    name: 'Grid',
    useCases: [
      WidgetbookUseCase(
        name: 'Basic Grid',
        builder: (context) => SingleChildScrollView(
          child: ZetaGrid(
            col: context.knobs.double.slider(label: 'col', min: 2, max: 16, divisions: 7, initialValue: 12),
            noGaps: context.knobs.boolean(label: 'No Gaps'),
            children: List.generate(16, (index) => const GridItem()),
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'Asymmetrical Grid',
        builder: (context) => SingleChildScrollView(
          child: ZetaGrid(
            asymmetricWeight: context.knobs.double.slider(label: 'Asymmetric', min: 1, max: 11, divisions: 10).toInt(),
            noGaps: context.knobs.boolean(label: 'No Gaps'),
            children: List.generate(16, (index) => const GridItem()),
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'Hybrid Grid',
        builder: (context) => LayoutBuilder(
          builder: (context, constraints) {
            final double initialSize = constraints.maxWidth * 0.01;
            final double maxSize = (constraints.maxWidth - (context.knobs.boolean(label: 'No Gaps') ? 0 : 40)) * 0.2;

            return ZetaGrid(
              noGaps: context.knobs.boolean(label: 'No Gaps'),
              col: 7,
              hybrid: true,
              children: [
                GridItem(
                  width: context.knobs.double
                      .slider(label: 'Fixed width 1', min: 1, max: maxSize, initialValue: initialSize),
                  label: 'Fixed 1',
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: context.knobs.double.slider(label: 'Flex width 1', min: 0, max: 5, initialValue: 1).toInt(),
                  child: const GridItem(label: 'Flex 1'),
                ),
                GridItem(
                  width: context.knobs.double
                      .slider(label: 'Fixed width 2', min: 1, max: maxSize, initialValue: initialSize),
                  label: 'Fixed 2',
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: context.knobs.double.slider(label: 'Flex width 2', min: 0, max: 5, initialValue: 1).toInt(),
                  child: const GridItem(label: 'Flex 2'),
                ),
                GridItem(
                  width: context.knobs.double
                      .slider(label: 'Fixed width 3', min: 1, max: maxSize, initialValue: initialSize),
                  label: 'Fixed 3',
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: context.knobs.double.slider(label: 'Flex width 3', min: 0, max: 5, initialValue: 1).toInt(),
                  child: const GridItem(label: 'Flex 3'),
                ),
                GridItem(
                  width: context.knobs.double
                      .slider(label: 'Fixed width 4', min: 1, max: maxSize, initialValue: initialSize),
                  label: 'Fixed 4',
                ),
              ],
            );
          },
        ),
      )
    ],
  );
}
