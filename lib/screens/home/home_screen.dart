// ============================================================
// HomeScreen – live store bar, search, carousel, categories,
//              rich categorized horizontal shelves, trust badges,
//              and full 2-column endless supermarket grid.
// ============================================================
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';
import '../../core/app_theme.dart';
import '../../data/mock_products.dart';
import '../../l10n/app_localizations.dart';
import '../../models/models.dart';
import '../../providers/cart_provider.dart';
import '../../providers/language_provider.dart';
import '../../providers/order_provider.dart';
import '../../providers/profile_provider.dart';
import '../../providers/store_provider.dart';
import '../../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _carouselCtrl = PageController();
  int _carouselIndex = 0;
  Timer? _carouselTimer;

  static const _offers = [
    {
      'title': 'Fresh Mangoes at ₹280/kg',
      'subtitle': 'Alphonso directly from Devgad farms',
      'color': Color(0xFFFFF3E0),
      'emoji': '🥭',
    },
    {
      'title': 'Buy 2 Get 1 Free on Dairy',
      'subtitle': 'Amul Milk, Paneer & more',
      'color': Color(0xFFE8F5E9),
      'emoji': '🥛',
    },
    {
      'title': 'Early Bird: Free Delivery',
      'subtitle': 'Order in 6–8 AM slot & save ₹40',
      'color': Color(0xFFE3F2FD),
      'emoji': '🐦',
    },
    {
      'title': 'JioPrime Members: Extra 5%',
      'subtitle': 'Activate now and save more',
      'color': Color(0xFFFFF8E1),
      'emoji': '⭐',
    },
  ];

  static const _categories = [
    {'label': 'Fruits', 'emoji': '🍎', 'cat': 'fruits', 'bg': Color(0xFFFFEBEE)},
    {'label': 'Vegetables', 'emoji': '🥦', 'cat': 'vegetables', 'bg': Color(0xFFE8F5E9)},
    {'label': 'Dairy', 'emoji': '🥛', 'cat': 'dairy', 'bg': Color(0xFFE1F5FE)},
    {'label': 'Staples', 'emoji': '🌾', 'cat': 'staples', 'bg': Color(0xFFFFF8E1)},
    {'label': 'Snacks', 'emoji': '🍿', 'cat': 'snacks', 'bg': Color(0xFFFFF3E0)},
    {'label': 'Beverages', 'emoji': '🥤', 'cat': 'beverages', 'bg': Color(0xFFF3E5F5)},
  ];

  @override
  void initState() {
    super.initState();
    _carouselTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;
      _carouselIndex = (_carouselIndex + 1) % _offers.length;
      _carouselCtrl.animateToPage(
        _carouselIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _carouselTimer?.cancel();
    _carouselCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final storeProvider = context.watch<StoreProvider>();
    final cartProvider = context.watch<CartProvider>();
    final langProvider = context.watch<LanguageProvider>();
    final profile = context.watch<ProfileProvider>();
    final orders = context.watch<OrderProvider>();
    final locale = langProvider.languageCode;
    final store = storeProvider.selectedStore;

    // Rich categorized product sets
    final freshProducts = mockProducts
        .where((p) => p.hasFreshnessGuarantee)
        .toList();

    final dealProducts = mockProducts
        .where((p) => p.defaultVariant.memberPricePerUnit < p.defaultVariant.pricePerUnit)
        .toList();

    final dairyProducts = mockProducts
        .where((p) => p.category == ProductCategory.dairy)
        .toList();

    final staplesProducts = mockProducts
        .where((p) => p.category == ProductCategory.staples)
        .toList();

    final snacksProducts = mockProducts
        .where((p) => p.category == ProductCategory.snacks || p.category == ProductCategory.beverages)
        .toList();

    // Buy again from last order
    final lastOrderItems = orders.pastOrders.isNotEmpty
        ? orders.pastOrders.first.items
        : <CartItem>[];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // App bar with Delivery Location & Cart
          SliverAppBar(
            floating: true,
            pinned: true,
            backgroundColor: AppColors.primary,
            elevation: 2,
            title: GestureDetector(
              onTap: () => context.push('/store-locator'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Delivering to',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(
                          color: AppColors.freshGreen,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          '⚡ 30 MINS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        store?.area ?? 'Kharghar, Navi Mumbai',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 18),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.language, color: Colors.white),
                onPressed: () => context.push('/language'),
                tooltip: 'Language',
              ),
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
                    onPressed: () => context.go('/cart'),
                  ),
                  if (cartProvider.itemCount > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          color: AppColors.offerOrange,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                        child: Center(
                          child: Text(
                            '${cartProvider.itemCount}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Quick Search Bar Box
                GestureDetector(
                  onTap: () => context.push('/search'),
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(14, 12, 14, 4),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.divider),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.search, color: AppColors.primary, size: 20),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Search "mangoes, atta, milk, chips, oil..."',
                            style: TextStyle(
                              color: AppColors.textHint,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Icon(Icons.mic, color: AppColors.textSecondary, size: 18),
                      ],
                    ),
                  ),
                ),

                // JioPrime VIP Banner
                if (!profile.jioPrime)
                  GestureDetector(
                    onTap: () => context.go('/profile'),
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(14, 10, 14, 4),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF8D6E18), Color(0xFFD4AF37)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF8D6E18).withValues(alpha: 0.25),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.star, color: Colors.white, size: 18),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'JioPrime VIP Membership',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 13,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Get EXTRA 5% OFF & FREE Scheduled Delivery',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'JOIN',
                              style: TextStyle(
                                color: Color(0xFF8D6E18),
                                fontWeight: FontWeight.w800,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // Offer Promotional Carousel
                const SizedBox(height: 12),
                SizedBox(
                  height: 135,
                  child: PageView.builder(
                    controller: _carouselCtrl,
                    onPageChanged: (i) => setState(() => _carouselIndex = i),
                    itemCount: _offers.length,
                    itemBuilder: (ctx, i) {
                      final offer = _offers[i];
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: offer['color'] as Color,
                          borderRadius: BorderRadius.circular(AppTheme.cardRadius),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(18),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: AppColors.offerOrange,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: const Text(
                                      'LIMITED OFFER',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 9.5,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0.4,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    offer['title'] as String,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 15,
                                      color: AppColors.textPrimary,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    offer['subtitle'] as String,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textSecondary,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              offer['emoji'] as String,
                              style: const TextStyle(fontSize: 48),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Carousel Dots
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _offers.length,
                    (i) => AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: _carouselIndex == i ? 22 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: _carouselIndex == i
                            ? AppColors.primary
                            : AppColors.textHint.withValues(alpha: 0.3),
                      ),
                    ),
                  ),
                ),

                // Shop by Category Grid
                const SizedBox(height: 16),
                SectionHeader(
                  title: 'Shop by Category',
                  actionLabel: l10n.seeAll,
                  onAction: () => context.go('/categories'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.05,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: _categories.length,
                    itemBuilder: (ctx, i) {
                      final cat = _categories[i];
                      return GestureDetector(
                        onTap: () => context.go(
                          '/categories',
                          extra: cat['cat'],
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: cat['bg'] as Color,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: (cat['bg'] as Color).withValues(alpha: 0.8),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.03),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                cat['emoji'] as String,
                                style: const TextStyle(fontSize: 32),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                cat['label'] as String,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Section 1: Fresh Today (Farm Fresh Produce)
                const SizedBox(height: 22),
                SectionHeader(
                  title: '🌱 ${l10n.freshToday}',
                  actionLabel: l10n.seeAll,
                  onAction: () => context.go('/categories', extra: 'fruits'),
                ),
                SizedBox(
                  height: 228,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    itemCount: freshProducts.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (ctx, i) => SizedBox(
                      width: 150,
                      child: ProductCard(
                        product: freshProducts[i],
                        locale: locale,
                        storeId: store?.id ?? '',
                      ),
                    ),
                  ),
                ),

                // Section 2: Mega Savings & Best Deals
                if (dealProducts.isNotEmpty) ...[
                  const SizedBox(height: 22),
                  SectionHeader(
                    title: '🔥 Smart Bazaar Super Savers',
                    actionLabel: l10n.seeAll,
                    onAction: () => context.go('/categories'),
                  ),
                  SizedBox(
                    height: 228,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      itemCount: dealProducts.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (ctx, i) => SizedBox(
                        width: 150,
                        child: ProductCard(
                          product: dealProducts[i],
                          locale: locale,
                          storeId: store?.id ?? '',
                        ),
                      ),
                    ),
                  ),
                ],

                // Section 3: Daily Dairy, Butter & Breakfast
                if (dairyProducts.isNotEmpty) ...[
                  const SizedBox(height: 22),
                  SectionHeader(
                    title: '🥛 Dairy, Milk & Breakfast',
                    actionLabel: l10n.seeAll,
                    onAction: () => context.go('/categories', extra: 'dairy'),
                  ),
                  SizedBox(
                    height: 228,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      itemCount: dairyProducts.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (ctx, i) => SizedBox(
                        width: 150,
                        child: ProductCard(
                          product: dairyProducts[i],
                          locale: locale,
                          storeId: store?.id ?? '',
                        ),
                      ),
                    ),
                  ),
                ],

                // Section 4: Kitchen Staples & Grains
                if (staplesProducts.isNotEmpty) ...[
                  const SizedBox(height: 22),
                  SectionHeader(
                    title: '🌾 Atta, Rice, Oil & Dals',
                    actionLabel: l10n.seeAll,
                    onAction: () => context.go('/categories', extra: 'staples'),
                  ),
                  SizedBox(
                    height: 228,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      itemCount: staplesProducts.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (ctx, i) => SizedBox(
                        width: 150,
                        child: ProductCard(
                          product: staplesProducts[i],
                          locale: locale,
                          storeId: store?.id ?? '',
                        ),
                      ),
                    ),
                  ),
                ],

                // Section 5: Snacks, Biscuits & Beverages
                if (snacksProducts.isNotEmpty) ...[
                  const SizedBox(height: 22),
                  SectionHeader(
                    title: '🍿 Munchies, Tea & Beverages',
                    actionLabel: l10n.seeAll,
                    onAction: () => context.go('/categories', extra: 'snacks'),
                  ),
                  SizedBox(
                    height: 228,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      itemCount: snacksProducts.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (ctx, i) => SizedBox(
                        width: 150,
                        child: ProductCard(
                          product: snacksProducts[i],
                          locale: locale,
                          storeId: store?.id ?? '',
                        ),
                      ),
                    ),
                  ),
                ],

                // Buy Again
                if (lastOrderItems.isNotEmpty) ...[
                  const SizedBox(height: 22),
                  SectionHeader(
                    title: '🔁 ${l10n.buyAgain}',
                    actionLabel: l10n.seeAll,
                    onAction: () => context.go('/orders'),
                  ),
                  SizedBox(
                    height: 228,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      itemCount: lastOrderItems.take(8).length,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (ctx, i) {
                        final item = lastOrderItems.take(8).toList()[i];
                        return SizedBox(
                          width: 150,
                          child: ProductCard(
                            product: item.product,
                            locale: locale,
                            storeId: store?.id ?? '',
                          ),
                        );
                      },
                    ),
                  ),
                ],

                // Reliance Smart Trust Badges
                const SizedBox(height: 28),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.divider),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _TrustItem(
                          icon: Icons.verified_user_outlined,
                          title: '100% Genuine',
                          subtitle: 'Quality checked',
                        ),
                        _TrustItem(
                          icon: Icons.schedule_outlined,
                          title: 'Scheduled Slot',
                          subtitle: 'On-time delivery',
                        ),
                        _TrustItem(
                          icon: Icons.savings_outlined,
                          title: 'Kirana Prices',
                          subtitle: 'Everyday low price',
                        ),
                      ],
                    ),
                  ),
                ),

                // Endless Full Catalog Grid (Explore All Items)
                const SizedBox(height: 26),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '🛒 Explore All Products',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Showing all ${mockProducts.length} essentials for Kharghar',
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      TextButton.icon(
                        onPressed: () => context.go('/categories'),
                        icon: const Icon(Icons.tune, size: 14),
                        label: const Text('Filters', style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // 2-Column Grid of all products
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.72,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: mockProducts.length,
                    itemBuilder: (ctx, i) => ProductCard(
                      product: mockProducts[i],
                      locale: locale,
                      storeId: store?.id ?? '',
                    ),
                  ),
                ),

                const SizedBox(height: 36),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TrustItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _TrustItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary, size: 24),
        const SizedBox(height: 6),
        Text(
          title,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 1),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 10,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
