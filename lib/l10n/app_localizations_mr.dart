// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Marathi (`mr`).
class AppLocalizationsMr extends AppLocalizations {
  AppLocalizationsMr([String locale = 'mr']) : super(locale);

  @override
  String get appName => 'रिलायन्स स्मार्ट बाजार';

  @override
  String get splashTagline => 'ताजे. जलद. डिलिव्हर.';

  @override
  String get loginTitle => 'स्वागत आहे';

  @override
  String get loginSubtitle => 'सुरू ठेवण्यासाठी आपला मोबाइल नंबर प्रविष्ट करा';

  @override
  String get mobileNumber => 'मोबाइल नंबर';

  @override
  String get mobileHint => '10 अंकी मोबाइल नंबर';

  @override
  String get sendOtp => 'OTP पाठवा';

  @override
  String get continueAsGuest => 'अतिथी म्हणून सुरू ठेवा';

  @override
  String get orDivider => 'किंवा';

  @override
  String get newUser => 'नवीन वापरकर्ता?';

  @override
  String get signUpHere => 'येथे साइन अप करा';

  @override
  String get otpTitle => 'OTP सत्यापित करा';

  @override
  String get otpSubtitle => 'या नंबरवर पाठवलेला 6 अंकी OTP प्रविष्ट करा';

  @override
  String get verify => 'सत्यापित करा';

  @override
  String get resendOtp => 'OTP पुन्हा पाठवा';

  @override
  String resendIn(int seconds) {
    return '${seconds}s मध्ये पुन्हा पाठवा';
  }

  @override
  String get demoOtpHint => 'डेमो OTP: 123456';

  @override
  String get wrongOtp => 'चुकीचा OTP. कृपया पुन्हा प्रयत्न करा.';

  @override
  String get selectLanguage => 'भाषा निवडा';

  @override
  String get languageSubtitle => 'आपली पसंतीची भाषा निवडा';

  @override
  String get continueBtn => 'सुरू ठेवा';

  @override
  String get storeLocator => 'स्टोअर शोधा';

  @override
  String get searchStores => 'क्षेत्र किंवा पिनकोडने शोधा…';

  @override
  String get nearestStores => 'जवळचे स्टोअर';

  @override
  String get noStoresFound => 'कोणताही स्टोअर सापडला नाही';

  @override
  String get selectStore => 'हे स्टोअर निवडा';

  @override
  String get getDirections => 'दिशानिर्देश मिळवा';

  @override
  String get callStore => 'स्टोअरला कॉल करा';

  @override
  String get openNow => 'आता उघडे';

  @override
  String get closedNow => 'बंद';

  @override
  String km(String distance) {
    return '$distance किमी';
  }

  @override
  String get usingDefaultLocation => 'डीफॉल्ट स्थान: खारघर वापरले जात आहे';

  @override
  String get home => 'मुख्यपृष्ठ';

  @override
  String get categories => 'श्रेणी';

  @override
  String get cart => 'कार्ट';

  @override
  String get orders => 'ऑर्डर';

  @override
  String get profile => 'प्रोफाइल';

  @override
  String get searchProducts => 'उत्पादने शोधा…';

  @override
  String get freshToday => 'आजचे ताजे';

  @override
  String get buyAgain => 'पुन्हा खरेदी करा';

  @override
  String get seeAll => 'सर्व पहा';

  @override
  String get offersForYou => 'आपल्यासाठी ऑफर';

  @override
  String get jioPrimeBanner => 'JioPrime सक्रिय करा – 5% अतिरिक्त सवलत मिळवा';

  @override
  String get changeStore => 'स्टोअर बदला';

  @override
  String get addToCart => 'कार्टमध्ये जोडा';

  @override
  String get addedToCart => 'कार्टमध्ये जोडले!';

  @override
  String get outOfStock => 'स्टॉकमध्ये नाही';

  @override
  String get inStock => 'स्टॉकमध्ये आहे';

  @override
  String get fewLeft => 'थोडे शिल्लक';

  @override
  String get qty => 'प्रमाण';

  @override
  String get kg => 'किग्रा';

  @override
  String get perKg => 'प्रति किग्रा';

  @override
  String get perPack => 'प्रति पॅक';

  @override
  String get loose => 'सुटे';

  @override
  String get packed => 'पॅक';

  @override
  String get organic => 'सेंद्रिय';

  @override
  String get underRs100 => '₹100 पेक्षा कमी';

  @override
  String get sortBy => 'क्रमवारी लावा';

  @override
  String get priceLowHigh => 'किंमत: कमी ते जास्त';

  @override
  String get priceHighLow => 'किंमत: जास्त ते कमी';

  @override
  String get freshness => 'ताजेपणा';

  @override
  String get filter => 'फिल्टर';

  @override
  String get productDetails => 'उत्पाद तपशील';

  @override
  String get selectWeight => 'वजन निवडा';

  @override
  String get selectVariant => 'प्रकार निवडा';

  @override
  String get ripeness => 'पक्वता';

  @override
  String get raw => 'कच्चे';

  @override
  String get medium => 'मध्यम';

  @override
  String get ripe => 'पिकलेले';

  @override
  String get freshnessGuarantee => 'ताजेपणाची हमी';

  @override
  String get freshnessPolicy =>
      '100% ताजे किंवा डिलिव्हरीच्या 24 तासांत पूर्ण परतावा.';

  @override
  String get farmerSource => 'शेतकरी स्त्रोत';

  @override
  String get memberPrice => 'सदस्य किंमत';

  @override
  String get memberBadge => 'JioPrime';

  @override
  String youSave(String amount) {
    return 'तुम्ही $amount वाचवता';
  }

  @override
  String totalPrice(String price) {
    return 'एकूण: $price';
  }

  @override
  String get myCart => 'माझी कार्ट';

  @override
  String get cartEmpty => 'तुमची कार्ट रिकामी आहे';

  @override
  String get cartEmptySubtitle => 'सुरुवात करण्यासाठी स्टोअरमधून आयटम जोडा';

  @override
  String get shopNow => 'आता खरेदी करा';

  @override
  String get chooseDeliverySlot => 'डिलिव्हरी स्लॉट निवडा';

  @override
  String get proceedToCheckout => 'चेकआउट करा';

  @override
  String get billDetails => 'बिल तपशील';

  @override
  String get subtotal => 'उपएकूण';

  @override
  String get bulkDiscount => 'बल्क सवलत (5%)';

  @override
  String get memberDiscount => 'सदस्य सवलत (5%)';

  @override
  String get deliveryFee => 'डिलिव्हरी शुल्क';

  @override
  String get free => 'मोफत';

  @override
  String get gst => 'GST';

  @override
  String get cgst => 'CGST';

  @override
  String get sgst => 'SGST';

  @override
  String get grandTotal => 'एकूण रक्कम';

  @override
  String get totalSavings => 'एकूण बचत';

  @override
  String get swipeToDelete => 'काढण्यासाठी स्वाइप करा';

  @override
  String get itemRemoved => 'आयटम काढला';

  @override
  String get undo => 'पूर्ववत करा';

  @override
  String get appliedOffer => 'ऑफर लागू';

  @override
  String get deliverySlot => 'डिलिव्हरी स्लॉट';

  @override
  String get selectDate => 'तारीख निवडा';

  @override
  String get selectTime => 'वेळ निवडा';

  @override
  String get earlyBird => 'अर्ली बर्ड';

  @override
  String get freeDelivery => 'मोफत डिलिव्हरी';

  @override
  String get slotFull => 'भरलेला';

  @override
  String slotsLeft(int count) {
    return '$count शिल्लक';
  }

  @override
  String get confirmSlot => 'स्लॉट निश्चित करा';

  @override
  String get slotSelected => 'स्लॉट निवडला';

  @override
  String get checkout => 'चेकआउट';

  @override
  String get deliveryAddress => 'डिलिव्हरी पत्ता';

  @override
  String get changeAddress => 'बदला';

  @override
  String get addNewAddress => 'नवीन पत्ता जोडा';

  @override
  String get slotSummary => 'डिलिव्हरी स्लॉट';

  @override
  String get needGstInvoice => 'मला GST पावती हवी आहे';

  @override
  String get businessName => 'व्यवसायाचे नाव';

  @override
  String get gstin => 'GSTIN';

  @override
  String get gstinHint => '15 अक्षरांचा GSTIN';

  @override
  String get businessAddress => 'व्यवसायाचा पत्ता';

  @override
  String get email => 'ईमेल पत्ता';

  @override
  String get orderSummary => 'ऑर्डर सारांश';

  @override
  String get placeOrder => 'ऑर्डर द्या';

  @override
  String get guestCheckoutPrompt => 'ऑर्डर देण्यासाठी कृपया लॉगिन करा';

  @override
  String get loginToPlaceOrder => 'लॉगिन करा';

  @override
  String get payment => 'पेमेंट';

  @override
  String get selectPayment => 'पेमेंट पद्धत निवडा';

  @override
  String get upi => 'UPI';

  @override
  String get cards => 'क्रेडिट / डेबिट कार्ड';

  @override
  String get netBanking => 'नेट बँकिंग';

  @override
  String get jioMoney => 'JioMoney';

  @override
  String get cod => 'कॅश ऑन डिलिव्हरी';

  @override
  String get upiId => 'UPI ID';

  @override
  String get upiHint => 'yourname@upi';

  @override
  String get cardNumber => 'कार्ड नंबर';

  @override
  String get expiryDate => 'समाप्ती (MM/YY)';

  @override
  String get cvv => 'CVV';

  @override
  String get cardholderName => 'कार्डधारकाचे नाव';

  @override
  String payNow(String amount) {
    return '$amount भरा';
  }

  @override
  String get processingPayment => 'पेमेंट प्रक्रिया सुरू आहे…';

  @override
  String get paymentSuccess => 'पेमेंट यशस्वी!';

  @override
  String get paymentFailed => 'पेमेंट अयशस्वी';

  @override
  String get tryAgain => 'पुन्हा प्रयत्न करा';

  @override
  String get orderConfirmed => 'ऑर्डर निश्चित!';

  @override
  String get orderPlacedSubtitle => 'तुमची ऑर्डर यशस्वीरित्या दिली गेली आहे.';

  @override
  String get orderId => 'ऑर्डर ID';

  @override
  String get estimatedDelivery => 'अनुमानित डिलिव्हरी';

  @override
  String get trackOrder => 'ऑर्डर ट्रॅक करा';

  @override
  String get continueShopping => 'खरेदी सुरू ठेवा';

  @override
  String get orderTimeline => 'ऑर्डर टाइमलाइन';

  @override
  String get orderHistory => 'माझे ऑर्डर';

  @override
  String get ongoing => 'चालू';

  @override
  String get past => 'जुने';

  @override
  String get viewReceipt => 'पावती पहा';

  @override
  String get repeatOrder => 'ऑर्डर पुन्हा करा';

  @override
  String get noOrders => 'अद्याप कोणताही ऑर्डर नाही';

  @override
  String get noOngoingOrders => 'कोणताही चालू ऑर्डर नाही';

  @override
  String get noPastOrders => 'कोणताही जुना ऑर्डर नाही';

  @override
  String get repeatOrderTitle => 'ऑर्डर पुन्हा करा';

  @override
  String get unavailable => 'उपलब्ध नाही';

  @override
  String get addAllToCart => 'सर्व कार्टमध्ये जोडा';

  @override
  String get quantitySlider => 'प्रमाण';

  @override
  String totalItems(int count) {
    return '$count आयटम';
  }

  @override
  String get digitalReceipt => 'डिजिटल पावती';

  @override
  String get receiptFrom => 'रिलायन्स स्मार्ट बाजार';

  @override
  String get item => 'आयटम';

  @override
  String get rate => 'दर';

  @override
  String get amount => 'रक्कम';

  @override
  String get discounts => 'सवलती';

  @override
  String get downloadPdf => 'PDF डाउनलोड करा';

  @override
  String get shareReceipt => 'शेअर करा';

  @override
  String get taxInvoice => 'कर चालान';

  @override
  String get receipt => 'पावती';

  @override
  String get myProfile => 'माझी प्रोफाइल';

  @override
  String get editProfile => 'प्रोफाइल संपादित करा';

  @override
  String get savedAddresses => 'जतन केलेले पत्ते';

  @override
  String get businessGstDetails => 'व्यवसाय / GST तपशील';

  @override
  String get language => 'भाषा';

  @override
  String get notifications => 'सूचना';

  @override
  String get offers => 'ऑफर आणि डील';

  @override
  String get orderUpdates => 'ऑर्डर अपडेट';

  @override
  String get deliveryAlerts => 'डिलिव्हरी अलर्ट';

  @override
  String get helpSupport => 'मदत आणि समर्थन';

  @override
  String get faq => 'वारंवार विचारले जाणारे प्रश्न';

  @override
  String get logout => 'लॉगआउट';

  @override
  String get logoutConfirm => 'तुम्हाला खरोखर लॉगआउट करायचे आहे का?';

  @override
  String get cancel => 'रद्द करा';

  @override
  String get save => 'जतन करा';

  @override
  String get delete => 'काढा';

  @override
  String get edit => 'संपादित करा';

  @override
  String get add => 'जोडा';

  @override
  String get yes => 'होय';

  @override
  String get no => 'नाही';

  @override
  String get ok => 'ठीक आहे';

  @override
  String get close => 'बंद करा';

  @override
  String get confirm => 'निश्चित करा';

  @override
  String get back => 'मागे';

  @override
  String get defaultAddress => 'डीफॉल्ट';

  @override
  String get setAsDefault => 'डीफॉल्ट म्हणून सेट करा';

  @override
  String get addressLabel => 'लेबल (घर / कार्यालय / इतर)';

  @override
  String get fullName => 'पूर्ण नाव';

  @override
  String get flatDoor => 'फ्लॅट / दरवाजा क्र.';

  @override
  String get streetLocality => 'रस्ता / परिसर';

  @override
  String get areaColony => 'क्षेत्र / वसाहत';

  @override
  String get city => 'शहर';

  @override
  String get state => 'राज्य';

  @override
  String get pincode => 'पिनकोड';

  @override
  String get noInternetConnection => 'इंटरनेट कनेक्शन नाही';

  @override
  String get somethingWentWrong => 'काहीतरी चुकले';

  @override
  String get retry => 'पुन्हा प्रयत्न करा';

  @override
  String get loading => 'लोड होत आहे…';

  @override
  String get searching => 'शोधत आहे…';

  @override
  String get noResults => 'कोणताही परिणाम सापडला नाही';

  @override
  String get storeCode => 'स्टोअर कोड';

  @override
  String get storeTimings => 'वेळ';

  @override
  String get inventoryLevels => 'यादी';

  @override
  String get shopFromStore => 'या स्टोअरमधून खरेदी करा';

  @override
  String get todayLabel => 'आज';

  @override
  String get tomorrowLabel => 'उद्या';

  @override
  String get jioPrimeActive => 'JioPrime सक्रिय';

  @override
  String get jioPrimeInactive => 'JioPrime सक्रिय करा';

  @override
  String get jioPrimeDesc => 'प्रत्येक ऑर्डरवर 5% अतिरिक्त सवलत मिळवा';

  @override
  String get phoneNumber => 'फोन नंबर';

  @override
  String version(String version) {
    return 'आवृत्ती $version';
  }
}
