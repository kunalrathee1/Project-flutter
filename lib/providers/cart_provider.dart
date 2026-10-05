// ============================================================
// CartProvider – manages cart state with persistence.
// ============================================================
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../models/models.dart';
import '../services/storage_service.dart';
import '../services/pricing_service.dart';
import '../data/mock_products.dart';

class CartProvider extends ChangeNotifier {
  final StorageService _storage;
  final PricingService _pricingService;

  List<CartItem> _items = [];
  DeliverySlot? _selectedSlot;
  bool _jioPrime = false;
  double _zoneMultiplier = 1.0;

  CartProvider(this._storage, this._pricingService) {
    _jioPrime = _storage.jioPrime;
    _loadFromStorage();
  }

  List<CartItem> get items => List.unmodifiable(_items);
  DeliverySlot? get selectedSlot => _selectedSlot;
  int get itemCount => _items.length;
  int get totalQuantityCount =>
      _items.fold(0, (sum, i) => sum + i.quantity.ceil());

  bool get isEmpty => _items.isEmpty;

  BillBreakdown get bill => _pricingService.compute(
        items: _items,
        jioPrime: _jioPrime,
        zoneMultiplier: _zoneMultiplier,
        slot: _selectedSlot,
      );

  void updateJioPrime(bool v) {
    _jioPrime = v;
    notifyListeners();
  }

  void updateZoneMultiplier(double z) {
    _zoneMultiplier = z;
    notifyListeners();
  }

  void setSlot(DeliverySlot slot) {
    _selectedSlot = slot;
    notifyListeners();
  }

  void clearSlot() {
    _selectedSlot = null;
    notifyListeners();
  }

  /// Add or increment a cart item. Same product+variant+ripeness = one line.
  void addItem({
    required Product product,
    required ProductVariant variant,
    required double quantity,
    Ripeness? ripeness,
  }) {
    // Find existing line
    final idx = _items.indexWhere(
      (i) =>
          i.product.id == product.id &&
          i.variant.id == variant.id &&
          i.ripeness == ripeness,
    );
    if (idx >= 0) {
      _items[idx] = _items[idx].copyWith(
        quantity: _items[idx].quantity + quantity,
      );
    } else {
      _items.add(CartItem(
        id: '${product.id}_${variant.id}_${ripeness?.name ?? 'none'}_${DateTime.now().millisecondsSinceEpoch}',
        product: product,
        variant: variant,
        quantity: quantity,
        ripeness: ripeness,
      ));
    }
    _save();
    HapticFeedback.lightImpact();
    notifyListeners();
  }

  void updateQuantity(String cartItemId, double newQty) {
    if (newQty <= 0) {
      removeItem(cartItemId);
      return;
    }
    final idx = _items.indexWhere((i) => i.id == cartItemId);
    if (idx >= 0) {
      _items[idx] = _items[idx].copyWith(quantity: newQty);
      _save();
      notifyListeners();
    }
  }

  void removeItem(String cartItemId) {
    _items.removeWhere((i) => i.id == cartItemId);
    _save();
    HapticFeedback.mediumImpact();
    notifyListeners();
  }

  void clearCart() {
    _items = [];
    _selectedSlot = null;
    _storage.clearCart();
    notifyListeners();
  }

  double quantityOf(String productId, String variantId, Ripeness? ripeness) {
    try {
      return _items.firstWhere(
        (i) =>
            i.product.id == productId &&
            i.variant.id == variantId &&
            i.ripeness == ripeness,
      ).quantity;
    } catch (_) {
      return 0;
    }
  }

  bool containsProduct(String productId) =>
      _items.any((i) => i.product.id == productId);

  // ---- Persistence ----
  void _save() {
    try {
      final data = _items
          .map((i) => {
                'productId': i.product.id,
                'variantId': i.variant.id,
                'quantity': i.quantity,
                'ripeness': i.ripeness?.name,
              })
          .toList();
      _storage.setCartJson(jsonEncode(data));
    } catch (_) {}
  }

  void _loadFromStorage() {
    final raw = _storage.cartJson;
    if (raw == null) return;
    try {
      final data = jsonDecode(raw) as List;
      _items = data.map((e) {
        final m = e as Map<String, dynamic>;
        final product = mockProducts.firstWhere(
          (p) => p.id == m['productId'],
          orElse: () => throw Exception('Product not found'),
        );
        final variant = product.variants.firstWhere(
          (v) => v.id == m['variantId'],
          orElse: () => product.variants.first,
        );
        final ripenessStr = m['ripeness'] as String?;
        Ripeness? ripeness;
        if (ripenessStr != null) {
          ripeness = Ripeness.values.firstWhere(
            (r) => r.name == ripenessStr,
            orElse: () => Ripeness.medium,
          );
        }
        return CartItem(
          id: '${product.id}_${variant.id}_${ripeness?.name ?? 'none'}_restore',
          product: product,
          variant: variant,
          quantity: (m['quantity'] as num).toDouble(),
          ripeness: ripeness,
        );
      }).toList();
    } catch (_) {
      _items = [];
    }
  }
}
