import 'package:flutter/material.dart';
import 'package:flutter_music_stream/presentation/component/music_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MusicListPage extends ConsumerWidget {
  const MusicListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(children: [MusicList()]);
  }
}
