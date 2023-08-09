import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../widgets.dart';

class GridExample extends StatelessWidget {
  static const String name = 'Grid';

  static const List<double?> symmetrical = [null, 2, 4, 8, 16];
  static const List<bool> noGaps = [false, true];
  static const List<double> asymmetrical = [11, 10, 9, 8, 7, 5, 4, 3, 2, 1];

  const GridExample({super.key});
  @override
  Widget build(BuildContext context) {
    final List<Widget> gridItems = List.generate(20, (index) => GridItem(label: (index + 1).toString()));

    final List<ExampleModel> examples = [
      ...symmetrical
          .map(
            (col) => noGaps.map(
              (noGaps) => ExampleModel(
                example: ZetaGrid(
                  col: col ?? 12,
                  noGaps: noGaps,
                  children: gridItems.getRange(0, (col ?? 12).toInt()).toList(),
                ),
                token:
                    r'$grid.zeta' + (col != null && col != 0 ? '.${col.toInt()}col' : '') + (noGaps ? '.nogaps' : ''),
                code:
                    'ZetaGrid(${col != null ? 'col:${col.toInt()}' : ''}${col != null && noGaps ? ', ' : ''}${noGaps ? 'noGaps: true' : ''}${col != null || noGaps ? ', ' : ''}children:[])',
              ),
            ),
          )
          .expand((element) => element),
      ...asymmetrical
          .map(
            (col) => noGaps.map(
              (noGaps) => ExampleModel(
                example: ZetaGrid(
                  asymmetricWeight: col.toInt(),
                  noGaps: noGaps,
                  children: gridItems.getRange(0, 12).toList(),
                ),
                token: r'$grid.zeta' + ('.${col.toInt()}to${(12 - col).toInt()}') + (noGaps ? '.nogaps' : ''),
                code: 'ZetaGrid(${'asymmetricWeight:${col.toInt()}'}${noGaps ? ', noGaps: true' : ''}, children:[])',
              ),
            ),
          )
          .expand((element) => element),
      ...noGaps.map(
        (noGaps) => ExampleModel(
          example: Column(
            children: [
              ZetaGrid(
                noGaps: noGaps,
                col: 8,
                hybrid: true,
                children: const [
                  GridItem(width: 120),
                  Flexible(fit: FlexFit.tight, child: GridItem()),
                  GridItem(width: 80),
                  Flexible(fit: FlexFit.tight, flex: 2, child: GridItem()),
                  GridItem(width: 76),
                  Flexible(fit: FlexFit.tight, child: GridItem()),
                  Flexible(fit: FlexFit.tight, flex: 3, child: GridItem()),
                  GridItem(width: 40),
                ],
              ),
            ],
          ),
          token: r'$grid.zeta.120px.1fr.80px.2fr.76px.1fr.3fr.40px' + (noGaps ? '.nogaps' : ''),
          code:
              'ZetaGrid(\n  col: 8,\n  hybrid: true,\n  ${noGaps ? 'noGaps: true,\n  ' : ''}children:[\n    GridItem(width: 120),\n    Flexible(fit: FlexFit.tight, child: GridItem()),\n    GridItem(width: 80),\n    Flexible(fit: FlexFit.tight, flex: 2, child: GridItem()),\n    GridItem(width: 76),\n    Flexible(fit: FlexFit.tight, child: GridItem()),\n    Flexible(fit: FlexFit.tight, flex: 3, child: GridItem()),\n    GridItem(width: 40),\n  ],\n)',
        ),
      )
    ];

    return ExampleScaffold(
      name: name,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [...examples.map(ExampleBuilder.new)],
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final String label;
  final double? width;
  const GridItem({this.label = '', this.width, super.key});

  @override
  Widget build(BuildContext context) {
    final ZetaColors colors = ZetaColors.of(context);
    return Container(
      height: 80,
      width: width,
      decoration: BoxDecoration(border: Border.all(color: colors.blue.border), color: colors.blue.shade20),
      child: ZetaText(label),
    );
  }
}
