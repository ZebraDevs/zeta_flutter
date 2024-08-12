import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

/// [ZetaDialogHeaderAlignment]
enum ZetaDialogHeaderAlignment {
  /// [left]
  left,

  /// [center]
  center,
}

/// Function to show a Zeta dialog.
Future<bool?> showZetaDialog(
  BuildContext context, {
  ZetaDialogHeaderAlignment headerAlignment = ZetaDialogHeaderAlignment.center,
  Widget? icon,
  String? title,
  required String message,
  String? primaryButtonLabel,
  VoidCallback? onPrimaryButtonPressed,
  String? secondaryButtonLabel,
  VoidCallback? onSecondaryButtonPressed,
  String? tertiaryButtonLabel,
  VoidCallback? onTertiaryButtonPressed,
  bool? rounded,
  bool barrierDismissible = true,
  bool useRootNavigator = true,
}) =>
    showDialog<bool?>(
      context: context,
      barrierDismissible: barrierDismissible,
      useRootNavigator: useRootNavigator,
      builder: (_) => _ZetaDialog(
        headerAlignment: headerAlignment,
        icon: icon,
        title: title,
        message: message,
        primaryButtonLabel: primaryButtonLabel,
        onPrimaryButtonPressed: onPrimaryButtonPressed,
        secondaryButtonLabel: secondaryButtonLabel,
        onSecondaryButtonPressed: onSecondaryButtonPressed,
        tertiaryButtonLabel: tertiaryButtonLabel,
        onTertiaryButtonPressed: onTertiaryButtonPressed,
        rounded: rounded,
      ),
    );

class _ZetaDialog extends ZetaStatelessWidget {
  const _ZetaDialog({
    this.headerAlignment = ZetaDialogHeaderAlignment.center,
    this.icon,
    this.title,
    required this.message,
    this.primaryButtonLabel,
    this.onPrimaryButtonPressed,
    this.secondaryButtonLabel,
    this.onSecondaryButtonPressed,
    this.tertiaryButtonLabel,
    this.onTertiaryButtonPressed,
    super.rounded,
  });

  final ZetaDialogHeaderAlignment headerAlignment;
  final Widget? icon;
  final String? title;
  final String message;
  final String? primaryButtonLabel;
  final VoidCallback? onPrimaryButtonPressed;
  final String? secondaryButtonLabel;
  final VoidCallback? onSecondaryButtonPressed;
  final String? tertiaryButtonLabel;
  final VoidCallback? onTertiaryButtonPressed;

  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);
    final primaryButton = primaryButtonLabel == null
        ? null
        : ZetaButton(
            label: primaryButtonLabel!,
            onPressed: onPrimaryButtonPressed ?? () => Navigator.of(context).pop(true),
          );
    final secondaryButton = secondaryButtonLabel == null
        ? null
        : ZetaButton.outlineSubtle(
            label: secondaryButtonLabel!,
            onPressed: onSecondaryButtonPressed ?? () => Navigator.of(context).pop(false),
          );
    final tertiaryButton = tertiaryButtonLabel == null
        ? null
        : TextButton(
            onPressed: onTertiaryButtonPressed,
            child: Text(tertiaryButtonLabel!),
          );
    final hasButton = primaryButton != null || secondaryButton != null || tertiaryButton != null;

    return ZetaRoundedScope(
      rounded: context.rounded,
      child: AlertDialog(
        surfaceTintColor: zeta.colors.surface.primary,
        shape: RoundedRectangleBorder(borderRadius: Zeta.of(context).radii.large),
        title: icon != null || title != null
            ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: switch (headerAlignment) {
                  ZetaDialogHeaderAlignment.left => CrossAxisAlignment.start,
                  ZetaDialogHeaderAlignment.center => CrossAxisAlignment.center,
                },
                children: [
                  if (icon != null)
                    Padding(
                      padding: EdgeInsets.only(bottom: Zeta.of(context).spacing.medium),
                      child: icon,
                    ),
                  if (title != null)
                    Text(
                      title!,
                      textAlign: switch (headerAlignment) {
                        ZetaDialogHeaderAlignment.left => TextAlign.left,
                        ZetaDialogHeaderAlignment.center => TextAlign.center,
                      },
                    ),
                ],
              )
            : null,
        titlePadding: context.deviceType == DeviceType.mobilePortrait
            ? null
            : EdgeInsets.only(
                left: Zeta.of(context).spacing.xl_6,
                right: Zeta.of(context).spacing.xl_6,
                top: Zeta.of(context).spacing.xl_2,
              ),
        titleTextStyle: zetaTextTheme.headlineSmall?.copyWith(
          color: zeta.colors.main.defaultColor,
        ),
        content: Text(message),
        contentPadding: context.deviceType == DeviceType.mobilePortrait
            ? null
            : EdgeInsets.only(
                left: Zeta.of(context).spacing.xl_6,
                right: Zeta.of(context).spacing.xl_6,
                top: Zeta.of(context).spacing.medium,
                bottom: Zeta.of(context).spacing.xl_2,
              ),
        contentTextStyle: context.deviceType == DeviceType.mobilePortrait
            ? zetaTextTheme.bodySmall?.copyWith(color: zeta.colors.main.defaultColor)
            : zetaTextTheme.bodyMedium?.copyWith(color: zeta.colors.main.defaultColor),
        actions: [
          if (context.deviceType == DeviceType.mobilePortrait)
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (hasButton) SizedBox(height: Zeta.of(context).spacing.xl_2),
                if (tertiaryButton == null)
                  Row(
                    children: [
                      if (secondaryButton != null) Expanded(child: secondaryButton),
                      if (primaryButton != null && secondaryButton != null)
                        SizedBox(width: Zeta.of(context).spacing.large),
                      if (primaryButton != null) Expanded(child: primaryButton),
                    ],
                  )
                else ...[
                  if (primaryButton != null) primaryButton,
                  if (primaryButton != null && secondaryButton != null)
                    SizedBox(height: Zeta.of(context).spacing.medium),
                  if (secondaryButton != null) secondaryButton,
                  if (primaryButton != null || secondaryButton != null)
                    SizedBox(height: Zeta.of(context).spacing.small),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [tertiaryButton],
                  ),
                ],
              ],
            )
          else
            Row(
              children: [
                if (tertiaryButton != null) tertiaryButton,
                if (primaryButton != null || secondaryButton != null) ...[
                  SizedBox(width: Zeta.of(context).spacing.xl_2),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (secondaryButton != null) secondaryButton,
                        if (primaryButton != null && secondaryButton != null)
                          SizedBox(width: Zeta.of(context).spacing.large),
                        if (primaryButton != null) primaryButton,
                      ],
                    ),
                  ),
                ],
              ],
            ),
        ],
        actionsPadding: context.deviceType == DeviceType.mobilePortrait
            ? null
            : EdgeInsets.symmetric(
                horizontal: Zeta.of(context).spacing.xl_6,
                vertical: Zeta.of(context).spacing.xl_2,
              ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<ZetaDialogHeaderAlignment>('headerAlignment', headerAlignment))
      ..add(StringProperty('title', title))
      ..add(StringProperty('message', message))
      ..add(StringProperty('primaryButtonLabel', primaryButtonLabel))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onPrimaryButtonPressed', onPrimaryButtonPressed))
      ..add(StringProperty('secondaryButtonLabel', secondaryButtonLabel))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onSecondaryButtonPressed', onSecondaryButtonPressed))
      ..add(StringProperty('tertiaryButtonLabel', tertiaryButtonLabel))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onTertiaryButtonPressed', onTertiaryButtonPressed))
      ..add(DiagnosticsProperty<bool>('rounded', rounded));
  }
}
