// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Gujarati (`gu`).
class AppLocalizationsGu extends AppLocalizations {
  AppLocalizationsGu([String locale = 'gu']) : super(locale);

  @override
  String get appName => 'રિલાયન્સ સ્માર્ટ બજાર';

  @override
  String get splashTagline => 'તાજું. ઝડપી. ડિલિવર.';

  @override
  String get loginTitle => 'સ્વાગત છે';

  @override
  String get loginSubtitle => 'ચાલુ રાખવા માટે તમારો મોબાઇલ નંબર દાખલ કરો';

  @override
  String get mobileNumber => 'મોબાઇલ નંબર';

  @override
  String get mobileHint => '10 અંકનો મોબાઇલ નંબર';

  @override
  String get sendOtp => 'OTP મોકલો';

  @override
  String get continueAsGuest => 'મહેમાન તરીકે ચાલુ રાખો';

  @override
  String get orDivider => 'અથવા';

  @override
  String get newUser => 'નવા વપરાશકર્તા?';

  @override
  String get signUpHere => 'અહીં સાઇન અપ કરો';

  @override
  String get otpTitle => 'OTP ચકાસો';

  @override
  String get otpSubtitle => 'આ નંબર પર મોકલેલ 6 અંકનો OTP દાખલ કરો';

  @override
  String get verify => 'ચકાસો';

  @override
  String get resendOtp => 'OTP ફરીથી મોકલો';

  @override
  String resendIn(int seconds) {
    return '${seconds}s માં ફરીથી મોકલો';
  }

  @override
  String get demoOtpHint => 'ડેમો OTP: 123456';

  @override
  String get wrongOtp => 'ખોટો OTP. કૃપા કરી ફરી પ્રયાસ કરો.';

  @override
  String get selectLanguage => 'ભાષા પસંદ કરો';

  @override
  String get languageSubtitle => 'તમારી પसंदीदा ભાષા પસંદ કરો';

  @override
  String get continueBtn => 'ચાલુ રાખો';

  @override
  String get storeLocator => 'સ્ટોર શોધો';

  @override
  String get searchStores => 'વિસ્તાર અથવા પિનકોડથી શોધો…';

  @override
  String get nearestStores => 'નજીકના સ્ટોર';

  @override
  String get noStoresFound => 'કોઈ સ્ટોર મળ્યો નથી';

  @override
  String get selectStore => 'આ સ્ટોર પસંદ કરો';

  @override
  String get getDirections => 'દિશા મેળવો';

  @override
  String get callStore => 'સ્ટોરને કૉલ કરો';

  @override
  String get openNow => 'હવે ખુલ્લો છે';

  @override
  String get closedNow => 'બંધ';

  @override
  String km(String distance) {
    return '$distance કિ.મી.';
  }

  @override
  String get usingDefaultLocation => 'ડિફૉલ્ટ સ્થાન: ખારઘર ઉપયોગ થઈ રહ્યો છે';

  @override
  String get home => 'હોમ';

  @override
  String get categories => 'શ્રેણીઓ';

  @override
  String get cart => 'કાર્ટ';

  @override
  String get orders => 'ઓર્ડર';

  @override
  String get profile => 'પ્રોફાઇલ';

  @override
  String get searchProducts => 'ઉત્પાદનો શોધો…';

  @override
  String get freshToday => 'આજના તાજા';

  @override
  String get buyAgain => 'ફરીથી ખરીદો';

  @override
  String get seeAll => 'બધું જુઓ';

  @override
  String get offersForYou => 'તમારા માટે ઓફર';

  @override
  String get jioPrimeBanner => 'JioPrime સક્રિય કરો – 5% વધારાની છૂટ મેળવો';

  @override
  String get changeStore => 'સ્ટોર બદલો';

  @override
  String get addToCart => 'કાર્ટમાં ઉમેરો';

  @override
  String get addedToCart => 'કાર્ટમાં ઉમેર્યું!';

  @override
  String get outOfStock => 'સ્ટૉકમાં નથી';

  @override
  String get inStock => 'સ્ટૉકમાં છે';

  @override
  String get fewLeft => 'થોડું બાકી';

  @override
  String get qty => 'જથ્થો';

  @override
  String get kg => 'કિ.ગ્રા.';

  @override
  String get perKg => 'પ્રતિ કિ.ગ્રા.';

  @override
  String get perPack => 'પ્રતિ પૅક';

  @override
  String get loose => 'છૂટક';

  @override
  String get packed => 'પૅક';

  @override
  String get organic => 'ઓર્ગેનિક';

  @override
  String get underRs100 => '₹100 થી ઓછું';

  @override
  String get sortBy => 'ક્રમ ગોઠવો';

  @override
  String get priceLowHigh => 'ભાવ: ઓછાથી વધારે';

  @override
  String get priceHighLow => 'ભાવ: વધારેથી ઓછા';

  @override
  String get freshness => 'તાજગી';

  @override
  String get filter => 'ફિલ્ટર';

  @override
  String get productDetails => 'ઉત્પાદ વિગત';

  @override
  String get selectWeight => 'વજન પસંદ કરો';

  @override
  String get selectVariant => 'વૅરિઅન્ટ પસંદ કરો';

  @override
  String get ripeness => 'પક્વતા';

  @override
  String get raw => 'કાચું';

  @override
  String get medium => 'મધ્યમ';

  @override
  String get ripe => 'પાકેલું';

  @override
  String get freshnessGuarantee => 'તાજગીની ગૅરૅન્ટી';

  @override
  String get freshnessPolicy =>
      '100% તાજું અથવા ડિલિવરીના 24 કલાકમાં સંપૂર્ણ રિફંડ.';

  @override
  String get farmerSource => 'ખેડૂત સ્ત્રોત';

  @override
  String get memberPrice => 'સભ્ય ભાવ';

  @override
  String get memberBadge => 'JioPrime';

  @override
  String youSave(String amount) {
    return 'તમે $amount બચાવો';
  }

  @override
  String totalPrice(String price) {
    return 'કુલ: $price';
  }

  @override
  String get myCart => 'મારી કાર્ટ';

  @override
  String get cartEmpty => 'તમારી કાર્ટ ખાલી છે';

  @override
  String get cartEmptySubtitle => 'શરૂ કરવા માટે સ્ટોરમાંથી આઇટમ ઉમેરો';

  @override
  String get shopNow => 'હવે ખરીદો';

  @override
  String get chooseDeliverySlot => 'ડિલિવરી સ્લૉટ પસંદ કરો';

  @override
  String get proceedToCheckout => 'ચેકઆઉટ કરો';

  @override
  String get billDetails => 'બિલ વિગત';

  @override
  String get subtotal => 'પેટા-કુલ';

  @override
  String get bulkDiscount => 'બલ્ક ડિસ્કાઉન્ટ (5%)';

  @override
  String get memberDiscount => 'સભ્ય ડિસ્કાઉન્ટ (5%)';

  @override
  String get deliveryFee => 'ડિલિવરી ફી';

  @override
  String get free => 'મફત';

  @override
  String get gst => 'GST';

  @override
  String get cgst => 'CGST';

  @override
  String get sgst => 'SGST';

  @override
  String get grandTotal => 'કુલ રકમ';

  @override
  String get totalSavings => 'કુલ બચત';

  @override
  String get swipeToDelete => 'દૂર કરવા સ્વાઇપ કરો';

  @override
  String get itemRemoved => 'આઇટમ દૂર કર્યું';

  @override
  String get undo => 'પૂર્વવત્ કરો';

  @override
  String get appliedOffer => 'ઓફર લાગુ';

  @override
  String get deliverySlot => 'ડિલિવરી સ્લૉટ';

  @override
  String get selectDate => 'તારીખ પસંદ કરો';

  @override
  String get selectTime => 'સમય પસંદ કરો';

  @override
  String get earlyBird => 'અર્લી બર્ડ';

  @override
  String get freeDelivery => 'મફત ડિલિવરી';

  @override
  String get slotFull => 'ભરેલો';

  @override
  String slotsLeft(int count) {
    return '$count બાકી';
  }

  @override
  String get confirmSlot => 'સ્લૉટ પૅક્કો કરો';

  @override
  String get slotSelected => 'સ્લૉટ પસંદ';

  @override
  String get checkout => 'ચેકઆઉટ';

  @override
  String get deliveryAddress => 'ડિલિવરી સરનામું';

  @override
  String get changeAddress => 'બદલો';

  @override
  String get addNewAddress => 'નવું સરનામું ઉમેરો';

  @override
  String get slotSummary => 'ડિલિવરી સ્લૉટ';

  @override
  String get needGstInvoice => 'મને GST ઇન્વૉઇસ જોઈએ';

  @override
  String get businessName => 'વ્યવસાયનું નામ';

  @override
  String get gstin => 'GSTIN';

  @override
  String get gstinHint => '15 અક્ષરનો GSTIN';

  @override
  String get businessAddress => 'વ્યવસાયનું સરનામું';

  @override
  String get email => 'ઇ-મેઇલ સરનામું';

  @override
  String get orderSummary => 'ઓર્ડર સારાંશ';

  @override
  String get placeOrder => 'ઓર્ડર આપો';

  @override
  String get guestCheckoutPrompt => 'ઓર્ડર આપવા કૃપા કરી લૉગ ઇન કરો';

  @override
  String get loginToPlaceOrder => 'લૉગ ઇન કરો';

  @override
  String get payment => 'ચૂકવણી';

  @override
  String get selectPayment => 'ચૂકવણી પ્રકાર પસંદ કરો';

  @override
  String get upi => 'UPI';

  @override
  String get cards => 'ક્રેડિટ / ડેબિટ કાર્ડ';

  @override
  String get netBanking => 'નેટ બૅન્કિંગ';

  @override
  String get jioMoney => 'JioMoney';

  @override
  String get cod => 'કૅશ ઓન ડિલિવરી';

  @override
  String get upiId => 'UPI ID';

  @override
  String get upiHint => 'yourname@upi';

  @override
  String get cardNumber => 'કાર્ડ નંબર';

  @override
  String get expiryDate => 'સમાપ્તિ (MM/YY)';

  @override
  String get cvv => 'CVV';

  @override
  String get cardholderName => 'કાર્ડધારકનું નામ';

  @override
  String payNow(String amount) {
    return '$amount ચૂકવો';
  }

  @override
  String get processingPayment => 'ચૂકવણી પ્રક્રિયા ચાલુ છે…';

  @override
  String get paymentSuccess => 'ચૂકવણી સફળ!';

  @override
  String get paymentFailed => 'ચૂકવણી નિષ્ફળ';

  @override
  String get tryAgain => 'ફરી પ્રયાસ કરો';

  @override
  String get orderConfirmed => 'ઓર્ડર પૅક્કો!';

  @override
  String get orderPlacedSubtitle => 'તમારો ઓર્ડર સફળતાપૂર્વક આપવામાં આવ્યો.';

  @override
  String get orderId => 'ઓર્ડર ID';

  @override
  String get estimatedDelivery => 'અંદાજિત ડિલિવરી';

  @override
  String get trackOrder => 'ઓર્ડર ટ્રૅક કરો';

  @override
  String get continueShopping => 'ખરીદી ચાલુ રાખો';

  @override
  String get orderTimeline => 'ઓર્ડર ટાઇમલાઇન';

  @override
  String get orderHistory => 'મારા ઓર્ડર';

  @override
  String get ongoing => 'ચાલુ';

  @override
  String get past => 'જૂના';

  @override
  String get viewReceipt => 'રિસિટ જુઓ';

  @override
  String get repeatOrder => 'ઓર્ડર ફરી કરો';

  @override
  String get noOrders => 'હજુ કોઈ ઓર્ડર નથી';

  @override
  String get noOngoingOrders => 'કોઈ ચાલુ ઓર્ડર નથી';

  @override
  String get noPastOrders => 'કોઈ જૂનો ઓર્ડર નથી';

  @override
  String get repeatOrderTitle => 'ઓર્ડર ફરી કરો';

  @override
  String get unavailable => 'ઉપલબ્ધ નથી';

  @override
  String get addAllToCart => 'બધું કાર્ટમાં ઉમેરો';

  @override
  String get quantitySlider => 'જથ્થો';

  @override
  String totalItems(int count) {
    return '$count આઇટમ';
  }

  @override
  String get digitalReceipt => 'ડિજિટલ રિસિટ';

  @override
  String get receiptFrom => 'રિલાયન્સ સ્માર્ટ બજાર';

  @override
  String get item => 'આઇટમ';

  @override
  String get rate => 'દર';

  @override
  String get amount => 'રકમ';

  @override
  String get discounts => 'છૂટ';

  @override
  String get downloadPdf => 'PDF ડાઉનલોડ કરો';

  @override
  String get shareReceipt => 'શૅર કરો';

  @override
  String get taxInvoice => 'કર ઇન્વૉઇસ';

  @override
  String get receipt => 'રિસિટ';

  @override
  String get myProfile => 'મારી પ્રોફાઇલ';

  @override
  String get editProfile => 'પ્રોફાઇલ સંપાદિત કરો';

  @override
  String get savedAddresses => 'સાચવેલ સરનામાં';

  @override
  String get businessGstDetails => 'વ્યવસાય / GST વિગત';

  @override
  String get language => 'ભાષા';

  @override
  String get notifications => 'સૂચનાઓ';

  @override
  String get offers => 'ઓફર અને ડિલ';

  @override
  String get orderUpdates => 'ઓર્ડર અપડેટ';

  @override
  String get deliveryAlerts => 'ડિલિવરી એલર્ટ';

  @override
  String get helpSupport => 'મદદ અને સહાય';

  @override
  String get faq => 'વારંવાર પૂછાતા પ્રશ્નો';

  @override
  String get logout => 'લૉગ આઉટ';

  @override
  String get logoutConfirm => 'શું તમે ખરેખર લૉગ આઉટ કરવા માગો છો?';

  @override
  String get cancel => 'રદ કરો';

  @override
  String get save => 'સાચવો';

  @override
  String get delete => 'ભૂંસો';

  @override
  String get edit => 'સંપાદિત કરો';

  @override
  String get add => 'ઉમેરો';

  @override
  String get yes => 'હા';

  @override
  String get no => 'ના';

  @override
  String get ok => 'ઠીક છે';

  @override
  String get close => 'બંધ કરો';

  @override
  String get confirm => 'પૅક્કો કરો';

  @override
  String get back => 'પાછળ';

  @override
  String get defaultAddress => 'ડિફૉલ્ટ';

  @override
  String get setAsDefault => 'ડિફૉલ્ટ તરીકે સેટ કરો';

  @override
  String get addressLabel => 'લેબલ (ઘર / ઑફિસ / અન્ય)';

  @override
  String get fullName => 'પૂરું નામ';

  @override
  String get flatDoor => 'ફ્લૅટ / દરવાજો નં.';

  @override
  String get streetLocality => 'શેરી / વિસ્તાર';

  @override
  String get areaColony => 'એરિયા / કૉલોની';

  @override
  String get city => 'શહેર';

  @override
  String get state => 'રાજ્ય';

  @override
  String get pincode => 'પિનકોડ';

  @override
  String get noInternetConnection => 'ઇન્ટરનેટ કનેક્શન નથી';

  @override
  String get somethingWentWrong => 'કંઈક ખોટું ગયું';

  @override
  String get retry => 'ફરી પ્રયાસ કરો';

  @override
  String get loading => 'લોડ થઈ રહ્યું છે…';

  @override
  String get searching => 'શોધી રહ્યા છીએ…';

  @override
  String get noResults => 'કોઈ પરિણામ મળ્યું નથી';

  @override
  String get storeCode => 'સ્ટોર કોડ';

  @override
  String get storeTimings => 'સમય';

  @override
  String get inventoryLevels => 'ઇન્વૅન્ટરી';

  @override
  String get shopFromStore => 'આ સ્ટોરમાંથી ખરીદો';

  @override
  String get todayLabel => 'આજે';

  @override
  String get tomorrowLabel => 'કાલે';

  @override
  String get jioPrimeActive => 'JioPrime સક્રિય';

  @override
  String get jioPrimeInactive => 'JioPrime સક્રિય કરો';

  @override
  String get jioPrimeDesc => 'દર ઓર્ડર પર 5% વધારાની છૂટ મેળવો';

  @override
  String get phoneNumber => 'ફોન નંબર';

  @override
  String version(String version) {
    return 'સંસ્કરણ $version';
  }
}
