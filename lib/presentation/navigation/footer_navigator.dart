import 'package:flutter/material.dart';
import 'package:flutter_music_stream/presentation/notifier/navigation_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FooterNavigator extends ConsumerWidget {
  const FooterNavigator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationState = ref.watch(navigationProvider);

    void trans(int index) {
      ref.read(navigationProvider.notifier).transition(index: index);
    }

    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'マイページ'),
      ],

      currentIndex: navigationState.selectedIndex,
      elevation: 0,
      onTap: trans,
      fixedColor: Colors.red, // 選択している部分の色
      backgroundColor: Colors.grey,
    );
  }
}
