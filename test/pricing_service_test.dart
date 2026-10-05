// ============================================================
// PricingService Unit Tests – tests subtotal, bulk discount,
// member discount (JioPrime), early-bird delivery fee, and GST.
// ============================================================
import 'package:flutter_test/flutter_test.dart';
import 'package:reliance_smart_bazaar/core/app_constants.dart';
import 'package:reliance_smart_bazaar/models/models.dart';
import 'package:reliance_smart_bazaar/services/pricing_service.dart';

void main() {
  late PricingService pricingService;

  setUp(() {
    pricingService = PricingService();
  });

  group('PricingService Tests', () {
    const testProduct = Product(
      id: 'mango_alphonso',
      names: {'en': 'Alphonso Mango'},
      category: ProductCategory.fruits,
      imageUrl: 'https://example.com/mango.jpg',
      gstRate: 0.0, // Fresh fruits are 0% GST
      variants: [
        ProductVariant(
          id: 'v_loose',
          label: 'Loose',
          pricePerUnit: 250.0,
          memberPricePerUnit: 237.5,
          packSizeKg: 1.0,
          isLoose: true,
        ),
      ],
    );

    const testDairyProduct = Product(
      id: 'amul_butter',
      names: {'en': 'Amul Butter 500g'},
      category: ProductCategory.dairy,
      imageUrl: 'https://example.com/butter.jpg',
      gstRate: 0.12, // 12% GST on butter
      variants: [
        ProductVariant(
          id: 'v_pack',
          label: '500g pack',
          pricePerUnit: 275.0,
          memberPricePerUnit: 261.25,
          packSizeKg: 0.5,
          isLoose: false,
        ),
      ],
    );

    test('Empty cart returns zero bill', () {
      final bill = pricingService.compute(
        items: [],
        jioPrime: false,
      );

      expect(bill.subtotal, 0.0);
      expect(bill.bulkDiscount, 0.0);
      expect(bill.memberDiscount, 0.0);
      expect(bill.grandTotal, 0.0);
      expect(bill.totalSavings, 0.0);
    });

    test('Standard item without discounts under free delivery threshold', () {
      final items = [
        const CartItem(
          id: 'item_1',
          product: testProduct,
          variant: ProductVariant(
            id: 'v_loose',
            label: 'Loose',
            pricePerUnit: 250.0,
            memberPricePerUnit: 237.5,
            packSizeKg: 1.0,
            isLoose: true,
          ),
          quantity: 1.0,
        ),
      ];

      final bill = pricingService.compute(
        items: items,
        jioPrime: false,
      );

      expect(bill.subtotal, 250.0);
      expect(bill.bulkDiscount, 0.0);
      expect(bill.memberDiscount, 0.0);
      expect(bill.deliveryFee, AppConstants.deliveryFee); // ₹40
      expect(bill.grandTotal, 290.0);
    });

    test('JioPrime member discount of 5% applies correctly', () {
      final items = [
        const CartItem(
          id: 'item_1',
          product: testProduct,
          variant: ProductVariant(
            id: 'v_loose',
            label: 'Loose',
            pricePerUnit: 1000.0,
            memberPricePerUnit: 950.0,
            packSizeKg: 1.0,
            isLoose: true,
          ),
          quantity: 1.0,
        ),
      ];

      final bill = pricingService.compute(
        items: items,
        jioPrime: true,
      );

      expect(bill.subtotal, 1000.0);
      expect(bill.memberDiscount, 50.0); // 5% of 1000
      expect(bill.deliveryFee, 0.0); // Free delivery >= 499
      expect(bill.grandTotal, 950.0);
      expect(bill.totalSavings, greaterThanOrEqualTo(50.0));
    });

    test('Bulk discount applies when subtotal > 2000', () {
      final items = [
        const CartItem(
          id: 'item_1',
          product: testProduct,
          variant: ProductVariant(
            id: 'v_loose',
            label: 'Loose',
            pricePerUnit: 500.0,
            memberPricePerUnit: 475.0,
            packSizeKg: 1.0,
            isLoose: true,
          ),
          quantity: 5.0, // Subtotal = 2500
        ),
      ];

      final bill = pricingService.compute(
        items: items,
        jioPrime: false,
      );

      expect(bill.subtotal, 2500.0);
      expect(bill.bulkDiscount, 125.0); // 5% of 2500
      expect(bill.deliveryFee, 0.0); // >= 499
      expect(bill.grandTotal, 2375.0);
    });

    test('GST calculation per line item', () {
      final items = [
        const CartItem(
          id: 'item_butter',
          product: testDairyProduct,
          variant: ProductVariant(
            id: 'v_pack',
            label: '500g pack',
            pricePerUnit: 500.0,
            memberPricePerUnit: 475.0,
            packSizeKg: 0.5,
            isLoose: false,
          ),
          quantity: 2.0, // Subtotal = 1000
        ),
      ];

      final bill = pricingService.compute(
        items: items,
        jioPrime: false,
      );

      expect(bill.subtotal, 1000.0);
      expect(bill.totalGst, 120.0); // 12% of 1000
      expect(bill.cgst, 60.0);
      expect(bill.sgst, 60.0);
      expect(bill.grandTotal, 1120.0);
    });
  });
}
