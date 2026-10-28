class AppRoutes {
  AppRoutes._(); // Mencegah class ini dibuat objeknya

  static const splash = '/';
  static const login = '/login';
  static const profile = '/profile';
  static const editProfile = '/profile/edit';
  static const settings = '/profile/settings'; // ⭐ Challenge: Halaman Pengaturan

  /// Path berparameter dibuat lewat fungsi, bukan string manual (Lab 8.2)
  static String projectDetail(String id) => '/profile/projects/$id';
}
