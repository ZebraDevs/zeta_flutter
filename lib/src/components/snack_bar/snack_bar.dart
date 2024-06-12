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
class ZetaSnackBar extends SnackBar {
  /// Sets basic styles for the [SnackBar].
  ZetaSnackBar({
    required BuildContext context,
    required Widget content,
    VoidCallback? onPressed,
    ZetaSnackBarType? type,
    Icon? leadingIcon,
    bool? rounded,
    String? actionLabel,
    String deleteActionLabel = 'Undo',
    String viewActionLabel = 'View',
    super.margin,
    super.behavior = SnackBarBehavior.floating,
    super.key,
  }) : super(
          elevation: 0,
          padding: EdgeInsets.zero,
          backgroundColor: _getBackgroundColorForType(context, type),
          shape: RoundedRectangleBorder(
            borderRadius: type != null
                ? ZetaRadius.full
                : rounded ?? context.rounded
                    ? ZetaRadius.minimal
                    : ZetaRadius.none,
          ),
          content: ZetaRoundedScope(
            rounded: rounded ?? context.rounded,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: ZetaSpacing.small),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        _LeadingIcon(type, leadingIcon),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: ZetaSpacing.medium),
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
  });

  final String? actionLabel;
  final String deleteActionLabel;
  final VoidCallback? onPressed;
  final ZetaSnackBarType? type;
  final String viewActionLabel;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<ZetaSnackBarType?>('type', type))
      ..add(StringProperty('actionLabel', actionLabel))
      ..add(StringProperty('deleteActionLabel', deleteActionLabel))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onPressed', onPressed))
      ..add(StringProperty('viewActionLabel', viewActionLabel));
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    return switch (type) {
      ZetaSnackBarType.defaultType => _IconButton(
          onPressed: () => ScaffoldMessenger.of(context).removeCurrentSnackBar(),
          color: colors.iconInverse,
        ),
      ZetaSnackBarType.action => _ActionButton(
          onPressed: onPressed,
          label: actionLabel,
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
          label: deleteActionLabel,
          color: colors.cool.shade90,
        ),
      ZetaSnackBarType.view => _ActionButton(
          onPressed: onPressed,
          label: viewActionLabel,
          color: colors.cool.shade90,
        ),
      _ => _ActionButton(
          onPressed: onPressed,
          label: actionLabel,
          color: colors.blue.shade50,
        ),
    };
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
      padding: const EdgeInsets.symmetric(vertical: ZetaSpacing.minimum),
      child: IconButton(
        style: IconButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: ZetaSpacing.medium),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minimumSize: const Size(ZetaSpacing.xl_1, ZetaSpacing.xl_1),
        ),
        onPressed: onPressed,
        icon: Icon(
          ZetaIcons.close_round,
          color: color,
          size: ZetaSpacing.xl_1,
        ),
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
      padding: const EdgeInsets.symmetric(horizontal: ZetaSpacing.medium),
      child: TextButton(
        style: TextButton.styleFrom(
          textStyle: ZetaTextStyles.labelLarge,
          padding: const EdgeInsets.symmetric(
            horizontal: ZetaSpacing.medium,
            vertical: ZetaSpacing.minimum,
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

  final Icon? icon;
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
      ZetaSnackBarType.positive => const Icon(ZetaIcons.check_circle_round),
      ZetaSnackBarType.info => const Icon(ZetaIcons.info_round),
      ZetaSnackBarType.warning => const Icon(ZetaIcons.warning_round),
      ZetaSnackBarType.error => const Icon(ZetaIcons.error_round),
      ZetaSnackBarType.deletion => const Icon(ZetaIcons.delete_round),
      ZetaSnackBarType.view => const Icon(ZetaIcons.open_in_new_window_round),
      _ => const SizedBox(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    return Padding(
      padding: type != null || icon != null ? const EdgeInsets.only(left: ZetaSpacing.medium) : EdgeInsets.zero,
      child: IconTheme(
        data: IconThemeData(
          color: _getIconColor(colors, type),
        ),
        child: icon ?? _getIcon(type),
      ),
    );
  }
}
