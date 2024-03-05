import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

Widget navigationBarUseCase(BuildContext context) {
  List<ZetaNavigationBarItem> items = List.generate(
    context.knobs.int.slider(label: 'Items', min: 2, max: 6, initialValue: 2),
    (index) => ZetaNavigationBarItem(icon: ZetaIcons.star_round, label: 'Label $index'),
  );
  int currIndex = 0;
  bool showButton = context.knobs.boolean(label: 'Button');
  int? dividerIndex = context.knobs.intOrNull.slider(label: 'Divider', min: 0, max: 6, initialValue: null);
  bool showSplit = context.knobs.boolean(label: 'Split Items');
  return StatefulBuilder(builder: (context, setState) {
    double width = (items.length * 90) + (showSplit ? 90 : 0) + (dividerIndex != null ? 90 : 0) + (showButton ? 90 : 0);
    return WidgetbookTestWidget(
      screenSize: Size(width, 260),
      widget: ZetaNavigationBar(
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
