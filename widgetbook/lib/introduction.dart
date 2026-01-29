import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markdown_widget/config/configs.dart';
import 'package:markdown_widget/widget/all.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

final _pictureRegex = RegExp(
  r'<picture[^>]*>(.*?)</picture>',
  dotAll: true,
  caseSensitive: false,
);

class IntroductionWidgetbook extends StatefulWidget {
  const IntroductionWidgetbook({super.key, required this.readme});
  final String readme;

  @override
  State<IntroductionWidgetbook> createState() => _IntroductionWidgetbookState();
}

class _IntroductionWidgetbookState extends State<IntroductionWidgetbook> {
  late String readme;

  @override
  void initState() {
    super.initState();
    readme = widget.readme.replaceAll('# Zeta Flutter', '').replaceAll(_pictureRegex, '').trim();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    final radius = Radius.circular(Zeta.of(context).spacing.xl);
    final isDark = Zeta.of(context).brightness == Brightness.dark;
    final config = isDark ? MarkdownConfig.darkConfig : MarkdownConfig.defaultConfig;

    return LayoutBuilder(
      builder: (context, constraints) {
        final largeScreen = constraints.maxWidth > 480;
        return ConstrainedBox(
          constraints: constraints.copyWith(
              maxHeight: constraints.maxHeight.isInfinite ? MediaQuery.sizeOf(context).height : constraints.maxHeight),
          child: Scaffold(
            backgroundColor: Colors.black,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Zeta.of(context).spacing.xl_10,
                  horizontal: Zeta.of(context).spacing.medium,
                ),
                child: Column(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: colors.mainInverse,
                        borderRadius: BorderRadius.only(topLeft: radius, topRight: radius),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          Zeta.of(context).spacing.xl_6,
                          Zeta.of(context).spacing.xl_9,
                          Zeta.of(context).spacing.xl_8,
                          Zeta.of(context).spacing.xl_6,
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'packages/zeta_flutter/assets/logos/zebra-logo-head.svg',
                              height: largeScreen ? 80 : 40,
                              width: largeScreen ? 80 : 40,
                              colorFilter: isDark
                                  ? const ColorFilter.matrix([
                                      -1.0, 0.0, 0.0, 0.0, 255.0, //
                                      0.0, -1.0, 0.0, 0.0, 255.0, //
                                      0.0, 0.0, -1.0, 0.0, 255.0, //
                                      0.0, 0.0, 0.0, 1.0, 0.0, //
                                    ])
                                  : null,
                            ),
                            SizedBox(width: largeScreen ? Zeta.of(context).spacing.xl_6 : Zeta.of(context).spacing.xl),
                            Expanded(
                              child: Text(
                                // x-release-please-start-version
                                'zeta_flutter v1.0.0',
                                // x-release-please-end
                                style: Zeta.of(context)
                                    .textStyles
                                    .displayLarge
                                    .copyWith(fontSize: largeScreen ? null : 24, color: colors.mainDefault),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: isDark ? colors.primitives.warm.shade10 : colors.surfaceDefault,
                        borderRadius: BorderRadius.only(bottomLeft: radius, bottomRight: radius),
                      ),
                      width: double.infinity,
                      padding: EdgeInsets.all(Zeta.of(context).spacing.xl_4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          MarkdownWidget(
                            data: readme,
                            shrinkWrap: true,
                            config: config.copy(
                              configs: [
                                PConfig(
                                  textStyle: Zeta.of(context).textStyles.bodyMedium.apply(
                                        color: colors.mainDefault,
                                      ),
                                ),
                                LinkConfig(
                                  style: TextStyle(
                                    color: colors.primitives.blue.shade50,
                                    decoration: TextDecoration.underline,
                                  ),
                                  onTap: (url) {
                                    final uri = Uri.tryParse(url);
                                    if (uri != null && uri.isAbsolute) {
                                      launchUrl(uri);
                                    } else {
                                      final uri2 =
                                          Uri.tryParse('https://github.com/ZebraDevs/zeta_flutter/blob/main/$url');
                                      if (uri2 != null && uri2.isAbsolute) {
                                        launchUrl(uri2);
                                      }
                                    }
                                  },
                                ),
                                CodeConfig(style: GoogleFonts.ibmPlexMono()),
                                if (isDark)
                                  PreConfig.darkConfig.copy(
                                    textStyle: GoogleFonts.ibmPlexMono(),
                                    wrapper: (child, _, language) => _CodeWrapperWidget(child, language),
                                  )
                                else
                                  PreConfig(
                                    textStyle: GoogleFonts.ibmPlexMono(),
                                    wrapper: (child, _, language) => _CodeWrapperWidget(child, language),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CodeWrapperWidget extends StatelessWidget {
  const _CodeWrapperWidget(this.child, this.language);
  final Widget child;
  final String language;

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    return Stack(
      children: [
        DefaultTextStyle(
          style: GoogleFonts.ibmPlexMono(color: Zeta.of(context).colors.mainDefault),
          child: child,
        ),
        if (language.isNotEmpty)
          Positioned(
            top: Zeta.of(context).spacing.small,
            right: 0,
            child: SelectionContainer.disabled(
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: Zeta.of(context).spacing.minimum,
                  horizontal: Zeta.of(context).spacing.medium,
                ),
                decoration: BoxDecoration(
                    color: colors.primitives.cool.shade40,
                    borderRadius: BorderRadius.all(Zeta.of(context).radius.rounded)),
                child: Text(language),
              ),
            ),
          ),
      ],
    );
  }
}
