// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appName => 'रिलायंस स्मार्ट बाज़ार';

  @override
  String get splashTagline => 'ताज़ा। तेज़। डिलीवर।';

  @override
  String get loginTitle => 'स्वागत है';

  @override
  String get loginSubtitle => 'जारी रखने के लिए अपना मोबाइल नंबर दर्ज करें';

  @override
  String get mobileNumber => 'मोबाइल नंबर';

  @override
  String get mobileHint => '10 अंकों का मोबाइल नंबर';

  @override
  String get sendOtp => 'OTP भेजें';

  @override
  String get continueAsGuest => 'अतिथि के रूप में जारी रखें';

  @override
  String get orDivider => 'या';

  @override
  String get newUser => 'नए उपयोगकर्ता?';

  @override
  String get signUpHere => 'यहाँ साइन अप करें';

  @override
  String get otpTitle => 'OTP सत्यापित करें';

  @override
  String get otpSubtitle => 'इस नंबर पर भेजा गया 6 अंकों का OTP दर्ज करें';

  @override
  String get verify => 'सत्यापित करें';

  @override
  String get resendOtp => 'OTP पुनः भेजें';

  @override
  String resendIn(int seconds) {
    return '${seconds}s में पुनः भेजें';
  }

  @override
  String get demoOtpHint => 'डेमो OTP: 123456';

  @override
  String get wrongOtp => 'गलत OTP। कृपया पुनः प्रयास करें।';

  @override
  String get selectLanguage => 'भाषा चुनें';

  @override
  String get languageSubtitle => 'अपनी पसंदीदा भाषा चुनें';

  @override
  String get continueBtn => 'जारी रखें';

  @override
  String get storeLocator => 'स्टोर ढूंढें';

  @override
  String get searchStores => 'क्षेत्र या पिनकोड से खोजें…';

  @override
  String get nearestStores => 'नजदीकी स्टोर';

  @override
  String get noStoresFound => 'कोई स्टोर नहीं मिला';

  @override
  String get selectStore => 'यह स्टोर चुनें';

  @override
  String get getDirections => 'दिशा पाएं';

  @override
  String get callStore => 'स्टोर को कॉल करें';

  @override
  String get openNow => 'अभी खुला है';

  @override
  String get closedNow => 'बंद';

  @override
  String km(String distance) {
    return '$distance किमी';
  }

  @override
  String get usingDefaultLocation =>
      'डिफ़ॉल्ट स्थान: खारघर उपयोग किया जा रहा है';

  @override
  String get home => 'होम';

  @override
  String get categories => 'श्रेणियाँ';

  @override
  String get cart => 'कार्ट';

  @override
  String get orders => 'आदेश';

  @override
  String get profile => 'प्रोफ़ाइल';

  @override
  String get searchProducts => 'उत्पाद खोजें…';

  @override
  String get freshToday => 'आज की ताज़ी सब्ज़ियाँ';

  @override
  String get buyAgain => 'फिर से खरीदें';

  @override
  String get seeAll => 'सब देखें';

  @override
  String get offersForYou => 'आपके लिए ऑफर';

  @override
  String get jioPrimeBanner => 'JioPrime सक्रिय करें – 5% अतिरिक्त छूट पाएं';

  @override
  String get changeStore => 'स्टोर बदलें';

  @override
  String get addToCart => 'कार्ट में जोड़ें';

  @override
  String get addedToCart => 'कार्ट में जोड़ा गया!';

  @override
  String get outOfStock => 'स्टॉक में नहीं';

  @override
  String get inStock => 'स्टॉक में है';

  @override
  String get fewLeft => 'कम बचा है';

  @override
  String get qty => 'मात्रा';

  @override
  String get kg => 'किग्रा';

  @override
  String get perKg => 'प्रति किग्रा';

  @override
  String get perPack => 'प्रति पैक';

  @override
  String get loose => 'खुला';

  @override
  String get packed => 'पैक';

  @override
  String get organic => 'जैविक';

  @override
  String get underRs100 => '₹100 से कम';

  @override
  String get sortBy => 'क्रमबद्ध करें';

  @override
  String get priceLowHigh => 'मूल्य: कम से अधिक';

  @override
  String get priceHighLow => 'मूल्य: अधिक से कम';

  @override
  String get freshness => 'ताज़गी';

  @override
  String get filter => 'फ़िल्टर';

  @override
  String get productDetails => 'उत्पाद विवरण';

  @override
  String get selectWeight => 'वजन चुनें';

  @override
  String get selectVariant => 'वेरिएंट चुनें';

  @override
  String get ripeness => 'पकाव';

  @override
  String get raw => 'कच्चा';

  @override
  String get medium => 'मध्यम';

  @override
  String get ripe => 'पका हुआ';

  @override
  String get freshnessGuarantee => 'ताज़गी की गारंटी';

  @override
  String get freshnessPolicy =>
      '100% ताज़ा या डिलीवरी के 24 घंटों में पूर्ण वापसी।';

  @override
  String get farmerSource => 'किसान स्रोत';

  @override
  String get memberPrice => 'सदस्य मूल्य';

  @override
  String get memberBadge => 'JioPrime';

  @override
  String youSave(String amount) {
    return 'आप बचाते हैं $amount';
  }

  @override
  String totalPrice(String price) {
    return 'कुल: $price';
  }

  @override
  String get myCart => 'मेरी कार्ट';

  @override
  String get cartEmpty => 'आपकी कार्ट खाली है';

  @override
  String get cartEmptySubtitle => 'शुरू करने के लिए स्टोर से आइटम जोड़ें';

  @override
  String get shopNow => 'अभी खरीदें';

  @override
  String get chooseDeliverySlot => 'डिलीवरी स्लॉट चुनें';

  @override
  String get proceedToCheckout => 'चेकआउट करें';

  @override
  String get billDetails => 'बिल विवरण';

  @override
  String get subtotal => 'उपकुल';

  @override
  String get bulkDiscount => 'बल्क छूट (5%)';

  @override
  String get memberDiscount => 'सदस्य छूट (5%)';

  @override
  String get deliveryFee => 'डिलीवरी शुल्क';

  @override
  String get free => 'मुफ़्त';

  @override
  String get gst => 'GST';

  @override
  String get cgst => 'CGST';

  @override
  String get sgst => 'SGST';

  @override
  String get grandTotal => 'कुल राशि';

  @override
  String get totalSavings => 'कुल बचत';

  @override
  String get swipeToDelete => 'हटाने के लिए स्वाइप करें';

  @override
  String get itemRemoved => 'आइटम हटाया गया';

  @override
  String get undo => 'पूर्ववत करें';

  @override
  String get appliedOffer => 'ऑफर लागू';

  @override
  String get deliverySlot => 'डिलीवरी स्लॉट';

  @override
  String get selectDate => 'तारीख चुनें';

  @override
  String get selectTime => 'समय चुनें';

  @override
  String get earlyBird => 'अर्ली बर्ड';

  @override
  String get freeDelivery => 'मुफ़्त डिलीवरी';

  @override
  String get slotFull => 'भरा हुआ';

  @override
  String slotsLeft(int count) {
    return '$count बचे हैं';
  }

  @override
  String get confirmSlot => 'स्लॉट कन्फर्म करें';

  @override
  String get slotSelected => 'स्लॉट चुना गया';

  @override
  String get checkout => 'चेकआउट';

  @override
  String get deliveryAddress => 'डिलीवरी पता';

  @override
  String get changeAddress => 'बदलें';

  @override
  String get addNewAddress => 'नया पता जोड़ें';

  @override
  String get slotSummary => 'डिलीवरी स्लॉट';

  @override
  String get needGstInvoice => 'मुझे GST इनवॉयस चाहिए';

  @override
  String get businessName => 'व्यवसाय का नाम';

  @override
  String get gstin => 'GSTIN';

  @override
  String get gstinHint => '15 अक्षरों का GSTIN';

  @override
  String get businessAddress => 'व्यवसाय का पता';

  @override
  String get email => 'ईमेल पता';

  @override
  String get orderSummary => 'ऑर्डर सारांश';

  @override
  String get placeOrder => 'ऑर्डर दें';

  @override
  String get guestCheckoutPrompt => 'ऑर्डर देने के लिए कृपया लॉगिन करें';

  @override
  String get loginToPlaceOrder => 'लॉगिन करें';

  @override
  String get payment => 'भुगतान';

  @override
  String get selectPayment => 'भुगतान विधि चुनें';

  @override
  String get upi => 'UPI';

  @override
  String get cards => 'क्रेडिट / डेबिट कार्ड';

  @override
  String get netBanking => 'नेट बैंकिंग';

  @override
  String get jioMoney => 'JioMoney';

  @override
  String get cod => 'कैश ऑन डिलीवरी';

  @override
  String get upiId => 'UPI ID';

  @override
  String get upiHint => 'yourname@upi';

  @override
  String get cardNumber => 'कार्ड नंबर';

  @override
  String get expiryDate => 'समाप्ति (MM/YY)';

  @override
  String get cvv => 'CVV';

  @override
  String get cardholderName => 'कार्डधारक का नाम';

  @override
  String payNow(String amount) {
    return '$amount भुगतान करें';
  }

  @override
  String get processingPayment => 'भुगतान प्रक्रिया में…';

  @override
  String get paymentSuccess => 'भुगतान सफल!';

  @override
  String get paymentFailed => 'भुगतान विफल';

  @override
  String get tryAgain => 'पुनः प्रयास करें';

  @override
  String get orderConfirmed => 'ऑर्डर कन्फर्म!';

  @override
  String get orderPlacedSubtitle => 'आपका ऑर्डर सफलतापूर्वक दिया गया है।';

  @override
  String get orderId => 'ऑर्डर ID';

  @override
  String get estimatedDelivery => 'अनुमानित डिलीवरी';

  @override
  String get trackOrder => 'ऑर्डर ट्रैक करें';

  @override
  String get continueShopping => 'खरीदारी जारी रखें';

  @override
  String get orderTimeline => 'ऑर्डर टाइमलाइन';

  @override
  String get orderHistory => 'मेरे ऑर्डर';

  @override
  String get ongoing => 'चल रहे';

  @override
  String get past => 'पुराने';

  @override
  String get viewReceipt => 'रसीद देखें';

  @override
  String get repeatOrder => 'फिर से ऑर्डर करें';

  @override
  String get noOrders => 'अभी तक कोई ऑर्डर नहीं';

  @override
  String get noOngoingOrders => 'कोई चल रहा ऑर्डर नहीं';

  @override
  String get noPastOrders => 'कोई पुराना ऑर्डर नहीं';

  @override
  String get repeatOrderTitle => 'ऑर्डर दोहराएं';

  @override
  String get unavailable => 'अनुपलब्ध';

  @override
  String get addAllToCart => 'सभी कार्ट में जोड़ें';

  @override
  String get quantitySlider => 'मात्रा';

  @override
  String totalItems(int count) {
    return '$count आइटम';
  }

  @override
  String get digitalReceipt => 'डिजिटल रसीद';

  @override
  String get receiptFrom => 'रिलायंस स्मार्ट बाज़ार';

  @override
  String get item => 'आइटम';

  @override
  String get rate => 'दर';

  @override
  String get amount => 'राशि';

  @override
  String get discounts => 'छूट';

  @override
  String get downloadPdf => 'PDF डाउनलोड करें';

  @override
  String get shareReceipt => 'शेयर करें';

  @override
  String get taxInvoice => 'कर चालान';

  @override
  String get receipt => 'रसीद';

  @override
  String get myProfile => 'मेरी प्रोफ़ाइल';

  @override
  String get editProfile => 'प्रोफ़ाइल संपादित करें';

  @override
  String get savedAddresses => 'सहेजे गए पते';

  @override
  String get businessGstDetails => 'व्यवसाय / GST विवरण';

  @override
  String get language => 'भाषा';

  @override
  String get notifications => 'सूचनाएं';

  @override
  String get offers => 'ऑफर और डील';

  @override
  String get orderUpdates => 'ऑर्डर अपडेट';

  @override
  String get deliveryAlerts => 'डिलीवरी अलर्ट';

  @override
  String get helpSupport => 'सहायता और समर्थन';

  @override
  String get faq => 'अक्सर पूछे जाने वाले प्रश्न';

  @override
  String get logout => 'लॉगआउट';

  @override
  String get logoutConfirm => 'क्या आप वाकई लॉगआउट करना चाहते हैं?';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get save => 'सहेजें';

  @override
  String get delete => 'हटाएं';

  @override
  String get edit => 'संपादित करें';

  @override
  String get add => 'जोड़ें';

  @override
  String get yes => 'हाँ';

  @override
  String get no => 'नहीं';

  @override
  String get ok => 'ठीक है';

  @override
  String get close => 'बंद करें';

  @override
  String get confirm => 'कन्फर्म करें';

  @override
  String get back => 'वापस';

  @override
  String get defaultAddress => 'डिफ़ॉल्ट';

  @override
  String get setAsDefault => 'डिफ़ॉल्ट के रूप में सेट करें';

  @override
  String get addressLabel => 'लेबल (घर / कार्यालय / अन्य)';

  @override
  String get fullName => 'पूरा नाम';

  @override
  String get flatDoor => 'फ्लैट / दरवाजा नं.';

  @override
  String get streetLocality => 'सड़क / इलाका';

  @override
  String get areaColony => 'क्षेत्र / कॉलोनी';

  @override
  String get city => 'शहर';

  @override
  String get state => 'राज्य';

  @override
  String get pincode => 'पिनकोड';

  @override
  String get noInternetConnection => 'इंटरनेट कनेक्शन नहीं है';

  @override
  String get somethingWentWrong => 'कुछ गलत हो गया';

  @override
  String get retry => 'पुनः प्रयास करें';

  @override
  String get loading => 'लोड हो रहा है…';

  @override
  String get searching => 'खोज रहे हैं…';

  @override
  String get noResults => 'कोई परिणाम नहीं मिला';

  @override
  String get storeCode => 'स्टोर कोड';

  @override
  String get storeTimings => 'समय';

  @override
  String get inventoryLevels => 'इन्वेंटरी';

  @override
  String get shopFromStore => 'इस स्टोर से खरीदें';

  @override
  String get todayLabel => 'आज';

  @override
  String get tomorrowLabel => 'कल';

  @override
  String get jioPrimeActive => 'JioPrime सक्रिय';

  @override
  String get jioPrimeInactive => 'JioPrime सक्रिय करें';

  @override
  String get jioPrimeDesc => 'हर ऑर्डर पर 5% अतिरिक्त छूट पाएं';

  @override
  String get phoneNumber => 'फ़ोन नंबर';

  @override
  String version(String version) {
    return 'संस्करण $version';
  }
}
