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

    if (isAi) {
      return DecoratedBox(
        decoration: const BoxDecoration(
          borderRadius: borderRadius,
          gradient: LinearGradient(
            colors: [Color(0xFFFF40FC), Color(0xFF1F6AFF)],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            stops: [0.23, 1.0],
          ),
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
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Zeta.of(context).colors.surfaceDefault,
        borderRadius: borderRadius,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: borderRadius,
        child: _buildCardContent(context),
      ),
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
            padding: EdgeInsets.all(Zeta.of(context).spacing.xl_2),
            child: Column(
              spacing: Zeta.of(context).spacing.large,
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
  const ZetaCardHeader({super.key, this.title, this.description, required this.isRequired});

  @override
  final String? title;
  @override
  final String? description;
  @override
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 1, // TODO(tokens): not a token
      children: [
        if (title != null)
          Row(
            children: [
              Text(
                title!,
                style: Zeta.of(context).textStyles.h4,
              ),
              if (isRequired)
                Text(' *', style: Zeta.of(context).textStyles.h4.apply(color: Zeta.of(context).colors.mainNegative)),
            ],
          ),
        if (description != null)
          Text(
            description!,
            style: Zeta.of(context).textStyles.h5.apply(color: Zeta.of(context).colors.mainSubtle),
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
/// TODO(design): Better description of the component and its usage.
class ZetaCard extends ZetaStatelessWidget implements _CardHeaderInterface, _CardInterface {
  /// Constructs a [ZetaCard].
  const ZetaCard({this.content, this.isAi = false, this.title, this.description, this.isRequired = false, super.key});

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
  Widget build(BuildContext context) {
    return ZetaBaseCard(
      header: ZetaCardHeader(isRequired: isRequired, title: title, description: description),
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
  Widget build(BuildContext context) {
    return ZetaBaseCard(
      header: ZetaCardHeader(isRequired: isRequired, title: title, description: description),
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
              Zeta.of(context).spacing.xl_2,
              Zeta.of(context).spacing.xl_2,
              Zeta.of(context).spacing.xl_2,
              _isExpanded ? Zeta.of(context).spacing.large : Zeta.of(context).spacing.xl_2,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedRotation(
                  turns: _isExpanded ? 0 : -0.25,
                  duration: ZetaAnimationLength.fast,
                  child: Icon(ZetaIcons.expand_more, color: Zeta.of(context).colors.mainDefault),
                ),
                widget.header,
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
