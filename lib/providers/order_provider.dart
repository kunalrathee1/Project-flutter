// ============================================================
// OrderProvider – saves/loads orders, manages status progression.
// ============================================================
import 'package:flutter/foundation.dart';
import '../models/models.dart';
import '../services/storage_service.dart';
import '../data/mock_products.dart';

class OrderProvider extends ChangeNotifier {
  final StorageService _storage;

  List<Order> _orders = [];
  int _nextSeq = 1;

  OrderProvider(this._storage) {
    _load();
  }

  List<Order> get orders => List.unmodifiable(_orders);
  List<Order> get ongoingOrders =>
      _orders.where((o) => o.isOngoing).toList();
  List<Order> get pastOrders =>
      _orders.where((o) => !o.isOngoing).toList();

  Order? orderById(String id) {
    try {
      return _orders.firstWhere((o) => o.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<String> placeOrder({
    required List<CartItem> items,
    required Address deliveryAddress,
    required DeliverySlot slot,
    required BillBreakdown bill,
    required String storeId,
    required String storeName,
    bool hasGstInvoice = false,
    GstDetails? gstDetails,
    required String paymentMethod,
  }) async {
    final now = DateTime.now();
    final id = _generateId(now);

    final order = Order(
      id: id,
      placedAt: now,
      items: items,
      deliveryAddress: deliveryAddress,
      slot: slot,
      bill: bill,
      status: OrderStatus.confirmed,
      storeId: storeId,
      storeName: storeName,
      hasGstInvoice: hasGstInvoice,
      gstDetails: gstDetails,
      paymentMethod: paymentMethod,
    );

    _orders.insert(0, order);
    _nextSeq++;
    await _save();
    notifyListeners();
    return id;
  }

  Future<void> updateOrderStatus(String orderId, OrderStatus status) async {
    final idx = _orders.indexWhere((o) => o.id == orderId);
    if (idx >= 0) {
      _orders[idx] = _orders[idx].copyWith(status: status);
      await _save();
      notifyListeners();
    }
  }

  String _generateId(DateTime ts) {
    final dateStr =
        '${ts.year}${ts.month.toString().padLeft(2, '0')}${ts.day.toString().padLeft(2, '0')}';
    final seq = _nextSeq.toString().padLeft(4, '0');
    return 'RSB-$dateStr-$seq';
  }

  // ---- Serialization ----
  // NOTE: Full serialization of Product objects is complex. We store minimal
  // data and reconstruct from mockProducts on load.
  Future<void> _save() async {
    try {
      final data = _orders.map(_orderToJson).toList();
      await _storage.setOrdersJson(data);
    } catch (_) {}
  }

  void _load() {
    try {
      final rawList = _storage.ordersJson;
      _orders = rawList
          .map(_orderFromJson)
          .whereType<Order>()
          .toList();
      if (_orders.isNotEmpty) {
        _nextSeq = _orders.length + 1;
      }
    } catch (_) {
      _orders = [];
    }
  }

  Map<String, dynamic> _orderToJson(Order o) => {
        'id': o.id,
        'placedAt': o.placedAt.toIso8601String(),
        'status': o.status.name,
        'storeId': o.storeId,
        'storeName': o.storeName,
        'hasGstInvoice': o.hasGstInvoice,
        'paymentMethod': o.paymentMethod,
        'address': o.deliveryAddress.toJson(),
        'slot': {
          'startHour': o.slot.startHour,
          'date': o.slot.date.toIso8601String(),
          'capacity': o.slot.capacity,
          'booked': o.slot.booked,
        },
        'bill': {
          'subtotal': o.bill.subtotal,
          'bulkDiscount': o.bill.bulkDiscount,
          'memberDiscount': o.bill.memberDiscount,
          'deliveryFee': o.bill.deliveryFee,
          'deliveryFeeWaived': o.bill.deliveryFeeWaived,
          'totalGst': o.bill.totalGst,
          'cgst': o.bill.cgst,
          'sgst': o.bill.sgst,
          'grandTotal': o.bill.grandTotal,
          'totalSavings': o.bill.totalSavings,
        },
        'items': o.items
            .map((i) => {
                  'productId': i.product.id,
                  'variantId': i.variant.id,
                  'quantity': i.quantity,
                  'ripeness': i.ripeness?.name,
                })
            .toList(),
        'gstDetails': o.gstDetails?.toJson(),
      };

  Order? _orderFromJson(Map<String, dynamic> m) {
    try {
      final items = (m['items'] as List).map((e) {
        final em = e as Map<String, dynamic>;
        final product = mockProducts.firstWhere(
          (p) => p.id == em['productId'],
        );
        final variant = product.variants.firstWhere(
          (v) => v.id == em['variantId'],
          orElse: () => product.variants.first,
        );
        final ripenessStr = em['ripeness'] as String?;
        Ripeness? ripeness;
        if (ripenessStr != null) {
          ripeness = Ripeness.values.firstWhere(
            (r) => r.name == ripenessStr,
            orElse: () => Ripeness.medium,
          );
        }
        return CartItem(
          id: '${product.id}_${variant.id}_restore',
          product: product,
          variant: variant,
          quantity: (em['quantity'] as num).toDouble(),
          ripeness: ripeness,
        );
      }).toList();

      final slotMap = m['slot'] as Map<String, dynamic>;
      final slot = DeliverySlot(
        startHour: slotMap['startHour'] as int,
        date: DateTime.parse(slotMap['date'] as String),
        capacity: slotMap['capacity'] as int,
        booked: slotMap['booked'] as int,
      );

      final billMap = m['bill'] as Map<String, dynamic>;
      final bill = BillBreakdown(
        subtotal: (billMap['subtotal'] as num).toDouble(),
        bulkDiscount: (billMap['bulkDiscount'] as num).toDouble(),
        memberDiscount: (billMap['memberDiscount'] as num).toDouble(),
        deliveryFee: (billMap['deliveryFee'] as num).toDouble(),
        deliveryFeeWaived: (billMap['deliveryFeeWaived'] as num).toDouble(),
        totalGst: (billMap['totalGst'] as num).toDouble(),
        cgst: (billMap['cgst'] as num).toDouble(),
        sgst: (billMap['sgst'] as num).toDouble(),
        grandTotal: (billMap['grandTotal'] as num).toDouble(),
        totalSavings: (billMap['totalSavings'] as num).toDouble(),
        lineItemTaxes: [],
      );

      final gstMap = m['gstDetails'] as Map<String, dynamic>?;
      GstDetails? gstDetails;
      if (gstMap != null) {
        gstDetails = GstDetails.fromJson(gstMap);
      }

      return Order(
        id: m['id'] as String,
        placedAt: DateTime.parse(m['placedAt'] as String),
        items: items,
        deliveryAddress:
            Address.fromJson(m['address'] as Map<String, dynamic>),
        slot: slot,
        bill: bill,
        status: OrderStatus.values.firstWhere(
          (s) => s.name == m['status'],
          orElse: () => OrderStatus.confirmed,
        ),
        storeId: m['storeId'] as String,
        storeName: m['storeName'] as String,
        hasGstInvoice: m['hasGstInvoice'] as bool? ?? false,
        gstDetails: gstDetails,
        paymentMethod: m['paymentMethod'] as String? ?? 'COD',
      );
    } catch (e) {
      return null;
    }
  }
}
