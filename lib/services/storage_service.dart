// ============================================================
// StorageService – thin wrapper over SharedPreferences.
// ============================================================
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/app_constants.dart';
import '../models/models.dart';

class StorageService {
  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ---- Session ----
  String? get phone => _prefs.getString(AppConstants.prefPhone);
  String? get userName => _prefs.getString(AppConstants.prefName);
  bool get isGuest => _prefs.getBool(AppConstants.prefIsGuest) ?? false;
  bool get isLoggedIn => phone != null || isGuest;

  Future<void> saveSession({
    required String phone,
    required String name,
    bool isGuest = false,
  }) async {
    await _prefs.setString(AppConstants.prefPhone, phone);
    await _prefs.setString(AppConstants.prefName, name);
    await _prefs.setBool(AppConstants.prefIsGuest, isGuest);
    await _prefs.setBool(AppConstants.prefOnboardingDone, true);
  }

  Future<void> saveGuestSession() async {
    await _prefs.setString(AppConstants.prefPhone, '');
    await _prefs.setString(AppConstants.prefName, 'Guest');
    await _prefs.setBool(AppConstants.prefIsGuest, true);
    await _prefs.setBool(AppConstants.prefOnboardingDone, true);
  }

  Future<void> clearSession() async {
    await _prefs.remove(AppConstants.prefPhone);
    await _prefs.remove(AppConstants.prefName);
    await _prefs.remove(AppConstants.prefIsGuest);
    await _prefs.remove(AppConstants.prefOnboardingDone);
    await _prefs.remove(AppConstants.prefJioPrime);
  }

  bool get onboardingDone =>
      _prefs.getBool(AppConstants.prefOnboardingDone) ?? false;

  // ---- Language ----
  String get language => _prefs.getString(AppConstants.prefLanguage) ?? 'en';
  Future<void> setLanguage(String code) =>
      _prefs.setString(AppConstants.prefLanguage, code);

  // ---- Store ----
  String? get selectedStoreId =>
      _prefs.getString(AppConstants.prefSelectedStoreId);
  Future<void> setSelectedStoreId(String id) =>
      _prefs.setString(AppConstants.prefSelectedStoreId, id);

  // ---- JioPrime ----
  bool get jioPrime => _prefs.getBool(AppConstants.prefJioPrime) ?? false;
  Future<void> setJioPrime(bool v) =>
      _prefs.setBool(AppConstants.prefJioPrime, v);

  // ---- Cart (persisted as JSON string) ----
  String? get cartJson => _prefs.getString(AppConstants.prefCart);
  Future<void> setCartJson(String json) =>
      _prefs.setString(AppConstants.prefCart, json);
  Future<void> clearCart() => _prefs.remove(AppConstants.prefCart);

  // ---- Orders ----
  List<Map<String, dynamic>> get ordersJson {
    final raw = _prefs.getString(AppConstants.prefOrders);
    if (raw == null) return [];
    try {
      return List<Map<String, dynamic>>.from(jsonDecode(raw) as List);
    } catch (_) {
      return [];
    }
  }

  Future<void> setOrdersJson(List<Map<String, dynamic>> data) =>
      _prefs.setString(AppConstants.prefOrders, jsonEncode(data));

  // ---- Addresses ----
  List<Address> get savedAddresses {
    final raw = _prefs.getString(AppConstants.prefAddresses);
    if (raw == null) return [Address.defaultKharghar];
    try {
      final list = jsonDecode(raw) as List;
      return list
          .map((e) => Address.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [Address.defaultKharghar];
    }
  }

  Future<void> setSavedAddresses(List<Address> addresses) =>
      _prefs.setString(
        AppConstants.prefAddresses,
        jsonEncode(addresses.map((a) => a.toJson()).toList()),
      );

  // ---- GST Details ----
  GstDetails? get gstDetails {
    final raw = _prefs.getString(AppConstants.prefGstDetails);
    if (raw == null) return null;
    try {
      return GstDetails.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  Future<void> setGstDetails(GstDetails? d) async {
    if (d == null) {
      await _prefs.remove(AppConstants.prefGstDetails);
    } else {
      await _prefs.setString(AppConstants.prefGstDetails, jsonEncode(d.toJson()));
    }
  }

  // ---- Notification prefs ----
  bool get notifOffers => _prefs.getBool(AppConstants.prefNotifOffers) ?? true;
  bool get notifOrders => _prefs.getBool(AppConstants.prefNotifOrders) ?? true;
  bool get notifDelivery =>
      _prefs.getBool(AppConstants.prefNotifDelivery) ?? true;
  Future<void> setNotifOffers(bool v) =>
      _prefs.setBool(AppConstants.prefNotifOffers, v);
  Future<void> setNotifOrders(bool v) =>
      _prefs.setBool(AppConstants.prefNotifOrders, v);
  Future<void> setNotifDelivery(bool v) =>
      _prefs.setBool(AppConstants.prefNotifDelivery, v);
}
