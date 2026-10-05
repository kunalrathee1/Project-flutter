// ============================================================
// StoreProvider – manages selected store + user location.
// ============================================================
import 'package:flutter/foundation.dart';
import '../models/models.dart';
import '../data/mock_stores.dart';
import '../services/location_service.dart';
import '../services/storage_service.dart';
import '../core/app_constants.dart';

enum StoreLoadState { idle, loading, done, error }

class StoreProvider extends ChangeNotifier {
  final StorageService _storage;
  final LocationService _locationService;

  StoreLoadState _loadState = StoreLoadState.idle;
  double _userLat = AppConstants.defaultLat;
  double _userLng = AppConstants.defaultLng;
  bool _usingDefaultLocation = true;
  String? _locationError;
  StoreInfo? _selectedStore;

  // Stores sorted by distance from user
  List<_StoreWithDistance> _storesWithDistance = [];

  StoreProvider(this._storage, this._locationService) {
    _initSelectedStore();
  }

  StoreLoadState get loadState => _loadState;
  double get userLat => _userLat;
  double get userLng => _userLng;
  bool get usingDefaultLocation => _usingDefaultLocation;
  String? get locationError => _locationError;
  StoreInfo? get selectedStore => _selectedStore;
  List<StoreInfo> get stores =>
      _storesWithDistance.map((s) => s.store).toList();
  List<StoreInfo> get allStores => mockStores;

  double distanceToStore(StoreInfo store) {
    return _storesWithDistance
        .firstWhere(
          (s) => s.store.id == store.id,
          orElse: () => _StoreWithDistance(store, 0),
        )
        .distanceMeters;
  }

  double get zoneMultiplier {
    final code = _selectedStore?.zoneCode ?? 'default';
    return AppConstants.zoneMultipliers[code] ?? 1.0;
  }

  void _initSelectedStore() {
    final id = _storage.selectedStoreId;
    if (id != null) {
      try {
        _selectedStore = mockStores.firstWhere((s) => s.id == id);
      } catch (_) {}
    }
    _storesWithDistance =
        mockStores.map((s) => _StoreWithDistance(s, 0)).toList();
  }

  Future<void> loadLocation() async {
    _loadState = StoreLoadState.loading;
    notifyListeners();

    final result = await _locationService.getCurrentLocation();
    _userLat = result.lat;
    _userLng = result.lng;
    _usingDefaultLocation = result.isDefault;
    _locationError = result.errorMessage;

    _computeDistances();
    _loadState = StoreLoadState.done;
    notifyListeners();
  }

  void _computeDistances() {
    _storesWithDistance = mockStores
        .map((s) => _StoreWithDistance(
              s,
              _locationService.distanceBetween(
                _userLat,
                _userLng,
                s.lat,
                s.lng,
              ),
            ))
        .toList()
      ..sort((a, b) => a.distanceMeters.compareTo(b.distanceMeters));
  }

  List<StoreInfo> searchStores(String query) {
    if (query.trim().isEmpty) return stores;
    final q = query.trim().toLowerCase();
    return stores.where((s) {
      return s.name.toLowerCase().contains(q) ||
          s.area.toLowerCase().contains(q) ||
          s.pincode.contains(q) ||
          s.city.toLowerCase().contains(q);
    }).toList();
  }

  Future<void> selectStore(StoreInfo store) async {
    _selectedStore = store;
    await _storage.setSelectedStoreId(store.id);
    notifyListeners();
  }
}

class _StoreWithDistance {
  final StoreInfo store;
  final double distanceMeters;
  _StoreWithDistance(this.store, this.distanceMeters);
}
