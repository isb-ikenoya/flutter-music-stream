import 'package:flutter_music_stream/presentation/state/navigation_state_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationNotifier extends Notifier<NavigationStateModel> {
  @override
  NavigationStateModel build() {
    return NavigationStateModel(selectedIndex: 0);
  }

  // 遷移
  void transition({required int index}) {
    state = NavigationStateModel(selectedIndex: index);
  }

  // リセット
  void reset() {
    state = NavigationStateModel(selectedIndex: 0);
  }
}

final navigationProvider =
    NotifierProvider<NavigationNotifier, NavigationStateModel>(() {
      return NavigationNotifier();
    });
