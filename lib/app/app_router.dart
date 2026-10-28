import 'package:go_router/go_router.dart';
import '../data/auth_service.dart';
import '../data/dummy_data.dart';
import '../models/models.dart';
import '../pages/edit_profile_page.dart';
import '../pages/login_page.dart';
import '../pages/not_found_page.dart';
import '../pages/profile_page.dart';
import '../pages/project_detail_page.dart';
import '../pages/settings_page.dart';
import '../pages/splash_page.dart';
import 'app_routes.dart';
import 'log_observer.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  debugLogDiagnostics: true, // Cetak log navigasi di Debug Console (Lab 8.4)
  observers: [LogObserver()], // Mengintip stack lewat NavigatorObserver (Lab 7)
  refreshListenable: AuthService.instance, // Pantau perubahan login/logout

  // ⭐⭐⭐ Challenge: Redirect & Guard Autentikasi
  redirect: (context, state) {
    final loggedIn = AuthService.instance.isLoggedIn;
    final atLogin = state.matchedLocation == AppRoutes.login;
    final atSplash = state.matchedLocation == AppRoutes.splash;

    // Splash screen selalu diizinkan tampil
    if (atSplash) return null;

    // Jika belum login dan belum di halaman login, paksa ke halaman login
    if (!loggedIn && !atLogin) {
      return AppRoutes.login;
    }

    // Jika sudah login tapi berada di halaman login, arahkan ke profil
    if (loggedIn && atLogin) {
      return AppRoutes.profile;
    }

    return null; // Lanjutkan navigasi normal
  },

  // Pengganti halaman 404 (Lab 5.3 & 8.4)
  errorBuilder: (context, state) => const NotFoundPage(),

  routes: [
    // ── Splash Screen (Lab 4) ──
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashPage(),
    ),

    // ── Login Page (Challenge ⭐⭐⭐) ──
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginPage(),
    ),

    // ── Profil Utama & Rute Anak (Lab 8.4) ──
    GoRoute(
      path: AppRoutes.profile,
      builder: (context, state) => const ProfilePage(),
      routes: [
        // ⭐⭐ Challenge & Lab 8.4: Path berparameter untuk Detail Proyek
        GoRoute(
          path: 'projects/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            final project = findProjectById(id);
            if (project == null) return const NotFoundPage();
            return ProjectDetailPage(project: project);
          },
        ),

        // Lab 8.4: Edit Profil dengan penerimaan objek Profile via `extra`
        GoRoute(
          path: 'edit',
          builder: (context, state) {
            final profile = state.extra;
            if (profile is! Profile) return const NotFoundPage();
            return EditProfilePage(profile: profile);
          },
        ),

        // ⭐ Challenge: Halaman Pengaturan (/profile/settings)
        GoRoute(
          path: 'settings',
          builder: (context, state) => const SettingsPage(),
        ),
      ],
    ),
  ],
);
