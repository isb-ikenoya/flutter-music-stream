// 音再生関連の処理を記載
import 'dart:async';

import 'package:flutter_music_stream/application/usecase/audio_controller.dart';
import 'package:flutter_music_stream/domain/repository/audio_engine_repository.dart';
import 'package:flutter_music_stream/infrastructure/repository/audio_engine_repository_impl.dart';
import 'package:flutter_music_stream/presentation/state/audio_state.dart';
import 'package:flutter_music_stream/presentation/state/progress_bar_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

class AudioControllerImpl implements AudioController {
  final AudioEngineRepository _engine;
  AudioControllerImpl(this._engine);

  @override
  Future<void> loadMusic(String url) async {
    try {
      await _engine.loadMusic(url);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> playMusic(String url) async {
    try {
      await _engine.play(url);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> pauseMusic() async {
    await _engine.pause();
  }

  @override
  Future<void> seek(Duration position) async {
    await _engine.seek(position);
  }
}

final audioControllerProvider = Provider<AudioControllerImpl>((ref) {
  final engine = ref.watch(audioEngineRepositoryProvider);
  return AudioControllerImpl(engine);
});

// プログレス関連
final progressBarProvider = StreamProvider<ProgressBarState>((ref) {
  final audioEngine = ref.watch(audioEngineRepositoryProvider);
  final player = audioEngine.player;

  return Rx.combineLatest3<Duration, Duration, Duration?, ProgressBarState>(
    player.positionStream,
    player.bufferedPositionStream,
    player.durationStream,
    (currentPosition, buffered, total) => ProgressBarState(
      currentPosition: currentPosition,
      buffered: buffered,
      total: total,
    ),
  );
});

// 再生状況関連
class AudioStatusNotifier extends AsyncNotifier<AudioState> {
  @override
  FutureOr<AudioState> build() async {
    final audioEngine = ref.watch(audioEngineRepositoryProvider);
    final player = audioEngine.player;

    player.playerStateStream.listen((state) {
      this.state = AsyncData(
        AudioState(
          isPlaying: state.playing,
          processingState: state.processingState,
        ),
      );
    });

    return AudioState(
      isPlaying: player.playing,
      processingState: player.processingState,
    );
  }
}

final audioStatusProvider =
    AsyncNotifierProvider<AudioStatusNotifier, AudioState>(() {
      return AudioStatusNotifier();
    });
