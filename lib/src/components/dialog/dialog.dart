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

/// [showZetaDialog]
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
  bool rounded = true,
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

class _ZetaDialog extends StatelessWidget {
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
    this.rounded = true,
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
  final bool rounded;

  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);
    final primaryButton = primaryButtonLabel == null
        ? null
        : ZetaButton(
            label: primaryButtonLabel!,
            onPressed: onPrimaryButtonPressed ?? () => Navigator.of(context).pop(true),
            borderType: rounded ? ZetaWidgetBorder.rounded : ZetaWidgetBorder.sharp,
          );
    final secondaryButton = secondaryButtonLabel == null
        ? null
        : ZetaButton.outlineSubtle(
            label: secondaryButtonLabel!,
            onPressed: onSecondaryButtonPressed ?? () => Navigator.of(context).pop(false),
            borderType: rounded ? ZetaWidgetBorder.rounded : ZetaWidgetBorder.sharp,
          );
    final tertiaryButton = tertiaryButtonLabel == null
        ? null
        : TextButton(
            onPressed: onTertiaryButtonPressed,
            child: Text(tertiaryButtonLabel!),
          );
    final hasButton = primaryButton != null || secondaryButton != null || tertiaryButton != null;

    return AlertDialog(
      surfaceTintColor: zeta.colors.surfacePrimary,
      shape: const RoundedRectangleBorder(borderRadius: ZetaRadius.large),
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
                    padding: const EdgeInsets.only(bottom: ZetaSpacing.medium),
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
          : const EdgeInsets.only(
              left: ZetaSpacing.xL6,
              right: ZetaSpacing.xL6,
              top: ZetaSpacing.xL2,
            ),
      titleTextStyle: zetaTextTheme.headlineSmall?.copyWith(
        color: zeta.colors.textDefault,
      ),
      content: Text(message),
      contentPadding: context.deviceType == DeviceType.mobilePortrait
          ? null
          : const EdgeInsets.only(
              left: ZetaSpacing.xL6,
              right: ZetaSpacing.xL6,
              top: ZetaSpacing.medium,
              bottom: ZetaSpacing.xL2,
            ),
      contentTextStyle: context.deviceType == DeviceType.mobilePortrait
          ? zetaTextTheme.bodySmall?.copyWith(color: zeta.colors.textDefault)
          : zetaTextTheme.bodyMedium?.copyWith(color: zeta.colors.textDefault),
      actions: [
        if (context.deviceType == DeviceType.mobilePortrait)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (hasButton) const SizedBox(height: ZetaSpacing.xL2),
              if (tertiaryButton == null)
                Row(
                  children: [
                    if (secondaryButton != null) Expanded(child: secondaryButton),
                    if (primaryButton != null && secondaryButton != null) const SizedBox(width: ZetaSpacing.large),
                    if (primaryButton != null) Expanded(child: primaryButton),
                  ],
                )
              else ...[
                if (primaryButton != null) primaryButton,
                if (primaryButton != null && secondaryButton != null) const SizedBox(height: ZetaSpacing.medium),
                if (secondaryButton != null) secondaryButton,
                if (primaryButton != null || secondaryButton != null) const SizedBox(height: ZetaSpacing.small),
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
                const SizedBox(width: ZetaSpacing.xL2),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (secondaryButton != null) secondaryButton,
                      if (primaryButton != null && secondaryButton != null) const SizedBox(width: ZetaSpacing.large),
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
          : const EdgeInsets.symmetric(
              horizontal: ZetaSpacing.xL6,
              vertical: ZetaSpacing.xL2,
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
