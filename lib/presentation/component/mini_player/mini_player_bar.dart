import 'package:flutter/material.dart';
import 'package:flutter_music_stream/presentation/component/play_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MiniPlayerBar extends ConsumerWidget {
  const MiniPlayerBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      // 親の高さ制限いっぱいに広げる
      height: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.cyan,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      // ListTile をやめて Row にすることで、タイトな高さに対応
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            // 1. アイコン部分
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Container(
                width: 32,
                height: 32,
                color: Colors.white24,
                child: const Icon(
                  Icons.music_note,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 12),

            // 2. テキスト部分 (Expanded で横幅の余りを使わせる)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '曲名',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "アーティスト名",
                    style: TextStyle(fontSize: 10, color: Colors.white70),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // 3. 再生ボタンなどのアクション
            PlayButton(),
          ],
        ),
      ),
    );
  }
}
