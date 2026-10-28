import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/models.dart';

class EditProfilePage extends StatefulWidget {
  final Profile profile;

  const EditProfilePage({
    super.key,
    required this.profile,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _jabatanController;
  late final TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    // Isi awal form dari data constructor
    _nameController = TextEditingController(text: widget.profile.name);
    _jabatanController = TextEditingController(text: widget.profile.jabatan);
    _bioController = TextEditingController(text: widget.profile.bio);
  }

  @override
  void dispose() {
    // dispose() controller itu wajib agar tidak memory leak
    _nameController.dispose();
    _jabatanController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  // ⭐⭐⭐ Cek apakah formulir telah mengalami perubahan data
  bool get _hasChanged {
    return _nameController.text.trim() != widget.profile.name.trim() ||
        _jabatanController.text.trim() != widget.profile.jabatan.trim() ||
        _bioController.text.trim() != widget.profile.bio.trim();
  }

  // ⭐⭐⭐ Dialog konfirmasi saat pengguna ingin membatalkan/kembali jika ada perubahan
  Future<bool> _confirmDiscardChanges() async {
    if (!_hasChanged) return true;

    final discard = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Buang perubahan?'),
        content: const Text(
          'Perubahan yang belum disimpan akan hilang jika kamu keluar dari halaman ini.',
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Tetap Edit'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Buang Perubahan'),
          ),
        ],
      ),
    );

    return discard ?? false;
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final updated = widget.profile.copyWith(
      name: _nameController.text.trim(),
      jabatan: _jabatanController.text.trim(),
      bio: _bioController.text.trim(),
    );

    // Tutup halaman SEKALIGUS kirim hasil data baru ke pemanggil
    context.pop(updated);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await _confirmDiscardChanges();
        if (shouldPop && context.mounted) {
          context.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profil'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Input Nama
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nama',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Nama tidak boleh kosong'
                      : null,
                ),
                const SizedBox(height: 16),

                // ⭐ Challenge: Input Jabatan / Pekerjaan
                TextFormField(
                  controller: _jabatanController,
                  decoration: const InputDecoration(
                    labelText: 'Jabatan / Profesi',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.badge_outlined),
                  ),
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Jabatan tidak boleh kosong'
                      : null,
                ),
                const SizedBox(height: 16),

                // Input Bio
                TextFormField(
                  controller: _bioController,
                  decoration: const InputDecoration(
                    labelText: 'Bio',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(bottom: 50),
                      child: Icon(Icons.description_outlined),
                    ),
                  ),
                  maxLines: 4,
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Bio tidak boleh kosong'
                      : null,
                ),
                const SizedBox(height: 24),

                // Tombol Aksi (Batal & Simpan)
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () async {
                          final shouldPop = await _confirmDiscardChanges();
                          if (shouldPop && context.mounted) {
                            context.pop();
                          }
                        },
                        child: const Text('Batal'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        onPressed: _save,
                        child: const Text('Simpan'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
