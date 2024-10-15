import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';
import 'extended_top_app_bar.dart';
import 'search_top_app_bar.dart';

export 'search_top_app_bar.dart' hide ZetaTopAppBarSearchField;

/// Top app bars provide content and actions related to the current screen.
/// {@category Components}
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=229-37&node-type=canvas&m=dev
///
/// Widgetbook: https://zeta-ds.web.app/flutter/widgetbook/index.html#/?path=components/top-app-bar/default
class ZetaTopAppBar extends ZetaStatefulWidget implements PreferredSizeWidget {
  /// Creates a ZetaTopAppBar.
  const ZetaTopAppBar({
    super.key,
    super.rounded,
    this.actions = const [],
    this.automaticallyImplyLeading = true,
    this.leading,
    this.title,
    this.titleTextStyle,
    this.type = ZetaTopAppBarType.defaultAppBar,
    @Deprecated('Use ZetaTopAppBar.search instead. ' 'Deprecated as of 0.16.0') ValueChanged<String>? onSearch,
    @Deprecated('Use ZetaTopAppBar.search instead. ' 'Deprecated as of 0.16.0') String? searchHintText,
    @Deprecated('Use ZetaTopAppBar.search instead. ' 'Deprecated as of 0.16.0') ZetaSearchController? searchController,
    @Deprecated('Use ZetaTopAppBar.search instead. ' 'Deprecated as of 0.16.0')
    VoidCallback? onSearchMicrophoneIconPressed,
  })  : shrinks = false,
        onSearch = null,
        searchHintText = null,
        searchController = null,
        onSearchMicrophoneIconPressed = null;

  /// Creates a ZetaTopAppBar with centered title.
  const ZetaTopAppBar.centered({
    super.key,
    super.rounded,
    this.actions = const [],
    this.automaticallyImplyLeading = true,
    this.leading,
    this.title,
    this.titleTextStyle,
    @Deprecated('Use ZetaTopAppBar.search instead. ' 'Deprecated as of 0.16.0') ValueChanged<String>? onSearch,
    @Deprecated('Use ZetaTopAppBar.search instead. ' 'Deprecated as of 0.16.0') String? searchHintText,
    @Deprecated('Use ZetaTopAppBar.search instead. ' 'Deprecated as of 0.16.0') ZetaSearchController? searchController,
    @Deprecated('Use ZetaTopAppBar.search instead. ' 'Deprecated as of 0.16.0')
    VoidCallback? onSearchMicrophoneIconPressed,
  })  : type = ZetaTopAppBarType.centered,
        onSearch = null,
        searchHintText = null,
        searchController = null,
        onSearchMicrophoneIconPressed = null,
        shrinks = false;

  /// Creates a ZetaTopAppBar with an expanding search field.
  const ZetaTopAppBar.search({
    super.key,
    super.rounded,
    this.automaticallyImplyLeading = true,
    this.searchController,
    this.leading,
    this.title,
    this.titleTextStyle,
    this.onSearch,
    this.searchHintText,
    this.onSearchMicrophoneIconPressed,
    this.actions = const [],
  })  : type = ZetaTopAppBarType.centered,
        shrinks = false;

  /// Creates a ZetaTopAppBar with an extended title over 2 lines.
  ///
  /// This component **must** be placed within a [CustomScrollView].
  const ZetaTopAppBar.extended({
    super.key,
    super.rounded,
    this.actions = const [],
    this.automaticallyImplyLeading = true,
    this.leading,
    this.title,
    this.titleTextStyle,
    this.shrinks = true,
    @Deprecated('Use ZetaTopAppBar.search instead. ' 'Deprecated as of 0.16.0') ValueChanged<String>? onSearch,
    @Deprecated('Use ZetaTopAppBar.search instead. ' 'Deprecated as of 0.16.0') String? searchHintText,
    @Deprecated('Use ZetaTopAppBar.search instead. ' 'Deprecated as of 0.16.0') ZetaSearchController? searchController,
    @Deprecated('Use ZetaTopAppBar.search instead. ' 'Deprecated as of 0.16.0')
    VoidCallback? onSearchMicrophoneIconPressed,
  })  : type = ZetaTopAppBarType.extended,
        onSearch = null,
        searchHintText = null,
        onSearchMicrophoneIconPressed = null,
        searchController = null;

  /// Called when text in the search field is submitted.
  final ValueChanged<String>? onSearch;

  /// A list of Widgets to display in a row after the [title] widget.
  final List<Widget> actions;

  /// Configures whether the back button to be displayed.
  final bool automaticallyImplyLeading;

  /// Widget displayed first in the app bar row.
  final Widget? leading;

  /// If omitted the microphone icon won't show up. Called when the icon button is pressed. Normally used for speech recognition/speech to text.
  final VoidCallback? onSearchMicrophoneIconPressed;

  /// Used to control the search textfield and states.
  final ZetaSearchController? searchController;

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
      ..add(DiagnosticsProperty<ZetaSearchController?>('searchController', searchController))
      ..add(StringProperty('searchHintText', searchHintText))
      ..add(EnumProperty<ZetaTopAppBarType>('type', type))
      ..add(DiagnosticsProperty<bool>('shrinks', shrinks));
  }
}

class _ZetaTopAppBarState extends State<ZetaTopAppBar> {
  late ZetaSearchController _searchController;
  bool get _searchEnabled => widget.searchController != null || widget.onSearch != null;
  bool get _searchActive => _searchController.isEnabled;

  @override
  void initState() {
    _searchController = widget.searchController ?? ZetaSearchController();
    _searchController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _getTitleText(ZetaColors colors) {
    Widget? title = widget.title;
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
    if (_searchActive) {
      return [
        IconButtonTheme(
          data: IconButtonThemeData(
            style: IconButton.styleFrom(iconSize: Zeta.of(context).spacing.xl),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                color: colors.cool.shade50,
                onPressed: () => _searchController.clearText(),
                icon: const ZetaIcon(ZetaIcons.cancel),
              ),
              if (widget.onSearchMicrophoneIconPressed != null) ...[
                SizedBox(
                  height: Zeta.of(context).spacing.xl_2,
                  child: VerticalDivider(width: ZetaBorders.medium, color: colors.cool.shade70),
                ),
                IconButton(
                  onPressed: widget.onSearchMicrophoneIconPressed,
                  icon: const ZetaIcon(ZetaIcons.microphone),
                ),
              ],
            ],
          ),
        ),
      ];
    }

    if (_searchEnabled) {
      return [
        ...widget.actions,
        IconButton(
          onPressed: () => setState(() {
            _searchController.startSearch();
          }),
          icon: const ZetaIcon(ZetaIcons.search),
        ),
      ];
    }
    return widget.actions;
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
            isExtended: widget.type == ZetaTopAppBarType.extended,
            child: titleText,
          )
        : titleText;

    if (widget.type == ZetaTopAppBarType.extended) {
      return SliverPersistentHeader(
        pinned: true,
        delegate: ZetaExtendedAppBarDelegate(
          actions: actions,
          leading: widget.leading,
          title: title,
          shrinks: widget.shrinks,
        ),
      );
    }

    Widget? leading = widget.leading;

    if (_searchActive) {
      leading = IconButton(
        onPressed: _searchController.closeSearch,
        icon: const ZetaIcon(ZetaIcons.arrow_back),
      );
    }

    return ZetaRoundedScope(
      rounded: context.rounded,
      child: ColoredBox(
        color: colors.surfacePrimary,
        child: IconButtonTheme(
          data: IconButtonThemeData(style: IconButton.styleFrom(tapTargetSize: MaterialTapTargetSize.shrinkWrap)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Zeta.of(context).spacing.minimum),
            child: AppBar(
              elevation: 0,
              scrolledUnderElevation: 0,
              iconTheme: IconThemeData(color: colors.cool.shade90),
              leadingWidth: Zeta.of(context).spacing.xl_6,
              leading: leading,
              automaticallyImplyLeading: widget.automaticallyImplyLeading,
              surfaceTintColor: Colors.transparent,
              centerTitle: widget.type == ZetaTopAppBarType.centered,
              titleTextStyle: widget.titleTextStyle == null
                  ? ZetaTextStyles.bodyLarge.copyWith(color: colors.textDefault)
                  : widget.titleTextStyle!.copyWith(color: colors.textDefault),
              title: title,
              actions: actions,
            ),
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
  @Deprecated('Use ZetaTopAppBar.centered instead. ' 'Deprecated as of 0.16.0')
  centeredTitle,

  /// Aligns the title to the center of the app bar.
  centered,

  /// Title below the app bar.
  @Deprecated('Use ZetaTopAppBar.extended instead. ' 'Deprecated as of 0.16.0')
  extendedTitle,

  /// Title extends over 2 lines and collapses when scrolled.
  extended,
}
