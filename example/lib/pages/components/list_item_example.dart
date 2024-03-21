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
  bool _isCheckBoxEnabled = false;
  bool _isSelected = true;

  _onDefaultListItemTap() {
    setState(() => _isCheckBoxEnabled = !_isCheckBoxEnabled);
  }

  @override
  Widget build(BuildContext context) {
    final zetaColors = Zeta.of(context).colors;

    return ExampleScaffold(
      name: ListItemExample.name,
      child: Container(
        color: zetaColors.surfaceSecondary,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // List Item with descriptor
              Padding(
                padding: const EdgeInsets.only(top: ZetaSpacing.x4),
                child: ZetaListItem(
                  dense: true,
                  leading: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(borderRadius: ZetaRadius.rounded),
                    child: Placeholder(),
                  ),
                  subtitle: Text("Descriptor"),
                  title: Text("List Item"),
                  trailing: ZetaCheckbox(
                    value: _isCheckBoxEnabled,
                    onChanged: (_) => _onDefaultListItemTap(),
                  ),
                  onTap: _onDefaultListItemTap,
                ),
              ),

              // Enabled
              Padding(
                padding: const EdgeInsets.only(top: ZetaSpacing.l),
                child: Text(
                  "Enabled",
                  style: ZetaTextStyles.titleLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: ZetaSpacing.m),
                child: ZetaListItem(title: Text("List Item")),
              ),

              // Selected
              Padding(
                padding: const EdgeInsets.only(top: ZetaSpacing.l),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Selected",
                    style: ZetaTextStyles.titleLarge,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: ZetaSpacing.m),
                child: ZetaListItem(
                  title: Text("List Item"),
                  selected: _isSelected,
                  trailing: _isSelected
                      ? Icon(
                          ZetaIcons.check_mark_sharp,
                          color: zetaColors.primary,
                        )
                      : null,
                  onTap: () => setState(() => _isSelected = !_isSelected),
                ),
              ),

              // Disabled
              Padding(
                padding: const EdgeInsets.only(top: ZetaSpacing.l),
                child: Text(
                  "Disabled",
                  style: ZetaTextStyles.titleLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: ZetaSpacing.m),
                child: ZetaListItem(
                  title: Text("List Item"),
                  enabled: false,
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
