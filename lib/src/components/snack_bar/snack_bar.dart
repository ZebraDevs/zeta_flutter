import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

/// Type used to define contextual [SnackBar]. The type defines the styles, icons and behavior.
enum ZetaSnackBarType {
  /// Default colors with leading icon with close action.
  defaultType,

  /// Default colors with leading icon and custom action.
  action,

  /// Success styles with close action.
  positive,

  /// Info styles with close action.
  info,

  /// Warning styles with close action.
  warning,

  /// Error styles with close action.
  error,

  /// Deletion styles with custom undo action.
  deletion,

  /// View styles with custom view action.
  view,
}

/// A lightweight message with an optional action which briefly displays at the
/// bottom of the screen.
///
/// Different styles can be applied to [ZetaSnackBar] with [ZetaSnackBarType].
/// {@category Components}
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=229-13&node-type=canvas&m=dev
///
/// Widgetbook: https://zeta-ds.web.app/flutter/widgetbook/index.html#/?path=components/snack-bar
class ZetaSnackBar extends SnackBar {
  /// Sets basic styles for the [SnackBar].
  ZetaSnackBar({
    super.key,
    super.behavior = SnackBarBehavior.floating,
    super.margin,

    /// Context required to get the theme and colors.
    required BuildContext context,

    /// The main content of the snackbar.
    required Widget content,

    /// Callback to be called when the action button is pressed.
    VoidCallback? onPressed,

    /// Type used to define contextual [SnackBar]. The type defines the styles, icons and behavior.
    ZetaSnackBarType? type,

    /// Icon to display at the start of the content.
    ///
    /// Should be of type [ZetaIcon] or [Icon].
    Widget? leadingIcon,

    /// {@macro zeta-widget-rounded}
    bool? rounded,

    /// Label for the action button.
    ///
    /// Depending on the `type`, the default label will be used; 'Undo' for [ZetaSnackBarType.deletion] and 'View' for [ZetaSnackBarType.view].
    String? actionLabel,

    /// Label for the delete action button.
    ///
    /// If null, 'Delete' will be used.
    @Deprecated('Use actionLabel instead.' ' Deprecated in 0.12.1') String? deleteActionLabel,

    /// Label for the view action button.
    ///
    /// If null, 'View' will be used.
    @Deprecated('Use actionLabel instead.' ' Deprecated in 0.12.1') String? viewActionLabel,

    /// Semantic label for the action button.
    ///
    /// If null, the `actionLabel` will be used.
    String? actionSemanticLabel,
  }) : super(
          elevation: 0,
          padding: EdgeInsets.zero,
          backgroundColor: _getBackgroundColorForType(context, type),
          shape: RoundedRectangleBorder(
            borderRadius: type != null
                ? Zeta.of(context).radius.full
                : rounded ?? context.rounded
                    ? Zeta.of(context).radius.minimal
                    : Zeta.of(context).radius.none,
          ),
          content: ZetaRoundedScope(
            rounded: rounded ?? context.rounded,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: Zeta.of(context).spacing.small),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        _LeadingIcon(type, leadingIcon),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(left: Zeta.of(context).spacing.medium),
                            child: _Content(type: type, child: content),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _Action(
                    type: type,
                    actionLabel: actionLabel,
                    onPressed: onPressed,
                    deleteActionLabel: deleteActionLabel,
                    viewActionLabel: viewActionLabel,
                    semanticLabel: actionSemanticLabel,
                  ),
                ],
              ),
            ),
          ),
        );

  static Color _getBackgroundColorForType(
    BuildContext context,
    ZetaSnackBarType? type,
  ) {
    final colors = Zeta.of(context).colors;

    return switch (type) {
      ZetaSnackBarType.positive => colors.green.shade10,
      ZetaSnackBarType.info => colors.purple.shade10,
      ZetaSnackBarType.warning => colors.orange.shade10,
      ZetaSnackBarType.deletion || ZetaSnackBarType.error => colors.red.shade10,
      ZetaSnackBarType.view => colors.blue.shade10,
      _ => colors.warm.shade100,
    };
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.child, required this.type});

  final Widget child;
  final ZetaSnackBarType? type;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<ZetaSnackBarType?>('type', type))
      ..add(DiagnosticsProperty<Widget>('child', child));
  }

  Color _getColorForType(
    ZetaColors colors,
    ZetaSnackBarType? type,
  ) {
    return switch (type) {
      ZetaSnackBarType.positive ||
      ZetaSnackBarType.info ||
      ZetaSnackBarType.warning ||
      ZetaSnackBarType.deletion ||
      ZetaSnackBarType.error ||
      ZetaSnackBarType.view =>
        colors.textDefault,
      _ => colors.textInverse,
    };
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    return DefaultTextStyle(
      style: ZetaTextStyles.bodyMedium.copyWith(
        color: _getColorForType(colors, type),
      ),
      child: child,
    );
  }
}

class _Action extends StatelessWidget {
  const _Action({
    required this.type,
    required this.actionLabel,
    required this.onPressed,
    required this.deleteActionLabel,
    required this.viewActionLabel,
    this.semanticLabel,
  });

  final String? actionLabel;
  final String? deleteActionLabel;
  final VoidCallback? onPressed;
  final ZetaSnackBarType? type;
  final String? viewActionLabel;
  final String? semanticLabel;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<ZetaSnackBarType?>('type', type))
      ..add(StringProperty('actionLabel', actionLabel))
      ..add(StringProperty('deleteActionLabel', deleteActionLabel))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onPressed', onPressed))
      ..add(StringProperty('viewActionLabel', viewActionLabel))
      ..add(StringProperty('semanticLabel', semanticLabel));
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    String? label = actionLabel;
    if (label == null) {
      if (type case ZetaSnackBarType.deletion) {
        label = deleteActionLabel ?? 'Undo';
      } else if (type case ZetaSnackBarType.view) {
        label = viewActionLabel ?? 'View';
      }
    }

    return Semantics(
      label: semanticLabel ?? label ?? '',
      button: true,
      enabled: onPressed != null,
      container: true,
      excludeSemantics: true,
      child: () {
        return switch (type) {
          ZetaSnackBarType.defaultType => _IconButton(
              onPressed: () => ScaffoldMessenger.of(context).removeCurrentSnackBar(),
              color: colors.iconInverse,
            ),
          ZetaSnackBarType.action => _ActionButton(
              onPressed: onPressed,
              label: label,
              color: colors.borderPrimaryMain,
            ),
          ZetaSnackBarType.positive ||
          ZetaSnackBarType.info ||
          ZetaSnackBarType.warning ||
          ZetaSnackBarType.error =>
            _IconButton(
              onPressed: () => ScaffoldMessenger.of(context).removeCurrentSnackBar(),
              color: colors.cool.shade90,
            ),
          ZetaSnackBarType.deletion => _ActionButton(
              onPressed: onPressed,
              label: label,
              color: colors.cool.shade90,
            ),
          ZetaSnackBarType.view => _ActionButton(
              onPressed: onPressed,
              label: label,
              color: colors.cool.shade90,
            ),
          _ => _ActionButton(
              onPressed: onPressed,
              label: label,
              color: colors.blue.shade50,
            ),
        };
      }(),
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({
    required this.onPressed,
    required this.color,
  });

  final Color color;
  final VoidCallback? onPressed;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<VoidCallback?>.has('onPressed', onPressed))
      ..add(ColorProperty('color', color));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Zeta.of(context).spacing.minimum),
      child: IconButton(
        style: IconButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: Zeta.of(context).spacing.medium),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minimumSize: Size(Zeta.of(context).spacing.xl, Zeta.of(context).spacing.xl),
        ),
        onPressed: onPressed,
        icon: ZetaIcon(ZetaIcons.close, color: color, size: Zeta.of(context).spacing.xl),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.onPressed,
    required this.label,
    required this.color,
  });

  final Color color;
  final String? label;
  final VoidCallback? onPressed;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<VoidCallback?>.has('onPressed', onPressed))
      ..add(StringProperty('label', label))
      ..add(ColorProperty('color', color));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Zeta.of(context).spacing.medium),
      child: TextButton(
        style: TextButton.styleFrom(
          textStyle: ZetaTextStyles.labelLarge,
          padding: EdgeInsets.symmetric(
            horizontal: Zeta.of(context).spacing.medium,
            vertical: Zeta.of(context).spacing.minimum,
          ),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minimumSize: Size.zero,
        ),
        onPressed: onPressed,
        child: Text(
          label ?? '',
          style: ZetaTextStyles.labelLarge.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _LeadingIcon extends StatelessWidget {
  const _LeadingIcon(this.type, this.icon);

  final Widget? icon;
  final ZetaSnackBarType? type;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<ZetaSnackBarType?>('type', type));
  }

  Color _getIconColor(ZetaColors colors, ZetaSnackBarType? type) {
    return switch (type) {
      ZetaSnackBarType.positive => colors.surfacePositive,
      ZetaSnackBarType.info => colors.surfaceInfo,
      ZetaSnackBarType.warning => colors.surfaceWarning,
      ZetaSnackBarType.error || ZetaSnackBarType.deletion => colors.surfaceNegative,
      ZetaSnackBarType.view => colors.primary,
      _ => colors.iconInverse,
    };
  }

  Widget _getIcon(ZetaSnackBarType? type) {
    return switch (type) {
      ZetaSnackBarType.positive => const ZetaIcon(ZetaIcons.check_circle),
      ZetaSnackBarType.info => const ZetaIcon(ZetaIcons.info),
      ZetaSnackBarType.warning => const ZetaIcon(ZetaIcons.warning),
      ZetaSnackBarType.error => const ZetaIcon(ZetaIcons.error),
      ZetaSnackBarType.deletion => const ZetaIcon(ZetaIcons.delete),
      ZetaSnackBarType.view => const ZetaIcon(ZetaIcons.open_in_new_window),
      _ => const Nothing(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    return Padding(
      padding: type != null || icon != null ? EdgeInsets.only(left: Zeta.of(context).spacing.medium) : EdgeInsets.zero,
      child: IconTheme(
        data: IconThemeData(
          color: _getIconColor(colors, type),
        ),
        child: icon ?? _getIcon(type),
      ),
    );
  }
}
