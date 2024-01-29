import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class AvatarExample extends StatelessWidget {
  static const String name = 'Avatar';

  const AvatarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ExampleScaffold(
          name: AvatarExample.name,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(ZetaSpacing.s),
            child: Column(
              children: [
                Column(
                  children: [
                    Text(
                      'ZetaAvatar.image',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Column(
                          children: ZetaAvatarSize.values.map((size) {
                            final height = ZetaAvatar.getSizePixels(size);
                            final padding = (ZetaAvatar.getSizePixels(size) - 14) / 2;
                            return Column(
                              children: [
                                SizedBox(
                                  height: height,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: padding),
                                    child: Text(size.name.toUpperCase()),
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            );
                          }).toList(),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          children: ZetaAvatarSize.values
                              .map((size) => Column(
                                    children: [
                                      ZetaAvatar.image(size: size),
                                      const SizedBox(height: 20),
                                    ],
                                  ))
                              .toList(),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          children: ZetaAvatarSize.values
                              .map((size) => Column(
                                    children: [
                                      ZetaAvatar.image(
                                        size: size,
                                        showStatus: true,
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ))
                              .toList(),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          children: ZetaAvatarSize.values
                              .map((size) => Column(
                                    children: [
                                      ZetaAvatar.image(
                                        size: size,
                                        imageUrl: 'https://i.ytimg.com/vi/KItsWUzFUOs/maxresdefault.jpg',
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ))
                              .toList(),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          children: ZetaAvatarSize.values
                              .map((size) => Column(
                                    children: [
                                      ZetaAvatar.image(
                                        size: size,
                                        showStatus: true,
                                        imageUrl: 'https://i.ytimg.com/vi/KItsWUzFUOs/maxresdefault.jpg',
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'ZetaAvatar.initials',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Column(
                          children: ZetaAvatarSize.values.map((size) {
                            final height = ZetaAvatar.getSizePixels(size);
                            final padding = (ZetaAvatar.getSizePixels(size) - 14) / 2;
                            return Column(
                              children: [
                                SizedBox(
                                  height: height,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: padding),
                                    child: Text(size.name.toUpperCase()),
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            );
                          }).toList(),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          children: ZetaAvatarSize.values
                              .map((size) => Column(
                                    children: [
                                      ZetaAvatar.initials(
                                        size: size,
                                        initials: 'AB',
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ))
                              .toList(),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          children: ZetaAvatarSize.values
                              .map((size) => Column(
                                    children: [
                                      ZetaAvatar.initials(
                                        size: size,
                                        name: 'Antony Brothers',
                                        showStatus: true,
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'ZetaAvatar.image with badge',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Column(
                          children: ZetaAvatarSize.values.map((size) {
                            final height = ZetaAvatar.getSizePixels(size) + 6;
                            final padding = (ZetaAvatar.getSizePixels(size) - 8) / 2;
                            return Column(
                              children: [
                                SizedBox(
                                  height: height,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: padding),
                                    child: Text(size.name.toUpperCase()),
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            );
                          }).toList(),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          children: ZetaAvatarSize.values
                              .map((size) => Column(
                                    children: [
                                      ZetaAvatar.image(
                                        size: size,
                                        badge: ZetaIndicator.notification(
                                          value: 3,
                                          size: _getBadgeSize(size),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ))
                              .toList(),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          children: ZetaAvatarSize.values
                              .map((size) => Column(
                                    children: [
                                      ZetaAvatar.image(
                                        size: size,
                                        showStatus: true,
                                        badge: ZetaIndicator.notification(
                                          value: 3,
                                          size: _getBadgeSize(size),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ))
                              .toList(),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          children: ZetaAvatarSize.values
                              .map((size) => Column(
                                    children: [
                                      ZetaAvatar.image(
                                        size: size,
                                        badge: ZetaIndicator.notification(
                                          value: 3,
                                          size: _getBadgeSize(size),
                                        ),
                                        imageUrl: 'https://i.ytimg.com/vi/KItsWUzFUOs/maxresdefault.jpg',
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ))
                              .toList(),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          children: ZetaAvatarSize.values
                              .map((size) => Column(
                                    children: [
                                      ZetaAvatar.image(
                                        size: size,
                                        showStatus: true,
                                        badge: ZetaIndicator.notification(
                                          value: 3,
                                          size: _getBadgeSize(size),
                                        ),
                                        imageUrl: 'https://i.ytimg.com/vi/KItsWUzFUOs/maxresdefault.jpg',
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'ZetaAvatar.initials with badge',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Column(
                          children: ZetaAvatarSize.values.map((size) {
                            final height = ZetaAvatar.getSizePixels(size) + 6;
                            final padding = (ZetaAvatar.getSizePixels(size) - 8) / 2;
                            return Column(
                              children: [
                                SizedBox(
                                  height: height,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: padding),
                                    child: Text(size.name.toUpperCase()),
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            );
                          }).toList(),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          children: ZetaAvatarSize.values
                              .map((size) => Column(
                                    children: [
                                      ZetaAvatar.initials(
                                        size: size,
                                        initials: 'AB',
                                        badge: ZetaIndicator.notification(
                                          value: 3,
                                          size: _getBadgeSize(size),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ))
                              .toList(),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          children: ZetaAvatarSize.values
                              .map((size) => Column(
                                    children: [
                                      ZetaAvatar.initials(
                                        size: size,
                                        name: 'Antony Brothers',
                                        showStatus: true,
                                        badge: ZetaIndicator.notification(
                                          value: 3,
                                          size: _getBadgeSize(size),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'ZetaAvatar.image with special status',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Column(
                          children: ZetaAvatarSize.values.map((size) {
                            final height = ZetaAvatar.getSizePixels(size) + 6;
                            final padding = (ZetaAvatar.getSizePixels(size) - 8) / 2;
                            return Column(
                              children: [
                                SizedBox(
                                  height: height,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: padding),
                                    child: Text(size.name.toUpperCase()),
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            );
                          }).toList(),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          children: ZetaAvatarSize.values
                              .map((size) => Column(
                                    children: [
                                      ZetaAvatar.image(
                                        size: size,
                                        specialStatus: ZetaIndicator.icon(
                                          size: _getSpecialStatusSize(size),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ))
                              .toList(),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          children: ZetaAvatarSize.values
                              .map((size) => Column(
                                    children: [
                                      ZetaAvatar.image(
                                        size: size,
                                        showStatus: true,
                                        specialStatus: ZetaIndicator.icon(
                                          size: _getSpecialStatusSize(size),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ))
                              .toList(),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          children: ZetaAvatarSize.values
                              .map((size) => Column(
                                    children: [
                                      ZetaAvatar.image(
                                        size: size,
                                        specialStatus: ZetaIndicator.icon(
                                          size: _getSpecialStatusSize(size),
                                        ),
                                        imageUrl: 'https://i.ytimg.com/vi/KItsWUzFUOs/maxresdefault.jpg',
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ))
                              .toList(),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          children: ZetaAvatarSize.values
                              .map((size) => Column(
                                    children: [
                                      ZetaAvatar.image(
                                        size: size,
                                        showStatus: true,
                                        specialStatus: ZetaIndicator.icon(
                                          size: _getSpecialStatusSize(size),
                                        ),
                                        imageUrl: 'https://i.ytimg.com/vi/KItsWUzFUOs/maxresdefault.jpg',
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'ZetaAvatar.initials with special status',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Column(
                          children: ZetaAvatarSize.values.map((size) {
                            final height = ZetaAvatar.getSizePixels(size) + 6;
                            final padding = (ZetaAvatar.getSizePixels(size) - 8) / 2;
                            return Column(
                              children: [
                                SizedBox(
                                  height: height,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: padding),
                                    child: Text(size.name.toUpperCase()),
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            );
                          }).toList(),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          children: ZetaAvatarSize.values
                              .map((size) => Column(
                                    children: [
                                      ZetaAvatar.initials(
                                        size: size,
                                        initials: 'AB',
                                        specialStatus: ZetaIndicator.icon(
                                          size: _getSpecialStatusSize(size),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ))
                              .toList(),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          children: ZetaAvatarSize.values
                              .map((size) => Column(
                                    children: [
                                      ZetaAvatar.initials(
                                        size: size,
                                        name: 'Antony Brothers',
                                        showStatus: true,
                                        specialStatus: ZetaIndicator.icon(
                                          size: _getSpecialStatusSize(size),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ],
                ),
              ].divide(const SizedBox(height: ZetaSpacing.x6)).toList(),
            ),
          ),
        );
      },
    );
  }

  static ZetaIndicatorSize _getBadgeSize(ZetaAvatarSize size) {
    switch (size) {
      case ZetaAvatarSize.xl:
        return ZetaIndicatorSize.large;
      case ZetaAvatarSize.l:
        return ZetaIndicatorSize.large;
      case ZetaAvatarSize.m:
        return ZetaIndicatorSize.large;
      case ZetaAvatarSize.s:
        return ZetaIndicatorSize.medium;
      case ZetaAvatarSize.xs:
        return ZetaIndicatorSize.small;
    }
  }

  static ZetaIndicatorSize _getSpecialStatusSize(ZetaAvatarSize size) {
    switch (size) {
      case ZetaAvatarSize.xl:
        return ZetaIndicatorSize.large;
      case ZetaAvatarSize.l:
        return ZetaIndicatorSize.medium;
      case ZetaAvatarSize.m:
        return ZetaIndicatorSize.medium;
      case ZetaAvatarSize.s:
        return ZetaIndicatorSize.medium;
      case ZetaAvatarSize.xs:
        return ZetaIndicatorSize.small;
    }
  }
}
