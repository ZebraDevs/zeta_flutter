import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class TopAppBarExample extends StatefulWidget {
  const TopAppBarExample({super.key});

  static const String name = 'TopAppBar';

  @override
  State<TopAppBarExample> createState() => _TopAppBarExampleState();
}

class _TopAppBarExampleState extends State<TopAppBarExample> {
  late final _searchController = AppBarSearchController();

  void _showHideSearch() {
    _searchController.isEnabled ? _searchController.closeSearch() : _searchController.startSearch();
  }

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: TopAppBarExample.name,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Default
            Padding(
              padding: const EdgeInsets.only(top: ZetaSpacing.x4),
              child: ZetaTopAppBar(
                leading: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.menu_rounded),
                ),
                title: Row(
                  children: [
                    ZetaAvatar(size: ZetaAvatarSize.xs),
                    Padding(
                      padding: const EdgeInsets.only(left: ZetaSpacing.s),
                      child: Text("Title"),
                    ),
                  ],
                ),
                actions: [
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
                ],
              ),
            ),

            // Centered
            Padding(
              padding: const EdgeInsets.only(top: ZetaSpacing.x4),
              child: ZetaTopAppBar(
                type: ZetaTopAppBarType.centeredTitle,
                leading: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.menu_rounded),
                ),
                title: Text("Title"),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.account_circle),
                  ),
                ],
              ),
            ),

            // Contextual
            Padding(
              padding: const EdgeInsets.only(top: ZetaSpacing.x4),
              child: ZetaTopAppBar(
                leading: IconButton(
                  onPressed: () {},
                  icon: Icon(ZetaIcons.close_round),
                ),
                title: Text("2 items"),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(ZetaIcons.edit_round),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(ZetaIcons.share_round),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(ZetaIcons.delete_round),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(ZetaIcons.more_vertical_round),
                  ),
                ],
              ),
            ),

            // Search
            Padding(
              padding: const EdgeInsets.only(top: ZetaSpacing.x4),
              child: Column(
                children: [
                  ZetaTopAppBar(
                    type: ZetaTopAppBarType.centeredTitle,
                    leading: BackButton(),
                    title: Text("Title"),
                    actions: [
                      IconButton(
                        onPressed: _showHideSearch,
                        icon: Icon(ZetaIcons.search_round),
                      )
                    ],
                    searchController: _searchController,
                    onSearch: (text) => debugPrint('search text: $text'),
                    onSearchMicrophoneIconPressed: () async {
                      var sampleTexts = [
                        'This is a sample text',
                        'Another sample',
                        'Speech recognition text',
                        'Example'
                      ];

                      var generatedText = sampleTexts[Random().nextInt(sampleTexts.length)];

                      _searchController.text = generatedText;
                    },
                  ),
                  ZetaButton.primary(
                    label: "Show/Hide Search",
                    onPressed: _showHideSearch,
                  )
                ],
              ),
            ),

            // Extended
            Padding(
              padding: const EdgeInsets.only(top: ZetaSpacing.x4),
              child: ZetaTopAppBar(
                type: ZetaTopAppBarType.extendedTitle,
                leading: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.menu),
                ),
                title: Text("Large title"),
                actions: [
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
