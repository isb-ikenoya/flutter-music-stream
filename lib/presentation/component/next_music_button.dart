import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NextMusicButton extends ConsumerWidget {
  const NextMusicButton({super.key});

  Future<void> handleTap() async {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () => handleTap(),
      icon: Icon(Icons.skip_next),
    );
  }
}
