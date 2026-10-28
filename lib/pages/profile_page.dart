import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../app/app_routes.dart';
import '../data/auth_service.dart';
import '../data/dummy_data.dart';
import '../models/models.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // State lokal profil (Lab 1)
  Profile _profile = defaultProfile;

  // State pendukung
  bool _isFollowing = false;
  int _followers = 1200;
  bool _isBioExpanded = false;
  bool _isLiked = false;

  // ═══════════════════════════════════════════════════════════════════
  // NAVIGASI (Lab 8 & Challenge)
  // ═══════════════════════════════════════════════════════════════════

  // Lab 8.6 & Challenge ⭐⭐: Buka detail proyek lewat ID di path
  void _openProjectDetail(Project project) {
    context.push(AppRoutes.projectDetail(project.id));
  }

  // Lab 8.6: Buka edit profil via context.push dengan extra
  Future<void> _openEditProfile() async {
    final result = await context.push<Profile>(
      AppRoutes.editProfile,
      extra: _profile,
    );

    if (!mounted || result == null) return;

    setState(() => _profile = result);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profil berhasil diperbarui'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Lab 6.1, Lab 8.6, & 🌟 Bonus Challenge: Logout dengan dialog konfirmasi
  Future<void> _logout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Keluar dari Akun?'),
        content: const Text(
          'Kamu akan keluar dari akun ini dan kembali ke halaman Masuk.',
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      AuthService.instance.logout();
      // Bersihkan stack dan kembali ke Splash / Login
      context.go(AppRoutes.splash);
    }
  }

  void _onFollowPressed() {
    setState(() {
      _isFollowing = !_isFollowing;
      _followers += _isFollowing ? 1 : -1;
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(_isFollowing
              ? 'Kamu mulai mengikuti ${_profile.name}'
              : 'Kamu berhenti mengikuti ${_profile.name}'),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kartu Profil Digital'),
        centerTitle: true,
        actions: [
          // ⭐ Challenge: Buka Halaman Pengaturan
          IconButton(
            tooltip: 'Pengaturan',
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push(AppRoutes.settings),
          ),
          // Lab 3 / 8: Edit Profil
          IconButton(
            tooltip: 'Edit Profil',
            icon: const Icon(Icons.edit_outlined),
            onPressed: _openEditProfile,
          ),
          // Lab 6.1 / 8: Tombol Logout
          IconButton(
            tooltip: 'Keluar',
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          // ── 1. AVATAR & HEADER PROFIL ──
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 52,
                  backgroundColor: colorScheme.primaryContainer,
                  child: const CircleAvatar(
                    radius: 48,
                    backgroundImage: NetworkImage(
                      'https://picsum.photos/seed/profile/300/300',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.verified,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Nama Pengguna
          Center(
            child: Text(
              _profile.name,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // ⭐ Challenge Pertemuan 1: Field Jabatan ditampilkan di bawah nama
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                _profile.jabatan,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // ── 2. STATISTIK PENGGUNA ──
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: colorScheme.outlineVariant.withValues(alpha: 0.5),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatItem('Proyek', '${dummyProjects.length}'),
                  _buildStatItem('Pengikut', '$_followers'),
                  _buildStatItem('Mengikuti', '320'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          // ── 3. TOMBOL IKUTI & SUKA ──
          Row(
            children: [
              Expanded(
                child: _isFollowing
                    ? OutlinedButton.icon(
                        onPressed: _onFollowPressed,
                        icon: const Icon(Icons.check),
                        label: const Text('Mengikuti'),
                      )
                    : FilledButton.icon(
                        onPressed: _onFollowPressed,
                        icon: const Icon(Icons.person_add),
                        label: const Text('Ikuti'),
                      ),
              ),
              const SizedBox(width: 8),
              IconButton.outlined(
                onPressed: () {
                  setState(() => _isLiked = !_isLiked);
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(_isLiked
                            ? 'Menyukai profil ❤️'
                            : 'Batal menyukai profil'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                },
                icon: Icon(
                  _isLiked ? Icons.favorite : Icons.favorite_border,
                  color: _isLiked ? Colors.red : null,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // ── 4. BIO DENGAN BUKA / TUTUP ──
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: colorScheme.outlineVariant.withValues(alpha: 0.5),
              ),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => setState(() => _isBioExpanded = !_isBioExpanded),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline,
                            size: 20, color: colorScheme.primary),
                        const SizedBox(width: 8),
                        Text(
                          'Tentang',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _profile.bio,
                      maxLines: _isBioExpanded ? null : 2,
                      overflow: _isBioExpanded
                          ? TextOverflow.visible
                          : TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          _isBioExpanded ? 'Tutup' : 'Selengkapnya',
                          style: TextStyle(
                            color: colorScheme.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Icon(
                          _isBioExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          size: 16,
                          color: colorScheme.primary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // ── 5. DAFTAR KARTU PROYEK (Lab 1 & 2) ──
          Row(
            children: [
              Icon(Icons.work_outline, size: 20, color: colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                'Proyek Portofolio',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // 3 Kartu Proyek sesuai Lab 1 slide 3/4 & Lab 2
          for (final p in dummyProjects)
            Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: BorderSide(
                  color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                ),
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                // 🌟 Bonus Challenge: Hero Animation pada ikon proyek
                leading: Hero(
                  tag: 'project-icon-${p.id}',
                  child: CircleAvatar(
                    backgroundColor: colorScheme.primaryContainer,
                    child: Icon(
                      Icons.folder_special_rounded,
                      color: colorScheme.primary,
                    ),
                  ),
                ),
                title: Text(
                  p.title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    p.techStack.join(' • '),
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 13,
                    ),
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () => _openProjectDetail(p), // Lab 2
              ),
            ),
          const SizedBox(height: 12),

          // Lab 6.2: Tombol Uji Halaman 404
          Center(
            child: TextButton.icon(
              onPressed: () => context.push('/halaman-ngawur'),
              icon: const Icon(Icons.explore_off_outlined, size: 18),
              label: const Text('Uji Rute 404 (Tidak Ditemukan)'),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
