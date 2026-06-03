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
      final currentSource = _player.audioSource;
      String? currentUrl;
      if (currentSource is UriAudioSource) {
        currentUrl = currentSource.uri.toString();
      }

      // 比較用に正規化
      final normalizedRequestUrl = Uri.parse(url).toString();

      // 既に同じURLがセットされていなければセット（ロード）
      if (currentUrl != normalizedRequestUrl) {
        debugPrint("プリロード開始: $url");
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
      final currentSource = _player.audioSource;
      String? currentUrl;

      if (currentSource is UriAudioSource) {
        currentUrl = currentSource.uri.toString();
      }

      // 比較用に正規化。just_audio内部で保持される形式に合わせるため。
      // ただし setUrl には元の url を渡す（二重エンコードによる404防止）。
      final normalizedRequestUrl = Uri.parse(url).toString();

      debugPrint("--- Play Request ---");
      debugPrint("Request URL: $url");
      debugPrint("Current URL: $currentUrl");

      // 1. 別の楽曲が要求された場合、または何もセットされていない場合
      if (currentUrl != normalizedRequestUrl) {
        debugPrint("別の曲を検出。読み込みを開始します。");
        // setUrl() は内部で前の接続を適切に破棄するため、明示的な stop() は不要。
        // stop() を呼ぶとリソース解放のタイミングで競合し、404 エラーを誘発することがあります。
        await _player.setUrl(url);
      }
      // 2. 同じ曲で完了状態（再生終了済み）の場合
      else if (_player.processingState == ProcessingState.completed) {
        debugPrint("曲の終端のため、最初に戻ります");
        await _player.seek(Duration.zero);
      } else {
        debugPrint("同じURLのため、現在の位置から再開します");
      }

      // 3. 再生を開始（まだ再生していない場合のみ）
      if (!_player.playing) {
        await _player.play();
      }
    } catch (e, stackTrace) {
      // 404が出る場合は、デバッグログの「要求URL」をブラウザ等で開きアクセス可能か確認してください
      debugPrint("再生エラー (404等): $e");
      debugPrint("エラー対象URL: $url");
      debugPrint(stackTrace.toString());
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
