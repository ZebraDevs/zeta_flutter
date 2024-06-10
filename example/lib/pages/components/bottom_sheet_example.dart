import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class BottomSheetExample extends StatefulWidget {
  static const String name = 'BottomSheet';

  const BottomSheetExample({super.key});

  @override
  State<BottomSheetExample> createState() => _BottomSheetExampleState();
}

class _BottomSheetExampleState extends State<BottomSheetExample> {
  bool centerTitle = true;

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: BottomSheetExample.name,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(ZetaSpacing.medium),
        child: Column(
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
                            icon: Icon(ZetaIcons.star_round),
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
                        leading: Icon(ZetaIcons.star_round),
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
      ),
    );
  }
}
