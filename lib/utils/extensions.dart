import 'package:flutter/material.dart';

/// Extension to add dividers to any view that can take an iterable.
///
/// Iterable can be converted to a list with [toList].
extension ListDivider on Iterable<Widget> {
  /// Divides a list of widgets with separators.
  Iterable<Widget> divide(Widget separator) sync* {
    if (isEmpty) return;

    final Iterator<Widget> iterator = this.iterator..moveNext();
    yield iterator.current;
    while (iterator.moveNext()) {
      yield separator;
      yield iterator.current;
    }
  }
}
