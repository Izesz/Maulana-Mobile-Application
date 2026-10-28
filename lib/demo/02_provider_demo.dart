import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'shared/follow_card.dart';

// ===== MODEL: state + logika, tanpa kode UI =====
class FollowModel extends ChangeNotifier {
  bool _isFollowing = false;
  int _followers = 1200;

  bool get isFollowing => _isFollowing;
  int get followers => _followers;

  void toggleFollow() {
    _isFollowing = !_isFollowing;
    _followers += _isFollowing ? 1 : -1;
    notifyListeners(); // beri tahu semua pendengar
  }
}

void main() => runApp(
      // Sediakan model di atas MaterialApp
      ChangeNotifierProvider(
        create: (_) => FollowModel(),
        child: MaterialApp(
          theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
          home: const ProviderDemo(),
        ),
      ),
    );

// ===== UI: StatelessWidget biasa =====
class ProviderDemo extends StatelessWidget {
  const ProviderDemo({super.key});

  @override
  Widget build(BuildContext context) {
    // watch: dibaca di build() → UI otomatis dibangun ulang
    final model = context.watch<FollowModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('2 · Provider')),
      body: Center(
        child: FollowCard(
          name: 'Fakhry Firdaus',
          followers: model.followers,
          isFollowing: model.isFollowing,
          onFollowPressed: () {
            // read: dipakai di dalam callback, bukan di build()
            final m = context.read<FollowModel>();
            m.toggleFollow();
            showFollowSnack(context, m.isFollowing);
          },
        ),
      ),
    );
  }
}
