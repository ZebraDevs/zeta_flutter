import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class ListItemExample extends StatefulWidget {
  static const String name = 'ListItem';

  const ListItemExample({super.key});

  @override
  State<ListItemExample> createState() => _ListItemExampleState();
}

class _ListItemExampleState extends State<ListItemExample> {
  bool _switchChecked = false;
  bool _checkboxChecked = false;

  String radioOption1 = 'Label 1';
  String radioOption2 = 'Label 2';
  String? radioGroupValue;

  @override
  Widget build(BuildContext context) {
    final zetaColors = Zeta.of(context).colors;

    return ExampleScaffold(
      name: ListItemExample.name,
      child: Container(
        color: zetaColors.surfaceSecondary,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildListItem(
                    'No Icon',
                    ZetaListItem(
                      primaryText: 'List Item',
                      secondaryText: 'Descriptor',
                    )),
                _buildListItem(
                  'Icon Left',
                  ZetaListItem(primaryText: 'List Item', leading: Icon(ZetaIcons.star_round)),
                ),
                _buildListItem(
                    'Toggle Right',
                    ZetaListItem.toggle(
                      primaryText: 'List Item',
                      value: _switchChecked,
                      onChanged: (value) {
                        setState(() {
                          _switchChecked = value!;
                        });
                      },
                    )),
                _buildListItem(
                    'Checkbox Right',
                    ZetaListItem.checkbox(
                      primaryText: 'List Item',
                      value: _checkboxChecked,
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          _checkboxChecked = value;
                        });
                      },
                    )),
                _buildListItem(
                  'Radio Right',
                  Column(
                    children: [
                      ZetaListItem.radio(
                        primaryText: 'Radio option 1',
                        value: radioOption1,
                        groupValue: radioGroupValue,
                        onChanged: (value) {
                          setState(() {
                            radioGroupValue = value;
                          });
                        },
                      ),
                      ZetaListItem.radio(
                        primaryText: 'Radio option 2',
                        value: radioOption2,
                        groupValue: radioGroupValue,
                        onChanged: (value) {
                          setState(() {
                            radioGroupValue = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                _buildListItem(
                  'Dropdown list',
                  ZetaDropdownListItem(
                    items: [
                      ZetaListItem(primaryText: 'List Item'),
                      ZetaListItem(primaryText: 'List Item'),
                      ZetaListItem(primaryText: 'List Item'),
                    ],
                    expanded: true,
                    primaryText: 'List Item',
                    leading: Icon(
                      ZetaIcons.star_round,
                    ),
                  ),
                ),
              ].divide(const SizedBox(height: 16)).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildListItem(String name, Widget listItem) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        name,
        style: ZetaTextStyles.bodyLarge,
      ),
      const SizedBox(height: 8),
      listItem,
    ],
  );
}
