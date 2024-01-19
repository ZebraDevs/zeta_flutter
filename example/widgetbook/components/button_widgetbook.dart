import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_example/pages/components/button_example.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

WidgetbookComponent buttonWidgetBook() {
  return WidgetbookComponent(
    name: 'Button',
    isInitiallyExpanded: false,
    useCases: [
      WidgetbookUseCase(
        name: 'Button',
        builder: (context) {
          final buttonColors = BuildExampleButtonColors(theme: Zeta.of(context));
          List<ZetaButtonColors> all = [
            buttonColors.primaryColors,
            buttonColors.primaryVariantColors,
            buttonColors.negativeColors,
            buttonColors.outlined,
            buttonColors.outlinedSubtle,
            buttonColors.textColors,
            buttonColors.textInverseColor,
          ];

          return TestWidget(
            widget: Padding(
              padding: EdgeInsets.all(20),
              child: ZetaButton(
                label: context.knobs.string(label: 'Text', initialValue: 'Button'),
                colors: context.knobs.list(
                  label: 'Colors',
                  options: all,
                  labelBuilder: (value) {
                    if (value.backgroundColor == buttonColors.primaryColors.backgroundColor) return 'Primary';
                    if (value.backgroundColor == buttonColors.primaryVariantColors.backgroundColor)
                      return 'Primary Variant';
                    if (value.backgroundColor == buttonColors.negativeColors.backgroundColor) return 'Negative';
                    if (value.foregroundColor == buttonColors.textColors.foregroundColor) return 'Text';
                    if (value.actionColor == buttonColors.outlined.actionColor) return 'Outlined';
                    if (value.actionColor == buttonColors.outlinedSubtle.actionColor) return 'Outline Subtle';
                    if (value.actionColor == buttonColors.textInverseColor.actionColor) return 'Text Inverse';
                    return '';
                  },
                ),
                onPressed: context.knobs.boolean(label: 'Disabled') ? null : () {},
                borderType: context.knobs.boolean(label: 'Rounded') ? BorderType.rounded : BorderType.sharp,
                icon: context.knobs.list(
                  label: 'Icon',
                  options: [
                    ZetaIcons.star_half_round,
                    ZetaIcons.add_alert_round,
                    ZetaIcons.add_box_round,
                    ZetaIcons.barcode_round,
                  ],
                  labelBuilder: (value) {
                    if (value == ZetaIcons.star_half_round) return 'ZetaIcons.star_half_round';
                    if (value == ZetaIcons.add_alert_round) return 'ZetaIcons.add_alert_round';
                    if (value == ZetaIcons.add_box_round) return 'ZetaIcons.add_box_round';
                    if (value == ZetaIcons.barcode_round) return 'ZetaIcons.barcode_round';
                    return '';
                  },
                ),
                iconOnRight: context.knobs.boolean(label: 'Icon on right'),
                size: context.knobs.list(label: 'Size', options: ZetaWidgetSize.values),
                type: context.knobs.list(label: 'Type', options: ZetaButtonType.values),
              ),
            ),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'Floating Action Button',
        builder: (context) => TestWidget(
          widget: Padding(padding: EdgeInsets.all(20), child: FabWidget(context)),
        ),
      )
    ],
  );
}

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
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Scaffold(
        body: ListView.builder(
          itemCount: MediaQuery.of(context).size.height.toInt(),
          controller: _scrollController,
          itemBuilder: (context, index) {
            return Text("$index");
          },
        ),
        floatingActionButton: ZetaFAB(
          scrollController: _scrollController,
          buttonLabel: widget.c.knobs.string(label: 'Label', initialValue: 'Floating Action Button'),
          onPressed: widget.c.knobs.boolean(label: 'Disabled') ? null : () {},
          buttonIcon: widget.c.knobs.list(
            label: 'Icon',
            options: [
              ZetaIcons.star_half_round,
              ZetaIcons.add_alert_round,
              ZetaIcons.add_box_round,
              ZetaIcons.barcode_round,
            ],
            labelBuilder: (value) {
              if (value == ZetaIcons.star_half_round) return 'ZetaIcons.star_half_round';
              if (value == ZetaIcons.add_alert_round) return 'ZetaIcons.add_alert_round';
              if (value == ZetaIcons.add_box_round) return 'ZetaIcons.add_box_round';
              if (value == ZetaIcons.barcode_round) return 'ZetaIcons.barcode_round';
              return '';
            },
          ),
          buttonShape: widget.c.knobs.list(label: 'Shape', options: ZetaFabShape.values),
          buttonSize: widget.c.knobs.list(label: 'Shape', options: ZetaFabSize.values),
          buttonType: widget.c.knobs.list(label: 'Shape', options: ZetaFabType.values),
          customAnimationDuration:
              widget.c.knobs.duration(label: 'Animation Duration', initialValue: Duration(milliseconds: 100)),
        ),
      ),
    );
  }
}
