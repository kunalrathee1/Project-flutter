// ============================================================
// main.dart – entry point: initialise services, set up providers.
// ============================================================
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'services/storage_service.dart';
import 'services/pricing_service.dart';
import 'services/slot_service.dart';
import 'services/location_service.dart';
import 'providers/auth_provider.dart';
import 'providers/language_provider.dart';
import 'providers/store_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/profile_provider.dart';
import 'providers/order_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock portrait + landscape on phones; allow all on tablets/web.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));

  // Initialise services
  final storage = StorageService();
  await storage.init();

  final pricing = PricingService();
  final slots = SlotService();
  final location = LocationService();

  runApp(
    MultiProvider(
      providers: [
        // Services (singletons available to providers)
        Provider<StorageService>.value(value: storage),
        Provider<PricingService>.value(value: pricing),
        Provider<SlotService>.value(value: slots),
        Provider<LocationService>.value(value: location),

        // Feature providers
        ChangeNotifierProvider(
          create: (_) => LanguageProvider(storage),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(storage),
        ),
        ChangeNotifierProvider(
          create: (_) => StoreProvider(storage, location),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileProvider(storage),
        ),
        ChangeNotifierProxyProvider<ProfileProvider, CartProvider>(
          create: (ctx) => CartProvider(storage, pricing),
          update: (ctx, profile, cart) {
            cart?.updateJioPrime(profile.jioPrime);
            return cart ?? CartProvider(storage, pricing);
          },
        ),
        ChangeNotifierProvider(
          create: (_) => OrderProvider(storage),
        ),
      ],
      child: const RelianceSmartApp(),
    ),
  );
}
