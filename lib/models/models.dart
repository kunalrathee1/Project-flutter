// ============================================================
// Models – all data models for the app.
// ============================================================

// ---- Address model ----
class Address {
  final String id;
  final String label; // Home / Office / Other
  final String name;
  final String phone;
  final String flat;
  final String street;
  final String area;
  final String city;
  final String state;
  final String pincode;
  final bool isDefault;

  const Address({
    required this.id,
    required this.label,
    required this.name,
    required this.phone,
    required this.flat,
    required this.street,
    required this.area,
    required this.city,
    required this.state,
    required this.pincode,
    this.isDefault = false,
  });

  String get fullAddress =>
      '$flat, $street, $area, $city – $pincode, $state';

  String get fullName => name;
  String get flatDoor => flat;
  String get streetLocality => street;
  String get areaColony => area;

  Address copyWith({
    String? id,
    String? label,
    String? name,
    String? phone,
    String? flat,
    String? street,
    String? area,
    String? city,
    String? state,
    String? pincode,
    bool? isDefault,
  }) {
    return Address(
      id: id ?? this.id,
      label: label ?? this.label,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      flat: flat ?? this.flat,
      street: street ?? this.street,
      area: area ?? this.area,
      city: city ?? this.city,
      state: state ?? this.state,
      pincode: pincode ?? this.pincode,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'label': label,
        'name': name,
        'phone': phone,
        'flat': flat,
        'street': street,
        'area': area,
        'city': city,
        'state': state,
        'pincode': pincode,
        'isDefault': isDefault,
      };

  factory Address.fromJson(Map<String, dynamic> j) => Address(
        id: j['id'] as String,
        label: j['label'] as String,
        name: j['name'] as String,
        phone: j['phone'] as String,
        flat: j['flat'] as String,
        street: j['street'] as String,
        area: j['area'] as String,
        city: j['city'] as String,
        state: j['state'] as String,
        pincode: j['pincode'] as String,
        isDefault: j['isDefault'] as bool? ?? false,
      );

  static Address get defaultKharghar => const Address(
        id: 'addr_default',
        label: 'Home',
        name: 'Kunal Sharma',
        phone: '9876543210',
        flat: 'A-204',
        street: 'Sector 12',
        area: 'Kharghar',
        city: 'Navi Mumbai',
        state: 'Maharashtra',
        pincode: '410210',
        isDefault: true,
      );
}

// ---- GstDetails model ----
class GstDetails {
  final String businessName;
  final String gstin;
  final String businessAddress;
  final String email;

  const GstDetails({
    required this.businessName,
    required this.gstin,
    required this.businessAddress,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        'businessName': businessName,
        'gstin': gstin,
        'businessAddress': businessAddress,
        'email': email,
      };

  factory GstDetails.fromJson(Map<String, dynamic> j) => GstDetails(
        businessName: j['businessName'] as String,
        gstin: j['gstin'] as String,
        businessAddress: j['businessAddress'] as String,
        email: j['email'] as String,
      );
}

// ---- User model ----
class AppUser {
  final String phone;
  final String name;
  final bool isGuest;
  final String? avatarUrl;

  const AppUser({
    required this.phone,
    required this.name,
    this.isGuest = false,
    this.avatarUrl,
  });

  AppUser copyWith({
    String? phone,
    String? name,
    bool? isGuest,
    String? avatarUrl,
  }) {
    return AppUser(
      phone: phone ?? this.phone,
      name: name ?? this.name,
      isGuest: isGuest ?? this.isGuest,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}

// ---- Farmer info (for fresh produce) ----
class FarmerInfo {
  final String name;
  final String village;
  final String state;
  final double lat;
  final double lng;
  final String? photoUrl;

  const FarmerInfo({
    required this.name,
    required this.village,
    required this.state,
    required this.lat,
    required this.lng,
    this.photoUrl,
  });
}

// ---- Product Category ----
enum ProductCategory {
  fruits,
  vegetables,
  dairy,
  staples,
  snacks,
  beverages,
}

extension ProductCategoryX on ProductCategory {
  String get displayName {
    switch (this) {
      case ProductCategory.fruits: return 'Fruits';
      case ProductCategory.vegetables: return 'Vegetables';
      case ProductCategory.dairy: return 'Dairy';
      case ProductCategory.staples: return 'Staples';
      case ProductCategory.snacks: return 'Snacks';
      case ProductCategory.beverages: return 'Beverages';
    }
  }

  String get icon {
    switch (this) {
      case ProductCategory.fruits: return '🍎';
      case ProductCategory.vegetables: return '🥦';
      case ProductCategory.dairy: return '🥛';
      case ProductCategory.staples: return '🌾';
      case ProductCategory.snacks: return '🍿';
      case ProductCategory.beverages: return '🥤';
    }
  }
}

// ---- Ripeness enum ----
enum Ripeness { raw, medium, ripe }

extension RipenessX on Ripeness {
  String get label {
    switch (this) {
      case Ripeness.raw: return 'Raw';
      case Ripeness.medium: return 'Medium';
      case Ripeness.ripe: return 'Ripe';
    }
  }

  String get emoji {
    switch (this) {
      case Ripeness.raw: return '🟢';
      case Ripeness.medium: return '🟡';
      case Ripeness.ripe: return '🔴';
    }
  }

  String get helperText {
    switch (this) {
      case Ripeness.raw: return 'Will ripen in 2-3 days at room temp';
      case Ripeness.medium: return 'Perfect for consumption in 1 day';
      case Ripeness.ripe: return 'Ready to eat immediately';
    }
  }
}

// ---- Product Variant ----
class ProductVariant {
  final String id;
  final String label; // e.g. "500g pack", "1 kg pack"
  final double pricePerUnit; // price for this unit
  final double memberPricePerUnit;
  final double packSizeKg; // how many kg in one unit
  final bool isLoose; // true => sold loose by weight
  final bool isOrganic;

  const ProductVariant({
    required this.id,
    required this.label,
    required this.pricePerUnit,
    required this.memberPricePerUnit,
    required this.packSizeKg,
    required this.isLoose,
    this.isOrganic = false,
  });
}

// ---- Product ----
class Product {
  final String id;
  final Map<String, String> names; // locale -> name
  final ProductCategory category;
  final String imageUrl;
  final double gstRate; // 0.0, 0.05, 0.12
  final bool hasFreshnessGuarantee;
  final bool ripeness; // only fruits
  final FarmerInfo? farmer;
  final List<ProductVariant> variants; // first variant = default
  final String? description;

  // Per-store stock: storeId -> stock level 0.0-1.0
  final Map<String, double> storeStock;

  const Product({
    required this.id,
    required this.names,
    required this.category,
    required this.imageUrl,
    required this.gstRate,
    required this.variants,
    this.hasFreshnessGuarantee = false,
    this.ripeness = false,
    this.farmer,
    this.description,
    this.storeStock = const {},
  });

  String nameFor(String locale) => names[locale] ?? names['en'] ?? id;
  String get nameEn => names['en'] ?? id;

  ProductVariant get defaultVariant => variants.first;
  List<ProductVariant> get looseVariants =>
      variants.where((v) => v.isLoose).toList();
  List<ProductVariant> get packedVariants =>
      variants.where((v) => !v.isLoose).toList();

  double stockAt(String storeId) => storeStock[storeId] ?? 0.8;
}

// ---- Delivery Slot ----
class DeliverySlot {
  final int startHour; // 6 means 6 AM
  final DateTime date;
  final int capacity; // total slots
  final int booked; // already booked

  const DeliverySlot({
    required this.startHour,
    required this.date,
    required this.capacity,
    required this.booked,
  });

  int get available => capacity - booked;
  bool get isFull => available <= 0;
  bool get fewLeft => available > 0 && available <= 3;
  bool get isFreeDelivery => startHour == 6 || startHour == 7; // 6-8 AM
  bool get isEarlyBird => startHour >= 6 && startHour < 8;

  /// Is this slot in the past (with 1-hour cutoff)?
  bool isPast(DateTime now) {
    final slotTime =
        DateTime(date.year, date.month, date.day, startHour);
    return slotTime.isBefore(now.add(const Duration(hours: 1)));
  }
}

// ---- Cart Item ----
class CartItem {
  final String id; // unique per cart line
  final Product product;
  final ProductVariant variant;
  final double quantity; // kg for loose, count for packed
  final Ripeness? ripeness;

  const CartItem({
    required this.id,
    required this.product,
    required this.variant,
    required this.quantity,
    this.ripeness,
  });

  CartItem copyWith({double? quantity}) {
    return CartItem(
      id: id,
      product: product,
      variant: variant,
      quantity: quantity ?? this.quantity,
      ripeness: ripeness,
    );
  }

  double linePrice(bool jioPrime) {
    final price = jioPrime
        ? variant.memberPricePerUnit
        : variant.pricePerUnit;
    if (variant.isLoose) {
      return price * quantity; // price is per kg
    } else {
      return price * quantity; // price is per pack
    }
  }
}

// ---- Bill Breakdown (returned by PricingService) ----
class BillBreakdown {
  final double subtotal;
  final double bulkDiscount;
  final double memberDiscount;
  final double deliveryFee;
  final double deliveryFeeWaived; // amount saved on delivery
  final double totalGst;
  final double cgst;
  final double sgst;
  final double grandTotal;
  final double totalSavings;
  final List<LineItemTax> lineItemTaxes;

  const BillBreakdown({
    required this.subtotal,
    required this.bulkDiscount,
    required this.memberDiscount,
    required this.deliveryFee,
    required this.deliveryFeeWaived,
    required this.totalGst,
    required this.cgst,
    required this.sgst,
    required this.grandTotal,
    required this.totalSavings,
    required this.lineItemTaxes,
  });
}

class LineItemTax {
  final String productId;
  final double taxableAmount;
  final double gstRate;
  final double gstAmount;

  const LineItemTax({
    required this.productId,
    required this.taxableAmount,
    required this.gstRate,
    required this.gstAmount,
  });
}

// ---- Order Status ----
enum OrderStatus { confirmed, packing, outForDelivery, delivered, cancelled }

extension OrderStatusX on OrderStatus {
  String get label {
    switch (this) {
      case OrderStatus.confirmed: return 'Order Confirmed';
      case OrderStatus.packing: return 'Packing';
      case OrderStatus.outForDelivery: return 'Out for Delivery';
      case OrderStatus.delivered: return 'Delivered';
      case OrderStatus.cancelled: return 'Cancelled';
    }
  }

  String get description {
    switch (this) {
      case OrderStatus.confirmed: return 'Your order has been placed successfully.';
      case OrderStatus.packing: return 'Store is preparing your order.';
      case OrderStatus.outForDelivery: return 'Delivery partner is on the way.';
      case OrderStatus.delivered: return 'Order delivered successfully!';
      case OrderStatus.cancelled: return 'Order was cancelled.';
    }
  }
}

// ---- Order ----
class Order {
  final String id;
  final DateTime placedAt;
  final List<CartItem> items;
  final Address deliveryAddress;
  final DeliverySlot slot;
  final BillBreakdown bill;
  final OrderStatus status;
  final String storeId;
  final String storeName;
  final bool hasGstInvoice;
  final GstDetails? gstDetails;
  final String paymentMethod;

  const Order({
    required this.id,
    required this.placedAt,
    required this.items,
    required this.deliveryAddress,
    required this.slot,
    required this.bill,
    required this.status,
    required this.storeId,
    required this.storeName,
    this.hasGstInvoice = false,
    this.gstDetails,
    required this.paymentMethod,
  });

  Order copyWith({OrderStatus? status}) {
    return Order(
      id: id,
      placedAt: placedAt,
      items: items,
      deliveryAddress: deliveryAddress,
      slot: slot,
      bill: bill,
      status: status ?? this.status,
      storeId: storeId,
      storeName: storeName,
      hasGstInvoice: hasGstInvoice,
      gstDetails: gstDetails,
      paymentMethod: paymentMethod,
    );
  }

  bool get isOngoing =>
      status == OrderStatus.confirmed ||
      status == OrderStatus.packing ||
      status == OrderStatus.outForDelivery;
}

// ---- Store ----
class StoreInfo {
  final String id;
  final String name;
  final String code;
  final String address;
  final String area;
  final String city;
  final String pincode;
  final String phone;
  final double lat;
  final double lng;
  final String zoneCode; // maps to AppConstants.zoneMultipliers
  final Map<ProductCategory, double> inventoryLevels; // 0.0-1.0 per category
  final int openHour;
  final int closeHour;

  const StoreInfo({
    required this.id,
    required this.name,
    required this.code,
    required this.address,
    required this.area,
    required this.city,
    required this.pincode,
    required this.phone,
    required this.lat,
    required this.lng,
    required this.zoneCode,
    required this.inventoryLevels,
    this.openHour = 7,
    this.closeHour = 23,
  });

  bool isOpen(DateTime now) {
    final h = now.hour;
    return h >= openHour && h < closeHour;
  }

  double get overallInventory {
    if (inventoryLevels.isEmpty) return 0.8;
    return inventoryLevels.values.reduce((a, b) => a + b) /
        inventoryLevels.length;
  }
}
