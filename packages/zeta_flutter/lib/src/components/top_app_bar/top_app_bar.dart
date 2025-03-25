import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

import 'extended_top_app_bar.dart';
import 'search_top_app_bar.dart';

export 'search_top_app_bar.dart' hide ZetaTopAppBarSearchField;

/// Top app bars provide content and actions related to the current screen.
///
/// To create Extended, Centered, or Search app bars, use the respective constructors.
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=229-37&node-type=canvas&m=dev
///
/// Widgetbook: https://design.zebra.com/flutter/widgetbook/index.html#/?path=components/top-app-bar/zetatopappbar/default
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
    this.titleSpacing,
  })  : shrinks = false,
        onSearch = null,
        searchHintText = null,
        searchController = null,
        clearSemanticLabel = null,
        microphoneSemanticLabel = null,
        searchBackSemanticLabel = null,
        searchSemanticLabel = null,
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
    this.titleSpacing,
  })  : type = ZetaTopAppBarType.centered,
        onSearch = null,
        searchHintText = null,
        searchController = null,
        onSearchMicrophoneIconPressed = null,
        clearSemanticLabel = null,
        searchBackSemanticLabel = null,
        microphoneSemanticLabel = null,
        searchSemanticLabel = null,
        shrinks = false;

  /// Creates a ZetaTopAppBar with an expanding search field.
  /// This will append a search icon to the right of the app bar.
  /// When the search icon is pressed, the search field will expand and replace the title widget.
  /// It will replace the leading widget with a back button which closes the search field.
  /// The search field can be controlled externally by the [searchController].
  const ZetaTopAppBar.search({
    super.key,
    super.rounded,
    this.type = ZetaTopAppBarType.defaultAppBar,
    this.automaticallyImplyLeading = true,
    this.searchController,
    this.leading,
    this.title,
    this.titleTextStyle,
    this.onSearch,
    this.searchHintText,
    this.onSearchMicrophoneIconPressed,
    this.actions = const [],
    this.clearSemanticLabel,
    this.microphoneSemanticLabel,
    this.searchSemanticLabel,
    this.searchBackSemanticLabel,
    this.titleSpacing,
  })  : shrinks = false,
        assert(type != ZetaTopAppBarType.extended, 'Search app bars cannot be extended');

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
    this.titleSpacing,
  })  : type = ZetaTopAppBarType.extended,
        onSearch = null,
        searchHintText = null,
        onSearchMicrophoneIconPressed = null,
        clearSemanticLabel = null,
        microphoneSemanticLabel = null,
        searchSemanticLabel = null,
        searchBackSemanticLabel = null,
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

  /// The semantic label for the clear icon.
  final String? clearSemanticLabel;

  /// The semantic label for the microphone icon.
  final String? microphoneSemanticLabel;

  /// The semantic label for the search icon.
  final String? searchSemanticLabel;

  /// The semantic label for the back icon when search is open.
  final String? searchBackSemanticLabel;

  /// The spacing around [title] content on the horizontal axis.
  final double? titleSpacing;

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
      ..add(DiagnosticsProperty<bool>('shrinks', shrinks))
      ..add(StringProperty('clearSemanticLabel', clearSemanticLabel))
      ..add(StringProperty('microphoneSemanticLabel', microphoneSemanticLabel))
      ..add(StringProperty('searchSemanticLabel', searchSemanticLabel))
      ..add(StringProperty('searchBackSemanticLabel', searchBackSemanticLabel))
      ..add(DoubleProperty('titleSpacing', titleSpacing));
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

  Widget _getTitle(ZetaColors colors) {
    return DefaultTextStyle(
      style: (widget.titleTextStyle ?? ZetaTextStyles.bodyLarge).copyWith(color: colors.mainDefault),
      child: widget.title ?? const Text(' '),
    );
  }

  List<Widget>? _getActions(ZetaColors colors) {
    if (_searchActive) {
      return [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Semantics(
              label: widget.clearSemanticLabel,
              button: true,
              child: IconButton(
                color: colors.mainDefault,
                onPressed: () => _searchController.clearText(),
                icon: Icon(
                  context.rounded ? ZetaIcons.cancel_round : ZetaIcons.cancel_sharp,
                  size: Zeta.of(context).spacing.xl,
                ),
              ),
            ),
            if (widget.onSearchMicrophoneIconPressed != null) ...[
              SizedBox(
                height: Zeta.of(context).spacing.xl_2,
                child: VerticalDivider(width: ZetaBorders.medium, color: colors.mainSubtle),
              ),
              Semantics(
                label: widget.microphoneSemanticLabel,
                button: true,
                child: IconButton(
                  onPressed: widget.onSearchMicrophoneIconPressed,
                  icon: Icon(context.rounded ? ZetaIcons.microphone_round : ZetaIcons.microphone_sharp),
                ),
              ),
            ],
          ],
        ),
      ];
    }

    if (_searchEnabled) {
      return [
        ...widget.actions,
        Semantics(
          label: widget.searchSemanticLabel,
          button: true,
          child: IconButton(
            onPressed: () => setState(() {
              _searchController.startSearch();
            }),
            icon: Icon(context.rounded ? ZetaIcons.search_round : ZetaIcons.search_sharp),
          ),
        ),
      ];
    }
    return widget.actions;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    final spacing = Zeta.of(context).spacing;

    final actions = _getActions(colors);
    final titleText = _getTitle(colors);

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
      leading = Semantics(
        label: widget.searchBackSemanticLabel,
        button: true,
        child: IconButton(
          onPressed: _searchController.closeSearch,
          icon: Icon(context.rounded ? ZetaIcons.arrow_back_round : ZetaIcons.arrow_back_sharp),
        ),
      );
    }

    return ZetaRoundedScope(
      rounded: context.rounded,
      child: ColoredBox(
        color: colors.surfaceDefault,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: spacing.minimum),
          child: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: colors.surfaceDefault,
            iconTheme: IconThemeData(color: colors.mainDefault),
            leading: leading,
            toolbarHeight: spacing.xl_9,
            titleSpacing:
                widget.titleSpacing ?? (leading != null || widget.automaticallyImplyLeading ? 0 : spacing.large),
            automaticallyImplyLeading: widget.automaticallyImplyLeading,
            surfaceTintColor: Colors.transparent,
            centerTitle: widget.type == ZetaTopAppBarType.centered,
            titleTextStyle: widget.titleTextStyle == null
                ? ZetaTextStyles.bodyLarge.copyWith(color: colors.mainDefault)
                : widget.titleTextStyle!.copyWith(color: colors.mainDefault),
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

  /// Aligns the title to the center of the app bar.
  centered,

  /// Title extends over 2 lines and collapses when scrolled.
  extended,
}
