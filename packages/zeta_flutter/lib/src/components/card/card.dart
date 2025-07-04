import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// Interface for card header properties.
abstract class _CardHeaderInterface {
  /// Title of the card, displayed in the header.
  String? get title;

  /// Subtitle of the card, displayed in the header.
  String? get description;

  /// Whether the card is required, indicated by a red asterisk (*) in the header.
  bool get isRequired;

  /// Maximum number of lines for the header text.
  int get headerMaxLines;
}

abstract class _CardInterface {
  /// Whether the card is an AI card.
  bool get isAi;

  /// Content of the card, displayed below the header.
  /// If null, no content is displayed.
  Widget? get content;
}

abstract class _CollapsibleCardInterface {
  /// Whether the card is expanded.
  bool get isExpanded;

  /// Callback when the card is toggled.
  VoidCallback? get onToggle;
}

/// A card component.
///
// TODO(design): Better description of the component and its usage.
class ZetaBaseCard extends ZetaStatelessWidget implements _CardInterface, _CollapsibleCardInterface {
  /// Constructs a [ZetaBaseCard].
  const ZetaBaseCard({
    required this.header,
    this.content,
    this.isAi = false,
    this.isExpanded = false,
    this.onToggle,
    required this.isCollapsible,
    super.key,
  });

  @override
  final Widget? content;
  @override
  final bool isAi;
  @override
  final bool isExpanded;
  @override
  final VoidCallback? onToggle;

  /// Header of the card, displayed at the top.
  final ZetaCardHeader header;

  /// Whether the card is collapsible.
  ///
  /// [content] *must* be provided if this is true.
  final bool isCollapsible;

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(12)); // TODO: not a token
    const borderWidth = 2.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            gradient: isAi
                ? const LinearGradient(
                    colors: [Color(0xFFFF40FC), Color(0xFF1F6AFF)],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    stops: [0.23, 1.0],
                  )
                : null,
          ),
          child: Container(
            margin: const EdgeInsets.all(borderWidth),
            decoration: BoxDecoration(
              color: Zeta.of(context).colors.surfaceDefault,
              borderRadius: const BorderRadius.all(Radius.circular(12 - borderWidth)),
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: const BorderRadius.all(Radius.circular(12 - borderWidth)),
              child: _buildCardContent(context),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCardContent(BuildContext context) {
    return isCollapsible
        ? _ZetaCollapsibleCardStateful(
            header: header,
            content: content,
            isExpanded: isExpanded,
          )
        : Padding(
            padding: EdgeInsets.all(Zeta.of(context).spacing.xl_2 - ZetaBorders.medium),
            child: Column(
              spacing: Zeta.of(context).spacing.large,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header,
                if (content != null) content!,
              ],
            ),
          );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<Widget?>('content', content))
      ..add(DiagnosticsProperty<bool>('isAi', isAi))
      ..add(DiagnosticsProperty<bool>('isExpanded', isExpanded))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onToggle', onToggle))
      ..add(DiagnosticsProperty<bool>('isCollapsible', isCollapsible));
  }
}

/// Header for the [ZetaCard] and [ZetaCollapsibleCard].
class ZetaCardHeader extends ZetaStatelessWidget implements _CardHeaderInterface {
  /// Constructs a [ZetaCardHeader].
  const ZetaCardHeader({super.key, this.title, this.description, required this.isRequired, this.headerMaxLines = 2});

  @override
  final String? title;
  @override
  final String? description;
  @override
  final bool isRequired;
  @override
  final int headerMaxLines;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: ZetaBorders.small,
            children: [
              if (title != null)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        title!,
                        style: Zeta.of(context).textStyles.h4.apply(color: Zeta.of(context).colors.mainDefault),
                        overflow: TextOverflow.ellipsis,
                        maxLines: headerMaxLines,
                        softWrap: true,
                      ),
                    ),
                    if (isRequired)
                      Text(
                        ' *',
                        style: Zeta.of(context).textStyles.h4.apply(color: Zeta.of(context).colors.mainNegative),
                      ),
                  ],
                ),
              if (description != null)
                Text(
                  description!,
                  style: Zeta.of(context).textStyles.h5.apply(color: Zeta.of(context).colors.mainSubtle),
                ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('title', title))
      ..add(StringProperty('subtitle', description))
      ..add(DiagnosticsProperty<bool>('isRequired', isRequired));
  }
}

/// A card component with a header and optional content.
// TODO(design): Better description of the component and its usage.
class ZetaCard extends ZetaStatelessWidget implements _CardHeaderInterface, _CardInterface {
  /// Constructs a [ZetaCard].
  const ZetaCard({
    this.content,
    this.isAi = false,
    this.title,
    this.description,
    this.isRequired = false,
    this.headerMaxLines = 2,
    super.key,
  });

  @override
  final String? title;

  @override
  final String? description;

  @override
  final bool isRequired;

  @override
  final Widget? content;

  @override
  final bool isAi;

  @override
  final int headerMaxLines;

  @override
  Widget build(BuildContext context) {
    return ZetaBaseCard(
      header: ZetaCardHeader(
        isRequired: isRequired,
        title: title,
        description: description,
        headerMaxLines: headerMaxLines,
      ),
      content: content,
      isAi: isAi,
      isCollapsible: false,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('isRequired', isRequired))
      ..add(StringProperty('description', description))
      ..add(StringProperty('title', title))
      ..add(DiagnosticsProperty<bool>('isAi', isAi));
  }
}

/// A collapsible card component with a header and optional content.
/// TODO(design): Better description of the component and its usage.
class ZetaCollapsibleCard extends ZetaStatelessWidget
    implements _CardHeaderInterface, _CardInterface, _CollapsibleCardInterface {
  /// Constructs a [ZetaCollapsibleCard].
  const ZetaCollapsibleCard({
    this.isExpanded = false,
    this.onToggle,
    this.content,
    this.isAi = false,
    this.title,
    this.description,
    this.isRequired = false,
    this.headerMaxLines = 2,
    super.key,
  });

  @override
  final String? title;
  @override
  final String? description;
  @override
  final bool isRequired;
  @override
  final Widget? content;
  @override
  final bool isAi;
  @override
  final bool isExpanded;
  @override
  final VoidCallback? onToggle;
  @override
  final int headerMaxLines;

  @override
  Widget build(BuildContext context) {
    return ZetaBaseCard(
      header: ZetaCardHeader(
        isRequired: isRequired,
        title: title,
        description: description,
        headerMaxLines: headerMaxLines,
      ),
      content: content,
      isAi: isAi,
      isCollapsible: true,
      isExpanded: isExpanded,
      onToggle: onToggle,
    );
  }
}

class _ZetaCollapsibleCardStateful extends StatefulWidget {
  const _ZetaCollapsibleCardStateful({required this.header, this.content, required this.isExpanded});

  final Widget header;
  final Widget? content;
  final bool isExpanded;
  @override
  State<_ZetaCollapsibleCardStateful> createState() => __ZetaCollapsibleCardStatefulState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('isExpanded', isExpanded));
  }
}

class __ZetaCollapsibleCardStatefulState extends State<_ZetaCollapsibleCardStateful> {
  late bool _isExpanded = widget.isExpanded;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(12), // TODO: not a token
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              Zeta.of(context).spacing.xl_2 - ZetaBorders.medium,
              Zeta.of(context).spacing.xl_2 - ZetaBorders.medium,
              Zeta.of(context).spacing.xl_2 - ZetaBorders.medium,
              _isExpanded ? Zeta.of(context).spacing.large : Zeta.of(context).spacing.xl_2 - ZetaBorders.medium,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedRotation(
                  turns: _isExpanded ? 0 : -0.25,
                  duration: ZetaAnimationLength.fast,
                  child: Icon(ZetaIcons.expand_more, color: Zeta.of(context).colors.mainDefault),
                ),
                Expanded(child: widget.header),
              ],
            ),
          ),
        ),
        AnimatedSize(
          duration: ZetaAnimationLength.normal,
          curve: Curves.easeInOut,
          child: ClipRect(
            child: ConstrainedBox(
              constraints: _isExpanded ? const BoxConstraints() : const BoxConstraints(maxHeight: 0),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  Zeta.of(context).spacing.xl_2,
                  Zeta.of(context).spacing.none,
                  Zeta.of(context).spacing.xl_2,
                  Zeta.of(context).spacing.none,
                ),
                child: widget.content,
              ),
            ),
          ),
        ),
        if (_isExpanded) SizedBox(height: Zeta.of(context).spacing.xl_2),
      ],
    );
  }
}
