class ProgressBarState {
  const ProgressBarState({
    required this.currentPosition,
    required this.buffered,
    this.total,
  });
  final Duration currentPosition;
  final Duration buffered;
  final Duration? total;
}
