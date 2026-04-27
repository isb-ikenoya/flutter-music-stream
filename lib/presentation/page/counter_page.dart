import 'package:flutter/material.dart';
import 'package:flutter_music_stream/presentation/notifier/counter_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterPage extends ConsumerWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // モデルごとに取得
    final counterState = ref.watch(counterProvider);

    return Column(
      children: [
        // モデル内のそれぞれの値にアクセス
        Text('回数: ${counterState.count}', style: TextStyle(fontSize: 30)),
        Text('状況: ${counterState.message}'),

        ElevatedButton(
          onPressed: () {
            // メソッドの呼び出し
            ref.read(counterProvider.notifier).increment();
          },
          child: Text('＋１'),
        ),

        TextButton(
          onPressed: () => ref.read(counterProvider.notifier).reset(),
          child: Text('リセット'),
        ),
      ],
    );
  }
}
