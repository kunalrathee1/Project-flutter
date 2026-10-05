# Reliance Smart Bazaar Online 🛒🍅

A complete, production-quality, cross-platform Flutter application digitizing the local supermarket and kirana shopping experience. Customers can select their nearest Reliance Smart Bazaar store, browse fresh produce with loose/packed options and ripeness grading, schedule delivery slots, enjoy member and bulk savings, request GST tax invoices, track live delivery on OpenStreetMap, and download or print digital tax invoices as PDFs.

Built without external paid backend services or API keys, running seamlessly across **Android**, **iOS**, and **Web**.

---

## 🌟 Highlights & Features

- **Store Selection & Location**:
  - Live geolocation via `geolocator` with graceful fallback to **Kharghar, Navi Mumbai, Maharashtra (Pincode: 410210)**.
  - Interactive OpenStreetMap store locator via `flutter_map` (zero API key needed).
  - Store inventory levels, store codes, timings, and zone-based pricing multipliers.
- **Produce & Fresh Groceries**:
  - Loose (sold by weight e.g., 0.5 kg, 1 kg, 2.5 kg) vs. Packed variant toggle.
  - Ripeness selector (**Raw 🟢, Medium 🟡, Ripe 🔴**) for mangoes and seasonal fruits.
  - Direct farmer sourcing card with provenance information.
  - Freshness Guarantee banner (100% fresh or refund within 24 hours).
- **Billing & Pricing Engine**:
  - Pure Dart single source of truth [`PricingService`](file:///Users/sahilpandey/Desktop/KUNAL-flutter/lib/services/pricing_service.dart).
  - Bulk discount (5% for orders > ₹2,000).
  - JioPrime membership discount (5% extra discount on every grocery order).
  - Tiered GST calculation per line item (0% on fresh produce, 5% on staples, 12% on dairy/butter, 18% on snacks/beverages) with automatic split into CGST + SGST.
  - Free delivery threshold (orders ≥ ₹499 or early-bird slots).
- **Delivery Slots**:
  - Custom 7-day horizontal date selector.
  - 1-hour slot intervals with live availability indicators ("Few Left", "Full", "Early Bird - Free Delivery").
- **Checkout & GST Invoicing**:
  - Delivery address management (add, edit, delete, set default).
  - Business tax invoice toggle with 15-character GSTIN validation and business details.
- **Payment & Order Processing**:
  - Seamless support for UPI, Credit/Debit Cards, Net Banking, JioMoney, and Cash on Delivery (COD).
  - Animated 2-second realistic payment processing overlay.
- **Post-Order Experience**:
  - Elastic success checkmark animation on confirmation.
  - Live delivery tracking on interactive OpenStreetMap with route and delivery executive contact.
  - Repeat order with stock checks and quantity counters.
  - Digital Receipt & compliant Tax Invoice with printable and shareable PDF export via `pdf` and `printing`.
- **Full Localization (4 Languages)**:
  - English (en), हिन्दी (hi), मराठी (mr), ગુજરાતી (gu) with real translations via Flutter's ARB internationalization system.

---

## 📱 Demo Credentials & Quick Info

| Attribute | Value |
|---|---|
| **Demo Mobile Number** | Any 10-digit number (e.g., `9876543210`) |
| **Demo OTP** | `123456` |
| **Default Location** | Kharghar, Navi Mumbai - 410210 (Lat: 19.0474, Lng: 73.0699) |
| **Default Store** | Reliance Smart Bazaar - Kharghar (Code: `RSB-KHARGHAR-01`) |
| **Sample GSTIN** | `27AAACR7191N1ZG` |

---

## 🚀 Viva & Presentation Walkthrough Flow

Follow this exact flow during your demonstration:

1. **Splash & Onboarding**:
   - Launch app: view Reliance red splash screen with slogan "Fresh. Fast. Delivered."
2. **Authentication**:
   - Enter `9876543210` on Login Screen.
   - Enter demo OTP `123456` (auto-focusing 6-pin input with countdown timer and shake error handling).
3. **Language Selection**:
   - Choose from English, हिन्दी, मराठी, or ગુજરાતી (the whole app translates in real time).
4. **Store Locator**:
   - Detects GPS or falls back to **Kharghar, Navi Mumbai**.
   - View Kharghar store on OpenStreetMap and tap "Shop from This Store".
5. **Home & Produce Catalog**:
   - Browse categories (Fruits, Vegetables, Dairy, Staples).
   - Tap **Alphonso Mango** to enter Product Detail.
   - Toggle between **Loose** and **Packed**, select Ripeness (**Ripe 🔴**), and adjust quantity to **2 kg**.
   - Tap "Add to Cart".
6. **Cart & Slot Booking**:
   - View itemized bill with savings breakdown.
   - Select Delivery Slot: pick Tomorrow's **6:00 AM – 7:00 AM** Early Bird slot (Delivery Fee: FREE).
7. **Checkout & GST Invoice**:
   - Select default Kharghar address.
   - Toggle "I need a GST Invoice" and input business details + GSTIN.
8. **Payment & Processing**:
   - Choose UPI or Credit Card.
   - Tap "Pay Now" → observe 2-second processing overlay.
9. **Order Confirmation & Tracking**:
   - Watch the animated elastic checkmark.
   - Tap "Track Order" to see live rider progress on OpenStreetMap and delivery partner card with call button.
10. **Receipt & Repeat Order**:
    - Tap "View Receipt" to see itemized Tax Invoice.
    - Tap "Print PDF" or "Share Receipt" to generate compliant PDF document.
    - Go to "My Orders" tab → "Repeat Order" → re-order with single tap.

---

## 🛠️ Tech Stack & Packages

- **Framework**: Flutter 3.x (Material 3, Dart null-safety)
- **State Management**: [`Provider`](https://pub.dev/packages/provider)
- **Navigation**: [`go_router`](https://pub.dev/packages/go_router) with `ShellRoute` bottom navigation
- **Local Persistence**: [`shared_preferences`](https://pub.dev/packages/shared_preferences)
- **Maps & Geolocation**: [`flutter_map`](https://pub.dev/packages/flutter_map), [`latlong2`](https://pub.dev/packages/latlong2), [`geolocator`](https://pub.dev/packages/geolocator)
- **PDF & Printing**: [`pdf`](https://pub.dev/packages/pdf), [`printing`](https://pub.dev/packages/printing)
- **Localization**: `flutter_localizations`, [`intl`](https://pub.dev/packages/intl)
- **Typography & UI**: [`google_fonts`](https://pub.dev/packages/google_fonts) (Poppins), [`cupertino_icons`](https://pub.dev/packages/cupertino_icons)
- **System Utilities**: [`url_launcher`](https://pub.dev/packages/url_launcher), [`permission_handler`](https://pub.dev/packages/permission_handler)

---

## 💻 Running the App

### Prerequisites
- Flutter SDK (≥ 3.24) installed and configured on your PATH.

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Run Tests
```bash
flutter test
```
All unit tests for the pricing engine and UI components will execute and pass.

### 3. Static Analysis
```bash
flutter analyze
```
Verified with **0 errors and 0 warnings**.

### 4. Run Locally

- **Web (Chrome)**:
  ```bash
  flutter run -d chrome
  ```
- **macOS Desktop**:
  ```bash
  flutter run -d macos
  ```
- **Android**:
  ```bash
  flutter run -d android
  ```
- **iOS Simulator**:
  ```bash
  flutter run -d ios
  ```

---

## 📁 Project Architecture

```
lib/
├── app.dart                   # Root widget with providers, theme, and l10n
├── core/
│   ├── app_colors.dart        # Reliance Red, Fresh Green, and theme colors
│   ├── app_constants.dart     # Thresholds, fallback coords, demo OTP
│   ├── app_formatters.dart    # Currency (₹), weight, date, time formatters
│   ├── app_theme.dart         # Material 3 light theme (Poppins typography)
│   └── validators.dart        # Phone, PIN, GSTIN, and email validators
├── data/
│   ├── mock_products.dart     # Produce catalog with loose/packed & ripeness data
│   └── mock_stores.dart       # Store database (Kharghar, Panvel, Vashi, Nerul)
├── l10n/
│   ├── app_en.arb             # English localization
│   ├── app_hi.arb             # हिन्दी (Hindi) localization
│   ├── app_mr.arb             # मराठी (Marathi) localization
│   └── app_gu.arb             # ગુજરાતી (Gujarati) localization
├── models/
│   └── models.dart            # Pure Dart domain models (Product, Order, Slot, etc.)
├── providers/
│   ├── auth_provider.dart     # Authentication & session provider
│   ├── cart_provider.dart     # Cart state, slot selection & bill breakdown
│   ├── language_provider.dart # Live locale switching & persistence
│   ├── order_provider.dart    # Order placement, tracking & history
│   ├── profile_provider.dart  # JioPrime, saved addresses & GST details
│   └── store_provider.dart    # Store selection & distance calculation
├── router.dart                # go_router with ShellRoute bottom bar
├── screens/
│   ├── auth/                  # LoginScreen & OtpScreen
│   ├── cart/                  # CartScreen (swipe-to-delete, bill details)
│   ├── catalog/               # CatalogScreen & SearchScreen
│   ├── checkout/              # CheckoutScreen (address, slot, GST invoice)
│   ├── home/                  # HomeScreen (banners, fresh today, buy again)
│   ├── language/              # LanguageScreen
│   ├── order/                 # Confirmation, Tracking, History, Reorder, Receipt
│   ├── payment/               # PaymentScreen (UPI, Cards, COD)
│   ├── product/               # ProductDetailScreen (loose/packed, ripeness)
│   ├── profile/               # ProfileScreen (JioPrime toggle, address book)
│   ├── slot/                  # SlotScreen (7-day date strip, slot chips)
│   ├── splash/                # SplashScreen
│   └── store/                 # StoreLocatorScreen & StoreDetailScreen
├── services/
│   ├── location_service.dart  # Geolocator + fallback to Kharghar
│   ├── pricing_service.dart   # Pure billing engine (bulk, JioPrime, GST)
│   ├── slot_service.dart      # Slot generation and cutoff enforcement
│   └── storage_service.dart   # SharedPreferences persistence
└── widgets/
    ├── shell_scaffold.dart    # Bottom navigation shell
    └── widgets.dart           # Reusable UI components & badges
```
