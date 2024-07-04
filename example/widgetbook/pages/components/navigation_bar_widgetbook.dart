import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';
import '../../utils/utils.dart';

Widget navigationBarUseCase(BuildContext context) {
  List<ZetaNavigationBarItem> items = List.generate(
    context.knobs.int.slider(label: 'Items', min: 2, max: 6, initialValue: 2),
    (index) => ZetaNavigationBarItem(icon: iconKnob(context)!, label: 'Label $index'),
  );
  int currIndex = 0;
  bool showButton = context.knobs.boolean(label: 'Button');
  int? dividerIndex = context.knobs.intOrNull.slider(label: 'Divider', min: 0, max: 6, initialValue: null);
  bool showSplit = context.knobs.boolean(label: 'Split Items');
  return StatefulBuilder(builder: (context, setState) {
    return WidgetbookScaffold(
      builder: (context, _) => ZetaNavigationBar(
        items: items,
        action: showButton ? ZetaButton.primary(label: 'Button', onPressed: () {}) : null,
        onTap: (i) => setState(() => currIndex = i),
        currentIndex: currIndex,
        splitItems: showSplit,
        dividerIndex: dividerIndex,
      ),
    );
  });
}
