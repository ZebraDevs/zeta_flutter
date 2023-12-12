import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../zeta_flutter.dart';
import '../utils/enums.dart';

///Zeta Priority Pill
class ZetaPriorityPill extends StatelessWidget {
  ///Constructs [ZetaPriorityPill]
  const ZetaPriorityPill({
    required this.index,
    required this.priority,
    this.borderType = BorderType.sharp,
    super.key,
  });

  ///Border type of the badge
  final BorderType borderType;

  ///Priority number
  final int index;

  ///Priority label
  final String priority;

  bool get _isBorderRounded => borderType == BorderType.rounded;

  @override
  Widget build(BuildContext context) {
    final theme = Zeta.of(context);
    return DecoratedBox(
      decoration: _buildBoxDecoration(theme),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIndexContainer(theme),
          _buildPriorityText(),
        ],
      ),
    );
  }

  BoxDecoration _buildBoxDecoration(Zeta theme) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(
        _isBorderRounded ? Dimensions.l : Dimensions.x0,
      ),
      color: theme.colors.blue.shade10,
    );
  }

  Widget _buildIndexContainer(Zeta theme) {
    return Container(
      alignment: Alignment.center,
      height: Dimensions.x7,
      width: _isBorderRounded ? Dimensions.x7 : Dimensions.x6,
      decoration: BoxDecoration(
        shape: _isBorderRounded ? BoxShape.circle : BoxShape.rectangle,
        color: theme.colors.blue.shade60,
      ),
      child: Text(
        '$index',
        style: ZetaText.zetaTitleSmall.apply(color: theme.colors.white),
      ),
    );
  }

  Widget _buildPriorityText() {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
        child: Text(
          priority,
          style: ZetaText.zetaTitleSmall,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<BorderType>('borderType', borderType))
      ..add(IntProperty('index', index))
      ..add(StringProperty('priority', priority));
  }
}
