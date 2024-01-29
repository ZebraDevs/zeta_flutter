import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

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
            padding: EdgeInsets.all(ZetaSpacing.s),
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
                          titleAlignment: Alignment.centerLeft,
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
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return ZetaBottomSheet(
                          title: 'Bottom Sheet',
                          titleAlignment: Alignment.centerLeft,
                          body: Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: List.generate(
                              6,
                              (index) => ZetaMenuItem.horizontal(label: Text('Menu Item'), onTap: () {}),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                ZetaMenuItem.horizontal(
                  label: Text('With center title'),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return ZetaBottomSheet(
                          title: 'Bottom Sheet',
                          horizontalAlignment: CrossAxisAlignment.center,
                          body: Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: List.generate(
                              6,
                              (index) => ZetaMenuItem.horizontal(label: Text('Menu Item'), onTap: () {}),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
