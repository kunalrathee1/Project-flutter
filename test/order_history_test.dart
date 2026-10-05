import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:reliance_smart_bazaar/data/mock_products.dart';
import 'package:reliance_smart_bazaar/l10n/app_localizations.dart';
import 'package:reliance_smart_bazaar/models/models.dart';
import 'package:reliance_smart_bazaar/providers/order_provider.dart';
import 'package:reliance_smart_bazaar/screens/order/order_history_screen.dart';
import 'package:reliance_smart_bazaar/services/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('OrderHistoryScreen renders with order', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final storage = StorageService();
    await storage.init();
    final orderProvider = OrderProvider(storage);

    final product = mockProducts.first;
    await orderProvider.placeOrder(
      items: [
        CartItem(
          id: 'test_item',
          product: product,
          variant: product.variants.first,
          quantity: 2,
        ),
      ],
      deliveryAddress: Address.defaultKharghar,
      slot: DeliverySlot(
        startHour: 6,
        date: DateTime.now(),
        capacity: 10,
        booked: 2,
      ),
      bill: const BillBreakdown(
        subtotal: 500,
        bulkDiscount: 0,
        memberDiscount: 0,
        deliveryFee: 0,
        deliveryFeeWaived: 40,
        totalGst: 0,
        cgst: 0,
        sgst: 0,
        grandTotal: 500,
        totalSavings: 40,
        lineItemTaxes: [],
      ),
      storeId: 'RSB-KHARGHAR-01',
      storeName: 'Reliance Smart Bazaar - Kharghar',
      paymentMethod: 'UPI',
    );

    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: orderProvider),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: OrderHistoryScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(OrderHistoryScreen), findsOneWidget);
    expect(orderProvider.ongoingOrders.length, 1);
  });
}
