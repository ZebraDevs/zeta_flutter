import 'package:flutter_test/flutter_test.dart';

import '../../../test_utils/test_utils.dart';

// TODO(test): Tests can not be implemented easily as we must mock the audio playback / recording functionality.
void main() {
  const String parentFolder = 'voice_memo';

  const goldenFile = GoldenFiles(component: parentFolder);
  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });

  group('Accessibility Tests', () {
    // meetsAccessibilityGuidelinesTest(
    //   ZetaAudioVisualizer(),
    // );
  });

  group('Content Tests', () {
    testWidgets('displays an empty box when no content is provided', (WidgetTester tester) async {});
    testWidgets('displays a correct waveform for wav pcm data', (WidgetTester tester) async {});
    testWidgets('displays the default waveform for non- wav pcm data', (WidgetTester tester) async {});
    testWidgets('displays the correct duration for wav pcm data', (WidgetTester tester) async {});
    testWidgets('displays the correct duration for non- wav pcm data', (WidgetTester tester) async {});
    testWidgets('timer counts down as audio is played', (WidgetTester tester) async {});
    testWidgets('waveform color changes as audio is played', (WidgetTester tester) async {});
  });

  group('Dimensions Tests', () {
    testWidgets('has the correct height', (WidgetTester tester) async {});
    testWidgets('has the correct width', (WidgetTester tester) async {});
    testWidgets('has the correct padding ', (WidgetTester tester) async {});
    testWidgets('has the amplitude heights', (WidgetTester tester) async {});
  });

  group('Styling Tests', () {
    testWidgets('duration text is styled correctly', (WidgetTester tester) async {});
    testWidgets('background color is applied correctly', (WidgetTester tester) async {});
    testWidgets('foreground color is applied correctly', (WidgetTester tester) async {});
    testWidgets('tertiary color is applied correctly', (WidgetTester tester) async {});
    testWidgets('button color is applied correctly', (WidgetTester tester) async {});
  });

  group('Interaction Tests', () {
    testWidgets('waveform responds to tap gestures', (WidgetTester tester) async {});
    testWidgets('waveform responds to drag gestures', (WidgetTester tester) async {});
    testWidgets('button plays audio', (WidgetTester tester) async {});
    testWidgets('button pauses audio', (WidgetTester tester) async {});
  });

  group('Golden Tests', () {
    // goldenTest(
    //   goldenFile,
    //   const ZetaAudioVisualizer(),
    //   'audio_visualizer_default',
    // );
    // goldenTest(
    //   goldenFile,
    //   const ZetaAudioVisualizer(),
    //   'audio_visualizer_wav_pcm_data',
    // );
    // goldenTest(
    //   goldenFile,
    //   const ZetaAudioVisualizer(),
    //   'audio_visualizer_non_wav_pcm_data',
    // );
    // goldenTest(
    //   goldenFile,
    //   const ZetaAudioVisualizer(),
    //   'audio_visualizer_custom_colors',
    // );
  });

  group('Performance Tests', () {
    testWidgets('pcm wav file is processed in acceptable time', (WidgetTester tester) async {});
    testWidgets('non-pcm wav file is processed in acceptable time', (WidgetTester tester) async {});
  });
}
