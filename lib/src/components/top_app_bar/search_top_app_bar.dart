import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// Creates a search field used on a [ZetaTopAppBar].
/// {@category Components}
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=229-37&node-type=canvas&m=dev
///
/// Widgetbook: https://zeta-ds.web.app/flutter/widgetbook/index.html#/?path=components/top-app-bar/search
class ZetaTopAppBarSearchField extends ZetaStatefulWidget {
  /// Constructs a [ZetaTopAppBarSearchField].
  const ZetaTopAppBarSearchField({
    super.key,
    super.rounded,
    required this.child,
    required this.onSearch,
    required this.searchController,
    required this.hintText,
    required this.type,
    required this.isExtended,
  });

  /// Called when text in the search field is submitted.
  final void Function(String value)? onSearch;

  /// Child of widget.
  final Widget? child;

  /// Label used as hint text. If null, displays 'Search'.
  final String hintText;

  /// Used to control the search textfield and states.
  final ZetaSearchController? searchController;

  /// Defines the styles of the app bar.
  final ZetaTopAppBarType type;

  /// Whether top app bar is extended.
  final bool isExtended;

  @override
  State<ZetaTopAppBarSearchField> createState() => _ZetaTopAppBarSearchFieldState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<void Function(String value)?>.has('onSearch', onSearch))
      ..add(StringProperty('hintText', hintText))
      ..add(DiagnosticsProperty<ZetaSearchController?>('searchController', searchController))
      ..add(EnumProperty<ZetaTopAppBarType>('type', type))
      ..add(DiagnosticsProperty<bool>('isExtended', isExtended));
  }
}

class _ZetaTopAppBarSearchFieldState extends State<ZetaTopAppBarSearchField> with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(
    vsync: this,
    duration: kThemeAnimationDuration,
  );

  late bool _isSearching = widget.searchController?.isEnabled ?? false;
  late final _textFocusNode = FocusNode();

  @override
  void initState() {
    widget.searchController?.addListener(_onSearchControllerChanged);
    widget.searchController?.textEditingController ??= TextEditingController();

    super.initState();
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
  void didUpdateWidget(covariant ZetaTopAppBarSearchField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchController != widget.searchController) {
      _setNextSearchState();
    }
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
    final extendedOffset = Zeta.of(context).spacing.minimum * 6.5; // TODO(UX-1202): Irregular spacing values

    return ZetaRoundedScope(
      rounded: context.rounded,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Row(
            mainAxisAlignment:
                widget.type == ZetaTopAppBarType.centered ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              widget.child ?? const Nothing(),
            ],
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: widget.isExtended ? extendedOffset : double.infinity),
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) => Transform.scale(
                scaleX: _animationController.value,
                alignment: Alignment.centerRight,
                origin: Offset.zero,
                child: TextField(
                  controller: widget.searchController?.textEditingController,
                  focusNode: _textFocusNode,
                  style: ZetaTextStyles.bodyMedium,
                  cursorColor: colors.mainDefault,
                  decoration: InputDecoration(
                    iconColor: colors.mainDefault,
                    filled: true,
                    border: InputBorder.none,
                    hintStyle: ZetaTextStyles.bodyMedium.copyWith(
                      color: colors.mainDisabled,
                    ),
                    hintText: widget.hintText,
                  ),
                  onEditingComplete: _submitSearch,
                  textInputAction: TextInputAction.search,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A controller used to control the search field in the app bar.
@Deprecated('Use ZetaSearchController instead. ' 'Deprecated as of 0.14.1')
typedef AppBarSearchController = ZetaSearchController;

/// A controller used to control the search field in the app bar.
class ZetaSearchController extends ChangeNotifier {
  bool _enabled = false;

  /// Controller used for the search field.
  TextEditingController? textEditingController;

  /// Whether the search is currently visible.
  bool get isEnabled => _enabled;

  /// The current text in the search field.
  String get text => textEditingController?.text ?? '';

  /// Displays text in the search field and overrides the existing.
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
