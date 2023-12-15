import 'package:flutter/material.dart';
import 'package:zeta_example/home.dart';
import 'package:zeta_flutter/zeta_flutter.dart';
import 'default_app_bar.dart';
import '../../widgets.dart';
import 'negative_app_bar.dart';
import 'positive_app_bar.dart';
import 'warning_app_bar.dart';

class AppBarExample extends StatelessWidget {
  static const String name = 'AppBar';

  const AppBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ExampleScaffold(
          name: AppBarExample.name,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: Dimensions.m),
            child: Column(
              children: [
                ZetaSystemBanner(
                  type: ZetaSystemBannerType.defaultAppBar,
                  automaticallyImplyLeading: false,
                  title: Text('Banner Title'),
                ),
                const SizedBox(height: Dimensions.m),
                ZetaSystemBanner(
                  type: ZetaSystemBannerType.positiveAppBar,
                  automaticallyImplyLeading: false,
                  title: Text('Banner Title'),
                  titleIcon: Icon(ZetaIcons.info_round),
                ),
                const SizedBox(height: Dimensions.m),
                ZetaSystemBanner(
                  type: ZetaSystemBannerType.warningAppBar,
                  automaticallyImplyLeading: false,
                  title: Text('Banner Title'),
                  centerTitle: true,
                ),
                const SizedBox(height: Dimensions.m),
                ZetaSystemBanner(
                  type: ZetaSystemBannerType.negativeAppBar,
                  automaticallyImplyLeading: false,
                  title: Text('Banner Title'),
                  titleIcon: Icon(ZetaIcons.info_round),
                  centerTitle: true,
                ),
                const SizedBox(height: Dimensions.m),
                ZetaSystemBanner(
                  type: ZetaSystemBannerType.defaultAppBar,
                  automaticallyImplyLeading: false,
                  title: Text('Banner Title'),
                  actions: [
                    IconButton(
                      onPressed: () => router.pushNamed(DefaultAppBarExample.name),
                      icon: Icon(ZetaIcons.chevron_right_round),
                    ),
                  ],
                ),
                const SizedBox(height: Dimensions.m),
                ZetaSystemBanner(
                  type: ZetaSystemBannerType.positiveAppBar,
                  automaticallyImplyLeading: false,
                  title: Text('Banner Title'),
                  titleIcon: Icon(ZetaIcons.info_round),
                  actions: [
                    IconButton(
                      onPressed: () => router.pushNamed(PositiveAppBarExample.name),
                      icon: Icon(ZetaIcons.chevron_right_round),
                    ),
                  ],
                ),
                const SizedBox(height: Dimensions.m),
                ZetaSystemBanner(
                  type: ZetaSystemBannerType.warningAppBar,
                  automaticallyImplyLeading: false,
                  title: Text('Banner Title'),
                  centerTitle: true,
                  actions: [
                    IconButton(
                      onPressed: () => router.pushNamed(WarningAppBarExample.name),
                      icon: Icon(ZetaIcons.chevron_right_round),
                    ),
                  ],
                ),
                const SizedBox(height: Dimensions.m),
                ZetaSystemBanner(
                  type: ZetaSystemBannerType.negativeAppBar,
                  automaticallyImplyLeading: false,
                  title: Text('Banner Title'),
                  titleIcon: Icon(ZetaIcons.info_round),
                  centerTitle: true,
                  actions: [
                    IconButton(
                      onPressed: () => router.pushNamed(NegativeAppBarExample.name),
                      icon: Icon(ZetaIcons.chevron_right_round),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
