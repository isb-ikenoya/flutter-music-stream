import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BackMusicButton extends ConsumerWidget {
  const BackMusicButton({super.key});

  Future<void> handleTap() async {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () => handleTap(),
      icon: Icon(Icons.skip_previous),
    );
  }
}
