import 'package:flutter/material.dart';
import '../theme/breakpoints.dart';
import '../utils/extensions.dart';

/// Default margin for grid component.
const double gridMargin = 24;

/// Default padding for grid component on desktop.
///
/// See also:
///  * [gridGutterMobile].
///  * [DeviceType].
const double gridGutterDesktop = 24;

/// Default padding for grid component on mobile.
///
/// See also:
///  * [gridGutterDesktop].
///  * [DeviceType].
const double gridGutterMobile = 24;

extension _Spacing on DeviceType {
  num crossAxisCount(num col) {
    switch (this) {
      case DeviceType.mobilePortrait:
        return 2;
      case DeviceType.mobileLandscape:
        return 4;
      case DeviceType.tablet:
        return col == 16 ? 8 : col;
      case DeviceType.desktop:
      case DeviceType.desktopL:
      case DeviceType.desktopXL:
        return col;
    }
  }

  double axisSpacing(int col) {
    switch (this) {
      case DeviceType.mobilePortrait:
      case DeviceType.mobileLandscape:
        return gridGutterMobile / 2;
      case DeviceType.tablet:
      case DeviceType.desktop:
      case DeviceType.desktopL:
      case DeviceType.desktopXL:
        return col == 16 ? gridGutterMobile / 2 : gridGutterDesktop / 2;
    }
  }
}

/// Zeta Grid component
class ZetaGrid extends StatelessWidget {
  /// Number of columns in grid. Should be an even number between 2 and 16, although values above 12 should be used sparingly.
  ///
  /// Defaults to 12.
  final int col;

  /// Removes gutters (gaps) from between children.
  ///
  /// Defaults to false.
  final bool noGaps;

  /// `Required` list of children to be placed into the grid.
  ///
  /// If the amount of children should match the number of columns.
  /// * If lower, empty widgets will be added.
  /// * If higher, trailing children will be ignored.
  final List<Widget> children;

  /// If not null, creates a 2 column asymmetric grid, where the first item has this weight.
  ///
  /// i.e. `asymmetricWeight: 1` will create a grid with 2 columns, where the first has a width of 1/12 and the second has a width of 11/12.
  final int? asymmetricWeight;

  /// If the Grid should allow custom child widths.
  ///
  /// Custom sized widgets can be mixed with Flexible wrapped widgets.
  ///
  /// This is potentially dangerous as children could exceed screen width, causing overflow errors.
  ///
  /// Defaults to false.
  final bool hybrid;

  /// Constructs a [ZetaGrid].
  const ZetaGrid({
    required this.children,
    this.col = 12,
    this.noGaps = false,
    this.asymmetricWeight,
    this.hybrid = false,
    super.key,
  })  : assert(
          asymmetricWeight == null || (asymmetricWeight > 0 && asymmetricWeight < 12),
          'If defined, asymmetricWeight should be in the range 1-11',
        ),
        assert(
          // ignore: use_is_even_rather_than_modulo
          col % 2 == 0,
          'Number of columns should be even',
        );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final DeviceType deviceType = constraints.deviceType;
        final crossAxisCount = deviceType.crossAxisCount(col);
        final divider = col / crossAxisCount;
        final List<Widget> rows = [];
        final double gutterSize = noGaps ? 0 : deviceType.axisSpacing(col);
        final Widget gutter = SizedBox(width: gutterSize, height: gutterSize);
        final Widget widget;

        if (hybrid) {
          widget = widget = Row(children: children.divide(gutter).toList());
        } else if (asymmetricWeight != null) {
          widget = Row(
            children: [
              Flexible(fit: FlexFit.tight, flex: asymmetricWeight as int, child: children.first),
              gutter,
              Flexible(fit: FlexFit.tight, flex: 12 - (asymmetricWeight as int), child: children[1]),
            ],
          );
        } else {
          final List<Widget> children2 = [...children];
          if (children.length < col) {
            children2.addAll(List.generate(col - children.length, (index) => const SizedBox()));
          }
          for (int i = 0; i < divider; i++) {
            rows.add(
              Row(
                children: children2
                    .sublist((i * crossAxisCount).toInt(), ((col / divider) * (i + 1)).round())
                    .map((e) => Expanded(child: e))
                    .divide(gutter)
                    .toList(),
              ),
            );
          }
          widget = Column(children: rows.divide(gutter).toList());
        }
        return Padding(
          padding: const EdgeInsets.all(gridMargin), //TODO: Luke check against webflow
          child: widget,
        );
      },
    );
  }
}
