import 'package:flutter/material.dart';
import 'package:flutter_music_stream/presentation/component/app_notifier_overlay.dart';
import 'package:flutter_music_stream/presentation/navigation/footer_navigator.dart';
import 'package:flutter_music_stream/presentation/notifier/navigation_notifier.dart';
import 'package:flutter_music_stream/presentation/page/music_list_page.dart';
import 'package:flutter_music_stream/presentation/page/second_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationState = ref.watch(navigationProvider);
    // 切り替える画面のリスト
    const List<Widget> display = [MusicListPage(), SecondPage()];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: SizedBox.expand(
          child: AppNotifierOverlay(
            child: display[navigationState.selectedIndex],
          ),
        ),
      ),
      bottomNavigationBar: FooterNavigator(),
    );
  }
}
