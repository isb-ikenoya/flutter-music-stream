abstract class AudioController {
  Future<void> loadMusic(String url);
  Future<void> playMusic(String url);
  Future<void> pauseMusic();
  Future<void> seek(Duration position);
}
