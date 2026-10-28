import 'package:flutter/material.dart';

/// "Dumb widget": hanya menampilkan data dan melaporkan event.
/// Tidak tahu apa pun tentang setState, Provider, Riverpod, Bloc, atau GetX.
class FollowCard extends StatelessWidget {
  const FollowCard({
    super.key,
    required this.name,
    required this.followers,
    required this.isFollowing,
    required this.onFollowPressed,
  });

  final String name;
  final int followers;
  final bool isFollowing;
  final VoidCallback onFollowPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.all(24),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
            const SizedBox(height: 12),
            Text(name, style: textTheme.titleLarge),
            const SizedBox(height: 4),
            Text('$followers pengikut', style: textTheme.bodyMedium),
            const SizedBox(height: 16),
            isFollowing
                ? OutlinedButton.icon(
                    onPressed: onFollowPressed,
                    icon: const Icon(Icons.check),
                    label: const Text('Mengikuti'),
                  )
                : FilledButton.icon(
                    onPressed: onFollowPressed,
                    icon: const Icon(Icons.person_add),
                    label: const Text('Ikuti'),
                  ),
          ],
        ),
      ),
    );
  }
}

/// Helper Snackbar yang dipakai demo 1–4.
void showFollowSnack(BuildContext context, bool isFollowing) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          isFollowing ? 'Kamu mulai mengikuti' : 'Kamu berhenti mengikuti',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
}
