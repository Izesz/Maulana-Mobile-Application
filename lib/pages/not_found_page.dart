import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../app/app_routes.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Oops!')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.explore_off, size: 72, color: colorScheme.error),
              const SizedBox(height: 16),
              Text(
                'Halaman Tidak Ditemukan',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Alamat atau parameter halaman yang kamu cari tidak tersedia.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () => context.go(AppRoutes.profile),
                icon: const Icon(Icons.home),
                label: const Text('Ke Beranda'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
