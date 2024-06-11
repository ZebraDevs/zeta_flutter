import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';
import 'extended_top_app_bar.dart';
import 'search_top_app_bar.dart';

export 'search_top_app_bar.dart' show AppBarSearchController;

/// Top app bars provide content and actions related to the current screen.
class ZetaTopAppBar extends StatefulWidget implements PreferredSizeWidget {
  /// Creates a ZetaTopAppBar.
  const ZetaTopAppBar({
    this.actions,
    this.automaticallyImplyLeading = true,
    this.searchController,
    this.leading,
    this.title,
    this.titleTextStyle,
    this.type = ZetaTopAppBarType.defaultAppBar,
    this.onSearch,
    this.searchHintText = 'Search',
    this.onSearchMicrophoneIconPressed,
    super.key,
  }) : shrinks = false;

  /// Creates a ZetaTopAppBar with centered title.
  const ZetaTopAppBar.centered({
    this.actions,
    this.automaticallyImplyLeading = true,
    this.searchController,
    this.leading,
    this.title,
    this.titleTextStyle,
    this.onSearch,
    this.searchHintText = 'Search',
    this.onSearchMicrophoneIconPressed,
    super.key,
  })  : type = ZetaTopAppBarType.centeredTitle,
        shrinks = false;

  /// Creates a ZetaTopAppBar with an extended title over 2 lines.
  ///
  /// This component **must** be placed within a [CustomScrollView].
  const ZetaTopAppBar.extended({
    this.actions,
    this.automaticallyImplyLeading = true,
    this.searchController,
    this.leading,
    this.title,
    this.titleTextStyle,
    this.onSearch,
    this.searchHintText = 'Search',
    this.onSearchMicrophoneIconPressed,
    this.shrinks = true,
    super.key,
  }) : type = ZetaTopAppBarType.extendedTitle;

  /// Called when text in the search field is submitted.
  final void Function(String)? onSearch;

  /// A list of Widgets to display in a row after the [title] widget.
  final List<Widget>? actions;

  /// Configures whether the back button to be displayed.
  final bool automaticallyImplyLeading;

  /// Widget displayed first in the app bar row.
  final Widget? leading;

  /// If omitted the microphone icon won't show up. Called when the icon button is pressed. Normally used for speech recognition/speech to text.
  final VoidCallback? onSearchMicrophoneIconPressed;

  /// Used to control the search textfield and states.
  final AppBarSearchController? searchController;

  /// Label used as hint text. If null, displays 'Search'.
  final String? searchHintText;

  /// Title of the app bar.
  final Widget? title;

  /// AppBar titleTextStyle
  final TextStyle? titleTextStyle;

  /// Defines the styles of the app bar.
  final ZetaTopAppBarType type;

  /// If `ZetaTopAppBarType.extend` shrinks. Does not affect other types of app bar.
  final bool shrinks;

  @override
  State<ZetaTopAppBar> createState() => _ZetaTopAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<TextStyle?>('titleTextStyle', titleTextStyle))
      ..add(ObjectFlagProperty<void Function(String p1)?>.has('onSearch', onSearch))
      ..add(DiagnosticsProperty<bool>('automaticallyImplyLeading', automaticallyImplyLeading))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onSearchMicrophoneIconPressed', onSearchMicrophoneIconPressed))
      ..add(DiagnosticsProperty<AppBarSearchController?>('searchController', searchController))
      ..add(StringProperty('searchHintText', searchHintText))
      ..add(EnumProperty<ZetaTopAppBarType>('type', type))
      ..add(DiagnosticsProperty<bool>('shrinks', shrinks));
  }
}

class _ZetaTopAppBarState extends State<ZetaTopAppBar> {
  bool _isSearchEnabled = false;

  @override
  void initState() {
    widget.searchController?.addListener(_onSearchControllerChanged);
    super.initState();
  }

  void _onSearchControllerChanged() {
    final controller = widget.searchController;
    if (controller == null) return;

    setState(() => _isSearchEnabled = controller.isEnabled);
  }

  @override
  void dispose() {
    widget.searchController?.removeListener(_onSearchControllerChanged);
    super.dispose();
  }

  Widget _getTitleText(ZetaColors colors) {
    var title = widget.title;
    if (widget.title is Row) {
      final oldRow = widget.title! as Row;
      title = Row(
        crossAxisAlignment: oldRow.crossAxisAlignment,
        key: oldRow.key,
        mainAxisAlignment: oldRow.mainAxisAlignment,
        mainAxisSize: oldRow.mainAxisSize,
        textBaseline: oldRow.textBaseline,
        textDirection: oldRow.textDirection,
        verticalDirection: oldRow.verticalDirection,
        children: oldRow.children.map(
          (item) {
            if (item is ZetaAvatar) {
              item = item.copyWith(size: ZetaAvatarSize.xxxs);
            }
            return item;
          },
        ).toList(),
      );
    }

    return DefaultTextStyle(
      style: (widget.titleTextStyle ?? ZetaTextStyles.bodyLarge).copyWith(color: colors.textDefault),
      child: title ?? const Text(' '),
    );
  }

  List<Widget>? _getActions(ZetaColors colors) {
    return _isSearchEnabled
        ? [
            IconButtonTheme(
              data: IconButtonThemeData(
                style: IconButton.styleFrom(iconSize: ZetaSpacing.xl_1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    color: colors.cool.shade50,
                    onPressed: () => widget.searchController?.clearText(),
                    icon: const Icon(ZetaIcons.cancel_round),
                  ),
                  if (widget.onSearchMicrophoneIconPressed != null) ...[
                    SizedBox(
                      height: ZetaSpacing.xl_2,
                      child: VerticalDivider(width: ZetaSpacingBase.x0_5, color: colors.cool.shade70),
                    ),
                    IconButton(
                      onPressed: widget.onSearchMicrophoneIconPressed,
                      icon: const Icon(ZetaIcons.microphone_round),
                    ),
                  ],
                ],
              ),
            ),
          ]
        : widget.actions;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    final actions = _getActions(colors);
    final titleText = _getTitleText(colors);

    final title = widget.searchController != null
        ? ZetaTopAppBarSearchField(
            searchController: widget.searchController,
            hintText: widget.searchHintText ?? 'Search',
            onSearch: widget.onSearch,
            type: widget.type,
            isExtended: widget.type == ZetaTopAppBarType.extendedTitle,
            child: titleText,
          )
        : titleText;

    if (widget.type == ZetaTopAppBarType.extendedTitle) {
      return SliverPersistentHeader(
        pinned: true,
        delegate: ZetaExtendedAppBarDelegate(
          actions: actions,
          leading: widget.leading,
          searchController: widget.searchController,
          title: title,
          shrinks: widget.shrinks,
        ),
      );
    }

    return ColoredBox(
      color: colors.surfacePrimary,
      child: IconButtonTheme(
        data: IconButtonThemeData(style: IconButton.styleFrom(tapTargetSize: MaterialTapTargetSize.shrinkWrap)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: ZetaSpacing.minimum),
          child: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            iconTheme: IconThemeData(color: colors.cool.shade90),
            leadingWidth: ZetaSpacing.xl_6,
            leading: widget.leading,
            automaticallyImplyLeading: widget.automaticallyImplyLeading,
            surfaceTintColor: Colors.transparent,
            centerTitle: widget.type == ZetaTopAppBarType.centeredTitle,
            titleTextStyle: widget.titleTextStyle == null
                ? ZetaTextStyles.bodyLarge.copyWith(color: colors.textDefault)
                : widget.titleTextStyle!.copyWith(color: colors.textDefault),
            title: title,
            actions: actions,
          ),
        ),
      ),
    );
  }
}

/// Defines the style of the app bar.
enum ZetaTopAppBarType {
  /// Title positioned on the left side.
  defaultAppBar,

  /// Title in the center.
  centeredTitle,

  /// Title below the app bar.
  extendedTitle,
}
