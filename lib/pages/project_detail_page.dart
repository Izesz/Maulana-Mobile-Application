import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/models.dart';

class ProjectDetailPage extends StatelessWidget {
  final Project project;

  const ProjectDetailPage({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(project.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🌟 Bonus Challenge: Hero Animation pada ikon proyek
            Center(
              child: Hero(
                tag: 'project-icon-${project.id}',
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.folder_special_rounded,
                    size: 48,
                    color: colorScheme.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Judul Proyek
            Text(
              project.title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // Deskripsi
            Text(
              project.description,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 24),

            // Tech Stack Section
            Text(
              'Teknologi yang Digunakan:',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: project.techStack.map((tech) {
                return Chip(
                  avatar: Icon(
                    Icons.check_circle_outline,
                    size: 16,
                    color: colorScheme.primary,
                  ),
                  label: Text(tech),
                  backgroundColor: colorScheme.secondaryContainer.withValues(alpha: 0.5),
                  side: BorderSide.none,
                );
              }).toList(),
            ),
            const SizedBox(height: 36),

            // Tombol Kembali
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton.icon(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Kembali'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
