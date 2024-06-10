import 'package:flutter/material.dart';

import '../../zeta_flutter.dart';

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

  /// Space out a list of wigets with gap of fixed width
  List<Widget> gap(double gap) {
    return divide(
      SizedBox.square(
        dimension: gap,
      ),
    ).toList();
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

/// Extensions on [num].
extension NumExtensions on num? {
  /// Returns input as a formatted string with a maximum amount of characters.
  ///
  /// [maxChars] defaults to one.
  String formatMaxChars([int maxChars = 1]) {
    final strVal = this == null ? '' : this!.abs().toString();
    return strVal.length > maxChars ? '${'9' * maxChars}+' : strVal;
  }
}

/// Extensions on [ZetaWidgetStatus].
extension ColorSwatches on ZetaWidgetStatus {
  /// Gets color swatch from [ZetaWidgetStatus]
  ZetaColorSwatch colorSwatch(BuildContext context) {
    final colors = Zeta.of(context).colors;
    switch (this) {
      case ZetaWidgetStatus.info:
        return colors.surfaceInfo;
      case ZetaWidgetStatus.positive:
        return colors.surfacePositive;
      case ZetaWidgetStatus.warning:
        return colors.surfaceWarning;
      case ZetaWidgetStatus.negative:
        return colors.surfaceNegative;
      case ZetaWidgetStatus.neutral:
        return colors.cool;
    }
  }
}

/// Extensions on [String].
extension StringExtensions on String? {
  /// Returns initials from a name.
  String get initials {
    if (this == null || (this?.isEmpty ?? true)) return '';
    final List<String> nameParts = this!.split(RegExp(r'\W+'))..removeWhere((item) => item.isEmpty);
    if (nameParts.isEmpty) return '';
    return (nameParts.length > 1
            ? nameParts[0].substring(0, 1) + nameParts[1].substring(0, 1)
            : nameParts[0].length > 1
                ? nameParts[0].substring(0, 2)
                : nameParts[0])
        .toUpperCase();
  }

  /// Capitalizes first letter of string.
  String capitalize() {
    if (this == null || this!.isEmpty) return '';
    if (this!.length == 1) return this!.toUpperCase();
    return '${this![0].toUpperCase()}${this!.substring(1).toLowerCase()}';
  }
}
