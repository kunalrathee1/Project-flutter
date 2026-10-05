// ============================================================
// AppConstants – app-wide constants: location, API, etc.
// ============================================================

abstract class AppConstants {
  // Default location: Kharghar, Navi Mumbai
  static const double defaultLat = 19.0474;
  static const double defaultLng = 73.0699;
  static const String defaultPincode = '410210';
  static const String defaultCity = 'Kharghar, Navi Mumbai';
  static const String defaultState = 'Maharashtra';

  // Demo credentials
  static const String demoOtp = '123456';
  static const int otpLength = 6;
  static const int otpResendSeconds = 30;

  // Pricing thresholds
  static const double bulkDiscountThreshold = 2000.0;
  static const double bulkDiscountRate = 0.05; // 5%
  static const double memberDiscountRate = 0.05; // 5%
  static const double freeDeliveryThreshold = 499.0;
  static const double deliveryFee = 40.0;

  // Store hours (24-hour)
  static const int storeOpenHour = 7;
  static const int storeCloseHour = 23; // 11 PM

  // Slot hours 6 AM to 10 PM (last slot 9-10 PM)
  static const int firstSlotHour = 6;
  static const int lastSlotHour = 22; // end of last slot
  static const int slotCutoffMinutes = 60; // cutoff 1 hour before

  // OSM tiles (no API key)
  static const String osmTileUrl =
      'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
  static const String osmAttribution = '© OpenStreetMap contributors';

  // Unsplash image base (used for product images with a stable seed)
  static const String unsplashBase = 'https://images.unsplash.com/photo-';

  // Zone multipliers keyed by zone code
  static const Map<String, double> zoneMultipliers = {
    'navi_mumbai': 1.00,
    'mumbai': 1.05,
    'pune': 0.95,
    'delhi': 1.08,
    'default': 1.00,
  };

  // SharedPreferences keys
  static const String prefPhone = 'user_phone';
  static const String prefName = 'user_name';
  static const String prefIsGuest = 'is_guest';
  static const String prefLanguage = 'language_code';
  static const String prefSelectedStoreId = 'selected_store_id';
  static const String prefCart = 'cart_data';
  static const String prefOrders = 'orders_data';
  static const String prefJioPrime = 'jio_prime';
  static const String prefAddresses = 'saved_addresses';
  static const String prefGstDetails = 'gst_details';
  static const String prefOnboardingDone = 'onboarding_done';
  static const String prefNotifOffers = 'notif_offers';
  static const String prefNotifOrders = 'notif_orders';
  static const String prefNotifDelivery = 'notif_delivery';

  // Supported locales
  static const List<String> supportedLocales = ['en', 'hi', 'mr', 'gu'];
  static const Map<String, String> languageNames = {
    'en': 'English',
    'hi': 'हिंदी',
    'mr': 'मराठी',
    'gu': 'ગુજરાતી',
  };

  // App version
  static const String appVersion = '1.0.0';
  static const String appName = 'Reliance Smart Bazaar';
}
