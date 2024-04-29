import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../zeta_flutter.dart';
import '../../theme/theme_data.dart';

/// Global header component
class ZetaGlobalHeader extends StatefulWidget {
  /// Constructor for [ZetaGlobalHeader]
  const ZetaGlobalHeader({
    super.key,
    required this.title,
    this.tabItems = const [],
    this.utilityButtons = const [],
  });

  /// Header title in top left of header
  final String title;

  /// Tab item buttons
  final List<ZetaTabItem> tabItems;

  /// Utility buttons
  final List<IconButton> utilityButtons;

  @override
  State<ZetaGlobalHeader> createState() => _GlobalHeaderState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('title', title));
  }
}

extension on DeviceType {
  /// Render buttons along the top menu half
  bool get isLarge {
    return this == DeviceType.desktopL || this == DeviceType.desktopXL;
  }

  /// Render
  bool get isSmall {
    return this == DeviceType.mobileLandscape ||
        this == DeviceType.mobilePortrait;
  }
}

class _GlobalHeaderState extends State<ZetaGlobalHeader> {
  int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    return LayoutBuilder(
      builder: (context, constraints) {
        final deviceType = constraints.deviceType;

        return Container(
          padding: const EdgeInsets.symmetric(
            vertical: ZetaSpacing.s,
            horizontal: ZetaSpacing.b,
          ),
          decoration: BoxDecoration(color: colors.surfacePrimary),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // Top Section
                children: [
                  Row(
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: colors.textDefault,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox.square(
                        dimension: ZetaSpacing.s,
                      ),
                      if (deviceType.isLarge && widget.tabItems.length > 5)

                        /// If using large screen, render some tabItems in to section
                        ...renderedChildren(widget.tabItems).sublist(0, 4),
                    ],
                  ),

                  /// If screen is not small, render search bar on the top
                  if (!deviceType.isSmall)
                    const Expanded(
                      child: ZetaSearchBar(),
                    ),
                  Row(
                    children: [
                      ...widget.utilityButtons,
                      const ZetaAvatar(
                        initials: 'PS',
                        size: ZetaAvatarSize.s,
                      ),
                    ].gap(ZetaSpacing.s),
                  ),
                ].gap(ZetaSpacing.s),
              ),
              const SizedBox(
                height: ZetaSpacing.x2,
              ),
              Row(
                children: [
                  if (deviceType.isSmall)
                    const Expanded(child: ZetaSearchBar()),
                  if (widget.tabItems.isNotEmpty)
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          /// Large screem filters some tab items to render on top

                          children:
                              deviceType.isLarge && widget.tabItems.length > 5
                                  ? renderedChildren(widget.tabItems)
                                      .sublist(5, widget.tabItems.length - 1)
                                  : renderedChildren(widget.tabItems),
                        ),
                      ),
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
        );
      },
    );
  }

  /// Extend tab items to register their active states
  List<ZetaTabItem> renderedChildren(List<ZetaTabItem> children) {
    final List<ZetaTabItem> modifiedChildren = [];
    for (final (index, child) in children.indexed) {
      modifiedChildren.add(
        child.copyWith(
          active: _selectedIndex == index,
          dropdown: child.dropdown,
          handlePress: () {
            setState(() {
              _selectedIndex = index;
            });
            child.handlePress!.call();
          },
        ),
      );
    }
    return modifiedChildren;
  }
}
