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
    final textStyle = Zeta.of(context).textStyles.bodyLarge;

    return ExampleScaffold(
      name: ListItemExample.name,
      paddingAll: 0,
      gap: 0,
      children: [
        ZetaListItem(
          primaryText: 'List Item',
          secondaryText: 'Descriptor',
          leading: Icon(ZetaIcons.star),
          key: Key('docs-list-item-icon'),
          showDivider: true,
        ),
        ZetaListItem(
          primaryText: 'List Item',
        ),
        ZetaDropdownListItem(
          items: [
            ZetaListItem(primaryText: 'List Item'),
            ZetaListItem(primaryText: 'List Item'),
            ZetaListItem(primaryText: 'List Item'),
          ],
          key: Key('docs-list-item-dropdown'),
          primaryText: 'List Item',
          leading: Icon(ZetaIcons.server),
          showDivider: true,
        ),
        ZetaListItem.checkbox(
          primaryText: 'List Item',
          value: _checkboxChecked,
          key: Key('docs-list-item-checkbox'),
          leading: ZetaAvatar.initials(
            size: ZetaAvatarSize.s,
            initials: 'AZ',
            backgroundColor: Zeta.of(context).colors.primitives.purple.shade80,
          ),
          showDivider: true,
          onChanged: (value) {
            print(value);
            setState(() {
              _checkboxChecked = value;
            });
          },
        ),
        ZetaListItem.toggle(
          primaryText: 'List Item',
          key: Key('docs-list-item-toggle'),
          value: _switchChecked,
          onChanged: (value) {
            setState(() {
              _switchChecked = value!;
            });
          },
        ),
        ZetaListItem.radio(
          primaryText: 'Radio option 1',
          value: radioOption1,
          groupValue: radioGroupValue,
          key: Key('docs-list-item-radio'),
          onChanged: (value) {
            setState(() {
              radioGroupValue = value;
            });
          },
        ),
        _buildListItem(
          'No Icon',
          ZetaListItem(
            primaryText: 'List Item',
            secondaryText: 'Descriptor',
          ),
          textStyle,
        ),
        _buildListItem(
          'Custom Title',
          ZetaListItem(
            title: ZetaButton(
              label: 'Custom Title Button',
              onPressed: () {},
            ),
          ),
          textStyle,
        ),
        _buildListItem(
          'Icon Left',
          ZetaListItem(primaryText: 'List Item', leading: Icon(ZetaIcons.star)),
          textStyle,
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
          ),
          textStyle,
        ),
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
          ),
          textStyle,
        ),
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
          textStyle,
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
            leading: Icon(ZetaIcons.star),
          ),
          textStyle,
        ),
      ].divide(const SizedBox(height: 16)).toList(),
    );
  }
}

Widget _buildListItem(String name, Widget listItem, TextStyle textStyle) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        name,
        style: textStyle,
      ),
      const SizedBox(height: 8),
      listItem,
    ],
  );
}
