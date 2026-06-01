import 'package:flutter/material.dart';
import 'package:flutter_music_stream/presentation/component/audio_progress_bar.dart';
import 'package:flutter_music_stream/presentation/component/back_music_button.dart';
import 'package:flutter_music_stream/presentation/component/next_music_button.dart';
import 'package:flutter_music_stream/presentation/component/play_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FullScreenPlayer extends ConsumerWidget {
  const FullScreenPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.red,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AudioProgressBar(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [BackMusicButton(), PlayButton(), NextMusicButton()],
            ),
          ],
        ),
      ),
    );
  }
}
