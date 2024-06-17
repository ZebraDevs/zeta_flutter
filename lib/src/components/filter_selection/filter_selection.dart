import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// Component [ZetaFilterSelection]
class ZetaFilterSelection extends ZetaStatelessWidget {
  /// Constructor for the component [ZetaFilterSelection]
  const ZetaFilterSelection({
    super.key,
    super.rounded,
    required this.items,
    this.onPressed,
  });

  /// The filter items - list of [ZetaFilterChip].
  final List<ZetaFilterChip> items;

  /// Called on filter button pressed.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ZetaSpacing.xl_7,
      child: Row(
        children: [
          Container(
            height: ZetaSpacing.xl_7,
            color: Zeta.of(context).colors.surfaceDefault,
            child: IconButton(
              visualDensity: VisualDensity.compact,
              onPressed: onPressed,
              icon: Icon(
                context.rounded ? ZetaIcons.filter_round : ZetaIcons.filter_sharp,
                size: ZetaSpacing.xl_2,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(ZetaSpacing.minimum),
              children: items
                  .map((e) => e.copyWith(rounded: rounded))
                  .divide(const SizedBox(width: ZetaSpacing.small))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onPressed', onPressed));
  }
}
