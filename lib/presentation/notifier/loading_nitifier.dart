import 'package:flutter_music_stream/presentation/state/loading_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingNotifier extends Notifier<LoadingState> {
  @override
  LoadingState build() {
    return LoadingState(status: LoadingStatus.hideLoading.index);
  }

  void update(int status) {
    state = LoadingState(status: status);
  }
}

final loadingProvider = NotifierProvider<LoadingNotifier, LoadingState>(() {
  return LoadingNotifier();
});
