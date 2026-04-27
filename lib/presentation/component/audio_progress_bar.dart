import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_stream/presentation/notifier/audio_controller_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AudioProgressBar extends ConsumerWidget {
  const AudioProgressBar({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressAsync = ref.watch(progressBarProvider);

    return progressAsync.when(
      data: (state) {
        return ProgressBar(
          progress: state.currentPosition,
          total: state.total ?? Duration.zero,
          buffered: state.buffered,
          onSeek: (duration) {
            ref.read(audioControllerProvider).seek(duration);
          },
        );
      },
      error: (err, stack) => Text('読み込みエラー: $err'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
