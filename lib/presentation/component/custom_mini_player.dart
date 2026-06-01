import 'package:flutter/material.dart';
import 'package:flutter_music_stream/presentation/component/mini_player/full_screen_player.dart';
import 'package:flutter_music_stream/presentation/component/mini_player/mini_player_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miniplayer/miniplayer.dart';

class CustomMiniPlayer extends ConsumerWidget {
  const CustomMiniPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final miniPlayerHeight = 64.0;
    final screenHeight = MediaQuery.of(context).size.height;

    return Miniplayer(
      minHeight: miniPlayerHeight,
      maxHeight: screenHeight,
      builder: (height, percentage) {
        if (height > miniPlayerHeight + 80) {
          // 全画面プレイヤー (スワイプで上がってきたとき)
          return FullScreenPlayer();
        } else {
          // ミニバー (常に下に表示されているとき)
          return const MiniPlayerBar();
        }
      },
    );
  }
}
