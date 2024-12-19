import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';
import '../../utils/utils.dart';

Widget buttonUseCase(BuildContext context) {
  final borderType = context.knobs.list(
    label: 'Border type',
    labelBuilder: enumLabelBuilder,
    options: ZetaWidgetBorder.values,
  );
  return WidgetbookScaffold(
    builder: (context, _) => ZetaButton(
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
      leadingIcon: iconKnob(context, nullable: true, name: "Leading Icon"),
      trailingIcon: iconKnob(context, nullable: true, name: "Trailing Icon"),
    ),
  );
}

Widget iconButtonUseCase(BuildContext context) {
  final borderType = context.knobs.list(
    label: 'Border type',
    options: ZetaWidgetBorder.values,
    labelBuilder: enumLabelBuilder,
  );
  return WidgetbookScaffold(
    builder: (context, _) => ZetaIconButton(
      icon: iconKnob(context)!,
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
  final onPressed = disabledKnob(context) ? null : () {};

  return WidgetbookScaffold(
    builder: (context, _) => ZetaButtonGroup(
      isLarge: context.knobs.boolean(label: 'Large'),
      isInverse: context.knobs.boolean(label: 'Inverse'),
      buttons: [
        ZetaGroupButton(
          label: context.knobs.string(label: 'Button 1 Title', initialValue: 'Button'),
          onPressed: onPressed,
          icon: iconKnob(context, name: 'Button 1 Icon', nullable: true, initial: null),
        ),
        ZetaGroupButton.dropdown(
          label: context.knobs.string(label: 'Button 2 Title'),
          onChange: disabledKnob(context) ? null : (_) {},
          icon: iconKnob(context, name: 'Button 2 Icon', nullable: true, initial: null),
          items: [
            ZetaDropdownItem(
              value: 'Item 1',
              icon: ZetaIcon(ZetaIcons.star),
            ),
            ZetaDropdownItem(
              value: 'Item 2',
              icon: ZetaIcon(ZetaIcons.star_half),
            ),
          ],
        ),
        ZetaGroupButton(
          label: context.knobs.string(label: 'Button 3 Title'),
          onPressed: onPressed,
          icon: iconKnob(context, name: 'Button 3 Icon', nullable: true, initial: null),
        )
      ],
    ),
  );
}

Widget floatingActionButtonUseCase(BuildContext context) => WidgetbookScaffold(
      builder: (context, _) => Padding(padding: EdgeInsets.all(Zeta.of(context).spacing.xl), child: FabWidget(context)),
    );

class FabWidget extends StatefulWidget {
  FabWidget(this.c);
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
          expanded: widget.c.knobs.boolean(label: 'Expanded'),
          scrollController: _scrollController,
          label: widget.c.knobs.string(label: 'Label', initialValue: 'Floating Action Button'),
          onPressed: widget.c.knobs.boolean(label: 'Disabled') ? null : () {},
          icon: iconKnob(context)!,
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
