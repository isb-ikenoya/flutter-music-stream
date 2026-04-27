import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_stream/presentation/notifier/loading_nitifier.dart';
import 'package:flutter_music_stream/presentation/state/loading_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppNotifierOverlay extends ConsumerWidget {
  const AppNotifierOverlay({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loadingState = ref.watch(loadingProvider);

    return Stack(
      children: [
        child,
        // ローディングオーバーレイ表示
        if (loadingState.status == LoadingStatus.loading.index)
          Positioned.fill(
            child: Container(
              color: Colors.black38,
              child: const Center(
                child: CupertinoActivityIndicator(radius: 10),
              ),
            ),
          ),
      ],
    );
  }
}
