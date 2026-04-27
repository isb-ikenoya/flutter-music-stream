import 'package:flutter/cupertino.dart';
import 'package:flutter_music_stream/domain/repository/audio_engine_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

class AudioEngineRepositoryImpl implements AudioEngineRepository {
  // just_audioの実態
  final AudioPlayer _player = AudioPlayer();
  // プレイヤー本体（操作用）
  @override
  AudioPlayer get player => _player;

  // 外部にStream公開
  @override
  Stream<Duration> get positionStream => _player.positionStream;
  @override
  Stream<Duration> get bufferedPositionStream => _player.bufferedPositionStream;
  @override
  Stream<Duration?> get durationStream => _player.durationStream;

  @override
  Future<void> loadMusic(String url) async {
    try {
      // 既に同じURLがセットされていなければセット（ロード）
      if (_player.audioSource == null) {
        // preload: true にすることで、setUrlした時点でデータの読み込みを開始する
        await _player.setUrl(url, preload: true);
      }
    } catch (e) {
      debugPrint("ロードエラー: $e");
    }
  }

  @override
  Future<void> play(String url) async {
    try {
      print("現在の状態: ${_player.processingState}");
      print("現在の位置: ${_player.position}");

      if (_player.processingState == ProcessingState.completed) {
        // 終わっていれば再生位置を最初に戻す
        await _player.seek(Duration.zero);
        // 念のため、少し待機（OSレベルのプレイヤーの準備時間を稼ぐ）
        await Future.delayed(const Duration(milliseconds: 50));
      }

      // すでに同じURLがセットされているか確認
      // 違うURLならロードし直し、同じなら単に再生（再開）
      if (_player.audioSource == null) {
        print("URLセット");
        await _player.setUrl(url);
      }

      // 再生（停止位置から再開される）
      await _player.play();
    } catch (e) {
      print("再生エラー: $e");
    }
  }

  @override
  Future<void> pause() async {
    await _player.pause();
  }

  void dispose() {
    _player.dispose();
  }

  @override
  Future<void> seek(Duration position) async {
    // シークすると自動で再生再開してしまうため事前にポーズ
    if (_player.processingState == ProcessingState.completed) {
      await _player.pause();
    }
    await _player.seek(position);
  }
}

final audioEngineRepositoryProvider = Provider<AudioEngineRepository>((ref) {
  // 1. インスタンスを作成
  final repository = AudioEngineRepositoryImpl();

  ref.onDispose(() {
    repository.dispose();
  });

  return repository;
});
