import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // ⭐ Challenge: Switch pengaturan profil (misalnya: Tampilkan Bio & Notifikasi)
  bool _showBio = true;
  bool _enableNotifications = true;
  bool _isPublicProfile = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('Tampilkan Bio'),
                    subtitle: const Text('Tampilkan ringkasan bio di kartu profil'),
                    secondary: const Icon(Icons.info_outline),
                    value: _showBio,
                    onChanged: (val) {
                      setState(() => _showBio = val);
                    },
                  ),
                  const Divider(),
                  SwitchListTile(
                    title: const Text('Profil Publik'),
                    subtitle:
                        const Text('Izinkan orang lain menemukan profil Anda'),
                    secondary: const Icon(Icons.public),
                    value: _isPublicProfile,
                    onChanged: (val) {
                      setState(() => _isPublicProfile = val);
                    },
                  ),
                  const Divider(),
                  SwitchListTile(
                    title: const Text('Notifikasi'),
                    subtitle:
                        const Text('Terima pemberitahuan proyek dan portofolio'),
                    secondary: const Icon(Icons.notifications_outlined),
                    value: _enableNotifications,
                    onChanged: (val) {
                      setState(() => _enableNotifications = val);
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: Text(
              'Versi Aplikasi 1.0.0 (Lab 8)',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
