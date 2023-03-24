import 'package:flutter/material.dart';
import '../../zeta_flutter.dart';

import '../utils/extensions.dart';

extension _Spacing on DeviceType {
  static const _mobilePortraitCount = 2;
  static const _mobileLandscapeCount = 4;
  static const _tabletCount = 8;

  num crossAxisCount(num col) {
    switch (this) {
      case DeviceType.mobilePortrait:
        return _mobilePortraitCount;
      case DeviceType.mobileLandscape:
        return _mobileLandscapeCount;
      case DeviceType.tablet:
        return col == ZetaGrid.maxCols ? _tabletCount : col;
      case DeviceType.desktop:
      case DeviceType.desktopL:
      case DeviceType.desktopXL:
        return col;
    }
  }

  double axisSpacing(double col) {
    switch (this) {
      case DeviceType.mobilePortrait:
      case DeviceType.mobileLandscape:
        return ZetaSpacing.x2;
      case DeviceType.tablet:
      case DeviceType.desktop:
      case DeviceType.desktopL:
      case DeviceType.desktopXL:
        return col == ZetaGrid.maxCols ? ZetaSpacing.x3 : ZetaSpacing.x4;
    }
  }
}

/// Zeta Grid.
class ZetaGrid extends StatelessWidget {
  /// Maximum number of cols that can be displayed.
  static const double maxCols = 16;

  /// Default number of cols.
  static const double defaultCols = 12;

  /// Default margin for grid component.
  static const double gridMargin = ZetaSpacing.x6;

  /// Number of columns in grid. Should be an even number between 2 and 16, although values above 12 should be used sparingly.
  ///
  /// Defaults to 12.
  final double col;

  /// Removes gutters (gaps) from between children.
  ///
  /// Defaults to false.
  final bool noGaps;

  /// `Required` list of children to be placed into the grid.
  final List<Widget> children;

  /// If not null, creates a 2 column asymmetric grid, where the first item has this weight.
  ///
  /// Example: `asymmetricWeight: 1` will create a grid with 2 columns, where the first has a width of 1/12 and the second has a width of 11/12.
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
    this.col = ZetaGrid.defaultCols,
    this.noGaps = false,
    this.asymmetricWeight,
    this.hybrid = false,
    super.key,
  }) : assert(
          asymmetricWeight == null || (asymmetricWeight > 0 && asymmetricWeight < defaultCols),
          'If defined, asymmetricWeight should be in the range 1-11',
        );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final DeviceType deviceType = constraints.deviceType;
        final crossAxisCount = deviceType.crossAxisCount(col);
        final divider = (children.length / crossAxisCount).ceil();
        final List<Widget> rows = [];
        final double gutterSize = noGaps ? ZetaSpacing.x0 : deviceType.axisSpacing(col);
        final Widget gutter = SizedBox(width: gutterSize, height: gutterSize);
        final Widget widget;

        if (hybrid) {
          final List<Widget> children2;
          if (children.length < col) {
            children2 = [...children, ...List.generate((col - children.length).toInt(), (index) => const SizedBox())];
          } else if (children.length > col) {
            children2 = children.getRange(0, col.toInt()).toList();
          } else {
            children2 = children;
          }
          widget = Row(
            children: [
              Expanded(child: Row(children: children2.divide(gutter).toList())),
            ],
          );
        } else if (asymmetricWeight != null) {
          widget = Row(
            children: [
              Flexible(flex: asymmetricWeight as int, fit: FlexFit.tight, child: children.first),
              gutter,
              Flexible(flex: (defaultCols - (asymmetricWeight as int)).toInt(), fit: FlexFit.tight, child: children[1]),
            ],
          );
        } else {
          if (children.length % col != 0) {
            children.addAll(List.generate((col - (children.length % col)).toInt(), (index) => const SizedBox()));
          }
//TODO: fix assymetic.
          for (int i = 0; i < divider; i++) {
            rows.add(
              Row(
                children: children
                    .sublist((i * crossAxisCount).toInt(), ((children.length / divider) * (i + 1)).round())
                    .map((e) => Expanded(child: e))
                    .divide(gutter)
                    .toList(),
              ),
            );
          }
          widget = Column(children: rows.divide(gutter).toList());
        }

        return Padding(padding: const EdgeInsets.all(gridMargin), child: widget);
      },
    );
  }
}
