import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../widgets.dart';

class BottomSheetExample extends StatelessWidget {
  static const String name = 'BottomSheet';

  const BottomSheetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ExampleScaffold(
          name: BottomSheetExample.name,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(Dimensions.s),
            child: Column(
              children: [
                bottomSheet(context),
                bottomSheet(context, Alignment.centerLeft),
              ],
            ),
          ),
        );
      },
    );
  }

  static bottomSheet(BuildContext context, [AlignmentGeometry? alignment]) => ZetaMenuItem.horizontal(
        label: Text('Bottom Sheet - ${alignment ?? Alignment.center}'),
        trailingIcon: Icon(ZetaIcons.caret_down_round),
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return ZetaBottomSheet(
                title: 'Bottom Sheet',
                titleAlignment: alignment,
                body: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: List.generate(
                    6,
                    (index) => ZetaMenuItem.vertical(
                      label: Text('Menu Item'),
                      icon: Icon(ZetaIcons.star_round),
                      onTap: () {},
                    ),
                  ),
                ),
              );
            },
          );
        },
      );
}
