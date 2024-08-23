import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markdown_widget/config/configs.dart';
import 'package:markdown_widget/widget/all.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class IntroductionWidgetbook extends StatefulWidget {
  final String readme;
  const IntroductionWidgetbook({super.key, required this.readme});

  @override
  State<IntroductionWidgetbook> createState() => _IntroductionWidgetbookState();
}

class _IntroductionWidgetbookState extends State<IntroductionWidgetbook> {
  late String readme;
  @override
  void initState() {
    super.initState();
    readme = widget.readme.replaceAll('# Zeta Flutter', '').trim();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    final radius = Radius.circular(ZetaSpacing.xl_1);
    final isDark = Zeta.of(context).brightness == Brightness.dark;
    final config = isDark ? MarkdownConfig.darkConfig : MarkdownConfig.defaultConfig;

    return LayoutBuilder(builder: (context, constraints) {
      final bool largeScreen = constraints.maxWidth > 480;
      return Scaffold(
        backgroundColor: colors.black,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: ZetaSpacing.xl_10, horizontal: ZetaSpacing.medium),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: colors.cool.shade20,
                    borderRadius: BorderRadius.only(topLeft: radius, topRight: radius),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      ZetaSpacing.xl_6,
                      ZetaSpacing.xl_9,
                      ZetaSpacing.xl_8,
                      ZetaSpacing.xl_6,
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          './assets/zebra-logo-head.svg',
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
                        SizedBox(width: largeScreen ? ZetaSpacing.xl_6 : ZetaSpacing.xl_1),
                        Expanded(
                          child: Text(
                            // x-release-please-start-version
                            'zeta_flutter v0.15.2',
                            // x-release-please-end
                            style: ZetaTextStyles.displayLarge.copyWith(fontSize: largeScreen ? null : 24),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: isDark ? colors.warm.shade10 : colors.surfacePrimary,
                    borderRadius: BorderRadius.only(bottomLeft: radius, bottomRight: radius),
                  ),
                  width: double.infinity,
                  padding: EdgeInsets.all(ZetaSpacing.xl_4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      MarkdownWidget(
                        data: readme,
                        shrinkWrap: true,
                        config: config.copy(
                          configs: [
                            LinkConfig(
                              style: TextStyle(
                                color: colors.blue.shade50,
                                decoration: TextDecoration.underline,
                              ),
                              onTap: (url) {
                                final Uri? uri = Uri.tryParse(url);
                                if (uri != null && uri.isAbsolute) {
                                  launchUrl(uri);
                                } else {
                                  final Uri? uri2 =
                                      Uri.tryParse('https://github.com/ZebraDevs/zeta_flutter/blob/main/' + url);
                                  if (uri2 != null && uri2.isAbsolute) {
                                    launchUrl(uri2);
                                  }
                                }
                              },
                            ),
                            CodeConfig(style: GoogleFonts.ibmPlexMono()),
                            isDark
                                ? PreConfig.darkConfig.copy(
                                    textStyle: GoogleFonts.ibmPlexMono(),
                                    wrapper: (child, _, language) => _CodeWrapperWidget(child, language),
                                  )
                                : PreConfig(
                                    textStyle: GoogleFonts.ibmPlexMono(),
                                    wrapper: (child, _, language) => _CodeWrapperWidget(child, language),
                                  )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _CodeWrapperWidget extends StatelessWidget {
  final Widget child;
  final String language;

  const _CodeWrapperWidget(this.child, this.language, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    return Stack(
      children: [
        DefaultTextStyle(
          style: GoogleFonts.ibmPlexMono(color: Zeta.of(context).colors.textDefault),
          child: child,
        ),
        if (language.isNotEmpty)
          Positioned(
            top: ZetaSpacing.small,
            right: 0,
            child: SelectionContainer.disabled(
              child: Container(
                child: Text(language),
                padding: EdgeInsets.symmetric(vertical: ZetaSpacing.minimum, horizontal: ZetaSpacing.medium),
                decoration: BoxDecoration(color: colors.cool.shade40, borderRadius: Zeta.of(context).radius.rounded),
              ),
            ),
          ),
      ],
    );
  }
}
