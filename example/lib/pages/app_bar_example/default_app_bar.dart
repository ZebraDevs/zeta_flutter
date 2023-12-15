import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_example/home.dart';

class DefaultAppBarExample extends StatelessWidget {
  static const String name = 'DefaultAppBar';

  const DefaultAppBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ZetaSystemBanner(
        type: ZetaSystemBannerType.defaultAppBar,
        automaticallyImplyLeading: false,
        title: Text('Banner Title'),
        leading: IconButton(
          onPressed: () => router.pop(),
          icon: Icon(ZetaIcons.chevron_left_round),
        ),
      ),
    );
  }
}
