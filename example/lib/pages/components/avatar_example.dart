import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class AvatarExample extends StatelessWidget {
  static const String name = 'Avatar/Avatar';

  const AvatarExample({super.key});

  @override
  Widget build(BuildContext context) {
    final Widget image = CachedNetworkImage(
      imageUrl: "https://i.ytimg.com/vi/KItsWUzFUOs/maxresdefault.jpg",
      placeholder: (context, url) => Icon(ZetaIcons.user),
      errorWidget: (context, url, error) => Icon(ZetaIcons.error),
      fit: BoxFit.cover,
    );

    return ExampleScaffold(
      name: AvatarExample.name,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(Zeta.of(context).spacing.medium),
            child: Column(
              children: [
                ZetaAvatar.initials(
                  initials: 'WW',
                  size: ZetaAvatarSize.xxs,
                  backgroundColor: Zeta.of(context).colors.borderPositive,
                ),
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
                            final height = size.pixelSize(context);
                            final padding = (height - 14) / 2;
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
                                      ZetaAvatar.image(size: size, image: image),
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
                                        image: image,
                                        borderColor: Zeta.of(context).colors.borderPositive,
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
                                        image: image,
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
                                        borderColor: Zeta.of(context).colors.borderPositive,
                                        image: image,
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
                            final height = size.pixelSize(context);
                            final padding = (height - 14) / 2;
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
                                        initials: 'AB',
                                        borderColor: Zeta.of(context).colors.borderPositive,
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
                            final height = size.pixelSize(context);
                            final padding = (height - 14) / 2;
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
                                        upperBadge: ZetaAvatarBadge.notification(value: 3),
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
                                        borderColor: Zeta.of(context).colors.borderPositive,
                                        upperBadge: ZetaAvatarBadge.notification(value: 3),
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
                                        upperBadge: ZetaAvatarBadge.notification(value: 3),
                                        image: image,
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
                                        borderColor: Zeta.of(context).colors.borderPositive,
                                        upperBadge: ZetaAvatarBadge.notification(value: 3),
                                        image: image,
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
                            final height = size.pixelSize(context);
                            final padding = (height - 14) / 2;
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
                                        upperBadge: ZetaAvatarBadge.notification(value: 3),
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
                                        initials: 'AB',
                                        borderColor: Zeta.of(context).colors.borderPositive,
                                        upperBadge: ZetaAvatarBadge.notification(value: 3),
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
                            final height = size.pixelSize(context);
                            final padding = (height - 14) / 2;
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
                                        lowerBadge: ZetaAvatarBadge.icon(),
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
                                        borderColor: Zeta.of(context).colors.borderPositive,
                                        lowerBadge: ZetaAvatarBadge.icon(),
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
                                        lowerBadge: ZetaAvatarBadge.icon(),
                                        image: image,
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
                                        borderColor: Zeta.of(context).colors.borderPositive,
                                        lowerBadge: ZetaAvatarBadge.icon(),
                                        image: image,
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
                            final height = size.pixelSize(context);
                            final padding = (height - 14) / 2;
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
                                        lowerBadge: ZetaAvatarBadge.icon(),
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
                                        initials: 'AB',
                                        borderColor: Zeta.of(context).colors.borderPositive,
                                        lowerBadge: ZetaAvatarBadge.icon(),
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
                      'ZetaAvatar with notification badge and status badge',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Column(
                          children: ZetaAvatarSize.values.map((size) {
                            final height = size.pixelSize(context);
                            final padding = (height - 14) / 2;
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
                                        image: image,
                                        upperBadge: ZetaAvatarBadge.notification(value: 3),
                                        lowerBadge: ZetaAvatarBadge.icon(),
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
                                        image: image,
                                        borderColor: Zeta.of(context).colors.borderPositive,
                                        upperBadge: ZetaAvatarBadge.notification(value: 3),
                                        lowerBadge: ZetaAvatarBadge.icon(),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ))
                              .toList(),
                        ),
                        Column(
                          children: ZetaAvatarSize.values
                              .map((size) => Column(
                                    children: [
                                      ZetaAvatar.initials(
                                        size: size,
                                        initials: 'AB',
                                        upperBadge: ZetaAvatarBadge.notification(value: 3),
                                        lowerBadge: ZetaAvatarBadge.icon(),
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
                                        initials: 'AB',
                                        borderColor: Zeta.of(context).colors.borderPositive,
                                        upperBadge: ZetaAvatarBadge.notification(value: 3),
                                        lowerBadge: ZetaAvatarBadge.icon(),
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
              ].divide(SizedBox(height: Zeta.of(context).spacing.xl_2)).toList(),
            ),
          ),
        ),
        Row(
          key: Key('docs'),
          spacing: 16,
          children: ZetaAvatarSize.values
              .map((size) => ZetaAvatar.initials(
                    size: size,
                    initials: 'AB',
                    borderColor: Zeta.of(context).colors.borderPositive,
                    upperBadge: ZetaAvatarBadge.notification(value: 3),
                    lowerBadge: ZetaAvatarBadge.icon(),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

extension on ZetaAvatarSize {
  double pixelSize(BuildContext context) {
    switch (this) {
      case ZetaAvatarSize.xxxl:
        return Zeta.of(context).spacing.minimum * 50;
      case ZetaAvatarSize.xxl:
        return Zeta.of(context).spacing.minimum * 30;
      case ZetaAvatarSize.xl:
        return Zeta.of(context).spacing.xl_10;
      case ZetaAvatarSize.l:
        return Zeta.of(context).spacing.xl_9;
      case ZetaAvatarSize.m:
        return Zeta.of(context).spacing.xl_8;
      case ZetaAvatarSize.s:
        return Zeta.of(context).spacing.xl_6;
      case ZetaAvatarSize.xs:
        return Zeta.of(context).spacing.xl_5;
      case ZetaAvatarSize.xxs:
        return Zeta.of(context).spacing.xl_4;
      case ZetaAvatarSize.xxxs:
        return Zeta.of(context).spacing.xl_2;
    }
  }
}

class AvatarBadgeExample extends StatelessWidget {
  static const String name = 'Avatar/StatusBadge';
  const AvatarBadgeExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: name,
      children: [
        Column(
          spacing: 16,
          children: [
            Wrap(spacing: 16, runSpacing: 16, children: [
              ZetaAvatarBadge(value: 9),
              ZetaAvatarBadge(value: 99),
              ZetaAvatarBadge(value: 999),
            ]),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                ZetaAvatarBadge(
                  icon: ZetaIcons.check_mark,
                  type: ZetaAvatarBadgeType.icon,
                  color: Zeta.of(context).colors.mainPositive,
                ),
                ZetaAvatarBadge(
                  icon: ZetaIcons.star,
                  type: ZetaAvatarBadgeType.icon,
                  color: Zeta.of(context).colors.mainWarning,
                ),
                ZetaAvatarBadge(
                  icon: ZetaIcons.chevron_left,
                  type: ZetaAvatarBadgeType.icon,
                  color: Zeta.of(context).colors.mainNegative,
                ),
                ZetaAvatarBadge(
                  icon: ZetaIcons.last_page,
                  type: ZetaAvatarBadgeType.icon,
                  color: Zeta.of(context).colors.mainInfo,
                ),
                ZetaAvatarBadge(
                  icon: ZetaIcons.barcode_bluetooth,
                  type: ZetaAvatarBadgeType.icon,
                  color: Zeta.of(context).colors.mainPrimary,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
