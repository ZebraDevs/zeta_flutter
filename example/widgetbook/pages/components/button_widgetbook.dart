import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

Widget buttonUseCase(BuildContext context) => WidgetbookTestWidget(
      widget: ZetaButton(
        label: context.knobs.string(label: 'Text', initialValue: 'Button'),
        onPressed: context.knobs.boolean(label: 'Disabled') ? null : () {},
        borderType: context.knobs.boolean(label: 'Rounded') ? ZetaWidgetBorder.rounded : ZetaWidgetBorder.sharp,
        size: context.knobs.list(
          label: 'Size',
          options: ZetaWidgetSize.values,
          labelBuilder: (value) => value.name.split('.').last.capitalize(),
        ),
        type: context.knobs.list(
          label: 'Type',
          options: ZetaButtonType.values,
          labelBuilder: (value) => value.name.split('.').last.capitalize(),
        ),
      ),
    );

Widget iconButtonUseCase(BuildContext context) => WidgetbookTestWidget(
      widget: ZetaIconButton(
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
        onPressed: context.knobs.boolean(label: 'Disabled') ? null : () {},
        borderType: context.knobs.boolean(label: 'Rounded') ? ZetaWidgetBorder.rounded : ZetaWidgetBorder.sharp,
        size: context.knobs.list(
          label: 'Size',
          labelBuilder: (value) => value.name.split('.').last.capitalize(),
          options: ZetaWidgetSize.values,
        ),
        type: context.knobs.list(
          label: 'Type',
          options: ZetaButtonType.values,
          labelBuilder: (value) => value.name.split('.').last.capitalize(),
        ),
      ),
    );

Widget floatingActionButtonUseCase(BuildContext context) => WidgetbookTestWidget(
      widget: Padding(padding: EdgeInsets.all(20), child: FabWidget(context)),
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
          label: widget.c.knobs.string(label: 'Label', initialValue: 'Floating Action Button'),
          onPressed: widget.c.knobs.boolean(label: 'Disabled') ? null : () {},
          icon: widget.c.knobs.list(
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
          shape: widget.c.knobs.list(
            label: 'Shape',
            options: ZetaWidgetBorder.values,
            labelBuilder: (value) => value.name.split('.').last.capitalize(),
          ),
          size: widget.c.knobs.list(
            label: 'Shape',
            options: ZetaFabSize.values,
            labelBuilder: (value) => value.name.split('.').last.capitalize(),
          ),
          type: widget.c.knobs.list(
            label: 'Shape',
            options: ZetaFabType.values,
            labelBuilder: (value) => value.name.split('.').last.capitalize(),
          ),
        ),
      ),
    );
  }
}
