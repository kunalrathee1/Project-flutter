// ============================================================
// PricingService – pure Dart, single source of truth for billing.
// Order: line price → subtotal → bulk discount → member discount
//        → delivery fee → GST per line → grand total.
// ============================================================
import '../models/models.dart';
import '../core/app_constants.dart';

class PricingService {
  /// Compute full bill breakdown.
  ///
  /// [items]       – cart items
  /// [jioPrime]    – is JioPrime active (affects member discount only)
  /// [zoneMultiplier] – from selected store's zone
  /// [slot]        – selected delivery slot (for delivery fee and early bird)
  BillBreakdown compute({
    required List<CartItem> items,
    required bool jioPrime,
    double zoneMultiplier = 1.0,
    DeliverySlot? slot,
  }) {
    if (items.isEmpty) {
      return const BillBreakdown(
        subtotal: 0,
        bulkDiscount: 0,
        memberDiscount: 0,
        deliveryFee: 0,
        deliveryFeeWaived: 0,
        totalGst: 0,
        cgst: 0,
        sgst: 0,
        grandTotal: 0,
        totalSavings: 0,
        lineItemTaxes: [],
      );
    }

    // ---- Step 1: Line prices (base price × zone multiplier × qty) ----
    // Note: member price already IS the discounted base – we use it per line
    // only as the taxable unit; the 5% member discount is applied at cart level
    // in step 4 so the bill shows it as a single discount line.
    double subtotal = 0;
    for (final item in items) {
      final basePrice = item.variant.pricePerUnit * zoneMultiplier;
      final lineTotal = basePrice * item.quantity;
      subtotal += lineTotal;
    }
    subtotal = _round(subtotal);

    // ---- Step 2: Bulk discount (5% if subtotal > ₹2000) ----
    final bulkDiscount = subtotal > AppConstants.bulkDiscountThreshold
        ? _round(subtotal * AppConstants.bulkDiscountRate)
        : 0.0;

    // ---- Step 3: Amount after bulk ----
    final afterBulk = _round(subtotal - bulkDiscount);

    // ---- Step 4: Member discount (5% off afterBulk if JioPrime ON) ----
    final memberDiscount =
        jioPrime ? _round(afterBulk * AppConstants.memberDiscountRate) : 0.0;

    final afterMember = _round(afterBulk - memberDiscount);

    // ---- Step 5: Delivery fee ----
    final isEarlyBird = slot != null && slot.isEarlyBird;
    final isFreeByAmount = afterMember >= AppConstants.freeDeliveryThreshold;
    double deliveryFee = 0;
    double deliveryFeeWaived = 0;
    if (isEarlyBird || isFreeByAmount) {
      deliveryFee = 0;
      deliveryFeeWaived = AppConstants.deliveryFee; // would have been ₹40
    } else {
      deliveryFee = AppConstants.deliveryFee;
      deliveryFeeWaived = 0;
    }

    // ---- Step 6: GST per line on its proportional share of afterMember ----
    // Taxable value proportionally distributed by line price
    final lineItemTaxes = <LineItemTax>[];
    double totalGst = 0;

    for (final item in items) {
      final basePrice = item.variant.pricePerUnit * zoneMultiplier;
      final lineRaw = basePrice * item.quantity;
      // Proportional taxable amount after all discounts
      final proportion = subtotal > 0 ? lineRaw / subtotal : 0.0;
      final taxable = _round(afterMember * proportion);
      final gst = _round(taxable * item.product.gstRate);
      totalGst += gst;
      lineItemTaxes.add(LineItemTax(
        productId: item.product.id,
        taxableAmount: taxable,
        gstRate: item.product.gstRate,
        gstAmount: gst,
      ));
    }
    totalGst = _round(totalGst);
    final cgst = _round(totalGst / 2);
    final sgst = _round(totalGst - cgst);

    // ---- Step 7: Grand total ----
    final grandTotal = _round(afterMember + totalGst + deliveryFee);

    // ---- Savings ----
    final totalSavings = _round(
      bulkDiscount + memberDiscount + deliveryFeeWaived,
    );

    return BillBreakdown(
      subtotal: subtotal,
      bulkDiscount: bulkDiscount,
      memberDiscount: memberDiscount,
      deliveryFee: deliveryFee,
      deliveryFeeWaived: deliveryFeeWaived,
      totalGst: totalGst,
      cgst: cgst,
      sgst: sgst,
      grandTotal: grandTotal,
      totalSavings: totalSavings,
      lineItemTaxes: lineItemTaxes,
    );
  }

  double _round(double v) => double.parse(v.toStringAsFixed(2));
}
