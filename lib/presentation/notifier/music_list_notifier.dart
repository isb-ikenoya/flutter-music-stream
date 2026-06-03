import 'package:flutter_music_stream/presentation/state/music_info_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'music_list_notifier.g.dart';

@riverpod
class MusicListNotifier extends _$MusicListNotifier {
  @override
  FutureOr<List<MusicInfoState>> build() async {
    // 初期リスト（APIから取得したり、アセットから読み込んだりする）
    return [
      MusicInfoState(
        id: '1',
        name: 'メヌエット',
        url: 'https://www.ne.jp/asahi/music/myuu/wave/menuettm.mp3',
      ),
      MusicInfoState(
        id: '2',
        name: 'アイネ・クライネ・ナハトムジーク',
        url: 'https://www.ne.jp/asahi/music/myuu/wave/eine.mp3',
      ),
      MusicInfoState(id: '3', name: 'Song B', url: 'https://example.com/b.mp3'),
      MusicInfoState(id: '4', name: 'Song B', url: 'https://example.com/b.mp3'),
      MusicInfoState(id: '5', name: 'Song B', url: 'https://example.com/b.mp3'),
      MusicInfoState(id: '6', name: 'Song B', url: 'https://example.com/b.mp3'),
      MusicInfoState(id: '7', name: 'Song B', url: 'https://example.com/b.mp3'),
      MusicInfoState(id: '8', name: 'Song B', url: 'https://example.com/b.mp3'),
      MusicInfoState(id: '9', name: 'Song C', url: 'https://example.com/b.mp3'),
    ];
  }

  // 曲の追加
  void addMusic(MusicInfoState music) {
    final current = state.value ?? [];
    state = AsyncData([...current, music]);

    // エンジン側の ConcatenatingAudioSource にも追加する処理をここに書く
  }
}
