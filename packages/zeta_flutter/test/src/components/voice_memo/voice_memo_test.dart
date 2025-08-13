import 'package:flutter_test/flutter_test.dart';

import '../../../test_utils/test_utils.dart';
// TODO(UX-1492): Tests can not be implemented easily as we must mock the audio playback / recording functionality.

void main() {
  const String parentFolder = 'voice_memo';

  const goldenFile = GoldenFiles(component: parentFolder);
  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });

  group('Accessibility Tests', () {
    // meetsAccessibilityGuidelinesTest(
    //   ZetaVoiceMemo(),
    // );
  });

  group('Content Tests', () {
    testWidgets('shows a warning when permissions are not given', (WidgetTester tester) async {});
    testWidgets('default behavior is correct', (WidgetTester tester) async {});
    testWidgets('shows all buttons when props are provided', (WidgetTester tester) async {});
    testWidgets('records audio for maximum amount of time', (WidgetTester tester) async {});
    testWidgets('records audio for short amount of time', (WidgetTester tester) async {});
    testWidgets('duration timer initially shows correct (maximum) time', (WidgetTester tester) async {});
    testWidgets('duration timer counts down correctly', (WidgetTester tester) async {});
    testWidgets('live waveform matches recorded audio', (WidgetTester tester) async {});
    testWidgets('paused waveform matches recorded audio', (WidgetTester tester) async {});
    testWidgets('"recording message" label is shown whilst recording', (WidgetTester tester) async {});
    testWidgets('"playing" label is shown whilst recording at correct time', (WidgetTester tester) async {});
    testWidgets('"send message" label is shown whilst recording at correct time', (WidgetTester tester) async {});
    testWidgets('"warning" label is shown whilst recording at correct time', (WidgetTester tester) async {});
    testWidgets('"warning" label counts down correctly', (WidgetTester tester) async {});
  });

  group('Dimensions Tests', () {
    testWidgets('has the correct height', (WidgetTester tester) async {});
    testWidgets('has the correct width', (WidgetTester tester) async {});
    testWidgets('has the correct padding ', (WidgetTester tester) async {});
    testWidgets('has the audio visualizer height', (WidgetTester tester) async {});
    testWidgets('has correct button sizes', (WidgetTester tester) async {});
  });

  group('Styling Tests', () {
    testWidgets('has the correct background color', (WidgetTester tester) async {});
    testWidgets('has the correct border radius', (WidgetTester tester) async {});
    testWidgets('has the correct icon colors', (WidgetTester tester) async {});
  });

  group('Interaction Tests', () {
    testWidgets('records audio on microphone icon press', (WidgetTester tester) async {});
    testWidgets('pauses audio recording on pause icon press', (WidgetTester tester) async {});
    testWidgets('restarts audio recording on restart icon press', (WidgetTester tester) async {});
    testWidgets('exits audio recording on trash icon press', (WidgetTester tester) async {});
    testWidgets('sends audio on send icon press', (WidgetTester tester) async {});
    testWidgets('recording is disabled once max time is reached', (WidgetTester tester) async {});
    testWidgets('recorded audio can be played back', (WidgetTester tester) async {});
  });

  group('Golden Tests', () {
    // goldenTest(
    //   goldenFile,
    //   const ZetaVoiceMemo(),
    //   'voice_memo_default',
    // );
    // goldenTest(
    //   goldenFile,
    //   const ZetaVoiceMemo(),
    //   'voice_memo_with_all_callbacks',
    // );
    // goldenTest(
    //   goldenFile,
    //   const ZetaVoiceMemo(),
    //   'voice_memo_recording_10_seconds',
    // );
    // goldenTest(
    //   goldenFile,
    //   const ZetaVoiceMemo(),
    //   'voice_memo_recorded_10_seconds',
    // );
  });

  group('Performance Tests', () {
    testWidgets('records audio without dropping frames', (WidgetTester tester) async {});

    testWidgets('generates waveform amplitudes in good time', (WidgetTester tester) async {});
    testWidgets('', (WidgetTester tester) async {});
  });
}
