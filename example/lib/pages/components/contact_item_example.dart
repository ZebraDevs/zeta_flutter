import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class ContactItemExample extends StatefulWidget {
  static const String name = 'ContactItem';

  const ContactItemExample({super.key});

  @override
  State<ContactItemExample> createState() => _ContactItemExampleState();
}

class _ContactItemExampleState extends State<ContactItemExample> {
  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: ContactItemExample.name,
      child: ZetaContactItem(
        onTap: () {},
        leading: ZetaAvatar(size: ZetaAvatarSize.s),
        title: Text("Contact / Group Name"),
        subtitle: Text("Store Associate - Bakery Dept."),
      ),
    );
  }
}
