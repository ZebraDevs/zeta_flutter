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

/// Extension to add spacing to any [Widget].
extension SpacingWidget on Widget {
  /// Equal padding on all sides.
  Widget paddingAll(double space) => Padding(padding: EdgeInsets.all(space), child: this);

  /// Padding on start edge only. Is affected by whether the device is LTR or RTL:
  ///
  /// LTR: Left edge
  /// RTL: Right edge
  Widget paddingStart(double space) => Padding(padding: EdgeInsetsDirectional.only(start: space), child: this);

  /// Padding on start edge only. Is affected by whether the device is LTR or RTL:
  ///
  /// LTR: Right edge
  /// RTL: Left edge
  Widget paddingEnd(double space) => Padding(padding: EdgeInsetsDirectional.only(end: space), child: this);

  /// Padding on bottom only.
  Widget paddingBottom(double space) => Padding(padding: EdgeInsets.only(bottom: space), child: this);

  /// Padding on top only.
  Widget paddingTop(double space) => Padding(padding: EdgeInsets.only(top: space), child: this);

  /// Equal padding on top and bottom.
  Widget paddingVertical(double space) => Padding(padding: EdgeInsets.symmetric(vertical: space), child: this);

  /// Equal padding on start and end.
  Widget paddingHorizontal(double space) => Padding(padding: EdgeInsets.symmetric(horizontal: space), child: this);
}
