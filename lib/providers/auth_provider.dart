// ============================================================
// AuthProvider – manages user session state.
// ============================================================
import 'package:flutter/foundation.dart';
import '../models/models.dart';
import '../services/storage_service.dart';

class AuthProvider extends ChangeNotifier {
  final StorageService _storage;

  AppUser? _user;
  bool _isLoading = false;

  AuthProvider(this._storage) {
    _loadFromStorage();
  }

  AppUser? get user => _user;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _user != null;
  bool get isGuest => _user?.isGuest ?? false;
  bool get isRealUser => isLoggedIn && !isGuest;

  void _loadFromStorage() {
    if (_storage.isLoggedIn) {
      _user = AppUser(
        phone: _storage.phone ?? '',
        name: _storage.userName ?? 'Guest',
        isGuest: _storage.isGuest,
      );
    }
  }

  Future<void> loginWithPhone({
    required String phone,
    required String name,
  }) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));
    await _storage.saveSession(phone: phone, name: name);
    _user = AppUser(phone: phone, name: name);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> continueAsGuest() async {
    await _storage.saveGuestSession();
    _user = const AppUser(phone: '', name: 'Guest', isGuest: true);
    notifyListeners();
  }

  Future<void> logout() async {
    await _storage.clearSession();
    _user = null;
    notifyListeners();
  }

  Future<void> updateProfile({required String name}) async {
    if (_user == null) return;
    await _storage.saveSession(
      phone: _user!.phone,
      name: name,
      isGuest: _user!.isGuest,
    );
    _user = _user!.copyWith(name: name);
    notifyListeners();
  }

  /// Upgrade guest to real user after OTP verified
  Future<void> upgradeGuest({required String phone, required String name}) async {
    await _storage.saveSession(phone: phone, name: name, isGuest: false);
    _user = AppUser(phone: phone, name: name);
    notifyListeners();
  }
}
