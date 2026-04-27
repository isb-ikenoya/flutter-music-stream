import 'package:just_audio/just_audio.dart';

class AudioState {
  final bool isPlaying;
  // プレイヤーの内部状態を追加
  final ProcessingState processingState;
  final String? currentUrl;

  AudioState({
    required this.isPlaying,
    this.processingState = ProcessingState.idle,
    this.currentUrl,
  });

  // 状態の一部だけを変えた新しい状態を作るためのメソッド
  AudioState copyWith({
    bool? isPlaying,
    ProcessingState? processingState,
    String? currentUrl,
  }) {
    return AudioState(
      isPlaying: isPlaying ?? this.isPlaying,
      processingState: processingState ?? this.processingState,
      currentUrl: currentUrl ?? this.currentUrl,
    );
  }
}
