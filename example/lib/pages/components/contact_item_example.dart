import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class ContactItemExample extends StatefulWidget {
  static const String name = 'ContactListItem';

  const ContactItemExample({super.key});

  @override
  State<ContactItemExample> createState() => _ContactItemExampleState();
}

class _ContactItemExampleState extends State<ContactItemExample> {
  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: ContactItemExample.name,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 500),
          child: Column(
            children: [
              ZetaContactItem(
                onTap: () {},
                leading: ZetaAvatar(
                  size: ZetaAvatarSize.s,
                  image: Image.asset('packages/zeta_widgetbook/assets/omer.jpg', fit: BoxFit.cover),
                ),
                title: Text("Contact / Group Name"),
                subtitle: Text("Store Associate - Bakery Dept."),
              ),
              ZetaContactItem(
                onTap: () {},
                leading: ZetaAvatar(
                  size: ZetaAvatarSize.s,
                  backgroundColor: Zeta.of(context).colors.surfaceAvatarBlue,
                  initials: 'AZ',
                ),
                title: Text("Contact / Group Name"),
                subtitle: Text("Store Associate - Bakery Dept."),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
