import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class VoiceMemoExample extends StatefulWidget {
  const VoiceMemoExample({super.key});

  static const String name = 'VoiceMemo';

  @override
  State<VoiceMemoExample> createState() => _VoiceMemoExampleState();
}

class _VoiceMemoExampleState extends State<VoiceMemoExample> {
  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: VoiceMemoExample.name,
      gap: 4,
      children: [
        const ZetaAudioVisualizer(
          url: 'https://freetestdata.com/wp-content/uploads/2021/09/Free_Test_Data_1MB_WAV.wav',
        ),
        const ZetaAudioVisualizer(
          assetPath: 'assets/notification.wav',
        ),
        Container(
          alignment: Alignment.centerRight,
          width: 345,
          decoration: BoxDecoration(
            color: Zeta.of(context).colors.mainPrimary,
            borderRadius: BorderRadius.all(Zeta.of(context).radius.rounded),
          ),
          child: Column(
            children: [
              ZetaAudioVisualizer(
                assetPath: 'assets/notification.wav',
                backgroundColor: Zeta.of(context).colors.mainPrimary,
                foregroundColor: Zeta.of(context).colors.mainInverse,
                tertiaryColor: Zeta.of(context).colors.mainDisabled,
                playButtonColor: Zeta.of(context).colors.mainInverse,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: Zeta.of(context).spacing.medium,
                  right: Zeta.of(context).spacing.medium,
                  bottom: Zeta.of(context).spacing.medium,
                ),
                child: Text(
                  "Hey there! Just wanted to remind you about our meeting tomorrow at 10 AM. Let's catch up then!",
                  style: Zeta.of(context).textStyles.bodyXSmall.copyWith(
                        color: Zeta.of(context).colors.mainInverse,
                      ),
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Zeta.of(context).colors.surfaceDefault,
            boxShadow: [
              BoxShadow(
                color: const Color.fromRGBO(40, 51, 61, 0.04),
                offset: const Offset(0, 0),
                blurRadius: 2,
                spreadRadius: 0,
              ),
              BoxShadow(
                color: const Color.fromRGBO(96, 104, 112, 0.16),
                offset: const Offset(0, 4),
                blurRadius: 8,
                spreadRadius: 0,
              ),
            ],
            borderRadius: BorderRadius.all(Zeta.of(context).radius.rounded),
          ),
          width: 375,
          child: ZetaVoiceMemo(
            maxRecordingDuration: Duration(seconds: 10),
            warningDuration: Duration(seconds: 5),
          ),
        ),
      ].gap(20),
    );
  }
}
