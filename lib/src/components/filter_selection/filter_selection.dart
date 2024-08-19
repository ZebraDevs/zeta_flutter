import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// Component [ZetaFilterSelection]
/// {@category Components}
class ZetaFilterSelection extends ZetaStatelessWidget {
  /// Constructor for the component [ZetaFilterSelection]
  const ZetaFilterSelection({
    super.key,
    super.rounded,
    required this.items,
    this.onPressed,
    this.buttonSemanticLabel,
    this.icon = ZetaIcons.filter,
  });

  /// The filter items - list of [ZetaFilterChip].
  final List<ZetaFilterChip> items;

  /// Called on filter button pressed.
  final VoidCallback? onPressed;

  /// Value passed into semantic label for the button.
  ///
  /// {@macro zeta-widget-semantic-label}
  final String? buttonSemanticLabel;

  /// Icon for the filter button.
  ///
  /// Default is [ZetaIcons.filter].
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ZetaSpacing.xl_7,
      child: Row(
        children: [
          Semantics(
            button: true,
            label: buttonSemanticLabel,
            excludeSemantics: true,
            enabled: onPressed != null,
            child: Container(
              height: ZetaSpacing.xl_7,
              color: Zeta.of(context).colors.surfaceDefault,
              child: IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: onPressed,
                icon: ZetaIcon(icon, size: ZetaSpacing.xl_2),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(ZetaSpacing.minimum),
              itemCount: items.length,
              itemBuilder: (context, index) => items[index].paddingHorizontal(ZetaSpacing.minimum),
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
      ..add(ObjectFlagProperty<VoidCallback?>.has('onPressed', onPressed))
      ..add(StringProperty('buttonSemanticLabel', buttonSemanticLabel))
      ..add(DiagnosticsProperty<IconData>('icon', icon));
  }
}
