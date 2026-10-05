// ============================================================
// LanguageProvider – manages app locale with live switching.
// ============================================================
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class LanguageProvider extends ChangeNotifier {
  final StorageService _storage;
  late Locale _locale;

  LanguageProvider(this._storage) {
    _locale = Locale(_storage.language);
  }

  Locale get locale => _locale;
  String get languageCode => _locale.languageCode;

  Future<void> setLanguage(String code) async {
    _locale = Locale(code);
    await _storage.setLanguage(code);
    notifyListeners();
  }
}
