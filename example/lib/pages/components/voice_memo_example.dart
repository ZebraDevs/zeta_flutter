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
      paddingAll: 0,
      gap: 4,
      children: [
        const ZetaAudioVisualizer(
          url: 'https://freetestdata.com/wp-content/uploads/2021/09/Free_Test_Data_10MB_WAV.wav',
        ),
        // const ZetaAudioVisualizer(
        //   url: 'https://freetestdata.com/wp-content/uploads/2021/09/Free_Test_Data_1MB_WAV.wav',
        // ),
        // const ZetaAudioVisualizer(
        //   assetPath: 'assets/notification.wav',
        // ),
      ].gap(20),
    );
  }
}
