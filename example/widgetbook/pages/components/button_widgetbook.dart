import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';
import '../../utils/utils.dart';

Widget buttonUseCase(BuildContext context) {
  final borderType = context.knobs.list(
    label: 'Border type',
    labelBuilder: enumLabelBuilder,
    options: ZetaWidgetBorder.values,
  );
  return WidgetbookTestWidget(
    widget: ZetaButton(
      label: context.knobs.string(label: 'Text', initialValue: 'Button'),
      onPressed: context.knobs.boolean(label: 'Disabled') ? null : () {},
      borderType: borderType,
      size: context.knobs.list(
        label: 'Size',
        options: ZetaWidgetSize.values,
        labelBuilder: enumLabelBuilder,
      ),
      type: context.knobs.list(
        label: 'Type',
        options: ZetaButtonType.values,
        labelBuilder: enumLabelBuilder,
      ),
      leadingIcon:
          iconKnob(context, rounded: borderType != ZetaWidgetBorder.sharp, nullable: true, name: "Leading Icon"),
      trailingIcon:
          iconKnob(context, rounded: borderType != ZetaWidgetBorder.sharp, nullable: true, name: "Trailing Icon"),
    ),
  );
}

Widget iconButtonUseCase(BuildContext context) {
  final borderType = context.knobs.list(
    label: 'Border type',
    options: ZetaWidgetBorder.values,
    labelBuilder: enumLabelBuilder,
  );
  return WidgetbookTestWidget(
    widget: ZetaIconButton(
      icon: iconKnob(context, rounded: borderType != ZetaWidgetBorder.sharp)!,
      onPressed: disabledKnob(context) ? null : () {},
      borderType: borderType,
      size: context.knobs.list(
        label: 'Size',
        labelBuilder: enumLabelBuilder,
        options: ZetaWidgetSize.values,
      ),
      type: context.knobs.list(
        label: 'Type',
        options: ZetaButtonType.values,
        labelBuilder: enumLabelBuilder,
      ),
    ),
  );
}

Widget buttonGroupUseCase(BuildContext context) {
  final bool rounded = roundedKnob(context);

  final onPressed = disabledKnob(context) ? null : () {};

  return WidgetbookTestWidget(
    widget: ZetaButtonGroup(
      isLarge: context.knobs.boolean(label: 'Large'),
      rounded: rounded,
      isInverse: context.knobs.boolean(label: 'Inverse'),
      buttons: [
        ZetaGroupButton(
          label: context.knobs.string(label: 'Button 1 Title', initialValue: 'Button'),
          onPressed: onPressed,
          icon: iconKnob(context, name: 'Button 1 Icon', nullable: true, initial: null, rounded: rounded),
        ),
        ZetaGroupButton.dropdown(
          label: context.knobs.string(label: 'Button 2 Title'),
          onChange: disabledKnob(context) ? null : (_) {},
          icon: iconKnob(context, name: 'Button 2 Icon', nullable: true, initial: null, rounded: rounded),
          items: [
            ZetaDropdownItem(
              value: 'Item 1',
              icon: Icon(ZetaIcons.star),
            ),
            ZetaDropdownItem(
              value: 'Item 2',
              icon: Icon(ZetaIcons.star_half),
            ),
          ],
        ),
        ZetaGroupButton(
          label: context.knobs.string(label: 'Button 3 Title'),
          onPressed: onPressed,
          icon: iconKnob(context, name: 'Button 3 Icon', nullable: true, initial: null, rounded: rounded),
        )
      ],
    ),
  );
}

Widget floatingActionButtonUseCase(BuildContext context) => WidgetbookTestWidget(
      screenSize: Size(1280, 720),
      widget: Padding(padding: EdgeInsets.all(ZetaSpacing.xl_1), child: FabWidget(context)),
    );

class FabWidget extends StatefulWidget {
  const FabWidget(this.c);
  final BuildContext c;

  @override
  State<FabWidget> createState() => _FabWidgetState();
}

class _FabWidgetState extends State<FabWidget> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext _) {
    final shape = widget.c.knobs.list(
      label: 'Shape',
      options: ZetaWidgetBorder.values,
      labelBuilder: enumLabelBuilder,
    );
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Scaffold(
        body: ListView.builder(
          key: PageStorageKey(0),
          itemCount: MediaQuery.of(context).size.height.toInt(),
          controller: _scrollController,
          itemBuilder: (context, index) => Text("$index"),
        ),
        floatingActionButton: ZetaFAB(
          initiallyExpanded: true,
          scrollController: _scrollController,
          label: widget.c.knobs.string(label: 'Label', initialValue: 'Floating Action Button'),
          onPressed: widget.c.knobs.boolean(label: 'Disabled') ? null : () {},
          icon: iconKnob(context, rounded: shape != ZetaWidgetBorder.sharp)!,
          shape: shape,
          size: widget.c.knobs.list(
            label: 'Size',
            options: ZetaFabSize.values,
            labelBuilder: enumLabelBuilder,
          ),
          type: widget.c.knobs.list(
            label: 'Type',
            options: ZetaFabType.values,
            labelBuilder: enumLabelBuilder,
          ),
        ),
      ),
    );
  }
}
