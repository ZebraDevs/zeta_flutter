import 'dart:async';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:audioplayers/audioplayers.dart' as AudioPlayers;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_soloud/flutter_soloud.dart';
import 'package:flutter_sound/public/flutter_sound_helper.dart';

import '../../../zeta_flutter.dart';
import 'audio_helpers.dart';

/// Audio Visualizer used within the [ZetaVoiceMemo] component.
class ZetaAudioVisualizer extends ZetaStatefulWidget {
  /// Constructs a [ZetaAudioVisualizer].
  const ZetaAudioVisualizer({
    super.key,
    super.rounded,
    this.assetPath,
    this.url,
  });

  final String? assetPath;

  final String? url;

  @override
  State<ZetaAudioVisualizer> createState() => _ZetaAudioVisualizerState();
}

class _ZetaAudioVisualizerState extends State<ZetaAudioVisualizer> {
  final PlayerController playerController = PlayerController();

  // int? playbackLocation;

  // AudioPlayers.AudioPlayer? _audioPlayer;

  Uri? localFile;

  // Duration? _duration;
  // Duration? get duration => _duration;
  // set duration(Duration? value) {
  //   if (duration != value) {
  //     setState(() => _duration = value);
  //   }
  }

  // bool _playing = false;
  // bool get playing => _playing;
  // set playing(bool value) {
  //   if (playing != value) {
  //     setState(() => _playing = value);
  //     if (value) {
  //       unawaited(_audioPlayer?.resume());
  //     } else {
  //       unawaited(_audioPlayer?.pause());
  //     }
  //   }
  // }

  int? _linesNeeded;
  int? get linesNeeded => _linesNeeded;
  set linesNeeded(int? value) {
    if (linesNeeded != value) {
      setState(() => _linesNeeded = value);
      // unawaited(getAmplitudes());
    }
  }

  // List<double> _amplitudes = [];

  // Future<void> getAmplitudes() async {
  //   if (localFile == null || linesNeeded == null) {
  //     debugPrint('Local file or linesNeeded is null.');
  //     return;
  //   }
  // }

  // Future<void> resetPlayback() async {
  //   _audioPlayer ??= AudioPlayers.AudioPlayer();
  //   if (widget.assetPath != null) {
  //     localFile = await fetchToMemory(widget.assetPath!);
  //   } else if (widget.url != null) {
  //     localFile = await downloadAudioFileToLocal(widget.url!);
  //   }

  //   if (localFile != null) {
  //     await _audioPlayer!.setSourceUrl(localFile!.toString());
  //     playing = false;
  //     duration = await _audioPlayer!.getDuration();
  //     unawaited(getAmplitudes());
  //     await playerController.preparePlayer(path: localFile?.toString() ?? '');
  //   }
  // }

  @override
  void initState() {
    super.initState();

    // unawaited(resetPlayback());

    //  playerController.preparePlayer(path: '../myFile.mp3');

    // _audioPlayer!.onPlayerComplete.listen((_) async {
    //   await resetPlayback();
    // });

    // _audioPlayer!.onPositionChanged.listen((position) {
    //   if (duration == null) return;
    //   setState(() {
    //     final x = position.inMilliseconds / duration!.inMilliseconds;
    //     final y = (x * linesNeeded!).clamp(1, linesNeeded! - 1);
    //     playbackLocation = y.toInt();
    //   });
    // });
    // await playerController.preparePlayer(path: localFile?.toString() ?? '');
  }

  @override
  void dispose() {
    unawaited(_audioPlayer?.dispose());

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(zeta.radius.rounded),
        color: Zeta.of(context).colors.surfaceHover,
      ),
      padding: const EdgeInsets.all(4), // TODO(tokens): token
      child: Row(
        children: [
          InkWell(
            onTap: () => setState(() => playing = !playing),
            child: Padding(
              padding: EdgeInsets.all(zeta.spacing.small),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: zeta.colors.mainPrimary,
                  borderRadius: BorderRadius.all(zeta.radius.full),
                ),
                child: Center(
                  child: AnimatedCrossFade(
                    firstChild: Icon(
                      ZetaIcons.play,
                      color: zeta.colors.mainInverse,
                    ),
                    secondChild: Icon(
                      ZetaIcons.pause,
                      color: zeta.colors.mainInverse,
                    ),
                    duration: const Duration(milliseconds: 100),
                    crossFadeState: playing ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return AudioFileWaveforms(size: Size(constraints.maxWidth, 32), playerController: playerController);
              },
            ),
          ),
          // Expanded(
          //   child: LayoutBuilder(
          //     builder: (context, constraints) {
          //       WidgetsBinding.instance.addPostFrameCallback((_) {
          //         if (mounted) {
          //           setState(() => linesNeeded = (constraints.maxWidth / 4).floor());
          //         }
          //       });
          //       return Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: _amplitudes.mapIndexed<Widget>(
          //           (int index, double amplitude) {
          //             return AnimatedContainer(
          //               duration: const Duration(milliseconds: 100),
          //               width: 2,
          //               height: (amplitude * 32).clamp(2, 32),
          //               margin: const EdgeInsets.symmetric(horizontal: 1),
          //               decoration: BoxDecoration(
          //                 color: (playbackLocation ?? 0) > index ? zeta.colors.mainDefault : zeta.colors.mainLight,
          //                 borderRadius: BorderRadius.circular(2),
          //               ),
          //             );
          //           },
          //         ).toList(),
          //       );
          //     },
          //   ),
          // ),

          Padding(
            padding: EdgeInsets.only(left: zeta.spacing.small, right: zeta.spacing.medium),
            child: Text(
              duration != null
                  ? '${duration!.inMinutes}:${(duration!.inSeconds % 60).toString().padLeft(2, '0')}'
                  : '0:00',
              style: zeta.textStyles.labelMedium,
            ),
          ),
        ],
      ),
    );
  }
}
