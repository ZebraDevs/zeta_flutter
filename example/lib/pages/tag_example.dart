import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../widgets.dart';

class TagExample extends StatelessWidget {
  static const String name = 'Tag';

  const TagExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: TagExample.name,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [tagsRowLeft, tagsRowRight],
      ),
    );
  }

  static Widget get tagsRowLeft => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ZetaTag.left(
            label: 'Tag',
            borderType: BorderType.sharp,
          ),
          ZetaTag.left(
            label: 'Tag',
            borderType: BorderType.rounded,
          )
        ],
      );

  static Widget get tagsRowRight => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ZetaTag.right(
            label: 'Tag',
            borderType: BorderType.sharp,
          ),
          ZetaTag.right(
            label: 'Tag',
            borderType: BorderType.rounded,
          )
        ],
      );
}
