import 'package:flutter/foundation.dart';

class AuthService extends ChangeNotifier {
  static final AuthService instance = AuthService._();
  AuthService._();

  // ⭐⭐⭐ Challenge: Status Login pengguna
  // Default true agar pengguna langsung dapat mengakses profil setelah Splash,
  // dan saat menekan tombol Keluar akan mengubah isLoggedIn menjadi false.
  bool _isLoggedIn = true;
  bool get isLoggedIn => _isLoggedIn;

  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}
