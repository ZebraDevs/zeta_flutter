import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class ListExample extends StatelessWidget {
  static const name = 'List';

  const ListExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: 'List',
      child: ZetaList(
        showDivider: false,
        items: [
          ZetaListItem(primaryText: 'Item 1'),
          ZetaListItem(primaryText: 'Item 2'),
          ZetaListItem(primaryText: 'Item 3', showDivider: true),
          ZetaListItem(primaryText: 'Item 4', showDivider: true),
          ZetaListItem(primaryText: 'Item 5'),
          ZetaListItem(primaryText: 'Item 6'),
        ],
      ),
    );
  }
}
