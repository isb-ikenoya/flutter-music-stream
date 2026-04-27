// ここはインターフェースの定義を書く
import 'package:just_audio/just_audio.dart';

abstract class AudioEngineRepository {
  Stream<Duration> get positionStream;
  Stream<Duration> get bufferedPositionStream;
  Stream<Duration?> get durationStream;
  AudioPlayer get player;

  Future<void> loadMusic(String url);
  Future<void> play(String url);
  Future<void> pause();
  Future<void> seek(Duration position);
}
