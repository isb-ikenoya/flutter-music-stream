import 'package:flutter/material.dart';
import 'package:flutter_music_stream/presentation/component/audio_progress_bar.dart';
import 'package:flutter_music_stream/presentation/component/play_button.dart';
import 'package:flutter_music_stream/presentation/notifier/audio_controller_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SecondPage extends ConsumerWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /*Future.microtask(() {
      ref
          .read(audioControllerProvider)
          .loadMusic("https://www.ne.jp/asahi/music/myuu/wave/menuettm.mp3");
    });*/

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue, title: const Text('テスト')),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () async {
                /*ref
                  .read(loadingProvider.notifier)
                  .update(LoadingStatus.loading.index);*/
              },
              child: const Text('実行'),
            ),
            TextButton(
              onPressed: () async {
                ref
                    .read(audioControllerProvider)
                    .playMusic(
                      'https://www.ne.jp/asahi/music/myuu/wave/menuettm.mp3',
                    );
              },
              child: const Text('再生'),
            ),
            PlayButton(),
            AudioProgressBar(),
          ],
        ),
      ),
    );
  }
}
