import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class AvatarExample extends StatelessWidget {
  static const String name = 'Avatar';

  const AvatarExample({super.key});

  @override
  Widget build(BuildContext context) {
    final Widget image = CachedNetworkImage(
      imageUrl: "https://i.ytimg.com/vi/KItsWUzFUOs/maxresdefault.jpg",
      placeholder: (context, url) => Icon(ZetaIcons.user_round),
      errorWidget: (context, url, error) => Icon(Icons.error),
      fit: BoxFit.cover,
    );

    return ExampleScaffold(
      name: AvatarExample.name,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(ZetaSpacing.medium),
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
                        final height = size.pixelSize;
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
                                    borderColor: Zeta.of(context).colors.green,
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
                                    borderColor: Zeta.of(context).colors.green,
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
                        final height = size.pixelSize;
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
                                    borderColor: Zeta.of(context).colors.green,
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
                        final height = size.pixelSize;
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
                                    borderColor: Zeta.of(context).colors.green,
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
                                    borderColor: Zeta.of(context).colors.green,
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
                        final height = size.pixelSize;
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
                                    borderColor: Zeta.of(context).colors.green,
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
                        final height = size.pixelSize;
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
                                    borderColor: Zeta.of(context).colors.green,
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
                                    borderColor: Zeta.of(context).colors.green,
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
                        final height = size.pixelSize;
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
                                    borderColor: Zeta.of(context).colors.green,
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
                        final height = size.pixelSize;
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
                                    borderColor: Zeta.of(context).colors.green,
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
                                    borderColor: Zeta.of(context).colors.green,
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
          ].divide(const SizedBox(height: ZetaSpacing.xl_2)).toList(),
        ),
      ),
    );
  }
}

extension on ZetaAvatarSize {
  double get pixelSize {
    switch (this) {
      case ZetaAvatarSize.xxxl:
        return ZetaSpacingBase.x50;
      case ZetaAvatarSize.xxl:
        return ZetaSpacingBase.x30;
      case ZetaAvatarSize.xl:
        return ZetaSpacing.xl_10;
      case ZetaAvatarSize.l:
        return ZetaSpacing.xl_9;
      case ZetaAvatarSize.m:
        return ZetaSpacing.xl_8;
      case ZetaAvatarSize.s:
        return ZetaSpacing.xl_6;
      case ZetaAvatarSize.xs:
        return ZetaSpacing.xl_5;
      case ZetaAvatarSize.xxs:
        return ZetaSpacing.xl_4;
      case ZetaAvatarSize.xxxs:
        return ZetaSpacing.xl_2;
    }
  }
}
