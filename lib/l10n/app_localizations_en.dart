// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Reliance Smart Bazaar';

  @override
  String get splashTagline => 'Fresh. Fast. Delivered.';

  @override
  String get loginTitle => 'Welcome Back';

  @override
  String get loginSubtitle => 'Enter your mobile number to continue';

  @override
  String get mobileNumber => 'Mobile Number';

  @override
  String get mobileHint => '10-digit mobile number';

  @override
  String get sendOtp => 'Send OTP';

  @override
  String get continueAsGuest => 'Continue as Guest';

  @override
  String get orDivider => 'OR';

  @override
  String get newUser => 'New user?';

  @override
  String get signUpHere => 'Sign up here';

  @override
  String get otpTitle => 'Verify OTP';

  @override
  String get otpSubtitle => 'Enter the 6-digit OTP sent to';

  @override
  String get verify => 'Verify';

  @override
  String get resendOtp => 'Resend OTP';

  @override
  String resendIn(int seconds) {
    return 'Resend in ${seconds}s';
  }

  @override
  String get demoOtpHint => 'Demo OTP: 123456';

  @override
  String get wrongOtp => 'Invalid OTP. Please try again.';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get languageSubtitle => 'Choose your preferred language';

  @override
  String get continueBtn => 'Continue';

  @override
  String get storeLocator => 'Store Locator';

  @override
  String get searchStores => 'Search by area or pincode…';

  @override
  String get nearestStores => 'Nearest Stores';

  @override
  String get noStoresFound => 'No stores found';

  @override
  String get selectStore => 'Select This Store';

  @override
  String get getDirections => 'Get Directions';

  @override
  String get callStore => 'Call Store';

  @override
  String get openNow => 'Open Now';

  @override
  String get closedNow => 'Closed';

  @override
  String km(String distance) {
    return '$distance km';
  }

  @override
  String get usingDefaultLocation => 'Using Kharghar as default location';

  @override
  String get home => 'Home';

  @override
  String get categories => 'Categories';

  @override
  String get cart => 'Cart';

  @override
  String get orders => 'Orders';

  @override
  String get profile => 'Profile';

  @override
  String get searchProducts => 'Search products…';

  @override
  String get freshToday => 'Fresh Today';

  @override
  String get buyAgain => 'Buy Again';

  @override
  String get seeAll => 'See All';

  @override
  String get offersForYou => 'Offers For You';

  @override
  String get jioPrimeBanner => 'Activate JioPrime – Get 5% extra off';

  @override
  String get changeStore => 'Change Store';

  @override
  String get addToCart => 'Add to Cart';

  @override
  String get addedToCart => 'Added to cart!';

  @override
  String get outOfStock => 'Out of Stock';

  @override
  String get inStock => 'In Stock';

  @override
  String get fewLeft => 'Few Left';

  @override
  String get qty => 'Qty';

  @override
  String get kg => 'kg';

  @override
  String get perKg => 'per kg';

  @override
  String get perPack => 'per pack';

  @override
  String get loose => 'Loose';

  @override
  String get packed => 'Packed';

  @override
  String get organic => 'Organic';

  @override
  String get underRs100 => 'Under ₹100';

  @override
  String get sortBy => 'Sort By';

  @override
  String get priceLowHigh => 'Price: Low to High';

  @override
  String get priceHighLow => 'Price: High to Low';

  @override
  String get freshness => 'Freshness';

  @override
  String get filter => 'Filter';

  @override
  String get productDetails => 'Product Details';

  @override
  String get selectWeight => 'Select Weight';

  @override
  String get selectVariant => 'Select Variant';

  @override
  String get ripeness => 'Ripeness';

  @override
  String get raw => 'Raw';

  @override
  String get medium => 'Medium';

  @override
  String get ripe => 'Ripe';

  @override
  String get freshnessGuarantee => 'Freshness Guarantee';

  @override
  String get freshnessPolicy =>
      '100% fresh or full refund within 24 hours of delivery.';

  @override
  String get farmerSource => 'Farmer Source';

  @override
  String get memberPrice => 'Member Price';

  @override
  String get memberBadge => 'JioPrime';

  @override
  String youSave(String amount) {
    return 'You save $amount';
  }

  @override
  String totalPrice(String price) {
    return 'Total: $price';
  }

  @override
  String get myCart => 'My Cart';

  @override
  String get cartEmpty => 'Your cart is empty';

  @override
  String get cartEmptySubtitle => 'Add items from the store to get started';

  @override
  String get shopNow => 'Shop Now';

  @override
  String get chooseDeliverySlot => 'Choose Delivery Slot';

  @override
  String get proceedToCheckout => 'Proceed to Checkout';

  @override
  String get billDetails => 'Bill Details';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get bulkDiscount => 'Bulk Discount (5%)';

  @override
  String get memberDiscount => 'Member Discount (5%)';

  @override
  String get deliveryFee => 'Delivery Fee';

  @override
  String get free => 'FREE';

  @override
  String get gst => 'GST';

  @override
  String get cgst => 'CGST';

  @override
  String get sgst => 'SGST';

  @override
  String get grandTotal => 'Grand Total';

  @override
  String get totalSavings => 'Total Savings';

  @override
  String get swipeToDelete => 'Swipe to remove';

  @override
  String get itemRemoved => 'Item removed';

  @override
  String get undo => 'Undo';

  @override
  String get appliedOffer => 'Offer Applied';

  @override
  String get deliverySlot => 'Delivery Slot';

  @override
  String get selectDate => 'Select Date';

  @override
  String get selectTime => 'Select Time';

  @override
  String get earlyBird => 'Early Bird';

  @override
  String get freeDelivery => 'Free Delivery';

  @override
  String get slotFull => 'Full';

  @override
  String slotsLeft(int count) {
    return '$count left';
  }

  @override
  String get confirmSlot => 'Confirm Slot';

  @override
  String get slotSelected => 'Slot selected';

  @override
  String get checkout => 'Checkout';

  @override
  String get deliveryAddress => 'Delivery Address';

  @override
  String get changeAddress => 'Change';

  @override
  String get addNewAddress => 'Add New Address';

  @override
  String get slotSummary => 'Delivery Slot';

  @override
  String get needGstInvoice => 'I need a GST Invoice';

  @override
  String get businessName => 'Business Name';

  @override
  String get gstin => 'GSTIN';

  @override
  String get gstinHint => '15-character GSTIN';

  @override
  String get businessAddress => 'Business Address';

  @override
  String get email => 'Email Address';

  @override
  String get orderSummary => 'Order Summary';

  @override
  String get placeOrder => 'Place Order';

  @override
  String get guestCheckoutPrompt => 'Please login to place an order';

  @override
  String get loginToPlaceOrder => 'Login to Place Order';

  @override
  String get payment => 'Payment';

  @override
  String get selectPayment => 'Select Payment Method';

  @override
  String get upi => 'UPI';

  @override
  String get cards => 'Credit / Debit Card';

  @override
  String get netBanking => 'Net Banking';

  @override
  String get jioMoney => 'JioMoney';

  @override
  String get cod => 'Cash on Delivery';

  @override
  String get upiId => 'UPI ID';

  @override
  String get upiHint => 'yourname@upi';

  @override
  String get cardNumber => 'Card Number';

  @override
  String get expiryDate => 'Expiry (MM/YY)';

  @override
  String get cvv => 'CVV';

  @override
  String get cardholderName => 'Cardholder Name';

  @override
  String payNow(String amount) {
    return 'Pay $amount';
  }

  @override
  String get processingPayment => 'Processing payment…';

  @override
  String get paymentSuccess => 'Payment Successful!';

  @override
  String get paymentFailed => 'Payment Failed';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get orderConfirmed => 'Order Confirmed!';

  @override
  String get orderPlacedSubtitle => 'Your order has been placed successfully.';

  @override
  String get orderId => 'Order ID';

  @override
  String get estimatedDelivery => 'Estimated Delivery';

  @override
  String get trackOrder => 'Track Order';

  @override
  String get continueShopping => 'Continue Shopping';

  @override
  String get orderTimeline => 'Order Timeline';

  @override
  String get orderHistory => 'My Orders';

  @override
  String get ongoing => 'Ongoing';

  @override
  String get past => 'Past';

  @override
  String get viewReceipt => 'View Receipt';

  @override
  String get repeatOrder => 'Repeat Order';

  @override
  String get noOrders => 'No orders yet';

  @override
  String get noOngoingOrders => 'No ongoing orders';

  @override
  String get noPastOrders => 'No past orders';

  @override
  String get repeatOrderTitle => 'Repeat Order';

  @override
  String get unavailable => 'Unavailable';

  @override
  String get addAllToCart => 'Add All to Cart';

  @override
  String get quantitySlider => 'Quantity';

  @override
  String totalItems(int count) {
    return '$count items';
  }

  @override
  String get digitalReceipt => 'Digital Receipt';

  @override
  String get receiptFrom => 'Reliance Smart Bazaar';

  @override
  String get item => 'Item';

  @override
  String get rate => 'Rate';

  @override
  String get amount => 'Amount';

  @override
  String get discounts => 'Discounts';

  @override
  String get downloadPdf => 'Download PDF';

  @override
  String get shareReceipt => 'Share';

  @override
  String get taxInvoice => 'TAX INVOICE';

  @override
  String get receipt => 'RECEIPT';

  @override
  String get myProfile => 'My Profile';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get savedAddresses => 'Saved Addresses';

  @override
  String get businessGstDetails => 'Business / GST Details';

  @override
  String get language => 'Language';

  @override
  String get notifications => 'Notifications';

  @override
  String get offers => 'Offers & Deals';

  @override
  String get orderUpdates => 'Order Updates';

  @override
  String get deliveryAlerts => 'Delivery Alerts';

  @override
  String get helpSupport => 'Help & Support';

  @override
  String get faq => 'FAQs';

  @override
  String get logout => 'Logout';

  @override
  String get logoutConfirm => 'Are you sure you want to logout?';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get add => 'Add';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get ok => 'OK';

  @override
  String get close => 'Close';

  @override
  String get confirm => 'Confirm';

  @override
  String get back => 'Back';

  @override
  String get defaultAddress => 'Default';

  @override
  String get setAsDefault => 'Set as Default';

  @override
  String get addressLabel => 'Label (Home / Office / Other)';

  @override
  String get fullName => 'Full Name';

  @override
  String get flatDoor => 'Flat / Door No.';

  @override
  String get streetLocality => 'Street / Locality';

  @override
  String get areaColony => 'Area / Colony';

  @override
  String get city => 'City';

  @override
  String get state => 'State';

  @override
  String get pincode => 'Pincode';

  @override
  String get noInternetConnection => 'No internet connection';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get retry => 'Retry';

  @override
  String get loading => 'Loading…';

  @override
  String get searching => 'Searching…';

  @override
  String get noResults => 'No results found';

  @override
  String get storeCode => 'Store Code';

  @override
  String get storeTimings => 'Timings';

  @override
  String get inventoryLevels => 'Inventory';

  @override
  String get shopFromStore => 'Shop from This Store';

  @override
  String get todayLabel => 'Today';

  @override
  String get tomorrowLabel => 'Tomorrow';

  @override
  String get jioPrimeActive => 'JioPrime Active';

  @override
  String get jioPrimeInactive => 'Activate JioPrime';

  @override
  String get jioPrimeDesc => 'Get 5% extra discount on every order';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String version(String version) {
    return 'Version $version';
  }
}
