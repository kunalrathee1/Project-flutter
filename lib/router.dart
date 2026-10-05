// ============================================================
// router.dart – go_router with ShellRoute for bottom nav.
// ============================================================
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/otp_screen.dart';
import 'screens/auth/profile_setup_screen.dart';
import 'screens/language/language_screen.dart';
import 'screens/store/store_locator_screen.dart';
import 'screens/store/store_detail_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/catalog/catalog_screen.dart';
import 'screens/catalog/search_screen.dart';
import 'screens/product/product_detail_screen.dart';
import 'screens/cart/cart_screen.dart';
import 'screens/slot/slot_screen.dart';
import 'screens/checkout/checkout_screen.dart';
import 'screens/payment/payment_screen.dart';
import 'screens/order/order_confirmation_screen.dart';
import 'screens/order/order_history_screen.dart';
import 'screens/order/order_tracking_screen.dart';
import 'screens/order/repeat_order_screen.dart';
import 'screens/order/receipt_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'widgets/shell_scaffold.dart';

final _rootKey = GlobalKey<NavigatorState>();
final _shellKey = GlobalKey<NavigatorState>();

GoRouter buildRouter(BuildContext context) {
  return GoRouter(
    navigatorKey: _rootKey,
    initialLocation: '/splash',
    redirect: (ctx, state) {
      if (state.uri.path == '/' || state.matchedLocation == '/') {
        return '/splash';
      }
      return null;
    },
    errorBuilder: (_, __) => const SplashScreen(),
    routes: [
      GoRoute(
        path: '/',
        redirect: (_, __) => '/splash',
      ),
      GoRoute(
        path: '/splash',
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (_, __) => const LoginScreen(),
      ),
      GoRoute(
        path: '/otp',
        builder: (_, state) {
          final phone = state.extra as String? ?? '';
          return OtpScreen(phone: phone);
        },
      ),
      GoRoute(
        path: '/profile-setup',
        builder: (_, state) {
          final phone = state.extra as String? ?? '';
          return ProfileSetupScreen(phone: phone);
        },
      ),
      GoRoute(
        path: '/language',
        builder: (_, __) => const LanguageScreen(),
      ),
      GoRoute(
        path: '/store-locator',
        builder: (_, __) => const StoreLocatorScreen(),
      ),
      GoRoute(
        path: '/store-detail',
        builder: (_, state) {
          final storeId = state.extra as String;
          return StoreDetailScreen(storeId: storeId);
        },
      ),
      GoRoute(
        path: '/search',
        builder: (_, state) {
          final query = state.extra as String? ?? '';
          return SearchScreen(initialQuery: query);
        },
      ),
      GoRoute(
        path: '/product/:id',
        builder: (_, state) {
          final id = state.pathParameters['id']!;
          return ProductDetailScreen(productId: id);
        },
      ),
      GoRoute(
        path: '/slot',
        builder: (_, __) => const SlotScreen(),
      ),
      GoRoute(
        path: '/checkout',
        builder: (_, __) => const CheckoutScreen(),
      ),
      GoRoute(
        path: '/payment',
        builder: (_, __) => const PaymentScreen(),
      ),
      GoRoute(
        path: '/order-confirmation',
        builder: (_, state) {
          final orderId = state.extra as String;
          return OrderConfirmationScreen(orderId: orderId);
        },
      ),
      GoRoute(
        path: '/order-tracking/:orderId',
        builder: (_, state) {
          final orderId = state.pathParameters['orderId']!;
          return OrderTrackingScreen(orderId: orderId);
        },
      ),
      GoRoute(
        path: '/repeat-order/:orderId',
        builder: (_, state) {
          final orderId = state.pathParameters['orderId']!;
          return RepeatOrderScreen(orderId: orderId);
        },
      ),
      GoRoute(
        path: '/receipt/:orderId',
        builder: (_, state) {
          final orderId = state.pathParameters['orderId']!;
          return ReceiptScreen(orderId: orderId);
        },
      ),
      // Shell for bottom navigation
      ShellRoute(
        navigatorKey: _shellKey,
        builder: (_, __, child) => ShellScaffold(child: child),
        routes: [
          GoRoute(
            path: '/home',
            builder: (_, __) => const HomeScreen(),
          ),
          GoRoute(
            path: '/categories',
            builder: (_, state) {
              final cat = state.extra as String?;
              return CatalogScreen(initialCategory: cat);
            },
          ),
          GoRoute(
            path: '/cart',
            builder: (_, __) => const CartScreen(),
          ),
          GoRoute(
            path: '/orders',
            builder: (_, __) => const OrderHistoryScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (_, __) => const ProfileScreen(),
          ),
        ],
      ),
    ],
  );
}
