import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../example_scaffold.dart';

class GridExample extends StatelessWidget implements ExampleWidget {
  const GridExample({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> gridItems = List.generate(16, (index) => GridItem(label: index + 1));

    return ExampleScaffold(
      name: name,
      children: [
        const Text("Basic (12 column) grid"),
        ZetaGrid(children: gridItems),
        const Text("`noGaps: true` removes the gaps from any grid"),
        ZetaGrid(noGaps: true, children: gridItems),
        const Text("2 column grid symmetrical."),
        ZetaGrid(col: 2, children: gridItems),
        const Text("4 column grid symmetrical."),
        ZetaGrid(col: 4, children: gridItems),
        const Text("8 column grid symmetrical."),
        ZetaGrid(col: 8, children: gridItems),
        const Text("16 column grid symmetrical."),
        ZetaGrid(col: 16, children: gridItems),
        const Text("11 to 1 Asymmetrical"),
        ZetaGrid(asymmetricWeight: 11, children: gridItems),
        const Text("10 to 2 Asymmetrical"),
        ZetaGrid(asymmetricWeight: 10, children: gridItems),
        const Text("9 to 3 Asymmetrical"),
        ZetaGrid(asymmetricWeight: 9, children: gridItems),
        const Text("8 to 4 Asymmetrical"),
        ZetaGrid(asymmetricWeight: 8, children: gridItems),
        const Text("7 to 5 Asymmetrical"),
        ZetaGrid(asymmetricWeight: 7, children: gridItems),
        const Text("5 to 7 Asymmetrical"),
        ZetaGrid(asymmetricWeight: 5, children: gridItems),
        const Text("4 to 8 Asymmetrical"),
        ZetaGrid(asymmetricWeight: 4, children: gridItems),
        const Text("3 to 9 Asymmetrical"),
        ZetaGrid(asymmetricWeight: 3, children: gridItems),
        const Text("2 to 10 Asymmetrical"),
        ZetaGrid(asymmetricWeight: 2, children: gridItems),
        const Text("1 to 11 Asymmetrical"),
        ZetaGrid(asymmetricWeight: 1, children: gridItems),
        const Text("8 Column hybrid"),
        const ZetaGrid(hybrid: true, children: [
          GridItem(width: 120),
          Flexible(child: GridItem()),
          GridItem(width: 80),
          Flexible(flex: 2, child: GridItem()),
          GridItem(width: 76),
          Flexible(child: GridItem()),
          Flexible(flex: 3, child: GridItem()),
          GridItem(width: 40),
        ]),
      ],
    );
  }

  @override
  final String name = 'Grid';
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
