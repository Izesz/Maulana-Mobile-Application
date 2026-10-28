import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'shared/follow_card.dart';

// ===== STATE: kelas immutable =====
class FollowState {
  const FollowState({this.isFollowing = false, this.followers = 1200});
  final bool isFollowing;
  final int followers;

  FollowState copyWith({bool? isFollowing, int? followers}) => FollowState(
        isFollowing: isFollowing ?? this.isFollowing,
        followers: followers ?? this.followers,
      );
}

// ===== NOTIFIER: logika =====
class FollowNotifier extends Notifier<FollowState> {
  @override
  FollowState build() => const FollowState(); // state awal

  void toggleFollow() {
    final following = !state.isFollowing;
    state = state.copyWith(
      isFollowing: following,
      followers: state.followers + (following ? 1 : -1),
    );
  }
}

// ===== PROVIDER: pintu akses ke notifier =====
final followProvider =
    NotifierProvider<FollowNotifier, FollowState>(FollowNotifier.new);

void main() => runApp(const ProviderScope(child: DemoApp()));

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const RiverpodDemo(),
    );
  }
}

// ===== UI: ConsumerWidget =====
class RiverpodDemo extends ConsumerWidget {
  const RiverpodDemo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // listen: untuk side effect (Snackbar), bukan untuk menggambar UI
    ref.listen(followProvider.select((s) => s.isFollowing), (prev, next) {
      showFollowSnack(context, next);
    });

    // watch: membaca state dan rebuild saat berubah
    final state = ref.watch(followProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('3 · Riverpod')),
      body: Center(
        child: FollowCard(
          name: 'Fakhry Firdaus',
          followers: state.followers,
          isFollowing: state.isFollowing,
          onFollowPressed: () =>
              ref.read(followProvider.notifier).toggleFollow(),
        ),
      ),
    );
  }
}
