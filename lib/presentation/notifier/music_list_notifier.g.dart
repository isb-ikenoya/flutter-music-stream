// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_list_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MusicListNotifier)
final musicListProvider = MusicListNotifierProvider._();

final class MusicListNotifierProvider
    extends $AsyncNotifierProvider<MusicListNotifier, List<MusicInfoState>> {
  MusicListNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'musicListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$musicListNotifierHash();

  @$internal
  @override
  MusicListNotifier create() => MusicListNotifier();
}

String _$musicListNotifierHash() => r'5653e5f6b031c8c64402f005317927c48514f9e4';

abstract class _$MusicListNotifier
    extends $AsyncNotifier<List<MusicInfoState>> {
  FutureOr<List<MusicInfoState>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<MusicInfoState>>, List<MusicInfoState>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<MusicInfoState>>,
                List<MusicInfoState>
              >,
              AsyncValue<List<MusicInfoState>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
