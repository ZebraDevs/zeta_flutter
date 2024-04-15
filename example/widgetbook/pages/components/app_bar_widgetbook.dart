import 'dart:math';

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

Widget defaultAppBarUseCase(BuildContext context) {
  return WidgetbookTestWidget(
    widget: StatefulBuilder(
      builder: (context, setState) {
        final title = context.knobs.string(label: "Title", initialValue: "Title");

        final type = context.knobs.list(
          label: "Type",
          options: [
            ZetaAppBarType.defaultAppBar,
            ZetaAppBarType.centeredTitle,
            ZetaAppBarType.extendedTitle,
          ],
          initialOption: ZetaAppBarType.defaultAppBar,
          labelBuilder: (type) => type.name,
        );

        final enabledActions = context.knobs.boolean(
          label: "Enabled actions",
          initialValue: true,
        );

        final leadingIcon = context.knobs.list<Icon>(
          label: "Leading Icon",
          options: [
            Icon(
              key: Key("Menu"),
              Icons.menu_rounded,
            ),
            Icon(
              key: Key("Close"),
              ZetaIcons.close_round,
            ),
            Icon(
              key: Key("Arrow back"),
              ZetaIcons.arrow_back_round,
            ),
          ],
          initialOption: Icon(Icons.menu_rounded),
          labelBuilder: (icon) => icon.key.toString(),
        );

        return ZetaAppBar(
          leading: IconButton(
            onPressed: () {},
            icon: leadingIcon,
          ),
          type: type,
          title: Text(title),
          actions: enabledActions
              ? [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.language),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.favorite),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(ZetaIcons.more_vertical_round),
                  )
                ]
              : null,
        );
      },
    ),
  );
}

Widget searchAppBarUseCase(BuildContext context) {
  return WidgetbookTestWidget(
    widget: _SearchUseCase(),
  );
}

class _SearchUseCase extends StatefulWidget {
  const _SearchUseCase();

  @override
  State<_SearchUseCase> createState() => _SearchUseCaseState();
}

class _SearchUseCaseState extends State<_SearchUseCase> {
  late final searchController = AppBarSearchController();

  @override
  Widget build(BuildContext context) {
    final title = context.knobs.string(label: "Title", initialValue: "Title");

    final type = context.knobs.list(
      label: "Type",
      options: [
        ZetaAppBarType.defaultAppBar,
        ZetaAppBarType.centeredTitle,
        ZetaAppBarType.extendedTitle,
      ],
      initialOption: ZetaAppBarType.defaultAppBar,
      labelBuilder: (type) => type.name,
    );

    final leadingIcon = context.knobs.list<Icon>(
      label: "Leading Icon",
      options: [
        Icon(
          key: Key("Menu"),
          Icons.menu_rounded,
        ),
        Icon(
          key: Key("Close"),
          ZetaIcons.close_round,
        ),
        Icon(
          key: Key("Arrow back"),
          ZetaIcons.arrow_back_round,
        ),
      ],
      initialOption: Icon(Icons.menu_rounded),
      labelBuilder: (icon) => icon.key.toString(),
    );

    final enabledSpeechRecognition = context.knobs.boolean(
      label: "Enabled speech recognition",
      description:
          "Randomly generated text. There is no real speech recognition. That is just for testing the functionality",
      initialValue: false,
    );

    return ZetaAppBar(
      leading: IconButton(
        onPressed: () {},
        icon: leadingIcon,
      ),
      type: type,
      title: Text(title),
      searchController: searchController,
      onSearchMicrophoneIconPressed: enabledSpeechRecognition
          ? () {
              var sampleTexts = ['This is a sample text', 'Another sample', 'Speech recognition text', 'Example'];

              var generatedText = sampleTexts[Random().nextInt(sampleTexts.length)];

              searchController.text = generatedText;
            }
          : null,
      actions: [
        IconButton(
            onPressed: () {
              searchController.isEnabled ? searchController.closeSearch() : searchController.startSearch();
            },
            icon: Icon(ZetaIcons.search_round)),
      ],
    );
  }
}
