import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_example/home.dart';

class NegativeAppBarExample extends StatelessWidget {
  static const String name = 'NegativeAppBar';

  const NegativeAppBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ZetaSystemBanner(
        type: ZetaSystemBannerType.negativeAppBar,
        automaticallyImplyLeading: false,
        title: Text('Banner Title'),
        titleIcon: Icon(ZetaIcons.info_round),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => router.pop(),
          icon: Icon(ZetaIcons.chevron_left_round),
        ),
      ),
    );
  }
}
