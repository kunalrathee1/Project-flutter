// ============================================================
// Mock Products – 30+ realistic products for Kharghar Reliance Smart.
// NOTE: DEMO DATA – prices are illustrative, not real market prices.
// Images via Unsplash stable URLs (crop=entropy for variety).
// ============================================================
import '../models/models.dart';

/// Unsplash helper – stable reproducible image per product
String _img(String photoId) =>
    'https://images.unsplash.com/photo-$photoId?w=400&q=80&fit=crop&auto=format';

// ============================================================
// FRUITS
// ============================================================
const _alphonsoFarmer = FarmerInfo(
  name: 'Ramesh Patil',
  village: 'Devgad',
  state: 'Maharashtra',
  lat: 16.3854,
  lng: 73.3879,
  photoUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&q=80',
);

const _bananaFarmer = FarmerInfo(
  name: 'Suresh Kumar',
  village: 'Jalgaon',
  state: 'Maharashtra',
  lat: 21.0,
  lng: 75.56,
  photoUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=200&q=80',
);

const _tomatoFarmer = FarmerInfo(
  name: 'Ganesh Yadav',
  village: 'Nashik',
  state: 'Maharashtra',
  lat: 19.9975,
  lng: 73.7898,
  photoUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200&q=80',
);

// ============================================================
// STORE STOCK MAPS (storeId -> 0.0–1.0)
// ============================================================
const _highStock = {
  'RS-NVM-0142': 0.95,
  'RS-NVM-0175': 0.80,
  'RS-NVM-0108': 0.88,
  'RS-NVM-0199': 0.60,
  'RS-NVM-0211': 0.82,
  'RS-NVM-0067': 0.94,
};

const _medStock = {
  'RS-NVM-0142': 0.75,
  'RS-NVM-0175': 0.70,
  'RS-NVM-0108': 0.80,
  'RS-NVM-0199': 0.55,
  'RS-NVM-0211': 0.65,
  'RS-NVM-0067': 0.78,
};

const _lowStock = {
  'RS-NVM-0142': 0.40,
  'RS-NVM-0175': 0.30,
  'RS-NVM-0108': 0.45,
  'RS-NVM-0199': 0.20,
  'RS-NVM-0211': 0.35,
  'RS-NVM-0067': 0.50,
};

final List<Product> mockProducts = [
  // ================================================================
  // FRUITS
  // ================================================================

  Product(
    id: 'fruit_mango_alphonso',
    names: {
      'en': 'Alphonso Mango',
      'hi': 'अल्फांसो आम',
      'mr': 'अल्फान्सो आंबा',
      'gu': 'આલ્ફાન્સો આંબો',
    },
    category: ProductCategory.fruits,
    imageUrl: _img('1568702846887-e0d4d3f9f8e'),
    gstRate: 0.0,
    hasFreshnessGuarantee: true,
    ripeness: true,
    farmer: _alphonsoFarmer,
    description:
        'Premium Devgad Alphonso mangoes – the king of mangoes. Rich, creamy and aromatic pulp with no fibre.',
    storeStock: _highStock,
    variants: [
      const ProductVariant(
        id: 'mango_loose_kg',
        label: 'Loose (per kg)',
        pricePerUnit: 280.0,
        memberPricePerUnit: 266.0,
        packSizeKg: 1.0,
        isLoose: true,
      ),
      const ProductVariant(
        id: 'mango_6pc_pack',
        label: '6 Pcs Pack (~1 kg)',
        pricePerUnit: 299.0,
        memberPricePerUnit: 284.0,
        packSizeKg: 1.0,
        isLoose: false,
      ),
      const ProductVariant(
        id: 'mango_12pc_box',
        label: '12 Pcs Gift Box (~2 kg)',
        pricePerUnit: 549.0,
        memberPricePerUnit: 519.0,
        packSizeKg: 2.0,
        isLoose: false,
      ),
    ],
  ),

  Product(
    id: 'fruit_banana',
    names: {
      'en': 'Banana',
      'hi': 'केला',
      'mr': 'केळी',
      'gu': 'કેળું',
    },
    category: ProductCategory.fruits,
    imageUrl: _img('1571771894821-ce9b6c11b08e'),
    gstRate: 0.0,
    hasFreshnessGuarantee: true,
    ripeness: true,
    farmer: _bananaFarmer,
    description: 'Fresh Robusta bananas from Jalgaon. High in potassium and natural energy.',
    storeStock: _highStock,
    variants: [
      const ProductVariant(
        id: 'banana_loose_kg',
        label: 'Loose (per kg)',
        pricePerUnit: 50.0,
        memberPricePerUnit: 47.5,
        packSizeKg: 1.0,
        isLoose: true,
      ),
      const ProductVariant(
        id: 'banana_dozen',
        label: 'Dozen (12 pcs)',
        pricePerUnit: 60.0,
        memberPricePerUnit: 57.0,
        packSizeKg: 1.2,
        isLoose: false,
      ),
    ],
  ),

  Product(
    id: 'fruit_apple',
    names: {
      'en': 'Apple (Shimla)',
      'hi': 'सेब (शिमला)',
      'mr': 'सफरचंद (शिमला)',
      'gu': 'સફરજન (શિમલા)',
    },
    category: ProductCategory.fruits,
    imageUrl: _img('1567306301408-9b74779a11af'),
    gstRate: 0.0,
    hasFreshnessGuarantee: true,
    ripeness: false,
    storeStock: _medStock,
    variants: [
      const ProductVariant(
        id: 'apple_loose_kg',
        label: 'Loose (per kg)',
        pricePerUnit: 180.0,
        memberPricePerUnit: 171.0,
        packSizeKg: 1.0,
        isLoose: true,
      ),
      const ProductVariant(
        id: 'apple_4pc_pack',
        label: '4 Pcs Pack',
        pricePerUnit: 120.0,
        memberPricePerUnit: 114.0,
        packSizeKg: 0.7,
        isLoose: false,
      ),
    ],
  ),

  Product(
    id: 'fruit_papaya',
    names: {
      'en': 'Papaya',
      'hi': 'पपीता',
      'mr': 'पपई',
      'gu': 'પપૈયા',
    },
    category: ProductCategory.fruits,
    imageUrl: _img('1526318136340-99be7db04e56'),
    gstRate: 0.0,
    hasFreshnessGuarantee: true,
    ripeness: true,
    storeStock: _medStock,
    variants: [
      const ProductVariant(
        id: 'papaya_loose_kg',
        label: 'Loose (per kg)',
        pricePerUnit: 45.0,
        memberPricePerUnit: 42.75,
        packSizeKg: 1.0,
        isLoose: true,
      ),
    ],
  ),

  Product(
    id: 'fruit_pomegranate',
    names: {
      'en': 'Pomegranate',
      'hi': 'अनार',
      'mr': 'डाळिंब',
      'gu': 'દાડમ',
    },
    category: ProductCategory.fruits,
    imageUrl: _img('1582284564688-da64b08d3f5e'),
    gstRate: 0.0,
    hasFreshnessGuarantee: true,
    ripeness: false,
    storeStock: _medStock,
    variants: [
      const ProductVariant(
        id: 'pomegranate_loose_kg',
        label: 'Loose (per kg)',
        pricePerUnit: 160.0,
        memberPricePerUnit: 152.0,
        packSizeKg: 1.0,
        isLoose: true,
      ),
      const ProductVariant(
        id: 'pomegranate_2pc',
        label: '2 Pcs (~600g)',
        pricePerUnit: 100.0,
        memberPricePerUnit: 95.0,
        packSizeKg: 0.6,
        isLoose: false,
      ),
    ],
  ),

  Product(
    id: 'fruit_watermelon',
    names: {
      'en': 'Watermelon',
      'hi': 'तरबूज',
      'mr': 'कलिंगड',
      'gu': 'તડબૂચ',
    },
    category: ProductCategory.fruits,
    imageUrl: _img('1568702846887-e0d4d3f9f8f'),
    gstRate: 0.0,
    hasFreshnessGuarantee: true,
    ripeness: false,
    storeStock: _lowStock,
    variants: [
      const ProductVariant(
        id: 'watermelon_piece',
        label: 'Whole (approx 3-5 kg)',
        pricePerUnit: 60.0,
        memberPricePerUnit: 57.0,
        packSizeKg: 4.0,
        isLoose: false,
      ),
      const ProductVariant(
        id: 'watermelon_half',
        label: 'Half Piece',
        pricePerUnit: 35.0,
        memberPricePerUnit: 33.0,
        packSizeKg: 2.0,
        isLoose: false,
      ),
    ],
  ),

  // ================================================================
  // VEGETABLES
  // ================================================================

  Product(
    id: 'veg_tomato',
    names: {
      'en': 'Tomato',
      'hi': 'टमाटर',
      'mr': 'टोमॅटो',
      'gu': 'ટામેટા',
    },
    category: ProductCategory.vegetables,
    imageUrl: _img('1546069901-ba9599a7e63c'),
    gstRate: 0.0,
    hasFreshnessGuarantee: true,
    ripeness: false,
    farmer: _tomatoFarmer,
    storeStock: _highStock,
    variants: [
      const ProductVariant(
        id: 'tomato_loose_kg',
        label: 'Loose (per kg)',
        pricePerUnit: 40.0,
        memberPricePerUnit: 38.0,
        packSizeKg: 1.0,
        isLoose: true,
      ),
      const ProductVariant(
        id: 'tomato_500g',
        label: '500g Pack',
        pricePerUnit: 22.0,
        memberPricePerUnit: 21.0,
        packSizeKg: 0.5,
        isLoose: false,
      ),
    ],
  ),

  Product(
    id: 'veg_onion',
    names: {
      'en': 'Onion',
      'hi': 'प्याज',
      'mr': 'कांदा',
      'gu': 'ડુંગળી',
    },
    category: ProductCategory.vegetables,
    imageUrl: _img('1618512496248-a82f5e86e66e'),
    gstRate: 0.0,
    hasFreshnessGuarantee: false,
    ripeness: false,
    storeStock: _highStock,
    variants: [
      const ProductVariant(
        id: 'onion_loose_kg',
        label: 'Loose (per kg)',
        pricePerUnit: 35.0,
        memberPricePerUnit: 33.25,
        packSizeKg: 1.0,
        isLoose: true,
      ),
      const ProductVariant(
        id: 'onion_2kg',
        label: '2 kg Net Bag',
        pricePerUnit: 65.0,
        memberPricePerUnit: 61.75,
        packSizeKg: 2.0,
        isLoose: false,
      ),
    ],
  ),

  Product(
    id: 'veg_potato',
    names: {
      'en': 'Potato',
      'hi': 'आलू',
      'mr': 'बटाटा',
      'gu': 'બટેટા',
    },
    category: ProductCategory.vegetables,
    imageUrl: _img('1518977676888-4253359a6a24'),
    gstRate: 0.0,
    hasFreshnessGuarantee: false,
    ripeness: false,
    storeStock: _highStock,
    variants: [
      const ProductVariant(
        id: 'potato_loose_kg',
        label: 'Loose (per kg)',
        pricePerUnit: 30.0,
        memberPricePerUnit: 28.5,
        packSizeKg: 1.0,
        isLoose: true,
      ),
      const ProductVariant(
        id: 'potato_5kg',
        label: '5 kg Net Bag',
        pricePerUnit: 130.0,
        memberPricePerUnit: 123.5,
        packSizeKg: 5.0,
        isLoose: false,
      ),
    ],
  ),

  Product(
    id: 'veg_spinach',
    names: {
      'en': 'Spinach (Palak)',
      'hi': 'पालक',
      'mr': 'पालक',
      'gu': 'પાલક',
    },
    category: ProductCategory.vegetables,
    imageUrl: _img('1576045057995-568f588f82fb'),
    gstRate: 0.0,
    hasFreshnessGuarantee: true,
    ripeness: false,
    storeStock: _medStock,
    variants: [
      const ProductVariant(
        id: 'spinach_bunch',
        label: 'Bunch (250g)',
        pricePerUnit: 20.0,
        memberPricePerUnit: 19.0,
        packSizeKg: 0.25,
        isLoose: false,
      ),
      const ProductVariant(
        id: 'spinach_loose_kg',
        label: 'Loose (per kg)',
        pricePerUnit: 60.0,
        memberPricePerUnit: 57.0,
        packSizeKg: 1.0,
        isLoose: true,
      ),
    ],
  ),

  Product(
    id: 'veg_okra',
    names: {
      'en': 'Okra (Bhindi)',
      'hi': 'भिंडी',
      'mr': 'भेंडी',
      'gu': 'ભીંડા',
    },
    category: ProductCategory.vegetables,
    imageUrl: _img('1601493700631-2b16ec4b4716'),
    gstRate: 0.0,
    hasFreshnessGuarantee: true,
    ripeness: false,
    storeStock: _medStock,
    variants: [
      const ProductVariant(
        id: 'okra_loose_kg',
        label: 'Loose (per kg)',
        pricePerUnit: 55.0,
        memberPricePerUnit: 52.25,
        packSizeKg: 1.0,
        isLoose: true,
      ),
    ],
  ),

  Product(
    id: 'veg_cauliflower',
    names: {
      'en': 'Cauliflower',
      'hi': 'फूलगोभी',
      'mr': 'फ्लॉवर',
      'gu': 'ફ્લાવર',
    },
    category: ProductCategory.vegetables,
    imageUrl: _img('1557844352-761f2f4f7bcc'),
    gstRate: 0.0,
    hasFreshnessGuarantee: true,
    ripeness: false,
    storeStock: _medStock,
    variants: [
      const ProductVariant(
        id: 'cauliflower_piece',
        label: 'Per Piece (~500g)',
        pricePerUnit: 35.0,
        memberPricePerUnit: 33.25,
        packSizeKg: 0.5,
        isLoose: false,
      ),
      const ProductVariant(
        id: 'cauliflower_loose_kg',
        label: 'Loose (per kg)',
        pricePerUnit: 60.0,
        memberPricePerUnit: 57.0,
        packSizeKg: 1.0,
        isLoose: true,
      ),
    ],
  ),

  // ================================================================
  // DAIRY
  // ================================================================

  Product(
    id: 'dairy_amul_milk',
    names: {
      'en': 'Amul Gold Milk',
      'hi': 'अमूल गोल्ड दूध',
      'mr': 'अमूल गोल्ड दूध',
      'gu': 'અમૂલ ગોલ્ડ દૂધ',
    },
    category: ProductCategory.dairy,
    imageUrl: _img('1563636619-e9143da7f9f0'),
    gstRate: 0.0,
    hasFreshnessGuarantee: true,
    ripeness: false,
    storeStock: _highStock,
    variants: [
      const ProductVariant(
        id: 'milk_500ml',
        label: '500 ml Pouch',
        pricePerUnit: 30.0,
        memberPricePerUnit: 28.5,
        packSizeKg: 0.5,
        isLoose: false,
      ),
      const ProductVariant(
        id: 'milk_1l',
        label: '1 Litre Pouch',
        pricePerUnit: 57.0,
        memberPricePerUnit: 54.15,
        packSizeKg: 1.0,
        isLoose: false,
      ),
    ],
  ),

  Product(
    id: 'dairy_paneer',
    names: {
      'en': 'Amul Paneer',
      'hi': 'अमूल पनीर',
      'mr': 'अमूल पनीर',
      'gu': 'અમૂલ પનીર',
    },
    category: ProductCategory.dairy,
    imageUrl: _img('1631452180519-a7aa0b47c5d0'),
    gstRate: 0.05,
    hasFreshnessGuarantee: true,
    ripeness: false,
    storeStock: _medStock,
    variants: [
      const ProductVariant(
        id: 'paneer_200g',
        label: '200g Pack',
        pricePerUnit: 80.0,
        memberPricePerUnit: 76.0,
        packSizeKg: 0.2,
        isLoose: false,
      ),
      const ProductVariant(
        id: 'paneer_500g',
        label: '500g Pack',
        pricePerUnit: 190.0,
        memberPricePerUnit: 180.5,
        packSizeKg: 0.5,
        isLoose: false,
      ),
    ],
  ),

  Product(
    id: 'dairy_curd',
    names: {
      'en': 'Mother Dairy Curd',
      'hi': 'मदर डेयरी दही',
      'mr': 'मदर डेयरी दही',
      'gu': 'મધર ડેરી દહીં',
    },
    category: ProductCategory.dairy,
    imageUrl: _img('1571771894821-ce9b6c11b07e'),
    gstRate: 0.05,
    hasFreshnessGuarantee: true,
    ripeness: false,
    storeStock: _highStock,
    variants: [
      const ProductVariant(
        id: 'curd_400g',
        label: '400g Cup',
        pricePerUnit: 35.0,
        memberPricePerUnit: 33.25,
        packSizeKg: 0.4,
        isLoose: false,
      ),
      const ProductVariant(
        id: 'curd_1kg',
        label: '1 kg Pouch',
        pricePerUnit: 78.0,
        memberPricePerUnit: 74.1,
        packSizeKg: 1.0,
        isLoose: false,
      ),
    ],
  ),

  Product(
    id: 'dairy_butter',
    names: {
      'en': 'Amul Butter',
      'hi': 'अमूल बटर',
      'mr': 'अमूल बटर',
      'gu': 'અમૂલ બટર',
    },
    category: ProductCategory.dairy,
    imageUrl: _img('1589985270826-4b7bb135bc9d'),
    gstRate: 0.12,
    hasFreshnessGuarantee: false,
    ripeness: false,
    storeStock: _medStock,
    variants: [
      const ProductVariant(
        id: 'butter_100g',
        label: '100g Pack',
        pricePerUnit: 52.0,
        memberPricePerUnit: 49.4,
        packSizeKg: 0.1,
        isLoose: false,
      ),
      const ProductVariant(
        id: 'butter_500g',
        label: '500g Pack',
        pricePerUnit: 248.0,
        memberPricePerUnit: 235.6,
        packSizeKg: 0.5,
        isLoose: false,
      ),
    ],
  ),

  // ================================================================
  // STAPLES
  // ================================================================

  Product(
    id: 'staple_atta',
    names: {
      'en': 'Aashirvaad Atta',
      'hi': 'आशीर्वाद आटा',
      'mr': 'आशीर्वाद पीठ',
      'gu': 'આશીર્વાદ આટો',
    },
    category: ProductCategory.staples,
    imageUrl: _img('1574323347407-f5d87c861e2f'),
    gstRate: 0.05,
    hasFreshnessGuarantee: false,
    ripeness: false,
    storeStock: _highStock,
    variants: [
      const ProductVariant(
        id: 'atta_1kg',
        label: '1 kg Pack',
        pricePerUnit: 62.0,
        memberPricePerUnit: 58.9,
        packSizeKg: 1.0,
        isLoose: false,
      ),
      const ProductVariant(
        id: 'atta_5kg',
        label: '5 kg Pack',
        pricePerUnit: 290.0,
        memberPricePerUnit: 275.5,
        packSizeKg: 5.0,
        isLoose: false,
      ),
      const ProductVariant(
        id: 'atta_10kg',
        label: '10 kg Pack',
        pricePerUnit: 560.0,
        memberPricePerUnit: 532.0,
        packSizeKg: 10.0,
        isLoose: false,
      ),
    ],
  ),

  Product(
    id: 'staple_toor_dal',
    names: {
      'en': 'Toor Dal (Arhar)',
      'hi': 'तूर दाल',
      'mr': 'तूर डाळ',
      'gu': 'તુવેર દાળ',
    },
    category: ProductCategory.staples,
    imageUrl: _img('1512058454905-6b841e7ad132'),
    gstRate: 0.05,
    hasFreshnessGuarantee: false,
    ripeness: false,
    storeStock: _highStock,
    variants: [
      const ProductVariant(
        id: 'toor_500g',
        label: '500g Pack',
        pricePerUnit: 70.0,
        memberPricePerUnit: 66.5,
        packSizeKg: 0.5,
        isLoose: false,
      ),
      const ProductVariant(
        id: 'toor_1kg',
        label: '1 kg Pack',
        pricePerUnit: 135.0,
        memberPricePerUnit: 128.25,
        packSizeKg: 1.0,
        isLoose: false,
      ),
      const ProductVariant(
        id: 'toor_loose_kg',
        label: 'Loose (per kg)',
        pricePerUnit: 130.0,
        memberPricePerUnit: 123.5,
        packSizeKg: 1.0,
        isLoose: true,
      ),
    ],
  ),

  Product(
    id: 'staple_basmati_rice',
    names: {
      'en': 'India Gate Basmati Rice',
      'hi': 'इंडिया गेट बासमती चावल',
      'mr': 'इंडिया गेट बासमती तांदूळ',
      'gu': 'ઇન્ડિયા ગેટ બાસ્મતી ચોખા',
    },
    category: ProductCategory.staples,
    imageUrl: _img('1586201375761-83865001e8ac'),
    gstRate: 0.05,
    hasFreshnessGuarantee: false,
    ripeness: false,
    storeStock: _highStock,
    variants: [
      const ProductVariant(
        id: 'rice_1kg',
        label: '1 kg Pack',
        pricePerUnit: 85.0,
        memberPricePerUnit: 80.75,
        packSizeKg: 1.0,
        isLoose: false,
      ),
      const ProductVariant(
        id: 'rice_5kg',
        label: '5 kg Pack',
        pricePerUnit: 399.0,
        memberPricePerUnit: 379.05,
        packSizeKg: 5.0,
        isLoose: false,
      ),
    ],
  ),

  Product(
    id: 'staple_sugar',
    names: {
      'en': 'Sugar (Refined)',
      'hi': 'चीनी',
      'mr': 'साखर',
      'gu': 'ખાંડ',
    },
    category: ProductCategory.staples,
    imageUrl: _img('1584305574647-0f89641b3eb5'),
    gstRate: 0.05,
    hasFreshnessGuarantee: false,
    ripeness: false,
    storeStock: _highStock,
    variants: [
      const ProductVariant(
        id: 'sugar_1kg',
        label: '1 kg Pack',
        pricePerUnit: 48.0,
        memberPricePerUnit: 45.6,
        packSizeKg: 1.0,
        isLoose: false,
      ),
      const ProductVariant(
        id: 'sugar_5kg',
        label: '5 kg Pack',
        pricePerUnit: 230.0,
        memberPricePerUnit: 218.5,
        packSizeKg: 5.0,
        isLoose: false,
      ),
      const ProductVariant(
        id: 'sugar_loose_kg',
        label: 'Loose (per kg)',
        pricePerUnit: 46.0,
        memberPricePerUnit: 43.7,
        packSizeKg: 1.0,
        isLoose: true,
      ),
    ],
  ),

  Product(
    id: 'staple_oil_sunflower',
    names: {
      'en': 'Saffola Sunflower Oil',
      'hi': 'सैफोला सनफ्लावर तेल',
      'mr': 'सॅफोला सूर्यफूल तेल',
      'gu': 'સૅફોલા સૂર્યમુખી તેલ',
    },
    category: ProductCategory.staples,
    imageUrl: _img('1620574387784-5b6e5e5e5e5e'),
    gstRate: 0.05,
    hasFreshnessGuarantee: false,
    ripeness: false,
    storeStock: _medStock,
    variants: [
      const ProductVariant(
        id: 'oil_1l',
        label: '1 Litre Bottle',
        pricePerUnit: 155.0,
        memberPricePerUnit: 147.25,
        packSizeKg: 1.0,
        isLoose: false,
      ),
      const ProductVariant(
        id: 'oil_5l',
        label: '5 Litre Can',
        pricePerUnit: 720.0,
        memberPricePerUnit: 684.0,
        packSizeKg: 5.0,
        isLoose: false,
      ),
    ],
  ),

  // ================================================================
  // SNACKS
  // ================================================================

  Product(
    id: 'snack_haldirams_mixture',
    names: {
      'en': 'Haldirams Mixture',
      'hi': 'हल्दीराम्स मिक्सचर',
      'mr': 'हल्दीराम्स मिश्रण',
      'gu': 'હલ્દીરામ્સ મિક્સ',
    },
    category: ProductCategory.snacks,
    imageUrl: _img('1599490772163-3eb7e13d965a'),
    gstRate: 0.12,
    hasFreshnessGuarantee: false,
    ripeness: false,
    storeStock: _highStock,
    variants: [
      const ProductVariant(
        id: 'mixture_200g',
        label: '200g Pack',
        pricePerUnit: 80.0,
        memberPricePerUnit: 76.0,
        packSizeKg: 0.2,
        isLoose: false,
      ),
      const ProductVariant(
        id: 'mixture_400g',
        label: '400g Pack',
        pricePerUnit: 150.0,
        memberPricePerUnit: 142.5,
        packSizeKg: 0.4,
        isLoose: false,
      ),
    ],
  ),

  Product(
    id: 'snack_lays_chips',
    names: {
      'en': "Lay's Classic Salted",
      'hi': "लेज़ क्लासिक",
      'mr': "लेज़ क्लासिक",
      'gu': "લૅઝ ક્લાસિક",
    },
    category: ProductCategory.snacks,
    imageUrl: _img('1553531888-6f78066a2e8d'),
    gstRate: 0.12,
    hasFreshnessGuarantee: false,
    ripeness: false,
    storeStock: _highStock,
    variants: [
      const ProductVariant(
        id: 'lays_26g',
        label: '26g Small Pack',
        pricePerUnit: 20.0,
        memberPricePerUnit: 19.0,
        packSizeKg: 0.026,
        isLoose: false,
      ),
      const ProductVariant(
        id: 'lays_145g',
        label: '145g Family Pack',
        pricePerUnit: 60.0,
        memberPricePerUnit: 57.0,
        packSizeKg: 0.145,
        isLoose: false,
      ),
    ],
  ),

  Product(
    id: 'snack_bikaji_bhujia',
    names: {
      'en': 'Bikaji Bikaneri Bhujia',
      'hi': 'बीकाजी बीकानेरी भुजिया',
      'mr': 'बीकाजी भुजिया',
      'gu': 'બીકાજી ભુજિયા',
    },
    category: ProductCategory.snacks,
    imageUrl: _img('1631906011-df2e5b89bfe3'),
    gstRate: 0.12,
    hasFreshnessGuarantee: false,
    ripeness: false,
    storeStock: _medStock,
    variants: [
      const ProductVariant(
        id: 'bhujia_200g',
        label: '200g Pack',
        pricePerUnit: 85.0,
        memberPricePerUnit: 80.75,
        packSizeKg: 0.2,
        isLoose: false,
      ),
      const ProductVariant(
        id: 'bhujia_500g',
        label: '500g Pack',
        pricePerUnit: 195.0,
        memberPricePerUnit: 185.25,
        packSizeKg: 0.5,
        isLoose: false,
      ),
    ],
  ),

  // ================================================================
  // BEVERAGES
  // ================================================================

  Product(
    id: 'bev_coca_cola',
    names: {
      'en': 'Coca-Cola',
      'hi': 'कोका-कोला',
      'mr': 'कोका-कोला',
      'gu': 'કોકા-કોલા',
    },
    category: ProductCategory.beverages,
    imageUrl: _img('1554866585-74b1c1de8b6e'),
    gstRate: 0.12,
    hasFreshnessGuarantee: false,
    ripeness: false,
    storeStock: _highStock,
    variants: [
      const ProductVariant(
        id: 'coke_250ml',
        label: '250 ml Can',
        pricePerUnit: 40.0,
        memberPricePerUnit: 38.0,
        packSizeKg: 0.25,
        isLoose: false,
      ),
      const ProductVariant(
        id: 'coke_600ml',
        label: '600 ml Bottle',
        pricePerUnit: 45.0,
        memberPricePerUnit: 42.75,
        packSizeKg: 0.6,
        isLoose: false,
      ),
      const ProductVariant(
        id: 'coke_2l',
        label: '2 Litre PET Bottle',
        pricePerUnit: 90.0,
        memberPricePerUnit: 85.5,
        packSizeKg: 2.0,
        isLoose: false,
      ),
    ],
  ),

  Product(
    id: 'bev_real_juice',
    names: {
      'en': 'Real Fruit Juice Mango',
      'hi': 'रियल फ्रूट जूस आम',
      'mr': 'रियल फ्रूट ज्यूस आंबा',
      'gu': 'રિયલ ફ્રૂટ જ્યૂસ કેરી',
    },
    category: ProductCategory.beverages,
    imageUrl: _img('1543362906-acfc16c67564'),
    gstRate: 0.12,
    hasFreshnessGuarantee: false,
    ripeness: false,
    storeStock: _medStock,
    variants: [
      const ProductVariant(
        id: 'juice_200ml',
        label: '200 ml Tetra Pack',
        pricePerUnit: 30.0,
        memberPricePerUnit: 28.5,
        packSizeKg: 0.2,
        isLoose: false,
      ),
      const ProductVariant(
        id: 'juice_1l',
        label: '1 Litre Tetra Pack',
        pricePerUnit: 110.0,
        memberPricePerUnit: 104.5,
        packSizeKg: 1.0,
        isLoose: false,
      ),
    ],
  ),

  Product(
    id: 'bev_tata_tea',
    names: {
      'en': 'Tata Tea Premium',
      'hi': 'टाटा टी प्रीमियम',
      'mr': 'टाटा टी प्रीमियम',
      'gu': 'ટાટા ટી પ્રીમિયમ',
    },
    category: ProductCategory.beverages,
    imageUrl: _img('1556742049-0cfed4f6a45d'),
    gstRate: 0.05,
    hasFreshnessGuarantee: false,
    ripeness: false,
    storeStock: _highStock,
    variants: [
      const ProductVariant(
        id: 'tea_250g',
        label: '250g Pack',
        pricePerUnit: 120.0,
        memberPricePerUnit: 114.0,
        packSizeKg: 0.25,
        isLoose: false,
      ),
      const ProductVariant(
        id: 'tea_500g',
        label: '500g Pack',
        pricePerUnit: 225.0,
        memberPricePerUnit: 213.75,
        packSizeKg: 0.5,
        isLoose: false,
      ),
    ],
  ),

  Product(
    id: 'bev_nescafe_instant',
    names: {
      'en': 'Nescafé Classic',
      'hi': 'नेस्कैफे क्लासिक',
      'mr': 'नेस्कैफे क्लासिक',
      'gu': 'નેસ્કૅફે ક્લાસિક',
    },
    category: ProductCategory.beverages,
    imageUrl: _img('1514228742587-6b1558fcca3d'),
    gstRate: 0.12,
    hasFreshnessGuarantee: false,
    ripeness: false,
    storeStock: _medStock,
    variants: [
      const ProductVariant(
        id: 'coffee_50g',
        label: '50g Jar',
        pricePerUnit: 160.0,
        memberPricePerUnit: 152.0,
        packSizeKg: 0.05,
        isLoose: false,
      ),
      const ProductVariant(
        id: 'coffee_200g',
        label: '200g Jar',
        pricePerUnit: 530.0,
        memberPricePerUnit: 503.5,
        packSizeKg: 0.2,
        isLoose: false,
      ),
    ],
  ),

  // Additional staple
  Product(
    id: 'staple_salt',
    names: {
      'en': 'Tata Salt (Iodized)',
      'hi': 'टाटा नमक',
      'mr': 'टाटा मीठ',
      'gu': 'ટાટા મીઠું',
    },
    category: ProductCategory.staples,
    imageUrl: _img('1571771894821-ce9b6c11b09e'),
    gstRate: 0.0,
    hasFreshnessGuarantee: false,
    ripeness: false,
    storeStock: _highStock,
    variants: [
      const ProductVariant(
        id: 'salt_1kg',
        label: '1 kg Pack',
        pricePerUnit: 22.0,
        memberPricePerUnit: 20.9,
        packSizeKg: 1.0,
        isLoose: false,
      ),
    ],
  ),

  Product(
    id: 'staple_mustard_oil',
    names: {
      'en': 'Fortune Mustard Oil',
      'hi': 'फॉर्च्यून सरसों तेल',
      'mr': 'फॉर्च्यून मोहरी तेल',
      'gu': 'ફૉર્ચ્યુન રાઈ તેલ',
    },
    category: ProductCategory.staples,
    imageUrl: _img('1535657088888-54f9c7a6c5c0'),
    gstRate: 0.05,
    hasFreshnessGuarantee: false,
    ripeness: false,
    storeStock: _medStock,
    variants: [
      const ProductVariant(
        id: 'mustard_1l',
        label: '1 Litre Bottle',
        pricePerUnit: 170.0,
        memberPricePerUnit: 161.5,
        packSizeKg: 1.0,
        isLoose: false,
      ),
    ],
  ),

  // Additional fruit
  Product(
    id: 'fruit_guava',
    names: {
      'en': 'Guava',
      'hi': 'अमरूद',
      'mr': 'पेरू',
      'gu': 'જામફળ',
    },
    category: ProductCategory.fruits,
    imageUrl: _img('1589985270826-4b7bb135bc9e'),
    gstRate: 0.0,
    hasFreshnessGuarantee: true,
    ripeness: true,
    storeStock: _medStock,
    variants: [
      const ProductVariant(
        id: 'guava_loose_kg',
        label: 'Loose (per kg)',
        pricePerUnit: 80.0,
        memberPricePerUnit: 76.0,
        packSizeKg: 1.0,
        isLoose: true,
      ),
    ],
  ),

  // Fresh Pomegranate
  Product(
    id: 'fruit_pomegranate',
    names: {
      'en': 'Fresh Pomegranate (Anar)',
      'hi': 'ताज़ा अनार',
      'mr': 'डाळिंब',
      'gu': 'દાડમ',
    },
    category: ProductCategory.fruits,
    imageUrl: _img('1557800636-894a64c1696f'),
    gstRate: 0.0,
    hasFreshnessGuarantee: true,
    ripeness: true,
    storeStock: _highStock,
    variants: [
      const ProductVariant(
        id: 'pom_loose_kg',
        label: 'Loose (per kg)',
        pricePerUnit: 180.0,
        memberPricePerUnit: 165.0,
        packSizeKg: 1.0,
        isLoose: true,
      ),
      const ProductVariant(
        id: 'pom_pack_4pc',
        label: '4 Pcs Pack (~800g)',
        pricePerUnit: 149.0,
        memberPricePerUnit: 139.0,
        packSizeKg: 0.8,
        isLoose: false,
      ),
    ],
  ),

  // Green Capsicum
  Product(
    id: 'veg_capsicum',
    names: {
      'en': 'Green Capsicum (Shimla Mirch)',
      'hi': 'शिमला मिर्च',
      'mr': 'ढोबळी मिरची',
      'gu': 'કેપ્સીકમ',
    },
    category: ProductCategory.vegetables,
    imageUrl: _img('1594968973184-9040a5a79963'),
    gstRate: 0.0,
    hasFreshnessGuarantee: true,
    storeStock: _highStock,
    variants: [
      const ProductVariant(
        id: 'capsicum_500g',
        label: '500g Pack',
        pricePerUnit: 45.0,
        memberPricePerUnit: 40.0,
        packSizeKg: 0.5,
        isLoose: false,
      ),
      const ProductVariant(
        id: 'capsicum_loose_kg',
        label: 'Loose (per kg)',
        pricePerUnit: 85.0,
        memberPricePerUnit: 79.0,
        packSizeKg: 1.0,
        isLoose: true,
      ),
    ],
  ),

  // Amul Salted Butter
  Product(
    id: 'dairy_amul_butter',
    names: {
      'en': 'Amul Pasteurised Salted Butter',
      'hi': 'अमुल मक्खन',
      'mr': 'अमुल लोणी',
      'gu': 'અમૂલ માખણ',
    },
    category: ProductCategory.dairy,
    imageUrl: _img('1589985270826-4b7bb135bc9e'),
    gstRate: 0.12,
    storeStock: _highStock,
    description: 'Utterly Butterly Delicious Amul butter made from pure milk fat.',
    variants: [
      const ProductVariant(
        id: 'butter_100g',
        label: '100g Carton',
        pricePerUnit: 58.0,
        memberPricePerUnit: 55.0,
        packSizeKg: 0.1,
        isLoose: false,
      ),
      const ProductVariant(
        id: 'butter_500g',
        label: '500g Value Pack',
        pricePerUnit: 275.0,
        memberPricePerUnit: 260.0,
        packSizeKg: 0.5,
        isLoose: false,
      ),
    ],
  ),

  // Fresh Paneer
  Product(
    id: 'dairy_fresh_paneer',
    names: {
      'en': 'Fresh Malai Paneer',
      'hi': 'ताज़ा मलाई पनीर',
      'mr': 'मलाई पनीर',
      'gu': 'તાજું પનીર',
    },
    category: ProductCategory.dairy,
    imageUrl: _img('1631452180519-c014fe946bc7'),
    gstRate: 0.05,
    hasFreshnessGuarantee: true,
    storeStock: _highStock,
    description: 'Soft, creamy and rich protein paneer made from fresh dairy milk.',
    variants: [
      const ProductVariant(
        id: 'paneer_200g',
        label: '200g Vacuum Pack',
        pricePerUnit: 90.0,
        memberPricePerUnit: 84.0,
        packSizeKg: 0.2,
        isLoose: false,
      ),
    ],
  ),

  // Amul Masti Dahi
  Product(
    id: 'dairy_amul_dahi',
    names: {
      'en': 'Amul Masti Dahi (Curd)',
      'hi': 'अमुल मस्ती दही',
      'mr': 'अमुल दही',
      'gu': 'અમૂલ મસ્તી દહીં',
    },
    category: ProductCategory.dairy,
    imageUrl: _img('1550583724-b2692b85b150'),
    gstRate: 0.05,
    storeStock: _highStock,
    variants: [
      const ProductVariant(
        id: 'dahi_400g',
        label: '400g Tub',
        pricePerUnit: 35.0,
        memberPricePerUnit: 32.0,
        packSizeKg: 0.4,
        isLoose: false,
      ),
    ],
  ),

  // Aashirvaad Shudh Chakki Atta
  Product(
    id: 'staples_aashirvaad_atta',
    names: {
      'en': 'Aashirvaad Shudh Chakki Atta',
      'hi': 'आशीर्वाद शुद्ध चक्की आटा',
      'mr': 'आशीर्वाद चक्की पीठ',
      'gu': 'આશીર્વાદ શુદ્ધ ચક્કી લોટ',
    },
    category: ProductCategory.staples,
    imageUrl: _img('1574323347407-f5e1ad6d020b'),
    gstRate: 0.05,
    storeStock: _highStock,
    description: '100% whole wheat chakki atta with 0% maida for soft, fluffy rotis.',
    variants: [
      const ProductVariant(
        id: 'atta_5kg',
        label: '5 kg Bag',
        pricePerUnit: 245.0,
        memberPricePerUnit: 229.0,
        packSizeKg: 5.0,
        isLoose: false,
      ),
      const ProductVariant(
        id: 'atta_10kg',
        label: '10 kg Mega Saver',
        pricePerUnit: 465.0,
        memberPricePerUnit: 439.0,
        packSizeKg: 10.0,
        isLoose: false,
      ),
    ],
  ),

  // India Gate Basmati Rice
  Product(
    id: 'staples_basmati_rice',
    names: {
      'en': 'India Gate Feast Rozzana Basmati Rice',
      'hi': 'इण्डिया गेट बासमती चावल',
      'mr': 'इंडिया गेट बासमती तांदूळ',
      'gu': 'ઈન્ડિયા ગેટ બાસમતી ચોખા',
    },
    category: ProductCategory.staples,
    imageUrl: _img('1586201375761-83865001e31c'),
    gstRate: 0.05,
    storeStock: _highStock,
    description: 'Aromatic long-grain basmati rice perfect for daily biryanis and pulao.',
    variants: [
      const ProductVariant(
        id: 'basmati_1kg',
        label: '1 kg Pouch',
        pricePerUnit: 110.0,
        memberPricePerUnit: 99.0,
        packSizeKg: 1.0,
        isLoose: false,
      ),
      const ProductVariant(
        id: 'basmati_5kg',
        label: '5 kg Bag',
        pricePerUnit: 499.0,
        memberPricePerUnit: 459.0,
        packSizeKg: 5.0,
        isLoose: false,
      ),
    ],
  ),

  // Fortune Sunflower Oil
  Product(
    id: 'staples_fortune_oil',
    names: {
      'en': 'Fortune Sunlite Refined Sunflower Oil',
      'hi': 'फॉर्च्यून सूरजमुखी तेल',
      'mr': 'फॉर्च्यून सूर्यफूल तेल',
      'gu': 'ફોર્ચ્યુન સનફ્લાવર તેલ',
    },
    category: ProductCategory.staples,
    imageUrl: _img('1474979266404-7eaacbcd87c5'),
    gstRate: 0.05,
    storeStock: _highStock,
    variants: [
      const ProductVariant(
        id: 'oil_1l_pouch',
        label: '1 Litre Pouch',
        pricePerUnit: 135.0,
        memberPricePerUnit: 124.0,
        packSizeKg: 1.0,
        isLoose: false,
      ),
      const ProductVariant(
        id: 'oil_5l_can',
        label: '5 Litre Jar',
        pricePerUnit: 649.0,
        memberPricePerUnit: 610.0,
        packSizeKg: 5.0,
        isLoose: false,
      ),
    ],
  ),

  // Tata Salt
  Product(
    id: 'staples_tata_salt',
    names: {
      'en': 'Tata Salt (Desh Ka Namak)',
      'hi': 'टाटा नमक',
      'mr': 'टाटा मीठ',
      'gu': 'ટાટા મીઠું',
    },
    category: ProductCategory.staples,
    imageUrl: _img('1518843875459-f738682238a6'),
    gstRate: 0.0,
    storeStock: _highStock,
    variants: [
      const ProductVariant(
        id: 'tata_salt_1kg',
        label: '1 kg Pouch',
        pricePerUnit: 28.0,
        memberPricePerUnit: 25.0,
        packSizeKg: 1.0,
        isLoose: false,
      ),
    ],
  ),

  // Maggi Noodles
  Product(
    id: 'snacks_maggi_noodles',
    names: {
      'en': 'Maggi 2-Minute Masala Noodles',
      'hi': 'मैगी 2-मिनट मसाला नूडल्स',
      'mr': 'मॅगी नूडल्स',
      'gu': 'મેગી મસાલા નૂડલ્સ',
    },
    category: ProductCategory.snacks,
    imageUrl: _img('1612927601601-6638404737ce'),
    gstRate: 0.12,
    storeStock: _highStock,
    description: 'Favorite Indian snack made with quality spices and herbs.',
    variants: [
      const ProductVariant(
        id: 'maggi_sing_70g',
        label: '70g Single Pack',
        pricePerUnit: 14.0,
        memberPricePerUnit: 13.0,
        packSizeKg: 0.07,
        isLoose: false,
      ),
      const ProductVariant(
        id: 'maggi_pack_6',
        label: 'Pack of 6 (420g)',
        pricePerUnit: 82.0,
        memberPricePerUnit: 76.0,
        packSizeKg: 0.42,
        isLoose: false,
      ),
    ],
  ),

  // Haldiram's Aloo Bhujia
  Product(
    id: 'snacks_haldirams_bhujia',
    names: {
      'en': "Haldiram's Nagpur Aloo Bhujia",
      'hi': 'हल्दीराम आलू भुजिया',
      'mr': 'हल्दीराम बटाटा भुजिया',
      'gu': 'હલ્દીરામ આલુ ભુજીયા',
    },
    category: ProductCategory.snacks,
    imageUrl: _img('1599490659213-e2b9527bd087'),
    gstRate: 0.12,
    storeStock: _highStock,
    variants: [
      const ProductVariant(
        id: 'bhujia_200g',
        label: '200g Pack',
        pricePerUnit: 55.0,
        memberPricePerUnit: 50.0,
        packSizeKg: 0.2,
        isLoose: false,
      ),
      const ProductVariant(
        id: 'bhujia_400g',
        label: '400g Saver Pack',
        pricePerUnit: 105.0,
        memberPricePerUnit: 95.0,
        packSizeKg: 0.4,
        isLoose: false,
      ),
    ],
  ),

  // Britannia Good Day
  Product(
    id: 'snacks_good_day_cookies',
    names: {
      'en': 'Britannia Good Day Butter Cookies',
      'hi': 'ब्रिटानिया गुड डे बिस्कुट',
      'mr': 'ब्रिटानिया गुड डे',
      'gu': 'બ્રિટાનિયા ગુડ ડે',
    },
    category: ProductCategory.snacks,
    imageUrl: _img('1558961363-fa8fdf82db35'),
    gstRate: 0.18,
    storeStock: _highStock,
    variants: [
      const ProductVariant(
        id: 'good_day_200g',
        label: '200g Pack',
        pricePerUnit: 40.0,
        memberPricePerUnit: 36.0,
        packSizeKg: 0.2,
        isLoose: false,
      ),
    ],
  ),

  // Tata Tea Gold
  Product(
    id: 'beverages_tata_tea_gold',
    names: {
      'en': 'Tata Tea Gold Premium Tea',
      'hi': 'टाटा टी गोल्ड चायपत्ती',
      'mr': 'टाटा टी गोल्ड चहा',
      'gu': 'ટાટા ટી ગોલ્ડ ચા',
    },
    category: ProductCategory.beverages,
    imageUrl: _img('1544787219-7f47ccb76574'),
    gstRate: 0.05,
    storeStock: _highStock,
    description: 'Unique blend of fine CTC tea leaves with 15% gently rolled long tea leaves.',
    variants: [
      const ProductVariant(
        id: 'tata_tea_250g',
        label: '250g Pouch',
        pricePerUnit: 155.0,
        memberPricePerUnit: 142.0,
        packSizeKg: 0.25,
        isLoose: false,
      ),
      const ProductVariant(
        id: 'tata_tea_500g',
        label: '500g Value Pack',
        pricePerUnit: 295.0,
        memberPricePerUnit: 275.0,
        packSizeKg: 0.5,
        isLoose: false,
      ),
    ],
  ),

  // Real Mixed Fruit Juice
  Product(
    id: 'beverages_real_juice',
    names: {
      'en': 'Real Fruit Power Mixed Fruit Juice',
      'hi': 'रियल मिक्स्ड फ्रूट जूस',
      'mr': 'रियल फ्रूट ज्यूस',
      'gu': 'રીયલ ફ્રૂટ જ્યૂસ',
    },
    category: ProductCategory.beverages,
    imageUrl: _img('1622597467836-f3285f2131b8'),
    gstRate: 0.12,
    storeStock: _highStock,
    variants: [
      const ProductVariant(
        id: 'real_juice_1l',
        label: '1 Litre Tetra Pack',
        pricePerUnit: 120.0,
        memberPricePerUnit: 108.0,
        packSizeKg: 1.0,
        isLoose: false,
      ),
    ],
  ),

  // Frooti Mango Drink
  Product(
    id: 'beverages_frooti',
    names: {
      'en': "Frooti Fresh 'N' Juicy Mango Drink",
      'hi': 'फ्रूटी मैंगो ड्रिंक',
      'mr': 'फ्रुटी मँगो ड्रिंक',
      'gu': 'ફ્રુટી મેંગો ડ્રિન્ક',
    },
    category: ProductCategory.beverages,
    imageUrl: _img('1546173159-315724a31696'),
    gstRate: 0.12,
    storeStock: _highStock,
    variants: [
      const ProductVariant(
        id: 'frooti_1_2l',
        label: '1.2 Litre Pet Bottle',
        pricePerUnit: 70.0,
        memberPricePerUnit: 65.0,
        packSizeKg: 1.2,
        isLoose: false,
      ),
    ],
  ),
];

/// Get products by category
List<Product> productsByCategory(ProductCategory cat) =>
    mockProducts.where((p) => p.category == cat).toList();

/// Search products by query in given locale
List<Product> searchProducts(String query, String locale) {
  if (query.trim().isEmpty) return mockProducts;
  final q = query.trim().toLowerCase();
  return mockProducts.where((p) {
    final nameEn = (p.names['en'] ?? '').toLowerCase();
    final nameLoc = (p.names[locale] ?? '').toLowerCase();
    return nameEn.contains(q) || nameLoc.contains(q);
  }).toList();
}
