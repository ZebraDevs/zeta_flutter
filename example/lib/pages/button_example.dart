import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../widgets.dart';

class ButtonExample extends StatelessWidget {
  static const String name = 'Button';

  const ButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Zeta.of(context);
    final colors = BuildExampleButtonColors(theme: theme);

    return ExampleScaffold(
      name: 'Button',
      child: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [roundedButtonsExample(colors), Divider(), Divider(), sharpButtonsExample(colors)],
          ),
        ),
      ),
    );
  }
}

Widget roundedButtonsExample(BuildExampleButtonColors colors) => Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ..._getZetaButtonExampleRows('Primary', colors.primaryColors),
        Divider(),
        ..._getZetaButtonExampleRows('Primary Variant', colors.primaryVariantColors),
        Divider(),
        ..._getZetaButtonExampleRows('Negative', colors.negativeColors, icon: ZetaIcons.delete_round),
        Divider(),
        ..._getZetaButtonExampleRows('Outlined', colors.outlined, buttonType: ZetaButtonType.outlined),
        Divider(),
        ..._getZetaButtonExampleRows('Outlined Subtle', colors.outlinedSubtle, buttonType: ZetaButtonType.outlined),
        Divider(),
        ..._getZetaButtonExampleRows('Text', colors.textColors),
        Divider(),
        ..._getZetaButtonExampleRows('Text Inverse', colors.textInverseColor),
      ],
    );

Widget sharpButtonsExample(BuildExampleButtonColors colors) => Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ..._getZetaButtonExampleRows('Primary', colors.primaryColors, border: BorderType.sharp),
        Divider(),
        ..._getZetaButtonExampleRows('Primary Variant', colors.primaryVariantColors, border: BorderType.sharp),
        Divider(),
        ..._getZetaButtonExampleRows('Negative', colors.negativeColors,
            icon: ZetaIcons.delete_sharp, border: BorderType.sharp),
        Divider(),
        ..._getZetaButtonExampleRows('Outlined', colors.outlined,
            buttonType: ZetaButtonType.outlined, border: BorderType.sharp),
        Divider(),
        ..._getZetaButtonExampleRows('Outlined Subtle', colors.outlinedSubtle,
            buttonType: ZetaButtonType.outlined, border: BorderType.sharp),
        Divider(),
        ..._getZetaButtonExampleRows('Text', colors.textColors, border: BorderType.sharp),
        Divider(),
        ..._getZetaButtonExampleRows('Text Inverse', colors.textInverseColor, border: BorderType.sharp),
      ],
    );

List<Widget> _getZetaButtonExampleRows(String label, ZetaButtonColors colors,
    {IconData? icon, ZetaButtonType buttonType = ZetaButtonType.filled, BorderType border = BorderType.rounded}) {
  return [
    Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Large $label', style: ZetaText.zetaTitleLarge)]),
    Divider(color: Colors.transparent),
    _getRow(buttonType, ZetaWidgetSize.large, colors, border: border, icon: icon),
    Divider(color: Colors.transparent),
    _getRow(buttonType, ZetaWidgetSize.large, colors, isDisabled: true, border: border, icon: icon),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Padding(padding: EdgeInsets.all(10), child: Text('Medium $label', style: ZetaText.zetaTitleLarge))],
    ),
    _getRow(buttonType, ZetaWidgetSize.medium, colors, border: border, icon: icon),
    _getRow(buttonType, ZetaWidgetSize.medium, colors, isDisabled: true, border: border, icon: icon),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Padding(padding: EdgeInsets.all(10), child: Text('Small $label', style: ZetaText.zetaTitleLarge))],
    ),
    _getRow(buttonType, ZetaWidgetSize.small, colors, border: border, icon: icon),
    _getRow(buttonType, ZetaWidgetSize.small, colors, isDisabled: true, border: border, icon: icon),
  ];
}

Widget _getRow(ZetaButtonType type, ZetaWidgetSize size, ZetaButtonColors colors,
    {bool isDisabled = false, IconData? icon, BorderType border = BorderType.rounded}) {
  final IconData defaultIcon = border == BorderType.rounded ? ZetaIcons.star_round : ZetaIcons.star_sharp;
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      _getZetaButtonExample(type, size, colors, isDisabled: isDisabled, border: border),
      _getZetaButtonExample(type, size, colors, icon: icon ?? defaultIcon, isDisabled: isDisabled, border: border),
      _getZetaButtonExample(type, size, colors,
          icon: icon ?? defaultIcon, iconRight: true, isDisabled: isDisabled, border: border),
    ],
  );
}

Widget _getZetaButtonExample(ZetaButtonType buttonType, ZetaWidgetSize size, ZetaButtonColors colors,
    {BorderType border = BorderType.rounded, IconData? icon, bool iconRight = false, bool isDisabled = false}) {
  print(buttonType);
  if (buttonType == ZetaButtonType.filled)
    return ZetaButton.filled(
      label: 'Button',
      icon: icon,
      iconOnRight: iconRight,
      borderType: border,
      size: size,
      colors: colors,
      onPressed: isDisabled ? null : () {},
    );
  return ZetaButton.outlined(
    label: 'Button',
    icon: icon,
    iconOnRight: iconRight,
    borderType: border,
    size: size,
    colors: colors,
    onPressed: isDisabled ? null : () {},
  );
}

class BuildExampleButtonColors {
  BuildExampleButtonColors({required this.theme});

  final Zeta theme;

  ZetaButtonColors get primaryColors {
    return ZetaButtonColors(
        backgroundColor: ZetaColorBase.blue.shade60,
        foregroundColor: ZetaColorBase.greyCool.shade20,
        actionColor: ZetaColorBase.blue.shade90,
        backgroundDisabled: ZetaColorBase.greyCool.shade30,
        foregroundDisabled: ZetaColorBase.greyCool.shade50);
  }

  ZetaButtonColors get primaryVariantColors {
    return ZetaButtonColors(
        backgroundColor: Color(0xFFFFD200),
        foregroundColor: ZetaColorBase.greyCool.shade90,
        actionColor: Color(0xFFC29500),
        backgroundDisabled: ZetaColorBase.greyCool.shade30,
        foregroundDisabled: ZetaColorBase.greyCool.shade50);
  }

  ZetaButtonColors get negativeColors {
    return ZetaButtonColors(
        backgroundColor: ZetaColorBase.red.shade60,
        foregroundColor: ZetaColorBase.greyCool.shade20,
        actionColor: ZetaColorBase.red.shade80,
        backgroundDisabled: ZetaColorBase.greyCool.shade30,
        foregroundDisabled: ZetaColorBase.greyCool.shade50);
  }

  ZetaButtonColors get outlined {
    return ZetaButtonColors(
        foregroundColor: ZetaColorBase.blue,
        actionColor: ZetaColorBase.greyCool.shade30,
        backgroundDisabled: ZetaColorBase.greyCool.shade30,
        foregroundDisabled: ZetaColorBase.greyCool.shade50,
        borderColor: ZetaColorBase.blue);
  }

  ZetaButtonColors get outlinedSubtle {
    return ZetaButtonColors(
        foregroundColor: theme.colors.textDefault,
        actionColor: ZetaColorBase.greyCool.shade50,
        backgroundDisabled: ZetaColorBase.greyCool.shade30,
        foregroundDisabled: ZetaColorBase.greyCool.shade50,
        iconColor: theme.colors.textDefault,
        borderColor: theme.colors.borderDefault);
  }

  ZetaButtonColors get textColors {
    return ZetaButtonColors(
        foregroundColor: ZetaColorBase.blue,
        actionColor: ZetaColorBase.greyCool.shade30,
        backgroundDisabled: ZetaColorBase.greyCool.shade30,
        foregroundDisabled: ZetaColorBase.greyCool.shade50);
  }

  ZetaButtonColors get textInverseColor {
    return ZetaButtonColors(
        foregroundColor: ZetaColorBase.blue.shade40,
        actionColor: ZetaColorBase.black,
        backgroundDisabled: Colors.transparent,
        foregroundDisabled: ZetaColorBase.greyCool);
  }
}
