import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../zeta_flutter.dart';

/// Not to be used externally.
/// Do not export from zeta.dart.
class ListScope extends InheritedWidget {
  /// Creates a new [ListScope]
  const ListScope({
    required super.child,
    required this.showDivider,
    this.indentItems = false,
    super.key,
  });

  /// Adds a divider between [ZetaListItem]s and [ZetaDropdownListItem]s in the scope.
  final bool showDivider;

  /// Indents all items in the scope without a leading widget.
  final bool indentItems;

  /// Fetches the closest [ListScope] ancestor in the widget tree.
  static ListScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ListScope>();
  }

  @override
  bool updateShouldNotify(ListScope oldWidget) =>
      oldWidget.showDivider != showDivider || oldWidget.indentItems != indentItems;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('showDivider', showDivider))
      ..add(DiagnosticsProperty<bool>('indentItems', indentItems));
  }
}
