import 'package:flutter/material.dart';
import 'package:zeta_example/config/components_config.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class BottomSheetExample extends StatefulWidget {
  const BottomSheetExample({super.key});

  @override
  State<BottomSheetExample> createState() => _BottomSheetExampleState();
}

class _BottomSheetExampleState extends State<BottomSheetExample> {
  bool centerTitle = true;

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: bottomSheetRoute,
      paddingAll: 0,
      children: [
        Column(
          children: [
            ZetaMenuItem.horizontal(
              label: Text('Grid'),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return ZetaBottomSheet(
                      title: 'Bottom Sheet',
                      centerTitle: centerTitle,
                      body: Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: List.generate(
                          6,
                          (index) => ZetaMenuItem.vertical(
                            label: Text('Menu Item'),
                            icon: Icon(ZetaIcons.star),
                            onTap: () {},
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            ZetaMenuItem.horizontal(
              label: Text('Horizontal'),
              onTap: () {
                showZetaBottomSheet(
                  context: context,
                  title: 'Bottom Sheet',
                  centerTitle: centerTitle,
                  body: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: List.generate(
                      6,
                      (index) => ZetaMenuItem.horizontal(
                        label: Text('Menu Item'),
                        onTap: () {},
                        leading: Icon(ZetaIcons.star),
                      ),
                    ),
                  ),
                );
              },
            ),
            ZetaCheckbox(
              label: 'Center title',
              value: centerTitle,
              onChanged: (value) => setState(() => centerTitle = !centerTitle),
            ),
          ],
        ),
        Container(
          color: Zeta.of(context).colors.mainInverse,
          padding: EdgeInsets.only(top: 16, left: 16, right: 16),
          key: Key('docs-bottom-sheet'),
          child: ZetaBottomSheet(
            title: 'Bottom Sheet',
            centerTitle: centerTitle,
            body: Column(
              children: [
                Wrap(
                  children: List.generate(
                    3,
                    (index) => ZetaMenuItem.horizontal(
                      label: Text('Menu Item'),
                      onTap: () {},
                    ),
                  ),
                ),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: List.generate(
                    6,
                    (index) => ZetaMenuItem.vertical(
                      label: Text('Menu Item'),
                      icon: Icon(ZetaIcons.star),
                      onTap: () {},
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
