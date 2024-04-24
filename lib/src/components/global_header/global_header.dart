import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../zeta_flutter.dart';

class ZetaGlobalHeader extends StatefulWidget {
  const ZetaGlobalHeader({
    super.key,
    required this.title,
    this.buttons = const [],
  });

  final String title;

  final List<ZetaTabItem> buttons;

  @override
  State<ZetaGlobalHeader> createState() => _GlobalHeaderState();
}

extension on ZetaWidgetSize {
  double get _width => this == ZetaWidgetSize.small
      ? 320
      : this == ZetaWidgetSize.medium
          ? 901
          : 1281;
}

class _GlobalHeaderState extends State<ZetaGlobalHeader> {
  final _leftKey = GlobalKey();
  final _rightKey = GlobalKey();
  late double size;
  double searchSize = 0.0;
  bool searchInTop = false;

  @override
  void initState() {
    super.initState();
    size = widget.buttons.length == 0
        ? 320
        : widget.buttons.length < 6
            ? 901
            : 1281;
  }

  double getWidth(GlobalKey key) {
    return key.currentContext!.size!.width;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        searchSize = size -
            getWidth(_leftKey) -
            getWidth(_rightKey) -
            (4 * ZetaSpacing.s);
      });
    });
    final colors = Zeta.of(context).colors;
    return Container(
      width: size,
      padding: const EdgeInsets.symmetric(
          vertical: ZetaSpacing.s, horizontal: ZetaSpacing.b),
      decoration: BoxDecoration(color: colors.surfacePrimary),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // Top Section
            children: [
              Row(
                key: _leftKey,
                children: [
                  Text(
                    widget.title,
                  ),
                  if (widget.buttons.length > 5)
                    ...widget.buttons.sublist(0, 4),
                ],
              ),
              if (widget.buttons.isNotEmpty)
                Container(
                  width: searchSize,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: ZetaRadius.rounded,
                  ),
                  child: Text("Search"),
                ), //TODO: Replace with search bar
              Row(
                key: _rightKey,
                children: [
                  const Icon(
                    ZetaIcons.alert_round,
                  ),
                  const Icon(
                    ZetaIcons.help_round,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(color: colors.borderDefault)),
                    ),
                  ),
                  const Icon(
                    ZetaIcons.apps_round,
                  ),
                  const ZetaAvatar(
                    initials: 'PS',
                    size: ZetaAvatarSize.s,
                  ),
                ]
                    .divide(
                      const SizedBox.square(
                        dimension: ZetaSpacing.s,
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
          Row(
            children: [
              if (widget.buttons.isEmpty)
                Container(
                  width: size - 2 * ZetaSpacing.b,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: ZetaRadius.rounded,
                  ),
                  child: Text("Search"),
                ),
              if (widget.buttons.length > 5)
                ...widget.buttons.sublist(5, widget.buttons.length - 1)
              else
                ...widget.buttons,
            ]
                .divide(
                  const SizedBox.square(
                    dimension: ZetaSpacing.s,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
