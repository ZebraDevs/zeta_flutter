import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_example/home.dart';

class WarningAppBarExample extends StatelessWidget {
  static const String name = 'WarningAppBar';

  const WarningAppBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ZetaSystemBanner(
        type: ZetaSystemBannerType.warningAppBar,
        automaticallyImplyLeading: false,
        title: Text('Banner Title'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => router.pop(),
          icon: Icon(ZetaIcons.chevron_left_round),
        ),
      ),
    );
  }
}
