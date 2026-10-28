import '../models/models.dart';

const defaultProfile = Profile(
  name: 'Fakhry Firdaus',
  jabatan: 'Software Engineer & Dosen',
  bio: 'Software Engineer & Dosen. Suka berbagi '
      'ilmu tentang Flutter dan aplikasi mobile.',
);

const dummyProjects = <Project>[
  Project(
    id: 'p1',
    title: 'Aplikasi Absensi Kampus',
    description:
        'Presensi berbasis QR code dengan validasi geolokasi mahasiswa dan sinkronisasi presensi real-time.',
    techStack: ['Flutter', 'Firebase', 'Provider'],
  ),
  Project(
    id: 'p2',
    title: 'Katalog UMKM Jember',
    description:
        'Aplikasi katalog digital untuk produk UMKM lokal dengan fitur pencarian, filter kategori, dan kontak langsung.',
    techStack: ['Flutter', 'REST API', 'Riverpod'],
  ),
  Project(
    id: 'p3',
    title: 'Monitoring Kandang Pintar',
    description:
        'Sistem pemantauan suhu, kelembaban, serta kontrol pakan otomatis berbasis IoT dan telemetri data real-time.',
    techStack: ['Flutter', 'MQTT', 'Bloc'],
  ),
];

// Pencari proyek berdasarkan ID (Lab 8.3 & Challenge ⭐⭐)
Project? findProjectById(String id) {
  for (final project in dummyProjects) {
    if (project.id == id) return project;
  }
  return null; // tidak ditemukan
}
