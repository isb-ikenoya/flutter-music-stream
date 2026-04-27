import 'package:flutter_music_stream/presentation/state/counter_state_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterNotifier extends Notifier<CounterStateModel> {
  // 初期状態
  @override
  CounterStateModel build() {
    return CounterStateModel(count: 0, message: 'ボタンを押して');
  }

  // 状態を更新するメソッド
  void increment() {
    state = state.copyWith(count: state.count + 1, message: '増えた');
  }

  void reset() {
    state = CounterStateModel(count: 0, message: 'リセットしました');
  }
}

// Provider（自動生成なしの場合は書く）
final counterProvider = NotifierProvider<CounterNotifier, CounterStateModel>(
  () {
    return CounterNotifier();
  },
);
