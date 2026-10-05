// ============================================================
// Mock Stores – 6 Reliance Smart stores near Kharghar.
// NOTE: These are DEMO DATA. Addresses are illustrative only.
// ============================================================
import '../models/models.dart';

final List<StoreInfo> mockStores = [
  // ---- Kharghar Sector 12 (closest to default location) ----
  StoreInfo(
    id: 'RS-NVM-0142',
    name: 'Reliance Smart Kharghar Sector 12',
    code: 'RS-NVM-0142',
    address: 'Shop 1-5, Sector 12 Market, Near Central Park',
    area: 'Kharghar Sector 12',
    city: 'Navi Mumbai',
    pincode: '410210',
    phone: '02227742100',
    lat: 19.0474,
    lng: 73.0699,
    zoneCode: 'navi_mumbai',
    inventoryLevels: {
      ProductCategory.fruits: 0.92,
      ProductCategory.vegetables: 0.88,
      ProductCategory.dairy: 0.95,
      ProductCategory.staples: 0.90,
      ProductCategory.snacks: 0.85,
      ProductCategory.beverages: 0.78,
    },
  ),

  // ---- Kharghar Sector 35 / Hiranandani ----
  StoreInfo(
    id: 'RS-NVM-0175',
    name: 'Reliance Smart Hiranandani Kharghar',
    code: 'RS-NVM-0175',
    address: 'Plot 22, Hiranandani Business Park, Sector 35',
    area: 'Kharghar Sector 35',
    city: 'Navi Mumbai',
    pincode: '410210',
    phone: '02227742175',
    lat: 19.0541,
    lng: 73.0742,
    zoneCode: 'navi_mumbai',
    inventoryLevels: {
      ProductCategory.fruits: 0.75,
      ProductCategory.vegetables: 0.80,
      ProductCategory.dairy: 0.90,
      ProductCategory.staples: 0.85,
      ProductCategory.snacks: 0.70,
      ProductCategory.beverages: 0.65,
    },
  ),

  // ---- CBD Belapur ----
  StoreInfo(
    id: 'RS-NVM-0108',
    name: 'Reliance Smart CBD Belapur',
    code: 'RS-NVM-0108',
    address: 'Ground Floor, Belapur Plaza, Sector 11, CBD Belapur',
    area: 'CBD Belapur',
    city: 'Navi Mumbai',
    pincode: '400614',
    phone: '02227741080',
    lat: 19.0220,
    lng: 73.0350,
    zoneCode: 'navi_mumbai',
    inventoryLevels: {
      ProductCategory.fruits: 0.88,
      ProductCategory.vegetables: 0.91,
      ProductCategory.dairy: 0.93,
      ProductCategory.staples: 0.87,
      ProductCategory.snacks: 0.82,
      ProductCategory.beverages: 0.79,
    },
  ),

  // ---- Panvel ----
  StoreInfo(
    id: 'RS-NVM-0199',
    name: 'Reliance Smart Panvel',
    code: 'RS-NVM-0199',
    address: 'Karnala Shopping Centre, Old Panvel, Near Bus Stand',
    area: 'Old Panvel',
    city: 'Panvel',
    pincode: '410206',
    phone: '02227741990',
    lat: 18.9895,
    lng: 73.1090,
    zoneCode: 'navi_mumbai',
    inventoryLevels: {
      ProductCategory.fruits: 0.60,
      ProductCategory.vegetables: 0.70,
      ProductCategory.dairy: 0.85,
      ProductCategory.staples: 0.88,
      ProductCategory.snacks: 0.75,
      ProductCategory.beverages: 0.80,
    },
  ),

  // ---- Kamothe ----
  StoreInfo(
    id: 'RS-NVM-0211',
    name: 'Reliance Smart Kamothe',
    code: 'RS-NVM-0211',
    address: 'Sec 6 Main Road, Kamothe, Near Kamothe Station',
    area: 'Kamothe',
    city: 'Navi Mumbai',
    pincode: '410209',
    phone: '02227742110',
    lat: 19.0160,
    lng: 73.0970,
    zoneCode: 'navi_mumbai',
    inventoryLevels: {
      ProductCategory.fruits: 0.82,
      ProductCategory.vegetables: 0.79,
      ProductCategory.dairy: 0.88,
      ProductCategory.staples: 0.92,
      ProductCategory.snacks: 0.68,
      ProductCategory.beverages: 0.72,
    },
  ),

  // ---- Vashi ----
  StoreInfo(
    id: 'RS-NVM-0067',
    name: 'Reliance Smart Vashi',
    code: 'RS-NVM-0067',
    address: 'Vashi Plaza, Sector 17, Vashi',
    area: 'Vashi',
    city: 'Navi Mumbai',
    pincode: '400703',
    phone: '02227740670',
    lat: 19.0762,
    lng: 73.0058,
    zoneCode: 'navi_mumbai',
    inventoryLevels: {
      ProductCategory.fruits: 0.94,
      ProductCategory.vegetables: 0.89,
      ProductCategory.dairy: 0.97,
      ProductCategory.staples: 0.91,
      ProductCategory.snacks: 0.88,
      ProductCategory.beverages: 0.85,
    },
  ),
];
