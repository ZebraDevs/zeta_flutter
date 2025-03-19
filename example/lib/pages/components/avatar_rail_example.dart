// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class AvatarRailExample extends StatefulWidget {
  static const String name = 'AvatarRail';

  const AvatarRailExample({super.key});

  @override
  State<AvatarRailExample> createState() => _AvatarRailExampleState();
}

class _AvatarRailExampleState extends State<AvatarRailExample> {
  int? selected;
  @override
  Widget build(BuildContext context) {
    final avatarList = [
      ZetaAvatar.initials(
        initials: 'AZ',
        label: 'Archie',
      ),
      ZetaAvatar.initials(
        initials: 'BY',
        label: 'Beth',
      ),
      ZetaAvatar.initials(
        initials: 'CX',
        label: 'Clara',
      ),
      ZetaAvatar.initials(
        initials: 'DW',
        label: 'Dan',
      ),
      ZetaAvatar.initials(
        initials: 'EV',
        label: 'Emily',
      ),
      ZetaAvatar.initials(
        initials: 'FU',
        label: 'Frank',
      ),
      ZetaAvatar.initials(
        initials: 'GT',
        label: 'George',
      ),
      ZetaAvatar.initials(
        initials: 'HS',
        label: 'Harith',
      ),
      ZetaAvatar.initials(
        initials: 'IR',
        label: 'Irene',
      ),
      ZetaAvatar.initials(
        initials: 'KQ',
        label: 'Katie',
      ),
    ];
    return ExampleScaffold(
      name: AvatarRailExample.name,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (final size in ZetaAvatarSize.values)
                  Row(
                    children: [
                      Text(size.toString()),
                      SizedBox(
                        width: 500,
                        child: ZetaAvatarRail(
                          gap: 10,
                          size: size,
                          labelMaxLines: 3,
                          onTap: (key) => {
                            setState(() {
                              selected = int.parse(key.toString().replaceAll(RegExp(r'[^0-9]'), ''));
                            })
                          },
                          avatars: avatarList,
                        ),
                      ),
                      if (selected != null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: avatarList[selected!].copyWith(size: size),
                        ),
                    ].gap(50),
                  )
              ],
            ),
          ),
        ),
        ZetaAvatarRail(
          key: Key('docs-avatar-rail'),
          gap: 10,
          size: ZetaAvatarSize.m,
          labelMaxLines: 3,
          avatars: avatarList,
        )
      ],
    );
  }
}
