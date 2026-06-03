import 'package:flutter/material.dart';
import 'package:flutter_music_stream/presentation/notifier/audio_controller_impl.dart';
import 'package:flutter_music_stream/presentation/state/music_info_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MusicListTile extends ConsumerWidget {
  final MusicInfoState song;
  const MusicListTile({super.key, required this.song});

  Future<void> handleTap(WidgetRef ref) async {
    final controller = ref.read(audioControllerProvider);
    await controller.playMusic(song.url);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 現在再生中の曲かどうかを判定（ハイライト用）
    final currentUrl = ref.watch(audioStatusProvider).value?.currentUrl;
    final isSelected = currentUrl == song.url;
    final controller = ref.read(audioControllerProvider);

    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        /*child: Image.network(song.artworkUrl ?? '', width: 50, height: 50, fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.music_note)),*/
        child: const Icon(Icons.music_note),
      ),
      title: Text(
        song.name,
        style: TextStyle(
          color: isSelected ? Colors.blue : null,
          fontWeight: isSelected ? FontWeight.bold : null,
        ),
      ),
      subtitle: Text("アーティスト名"),
      onTap: () async => await handleTap(ref),
    );
  }
}
