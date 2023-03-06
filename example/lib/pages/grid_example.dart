import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class GridExampleModel {
  final double col;
  final bool noGaps;
  final int? asymmetric;
  final String name;
  final List<Widget>? children;
  final String? childrenText;

  const GridExampleModel(
    this.col,
    this.asymmetric,
    this.noGaps,
    this.name, [
    this.children,
    this.childrenText,
  ]);
}

class GridExample extends StatelessWidget {
  static const List<GridExampleModel> gridExamples = [
    GridExampleModel(12, null, false, 'Basic 12 col grid'),
    GridExampleModel(12, null, true, 'Basic 12 col grid gapless'),
    GridExampleModel(2, null, false, '2 col grid'),
    GridExampleModel(4, null, false, '4 col grid'),
    GridExampleModel(8, null, false, '8 col grid'),
    GridExampleModel(12, null, false, '12 col grid'),
    GridExampleModel(16, null, false, '16 col grid'),
    GridExampleModel(2, null, true, '2 col grid gapless'),
    GridExampleModel(4, null, true, '4 col grid gapless'),
    GridExampleModel(8, null, true, '8 col grid gapless'),
    GridExampleModel(12, null, true, '12 col grid gapless'),
    GridExampleModel(16, null, true, '16 col grid gapless'),
    GridExampleModel(12, 11, false, '11 to 1 grid'),
    GridExampleModel(12, 10, false, '10 to 2 grid'),
    GridExampleModel(12, 9, false, '9 to 3 grid'),
    GridExampleModel(12, 8, false, '8 to 4 grid'),
    GridExampleModel(12, 7, false, '7 to 5 grid'),
    GridExampleModel(12, 5, false, '5 to 7 grid'),
    GridExampleModel(12, 4, false, '4 to 8 grid'),
    GridExampleModel(12, 3, false, '3 to 9 grid'),
    GridExampleModel(12, 2, false, '2 to 10 grid'),
    GridExampleModel(12, 1, false, '1 to 11 grid'),
    GridExampleModel(12, 11, true, '11 to 1 grid gapless'),
    GridExampleModel(12, 10, true, '10 to 2 grid gapless'),
    GridExampleModel(12, 9, true, '9 to 3 grid gapless'),
    GridExampleModel(12, 8, true, '8 to 4 grid gapless'),
    GridExampleModel(12, 7, true, '7 to 5 grid gapless'),
    GridExampleModel(12, 5, true, '5 to 7 grid gapless'),
    GridExampleModel(12, 4, true, '4 to 8 grid gapless'),
    GridExampleModel(12, 3, true, '3 to 9 grid gapless'),
    GridExampleModel(12, 2, true, '2 to 10 grid gapless'),
    GridExampleModel(12, 1, true, '1 to 11 grid gapless'),
    GridExampleModel(
      8,
      null,
      false,
      'Hybrid',
      [
        GridItem(width: 120),
        Flexible(child: GridItem()),
        GridItem(width: 80),
        Flexible(flex: 2, child: GridItem()),
        GridItem(width: 76),
        Flexible(child: GridItem()),
        Flexible(flex: 3, child: GridItem()),
        GridItem(width: 40),
      ],
      "[GridItem(width: 120), Flexible(child: GridItem()),GridItem(width: 80), Flexible(flex: 2, child: GridItem()), GridItem(width: 76), Flexible(child: GridItem()), Flexible(flex: 3, child: GridItem()), GridItem(width: 40), ]",
    ),
    GridExampleModel(
      8,
      null,
      true,
      'Hybrid gapless',
      [
        GridItem(width: 120),
        Flexible(child: GridItem()),
        GridItem(width: 80),
        Flexible(flex: 2, child: GridItem()),
        GridItem(width: 76),
        Flexible(child: GridItem()),
        Flexible(flex: 3, child: GridItem()),
        GridItem(width: 40),
      ],
      "[GridItem(width: 120), Flexible(child: GridItem()),GridItem(width: 80), Flexible(flex: 2, child: GridItem()), GridItem(width: 76), Flexible(child: GridItem()), Flexible(flex: 3, child: GridItem()), GridItem(width: 40), ]",
    ),
  ];
  const GridExample({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> gridItems = List.generate(16, (index) => GridItem(label: index + 1));

    return Column(
      children: gridExamples.map((e) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(e.name, style: Theme.of(context).textTheme.headlineSmall),
            ZetaGrid(
              col: e.col,
              noGaps: e.noGaps,
              asymmetricWeight: e.asymmetric,
              hybrid: e.children != null,
              children: e.children != null ? e.children! : gridItems,
            ),
            Container(
              color: const Color(0xFFE9E9E9),
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(left: 16),
              child: Text(
                  'ZetaGrid(${e.col != 12 ? 'col:${e.col},' : ''}${e.noGaps ? 'noGaps:true, ' : ''}${e.asymmetric != null ? 'asymmetricWeight:${e.asymmetric}, ' : ''}${e.children != null ? 'hybrid: true, ' : ''}${e.children != null ? 'children:${e.childrenText}, ' : ''})',
                  style: Theme.of(context).textTheme.bodyMedium),
            ),
            const SizedBox(height: 40),
          ],
        );
      }).toList(),
    );
  }
}

class GridItem extends StatelessWidget {
  final dynamic label;
  final double? width;
  const GridItem({this.label, this.width, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: width,
      decoration: BoxDecoration(border: Border.all(color: const Color(0xFF7bb7f5)), color: const Color(0xCCc0dcf9)),
      child: label != null ? Text(label.toString()) : null,
    );
  }
}
