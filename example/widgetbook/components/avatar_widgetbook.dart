import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_example/pages/avatar_example.dart';

WidgetbookComponent avatarWidgetBook() {
  return WidgetbookComponent(
    name: 'Avatar',
    useCases: [
      WidgetbookUseCase(
        name: 'Photo',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(20),
          child: AvatarExample.avatarImageExample,
        ),
      ),
      WidgetbookUseCase(
        name: 'Initials',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(20),
          child: AvatarExample.avatarInitialsExample,
        ),
      ),
      WidgetbookUseCase(
        name: 'Photo with badge',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(20),
          child: AvatarExample.avatarImageWithBadgeExample,
        ),
      ),
      WidgetbookUseCase(
        name: 'Initials with badge',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(20),
          child: AvatarExample.avatarInitialsWithBadgeExample,
        ),
      ),
      WidgetbookUseCase(
        name: 'Photo with special status',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(20),
          child: AvatarExample.avatarImageWithSpecialStatusExample,
        ),
      ),
      WidgetbookUseCase(
        name: 'Initials with special status',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(20),
          child: AvatarExample.avatarInitialsWithSpecialStatusExample,
        ),
      ),
    ],
  );
}
