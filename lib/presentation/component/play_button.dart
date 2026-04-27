import 'package:flutter/material.dart';
import 'package:flutter_music_stream/presentation/notifier/audio_controller_impl.dart';
import 'package:flutter_music_stream/presentation/state/audio_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

class PlayButton extends ConsumerWidget {
  const PlayButton({super.key});

  // ロジックを関数として切り出し
  Future<void> handleTap(WidgetRef ref, AudioState state) async {
    final controller = ref.read(audioControllerProvider);

    // 再生終了している、もしくは再生中ではない場合
    final isCompleted = state.processingState == ProcessingState.completed;

    if (isCompleted || !state.isPlaying) {
      await controller.playMusic(
        'https://www.ne.jp/asahi/music/myuu/wave/menuettm.mp3',
      );
    } else {
      // 再生中の場合のみ一時停止
      await controller.pauseMusic();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioState = ref.watch(audioStatusProvider);

    return audioState.when(
      data: (state) {
        // 読み込み中・バッファリング中はインジケータを出す
        if (state.processingState == ProcessingState.loading ||
            state.processingState == ProcessingState.buffering) {
          return const CircularProgressIndicator();
        }

        final isCompleted = state.processingState == ProcessingState.completed;
        final showPlayIcon = !state.isPlaying || isCompleted;

        return IconButton(
          onPressed: () => handleTap(ref, state),
          icon: Icon(showPlayIcon ? Icons.play_arrow : Icons.stop),
        );
      },
      error: (err, stack) => Text('読み込みエラー: $err'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
