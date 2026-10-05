// ============================================================
// ProfileProvider – JioPrime, addresses, GST details,
//                   notification preferences.
// ============================================================
import 'package:flutter/foundation.dart';
import '../models/models.dart';
import '../services/storage_service.dart';

class ProfileProvider extends ChangeNotifier {
  final StorageService _storage;

  bool _jioPrime = false;
  List<Address> _addresses = [];
  GstDetails? _gstDetails;
  bool _notifOffers = true;
  bool _notifOrders = true;
  bool _notifDelivery = true;

  ProfileProvider(this._storage) {
    _load();
  }

  bool get jioPrime => _jioPrime;
  List<Address> get addresses => List.unmodifiable(_addresses);
  GstDetails? get gstDetails => _gstDetails;
  Address get defaultAddress {
    try {
      return _addresses.firstWhere((a) => a.isDefault);
    } catch (_) {
      return _addresses.isNotEmpty
          ? _addresses.first
          : Address.defaultKharghar;
    }
  }

  bool get notifOffers => _notifOffers;
  bool get notifOrders => _notifOrders;
  bool get notifDelivery => _notifDelivery;

  void _load() {
    _jioPrime = _storage.jioPrime;
    _addresses = _storage.savedAddresses;
    _gstDetails = _storage.gstDetails;
    _notifOffers = _storage.notifOffers;
    _notifOrders = _storage.notifOrders;
    _notifDelivery = _storage.notifDelivery;
  }

  Future<void> setJioPrime(bool v) async {
    _jioPrime = v;
    await _storage.setJioPrime(v);
    notifyListeners();
  }

  Future<void> addAddress(Address address) async {
    // If new address is default, remove default from others
    if (address.isDefault) {
      _addresses = _addresses
          .map((a) => a.copyWith(isDefault: false))
          .toList();
    }
    _addresses.add(address);
    await _storage.setSavedAddresses(_addresses);
    notifyListeners();
  }

  Future<void> updateAddress(Address address) async {
    if (address.isDefault) {
      _addresses = _addresses
          .map((a) => a.id == address.id ? a : a.copyWith(isDefault: false))
          .toList();
    }
    final idx = _addresses.indexWhere((a) => a.id == address.id);
    if (idx >= 0) {
      _addresses[idx] = address;
      await _storage.setSavedAddresses(_addresses);
      notifyListeners();
    }
  }

  Future<void> deleteAddress(String id) async {
    _addresses.removeWhere((a) => a.id == id);
    await _storage.setSavedAddresses(_addresses);
    notifyListeners();
  }

  Future<void> setDefaultAddress(String id) async {
    _addresses = _addresses
        .map((a) => a.copyWith(isDefault: a.id == id))
        .toList();
    await _storage.setSavedAddresses(_addresses);
    notifyListeners();
  }

  Future<void> setGstDetails(GstDetails? d) async {
    _gstDetails = d;
    await _storage.setGstDetails(d);
    notifyListeners();
  }

  Future<void> setNotifOffers(bool v) async {
    _notifOffers = v;
    await _storage.setNotifOffers(v);
    notifyListeners();
  }

  Future<void> setNotifOrders(bool v) async {
    _notifOrders = v;
    await _storage.setNotifOrders(v);
    notifyListeners();
  }

  Future<void> setNotifDelivery(bool v) async {
    _notifDelivery = v;
    await _storage.setNotifDelivery(v);
    notifyListeners();
  }
}
