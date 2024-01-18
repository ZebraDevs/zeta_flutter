import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

///[ZetaInPageBanner] button attributes
class ZetaPageBannerButton {
  ///Constructs [ZetaPageBannerButton]
  const ZetaPageBannerButton({this.onPressed, this.label});

  ///Called when the button is tapped.
  final VoidCallback? onPressed;

  ///Label for the button
  final String? label;
}

///Zeta In Page Banner
class ZetaInPageBanner extends StatelessWidget {
  ///Constructs [ZetaInPageBanner]
  const ZetaInPageBanner({
    required this.content,
    this.borderType = BorderType.rounded,
    this.severity = WidgetSeverity.info,
    this.showIconClose = true,
    this.onClose,
    this.title,
    this.customColors,
    this.customIcon,
    this.firstButton,
    this.secondButton,
    super.key,
  });

  ///The content of the banner
  final Widget content;

  ///The border type of the banner
  ///Defaults to 'rounded'
  final BorderType borderType;

  ///Determines the color of the banner
  ///Defaults to 'neutral'
  final WidgetSeverity severity;

  ///Determines if the banner has icon for closing
  ///Defaults to true
  final bool showIconClose;

  ///Title of the banner
  final String? title;

  ///If [severity] is set to 'custom',
  ///
  ///[customColors] should be set.
  final ZetaWidgetColor? customColors;

  ///Custom icon
  final IconData? customIcon;

  ///Attributes for the left button
  final ZetaPageBannerButton? firstButton;

  ///Attributes for the right button
  final ZetaPageBannerButton? secondButton;

  ///Called when the button 'Close' is tapped.
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final theme = Zeta.of(context);
    final colors = _getColors(theme);
    return DecoratedBox(
      decoration: _buildDecoration(colors),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.x3),
        child: Column(
          children: _buildBannerContent(theme, colors),
        ),
      ),
    );
  }

  List<Widget> _buildBannerContent(Zeta theme, ZetaWidgetColor colors) {
    final hasTitle = title != null;
    return [
      if (hasTitle) _buildTitleRow(colors, theme),
      _buildContentRow(theme, colors, hasTitle),
    ];
  }

  Widget _buildTitleRow(ZetaWidgetColor colors, Zeta theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.x2),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                _buildIconLeft(colors, theme),
                const SizedBox(width: Dimensions.x2),
                if (title != null) ...[_buildTitle()],
              ],
            ),
          ),
          if (showIconClose) ...[
            Align(
              alignment: Alignment.centerRight,
              child: _buildIconClose(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildContentRow(Zeta theme, ZetaWidgetColor colors, bool hasTitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title == null) ...[
              _buildIconLeft(colors, theme),
              const SizedBox(width: Dimensions.x2),
            ],
            _buildContent(hasTitle, theme),
            if (showIconClose && !hasTitle) ...[_buildIconClose()],
          ],
        ),
        _buildButtonsRow(theme, colors),
      ],
    );
  }

  Widget _buildButtonsRow(Zeta theme, ZetaWidgetColor colors) {
    return Row(
      children: [
        const Padding(padding: EdgeInsets.only(left: Dimensions.x7)),
        if (firstButton != null) ...[
          _buildButton(theme, colors, firstButton!),
          const SizedBox(width: Dimensions.x2),
        ],
        if (secondButton != null) ...[
          _buildButton(theme, colors, secondButton!),
        ],
      ],
    );
  }

  BoxDecoration _buildDecoration(ZetaWidgetColor colors) {
    return BoxDecoration(
      color: colors.backgroundColor,
      border: Border.all(color: colors.foregroundColor),
      borderRadius: BorderRadius.circular(
        borderType == BorderType.rounded ? Dimensions.x1 : Dimensions.x0,
      ),
    );
  }

  Expanded _buildContent(bool hasTitle, Zeta theme) => Expanded(
        child: Padding(
          padding: EdgeInsets.only(left: hasTitle ? Dimensions.x7 : Dimensions.x0),
          child: DefaultTextStyle(
            style: ZetaTextStyles.bodyMedium.apply(color: theme.colors.textDefault),
            child: content,
          ),
        ),
      );

  Widget _buildIconClose() => GestureDetector(
        onTap: onClose,
        child: Icon(
          borderType == BorderType.sharp ? ZetaIcons.close_sharp : ZetaIcons.close_round,
          size: Dimensions.x5,
        ),
      );

  Icon _buildIconLeft(ZetaWidgetColor colors, Zeta theme) => Icon(
        _getIconLeft(),
        size: Dimensions.x5,
        color: severity == WidgetSeverity.neutral ? theme.colors.textDefault : colors.foregroundColor,
      );

  Widget _buildTitle() => Flexible(
        child: Text(
          title!,
          style: ZetaTextStyles.titleSmall,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        ),
      );

  Widget _buildButton(
    Zeta theme,
    ZetaWidgetColor colors,
    ZetaPageBannerButton buttonAttributes,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.x3),
      child: ZetaButton.outlined(
        label: buttonAttributes.label ?? '',
        borderType: borderType,
        size: ZetaWidgetSize.medium,
        colors: ZetaButtonColors(
          borderColor: theme.colors.borderSubtle,
          foregroundColor: theme.colors.textDefault,
          actionColor: ZetaColorBase.greyCool.shade30,
        ),
        onPressed: buttonAttributes.onPressed,
      ),
    );
  }

  IconData _getIconLeft() {
    final isRounded = borderType == BorderType.rounded;
    final defaultIcon = isRounded ? ZetaIcons.info_round : ZetaIcons.info_sharp;
    if (severity == WidgetSeverity.positive) {
      return isRounded ? ZetaIcons.check_circle_round : ZetaIcons.check_circle_sharp;
    } else if (severity == WidgetSeverity.warning) {
      return isRounded ? ZetaIcons.warning_round : ZetaIcons.warning_sharp;
    } else if (severity == WidgetSeverity.negative) {
      return isRounded ? ZetaIcons.error_round : ZetaIcons.error_sharp;
    } else if (severity == WidgetSeverity.custom) {
      return customIcon ?? defaultIcon;
    }
    return defaultIcon;
  }

  ZetaWidgetColor _getColors(Zeta theme) {
    final defaultColorScheme = ZetaWidgetColor(
      backgroundColor: theme.colors.surfacePrimary,
      foregroundColor: theme.colors.borderDefault,
    );
    switch (severity) {
      case WidgetSeverity.neutral:
        return defaultColorScheme;
      case WidgetSeverity.info:
        return ZetaWidgetColor(
          backgroundColor: theme.colors.info.surface,
          foregroundColor: theme.colors.info.border,
        );
      case WidgetSeverity.positive:
        return ZetaWidgetColor(
          backgroundColor: theme.colors.positive.surface,
          foregroundColor: theme.colors.positive.border,
        );
      case WidgetSeverity.warning:
        return ZetaWidgetColor(
          backgroundColor: theme.colors.warning.surface.lighten(6),
          foregroundColor: theme.colors.warning.border,
        );
      case WidgetSeverity.negative:
        return ZetaWidgetColor(
          backgroundColor: theme.colors.negative.surface,
          foregroundColor: theme.colors.negative.border,
        );
      case WidgetSeverity.custom:
        return customColors ?? defaultColorScheme;
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<BorderType>('borderType', borderType))
      ..add(EnumProperty<WidgetSeverity>('severity', severity))
      ..add(DiagnosticsProperty<bool>('isClosing', showIconClose))
      ..add(StringProperty('title', title))
      ..add(
        DiagnosticsProperty<ZetaWidgetColor?>('customColors', customColors),
      )
      ..add(DiagnosticsProperty<IconData?>('customIcon', customIcon))
      ..add(
        DiagnosticsProperty<ZetaPageBannerButton>('firstButton', firstButton),
      )
      ..add(
        DiagnosticsProperty<ZetaPageBannerButton>(
          'secondButton',
          secondButton,
        ),
      )
      ..add(
        ObjectFlagProperty<VoidCallback>.has(
          'onCloseFunction',
          onClose,
        ),
      );
  }
}
