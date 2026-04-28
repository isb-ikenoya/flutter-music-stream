import 'package:flutter/material.dart';
import 'package:flutter_music_stream/presentation/component/music_list_tile.dart';
import 'package:flutter_music_stream/presentation/notifier/music_list_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MusicList extends ConsumerWidget {
  const MusicList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final musicListAsync = ref.watch(musicListProvider);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            title: const Text('SliverAppBar Sample'),
            background: Image.network(
              'https://images.unsplash.com/photo-1588099768550-4014589e03e0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          //title: Text('My Playlist'),
          floating: true,
        ),
        musicListAsync.when(
          data: (list) => SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => MusicListTile(song: list[index]),
              childCount: list.length,
            ),
          ),
          loading: () => const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (e, __) =>
              SliverFillRemaining(child: Center(child: Text('Error: $e'))),
        ),
      ],
    );
  }
}
