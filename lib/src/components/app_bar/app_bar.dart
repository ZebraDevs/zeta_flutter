import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

/// Zeta app bar.
class ZetaAppBar extends StatefulWidget implements PreferredSizeWidget {
  /// Creates a Zeta app bar.
  const ZetaAppBar({
    this.actions,
    this.automaticallyImplyLeading = true,
    this.searchController,
    this.leading,
    this.title,
    this.type = ZetaAppBarType.defaultAppBar,
    this.onSearch,
    this.searchHintText = 'Search',
    this.onSearchMicrophoneIconPressed,
    super.key,
  });

  /// Called when text in the search field is submited.
  final void Function(String)? onSearch;

  /// A list of Widgets to display in a row after the [title] widget.
  final List<Widget>? actions;

  /// Configures whether the back button to be displayed.
  final bool automaticallyImplyLeading;

  /// Widget displayed first in the app bar row.
  final Widget? leading;

  /// If omitted the microphone icon won't show up. Called when the icon button is pressed. Normally used for speech recognition/speech to text.
  final VoidCallback? onSearchMicrophoneIconPressed;

  /// Used to controll the search textfield and states.
  final AppBarSearchController? searchController;

  /// Label used as hint text.
  final String searchHintText;

  /// Title of the app bar. Normally a [Text] widget.
  final Widget? title;

  /// Defines the styles of the app bar.
  final ZetaAppBarType type;

  @override
  State<ZetaAppBar> createState() => _ZetaAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        ObjectFlagProperty<void Function(String p1)?>.has('onSearch', onSearch),
      )
      ..add(
        DiagnosticsProperty<bool>(
          'automaticallyImplyLeading',
          automaticallyImplyLeading,
        ),
      )
      ..add(
        DiagnosticsProperty<AppBarSearchController?>(
          'searchController',
          searchController,
        ),
      )
      ..add(
        ObjectFlagProperty<VoidCallback?>.has(
          'onSearchMicrophoneIconPressed',
          onSearchMicrophoneIconPressed,
        ),
      )
      ..add(StringProperty('searchHintText', searchHintText))
      ..add(EnumProperty<ZetaAppBarType>('type', type));
  }
}

class _ZetaAppBarState extends State<ZetaAppBar> {
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

  Widget? _getTitle() {
    return widget.type != ZetaAppBarType.extendedTitle
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: ZetaSpacing.b),
            child: widget.title,
          )
        : null;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    return IconButtonTheme(
      data: IconButtonThemeData(
        style: IconButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: ZetaSpacing.b),
        child: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: colors.cool.shade90),
          leadingWidth: ZetaSpacing.x10,
          leading: widget.leading,
          automaticallyImplyLeading: widget.automaticallyImplyLeading,
          centerTitle: widget.type == ZetaAppBarType.centeredTitle,
          titleSpacing: 0,
          titleTextStyle: ZetaTextStyles.bodyLarge.copyWith(
            color: colors.textDefault,
          ),
          title: widget.searchController != null
              ? _SearchField(
                  searchController: widget.searchController,
                  hintText: widget.searchHintText,
                  onSearch: widget.onSearch,
                  type: widget.type,
                  child: _getTitle(),
                )
              : _getTitle(),
          actions: _isSearchEnabled
              ? [
                  IconButtonTheme(
                    data: IconButtonThemeData(
                      style: IconButton.styleFrom(
                        iconSize: ZetaSpacing.x5,
                      ),
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
                            height: ZetaSpacing.m,
                            child: VerticalDivider(
                              width: ZetaSpacing.x0_5,
                              color: colors.cool.shade70,
                            ),
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
              : widget.actions,
          flexibleSpace: widget.type == ZetaAppBarType.extendedTitle
              ? Padding(
                  padding: EdgeInsets.only(
                    top: widget.preferredSize.height,
                    left: ZetaSpacing.s,
                    right: ZetaSpacing.s,
                  ),
                  child: DefaultTextStyle(
                    style: ZetaTextStyles.bodyLarge.copyWith(
                      color: colors.textDefault,
                    ),
                    child: widget.title ?? const SizedBox(),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

/// Defines the style of the app bar.
enum ZetaAppBarType {
  /// Title positioned on the left side.
  defaultAppBar,

  /// Title in the center.
  centeredTitle,

  /// Title below the app bar.
  extendedTitle,
}

class _SearchField extends StatefulWidget {
  const _SearchField({
    required this.child,
    required this.onSearch,
    required this.searchController,
    required this.hintText,
    required this.type,
  });

  final void Function(String value)? onSearch;
  final Widget? child;
  final String hintText;
  final AppBarSearchController? searchController;
  final ZetaAppBarType type;

  @override
  State<_SearchField> createState() => _SearchFieldState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        ObjectFlagProperty<void Function(String value)?>.has(
          'onSearch',
          onSearch,
        ),
      )
      ..add(StringProperty('hintText', hintText))
      ..add(
        DiagnosticsProperty<AppBarSearchController?>(
          'searchController',
          searchController,
        ),
      )
      ..add(EnumProperty<ZetaAppBarType>('type', type));
  }
}

class _SearchFieldState extends State<_SearchField> with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(
    vsync: this,
    duration: kThemeAnimationDuration,
  );

  late bool _isSearching = widget.searchController?.isEnabled ?? false;
  late final _textFocusNode = FocusNode();

  @override
  void initState() {
    _textFocusNode.addListener(_onFocusChanged);
    widget.searchController?.addListener(_onSearchControllerChanged);
    widget.searchController?.textEditingController ??= TextEditingController();

    super.initState();
  }

  void _onFocusChanged() {
    final text = widget.searchController?.text ?? '';
    final shouldCloseSearch = _isSearching && text.isEmpty && !_textFocusNode.hasFocus;

    if (shouldCloseSearch) _closeSearch();
  }

  void _onSearchControllerChanged() {
    final controller = widget.searchController;
    if (controller == null) return;

    controller.isEnabled ? _startSearch() : _closeSearch();
  }

  void _setNextSearchState() {
    if (!_isSearching) return _startSearch();

    _closeSearch();
  }

  void _startSearch() {
    widget.searchController?.startSearch();
    setState(() => _isSearching = true);

    _animationController.forward();
    FocusScope.of(context).requestFocus(_textFocusNode);
  }

  void _closeSearch() {
    widget.searchController?.closeSearch();
    setState(() => _isSearching = false);
    _animationController.reverse();
    _removeFocus(context);
  }

  void _submitSearch() {
    widget.onSearch?.call(widget.searchController?.text ?? '');
    widget.searchController?.text = '';
    _closeSearch();
  }

  void _removeFocus(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  void didUpdateWidget(covariant _SearchField oldWidget) {
    if (oldWidget.searchController != widget.searchController) {
      _setNextSearchState();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _textFocusNode.dispose();
    widget.searchController?.removeListener(_onSearchControllerChanged);
    widget.searchController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment:
              widget.type == ZetaAppBarType.centeredTitle ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            widget.child ?? const SizedBox(),
          ],
        ),
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) => Transform.scale(
            scaleX: _animationController.value * 1,
            alignment: Alignment.centerRight,
            origin: Offset.zero,
            child: TextField(
              controller: widget.searchController?.textEditingController,
              focusNode: _textFocusNode,
              style: ZetaTextStyles.bodyMedium,
              cursorColor: colors.cool.shade90,
              decoration: InputDecoration(
                iconColor: colors.cool.shade90,
                filled: true,
                border: InputBorder.none,
                hintStyle: ZetaTextStyles.bodyMedium.copyWith(
                  color: colors.textDisabled,
                ),
                hintText: widget.hintText,
              ),
              onEditingComplete: _submitSearch,
              textInputAction: TextInputAction.search,
            ),
          ),
        ),
      ],
    );
  }
}

/// Controlls the search.
class AppBarSearchController extends ChangeNotifier {
  bool _enabled = false;

  /// Controller used for the search field.
  TextEditingController? textEditingController;

  /// Whether the search is currently vissible.
  bool get isEnabled => _enabled;

  /// The current text in the search field.
  String get text => textEditingController?.text ?? '';

  /// Displayes text in the search field and overrides the existing.
  set text(String text) => textEditingController?.text = text;

  /// Displays the search field over the title in the app bar.
  void startSearch() {
    if (_enabled) return;

    _enabled = true;
    notifyListeners();
  }

  /// Hides the search field from the app bar.
  void closeSearch() {
    if (!_enabled) return;

    _enabled = false;
    notifyListeners();
  }

  /// Removes the text from search field.
  void clearText() => textEditingController?.clear();

  @override
  void dispose() {
    textEditingController?.dispose();
    super.dispose();
  }
}
